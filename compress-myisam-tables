#!/bin/sh
#
# Description:
#   Create a tarball for each MySQL MyISAM table in the current directory
# Requirements:
#   tar
# Usage:
#   ./archive_myisam_tables.sh     Archive all MyISAM tables
#   ./archive_myisam_tables.sh -r  Archive all MyISAM tables and remove uncompressed tables
#

# MySQL config file? RedHat/CentOS etc.
if [ -f /etc/my.cnf ]; then
	datadir=`grep datadir /etc/my.cnf | cut -f2 -d= | tr -d ' '`
fi

# Debian/Ubuntu?
if [ -f /etc/mysql/my.cnf ]; then
	datadir=`grep datadir /etc/my.cnf | cut -f2 -d= | tr -d ' '`
fi

if [ -z $datadir ]; then
	echo "Could not find the MySQL datadir!"
	exit 1
fi

# Don't run this in the MySQL datadir, that wouldn't be fun
if [ "$PWD" == "$datadir" ]; then
	echo "Don't run this from the mysql datadir!"
	echo "Copy the tables to a backu dir/host first, then run this"
	exit 2
fi

TABLE_LIST=`ls {*.MYI,*.MYD,*.frm} 2>/dev/null|sed 's/....$//g'|uniq`

# Create a gzipped tarball for each TABLE in the pwd
for TABLE in $TABLE_LIST; do
	# Don't bother if the tarball already exists
	if [ ! -f ${TABLE}.tar.gz ]; then
		echo "Compressing table: $TABLE"
		tar czf ${TABLE}.tar.gz ${TABLE}.MYI ${TABLE}.MYD ${TABLE}.frm
		if [ "$?" -eq "0" ]; then
			# Optionally remove the old uncompressed files
			if [[ ! -z $1 && $1 == '-r' ]]; then
				echo "Removing old table files"
				rm ${TABLE}.{MYI,MYD,frm}
			fi
		else
			echo "Failed!"
			exit 1
		fi
	fi
done
