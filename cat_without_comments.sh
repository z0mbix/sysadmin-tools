#!/bin/sh
#
# Description:
#   cat a file to stdout without #, // or ; comments or blank lines
#

if [ -z $1 ]; then
	echo "You must specify a file name!"
	exit 1
fi

grep -v -E '^$|^[[:blank:]]*#|^;|^[[:blank:]]*//' $1
