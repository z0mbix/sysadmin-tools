#!/bin/sh
#
# Client script to dd $DEVICE to $BACKUP_HOST
#

DEVICE=/dev/rwd0a
BACKUP_HOST=192.168.20.8
PORT=9000

if [ `id -u` != "0" ]; then
	echo "You must be root to run this script"
	exit 1
fi

dd if=$DEVICE | nc $BACKUP_HOST $PORT
