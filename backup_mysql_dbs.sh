#!/bin/sh
#
# Description:
#   Dump each DB out of mysql into its own compressed dumpfile (pigz or gzip)
# Requirements:
#   MySQL client/mysqldump
#   The MySQL user with permissions to backup must be set in ~/.my.cnf
# Example usage:
#   cd /var/backups/db && backup_mysql_dbs.sh
#

TODAY=`date +%Y-%m-%d`
COMP_TOOL=gzip
which pigz >/dev/null 2>&1 && COMP_TOOL=pigz

logger "Dumping All MySQL databases"

# Check if a master server:
mysql -e "show global variables like 'log_bin'"|grep ON
if [ "$?" -eq "0" ]; then
	FLAGS="--master-data"
else
	FLAGS=""
fi

DBS=`mysql --skip-column-names -e "show databases"`

for DB in $DBS; do
	if [ ! -d $DB ]; then
		mkdir $DB
	fi
	DUMPFILE="${DB}_${TODAY}.sql.gz"
	echo -n "Dumping MySQL Database: ${DB} (`date '+%H:%M:%S'`) - "
	mysqldump $FLAGS --triggers --routines "${DB}" | $COMP_TOOL > ${DB}/${DUMPFILE}
	echo "done (`date '+%H:%M:%S'`)"
done
