#!/bin/bash
# 
# Description:
#   Dump all the LVM volumes on a host from a read-only snapshot to a
#   compressed image somewhere sensible like a NAS
# Requirements:
#   lvm, gzip or pigz
# Usage:
#   backup_lvs.sh
#

SNAP_SIZE=4G			# See lvcreate man page on how to set this
VOL_GROUP=VM-VG			# Volume group
DEST_DIR=/Backup/vm		# NFS mount on a NAS?
DATE_STR=`date +%F`
COMP_TOOL=gzip
which pigz >/dev/null 2>&1 && COMP_TOOL=pigz

# lvs doesn't parse well under cron
for LV in `ls /dev/${VOL_GROUP} | egrep '\-root$'`; do 
	SNAPSHOT_NAME=${LV}_backup-snapshot
	SNAPSHOT_PATH=/dev/${VOL_GROUP}/${SNAPSHOT_NAME}
	DEST_FILE=${DEST_DIR}/${LV}_${DATE_STR}.img.gz
	echo "Backing up ${LV} to ${DEST_FILE}"
	# Snapshot the LV
	lvcreate --snapshot --name ${SNAPSHOT_NAME} --size ${SNAP_SIZE} --permission r /dev/${VOL_GROUP}/${LV}
	# Dump snapshot to gzipped image file
	dd if=${SNAPSHOT_PATH} | $COMP_TOOL > ${DEST_FILE}
	# Remove snapshot
	lvremove -f ${SNAPSHOT_PATH}
	echo "Done!"
done
