#!/bin/sh
#
# Description:
#   Show all environment variables for a running process
#
# Requirements:
#   xargs
#
# Example Usage:
#   get_process_env.sh 13425
#   get_process_env.sh `cat /var/run/nginx/nginx.pid`
#


if [ -z $1 ]; then
	echo "You must specify a process ID"
	echo "$0 [pid]"
	exit 1
fi

xargs --null --max-arg=1 echo < /proc/${1}/environ
