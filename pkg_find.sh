#!/bin/sh
#
# pkg_find is a utility to easily locate OpenBSD/FreeBSD packages
#
# Author:  z0mbix (zombie | at | zombix dot org)
#
# 19/01/06 - Version 0.1 - OpenBSD Version
# 26/07/10 - Version 0.2 - Added FreeBSD Support
#

UNAME=`uname -s`
VERSION=`uname -r | cut -d '.' -f 1,2`
RELEASE=`uname -r`
ARCH=`uname -m`
PKGFILE="$HOME/.packages-$RELEASE"

if [ ${UNAME} = "FreeBSD" ]; then
	FTPMIRROR=ftp.uk.freebsd.org
	FTPPATH=pub/FreeBSD/releases/$ARCH/$VERSION/packages
	INDEXFILE=INDEX.bz2
elif [ ${UNAME} = "OpenBSD" ]; then
	FTPMIRROR=ftp.openbsd.org
	FTPPATH=pub/OpenBSD/$RELEASE/packages/$ARCH
	INDEXFILE=index.txt
fi

if [ $# -lt 1 ]; then
  echo "Please specify atleast one package to search for."
else
	if [ ! -f $PKGFILE ]; then
		echo "$PKGFILE does not exist, downloading..."
		if [ ${UNAME} = "FreeBSD" ]; then
			ftp -4 -V -o $PKGFILE.bz2 ftp://$FTPMIRROR/$FTPPATH/$INDEXFILE
			bunzip2 $PKGFILE.bz2
		elif [ ${UNAME} = "OpenBSD" ]; then
			ftp -4 -V -o $PKGFILE ftp://$FTPMIRROR/$FTPPATH/$INDEXFILE
		fi
		
		if [ ! -f $PKGFILE ]; then
			echo "Please manually download the file:"
			echo "$FTPMIRROR/$FTPPATH/$INDEXFILE"
			echo "and save it as:"
			echo "$PKGFILE"
			exit
		fi
	fi
	for PKG in $@; do
		echo "Results for: $PKG"
		if [ ${UNAME} = "FreeBSD" ]; then
			grep -i "^$PKG" $PKGFILE | cut -f1 -d\|
		elif [ ${UNAME} = "FreeBSD" ]; then
			grep -i "^$PKG" $PKGFILE
		fi
	done
fi
