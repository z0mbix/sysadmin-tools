#!/bin/sh
#
# Description:
#   This is just a wrapper script that lists installed binpatch patches
#   See the binpatch website for more information on binary patching your
#   OpenBSD system: http://openbsdbinpatch.sourceforge.net/
# Requirements:
#   OpenBSD and a shell
#

RELEASE=`uname -r`
ARCH=`machine`
DATE=`date '+%b %d %T'`
PATCHNO=$1
PATCHDBDIR=/var/db/binpatch
DBFILE=$PATCHDBDIR/install.log
PATCHFILE=binpatch-$RELEASE-$ARCH-$PATCHNO.tgz
PLIST=$PATCHDBDIR/$RELEASE/$PATCHNO/FILES

usage() {
	echo "usage: binpatch_info"
	echo "       binpatch_info 001"
	exit 1
}

getPatchInfo() {
	if [ -d $PATCHDBDIR/$RELEASE/$PATCHNO ]; then
		INSTALLDATE=`grep $RELEASE-$ARCH-$PATCHNO $DBFILE | cut -f3-5 -d' '`
		if [ -f $PLIST ]; then
			echo "Installed file(s) for binpatch $PATCHNO ($INSTALLDATE):"
			sed s/^\.//g $PLIST
		fi
	else
		echo "Binpatch $PATCHNO not installed!"
	fi
}

# Check arguments
if [ $# -gt 2 ]; then
	usage
fi

if [ $# -eq 0 ]; then
	grep "^$RELEASE-$ARCH" $DBFILE
elif [ $# -eq 1 ]; then
	getPatchInfo
fi
