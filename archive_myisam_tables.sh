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

if pgrep mysqld>/dev/null; then
	echo "It appears you are running MySQL, please don't run this from the mysql datadir"
	echo -n "Do you want to proceed? (y/n): "
	read ANSWER
	case "$ANSWER" in
		y|Y)   ;;
		n|N)  exit 1 ;;
		*)    exit 1 ;;
	esac
fi

TABLE_LIST=`ls {*.MYI,*.MYD,*.frm}|sed 's/....$//g'|uniq`

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
