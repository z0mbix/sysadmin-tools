#!/bin/sh
#
# Description:
#   This is just a wrapper script that installs binpatch patches and
#   logs the date and time and a list of what files were installed.
#   See the binpatch website for more information on binary patching
#   your OpenBSD system: http://openbsdbinpatch.sourceforge.net/
# Requirements:
#   OpenBSD and a shell
#

RELEASE=`uname -r`
ARCH=`machine`
DATE=`date '+%b %d %Y %T'`
PATCHNO=$1
PATCHDBDIR=/var/db/binpatch
DBFILE=${PATCHDBDIR}/install.log
PATCHFILE=binpatch-$RELEASE-$ARCH-$PATCHNO.tgz
#SIGNKEY=~/.ssh/id_rsa.pub	# Set to NO if not required
SIGNKEY=NO			# Set to NO if not required

# Check for one argument:
if [ $# != 1 ]; then
	echo "usage: binpatch_add 001"
	exit 1
fi

# Check if this patch is already installed
if [ -d ${PATCHDBDIR}/$RELEASE/$PATCHNO ]; then
	echo "Patch $PATCHNO already installed!"
	echo "Directory ${PATCHDBDIR}/$RELEASE/$PATCHNO already exists!"
	echo "If you are re-installing this patch, remove this directory and re-run"
	exit 1
fi

chksumfile() {
	echo -n " - Comparing checksum: "
	CKSUM=`grep "MD5 ($PATCHFILE)" $PATCHDBDIR/$RELEASE/CKSUMS | awk '{print $4}'`
	MYCKSUM=`cksum -a md5 $1 | awk '{print $4}'`
	if [ "$MYCKSUM" == "$CKSUM" ]; then
		echo "ok"
	else
		echo "failed!"
		exit 1
	fi
}

# Get updated CKSUM file:
# Use standard ftp in non-verbose mode:
echo " - Downloading CKSUMS file:"
ftp -VEa -o $PATCHDBDIR/$RELEASE/CKSUMS $BINPATCH_PATH/CKSUMS

# Try to get from BINPATCH_PATH if it doesn't exist in cwd:
if [ ! -f /tmp/$PATCHFILE ]; then
	echo " - Downloading binpatch: $PATCHFILE"
	# Use standard ftp in non-verbose mode and save in cwd:
	ftp -VEa -o /tmp/$PATCHFILE $BINPATCH_PATH/$PATCHFILE
fi

# Try to install from cwd:
if [ -f /tmp/$PATCHFILE ]; then
	# Check MD5 Checksum:
	chksumfile /tmp/$PATCHFILE

	# Check if the user wants to check gzsig:
	if [ "${SIGNKEY}" != "NO" ]; then
		# Check gzsig and exit if not verified:
		if ! gzsig verify -q ${SIGNKEY} $PATCHFILE; then
			echo "$PATCHFILE NOT verified with key ${SIGNKEY}. Exiting!"
			exit 1
		else
			echo "$PATCHFILE verified with key ${SIGNKEY}"
		fi
	fi

	# Create db directory if it does not exist:
	echo " - Installing binpatch..."
	mkdir -p ${PATCHDBDIR}/$RELEASE/$PATCHNO

	# Create file list for this binpatch:
	tar tzf /tmp/$PATCHFILE > ${PATCHDBDIR}/$RELEASE/$PATCHNO/FILES

	# Check if binpatch includes kernel updates:
	if grep "^./bsd$" ${PATCHDBDIR}/$RELEASE/$PATCHNO/FILES > /dev/null; then
		echo "Kernel Update!"
		echo " Backing up /bsd to /bsd.old"
		cp /bsd /bsd.old
	fi

	if grep "^./bsd.mp$" ${PATCHDBDIR}/$RELEASE/$PATCHNO/FILES > /dev/null; then
		cp /bsd.mp /bsd.mp.old
	fi

	# Actually unpack the binpatch tarball in /:
	tar xzpvf "/tmp/$PATCHFILE" -C /
	
	# Update install file with new patch details:
	echo "$RELEASE-$ARCH-$PATCHNO installed: ${DATE}" | tee -a ${DBFILE}

	# Cleanup binpatch file:
	#rm $PATCHFILE
else
	echo "Could not find: $PATCHFILE"
fi
