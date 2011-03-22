#!/bin/sh
#
# Description:
#   Script to backup /etc to cwd
# Requirements:
#   tar
# Usage:
#   cd /backups/etc && backup_etc.sh
#

SOURCE=etc
HOST=`hostname -s`
TODAY=`date +%Y-%m-%d`

tar -C / -czf etc-${HOST}-${TODAY}.tar.gz $SOURCE && logger "Backed up /$SOURCE"
