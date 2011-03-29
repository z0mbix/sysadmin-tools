#!/bin/sh
#
# Description:
#   Run from cron so that an email if generated if the server
# Requirements:
#   None really
# Example Usage:
#   0 1 * * * /path/to/diskspace_check.sh
#

FS_TYPE=ext4

if df -T -t $FS_TYPE | egrep "(100%|[9][0-9]%)" >/dev/null; then
	echo "`hostname -s `: Disk Usage Warning"
	df -hT 
fi
