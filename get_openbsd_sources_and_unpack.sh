#!/bin/sh

if [ `uname` != "OpenBSD" ]; then
	echo "System is not OpenBSD!! Aborting."
	exit 1
fi

RELEASE=$1
MIRROR=ftp.openbsd.org
URL=ftp://$MIRROR/pub/OpenBSD/$RELEASE

echo "Getting system source:"
ftp $URL/src.tar.gz

echo "Getting kernel source:"
ftp $URL/sys.tar.gz

echo "Getting ports tree:" 
ftp $URL/ports.tar.gz

if [ ! -d /usr/src ]; then
	mkdir /usr/src
fi

# Unpack the system source files:
if [ -f src.tar.gz ]; then
	tar xzf src.tar.gz -C /usr/src
fi

# Unpack the kernel source files:
if [ -f sys.tar.gz ]; then
	tar xzf sys.tar.gz -C /usr/src
fi

if [ -f ports.tar.gz ]; then
	tar xzf ports.tar.gz -C /usr
fi

echo "done."
