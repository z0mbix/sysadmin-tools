#!/bin/sh
#
# Description:
#   Download OpenBSD sources and ports tree for your release
# Requirements:
#   Only what is in base
# Usage:
#   sudo ./get_openbsd_sources_and_unpack.sh
# Notes:
#   As there are no checksums for these packages, we just do
#   a simple check to see if the ftp command completed OK
#   and that the files exist before trying to unpack them.
# 

RELEASE=`uname -r`
MIRROR=ftp.openbsd.org
#MIRROR=ftp.plig.net # London, UK Mirror
URL=ftp://$MIRROR/pub/OpenBSD/$RELEASE

if [ `id -u` -ne 0 ]; then
	echo "You need to be root to unpack the source and ports tree in /usr"
	exit 1
fi

if [ `uname` != "OpenBSD" ]; then
	echo "System is not OpenBSD!"
	exit 1
fi

echo "Getting system source:"
ftp -C $URL/src.tar.gz
if [ $? -ne "0" ]; then
	echo "System source (src.tar.gz) did not download correctly!"
	exit 1
fi

echo "Getting kernel source:"
ftp -C $URL/sys.tar.gz
if [ $? -ne "0" ]; then
	echo "Kernal source (sys.tar.gz) did not download correctly!"
	exit 1
fi

echo "Getting ports tree:" 
ftp -C $URL/ports.tar.gz
if [ $? -ne "0" ]; then
	echo "Ports tree (ports.tar.gz) did not download correctly!"
	exit 1
fi

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
