#!/bin/bash
#
# Description:
#   Unmount an LVM partition
# Requirements:
#   LVM, kpartx
# Usage:
#   umount_lvm_partition.sh prd-db01-root
#

if [ $# != 1 ]; then
	echo "You must enter a LV to unmount!"
	exit 1
fi

MNTPNT=/mnt/lvm
LVMPART=$1
LVMMNTPNT=$MNTPNT/$LVMPART
VOLGROUP=`lvs |grep $LVMPART|awk '{print \$2}'`

if umount $LVMMNTPNT; then
	rmdir $LVMMNTPNT
else
	echo "Unmount failed!"
fi

kpartx -d /dev/$VOLGROUP/$LVMPART
