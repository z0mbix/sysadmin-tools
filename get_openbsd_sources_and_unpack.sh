#!/bin/sh

if [ `uname` != "OpenBSD" ]; then
	echo "System is not OpenBSD!! Aborting."
fi

release=$1
mirror=ftp.openbsd.org
url=ftp://$mirror/pub/OpenBSD/$release

echo "Getting system source:"
ftp $url/src.tar.gz

echo "Getting kernel source:"
ftp $url/sys.tar.gz

echo "Getting ports tree:" 
ftp $url/ports.tar.gz

if [ ! -d /usr/src ]; then
	mkdir /usr/src
fi

# Unpack the system source files:
cp src.tar.gz /usr/src
cd /usr/src
tar -xvzf src.tar.gz
rm -f /usr/src/src.tar.gz

# Unpack the kernel source files:
cp sys.tar.gz /usr/src
cd /usr/src
tar -xvzf sys.tar.gz
rm -f /usr/src/sys.tar.gz

cp ports.tar.gz /usr
cd /usr
tar xzf ports.tar.gz
rm -f /usr/ports.tar.gz

echo "done."
