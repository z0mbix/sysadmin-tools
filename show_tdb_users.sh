#!/bin/sh
#
# Description:
#   Display samba users in a tdb database file
# Requirements:
#   tdb-tools (apt-get install tdb-tools on debian/ubuntu)
# Example Usage:
#   show_tdb_users.sh /etc/samba/private/userpasswd.tdb
#

# Default password database file name
DB=/etc/samba/private/passdb.tdb

if [ ! -z $1 ]; then
	DB=$1
fi

if [ ! -f $DB ]; then
	echo "That DB file doesn't exist!"
	exit 1
fi

tdbdump $DB | grep "USER_" | cut -f2 -d_ | cut -f1 -d\\
