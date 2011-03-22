#!/bin/bash

if [ -d /usr/src ]; then
	if [ -f /usr/src/sys/conf/newvers.sh ]; then
		grep -E '^BRANCH|^REVISION' /usr/src/sys/conf/newvers.sh
	else
		echo "Can't find version file"
		exit 1
	fi
else
	echo "Source not in /usr/src!"
	exit 1
fi
