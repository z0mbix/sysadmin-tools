#!/bin/bash
#
# If NFS clients boot-up before the NFS server(s) have started
# the shares aren't mounted. This needs a work around.
#
# DW - 01/Nov/09
#

MNT=/Content

until [ "$MISSION" == "COMPLETE" ]; do
	MNT_INFO=$(mount | awk -v mnt=$MNT '{ if ($3 == mnt) print $0 }')
	if [[ "$MNT_INFO" == "" ]]; then
		echo "$MNT not mounted! Mounting..."
		mount $MNT > /dev/null 2>&1
		MOUNT_CODE=$?
		if [[ "$MOUNT_CODE" -eq "0" ]]; then
			MISSION="COMPLETE"
			echo "Mount successful!"
		else
			echo "Mount failed! Retrying in 5 secs..."
		fi
	else
		MISSION="COMPLETE"
	fi
	sleep 5
done
