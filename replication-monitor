#!/bin/sh
# replication_monitor.sh - a mysql replication monitor
# Copyright (C) 2006 Mihai Secasiu http://patchlog.com
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as 
# published by the Free Software Foundation 
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#


DB_USER=replc
DB_PASS="your_password"

alert_to="your_email@address.org"
alert_cc=""
alert_subject="REPLICATION FAILED"
alert_message="one of the replication threads on\
the slave server failed or the server is down\n";

rf=$(mktemp)

echo "show slave status\G"|\
mysql -u $DB_USER --password=$DB_PASS > $rf 2>&1


repl_IO=$(cat $rf|grep "Slave_IO_Running"|cut -f2 -d':')
repl_SQL=$(cat $rf|grep "Slave_SQL_Running"|cut -f2 -d':')


if [ "$repl_IO" != " Yes" -o "$repl_SQL" != " Yes" ] ; then
        if [ "$alert_cc" != "" ] ; then 
                cc=" -c $alert_cc "
        fi

cat <<EOF | mail -s "$alert_subject"  $alert_to $cc 
$alert_message

return from slave status command:
$(cat $rf)
EOF
rm $rf
fi

