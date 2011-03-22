#!/bin/sh
#
# Description:
#   rsync the entire mysql directory of a slave to the backup NAS.
# Requirements:
#   rsync and mysql
# Usage:
#   Run from cron with something like:
#   05 04 * * *	/usr/local/sbin/backup_mysql_dbs_rsync.sh
#

TODAY=`date +%Y-%m-%d`
MYSQL_DIR=/var/lib/mysql/
DEST_DIR=/Backups/`hostname -s`/db/

logger "Backing up MySQL databases"

# Check if a slave server:
mysql -e "show global variables like 'log_bin'"|grep ON
if [ "$?" -eq "0" ]; then
    echo "Not a slave!"
    exit 1
fi

service mysql stop
rsync -avh --stats --delete-after $MYSQL_DIR $DEST_DIR
service mysql start
