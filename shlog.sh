#!/bin/sh
#
# Description: Quick and simple way for a sysadmin to take notes on a system
#   to keep a track of what changes he/she made. Add to shell logout file
#   to get it to prompt you when you log out.
#
# Requirements: A shell and some fingers
#
# Author: z0mbix (zombie@zombix.org)
#

NAME="shlog"
LOGFILE=$HOME/.shlog.log
DATE=`date '+%b %d %Y %T'`

function usage {
	echo -e "Usage: shlog"
	echo -e "       shlog -s"
	echo -e "       shlog --show"
}

if [ $# = 1 ]; then
	case "$1" in
		-s|--show)
			cat $LOGFILE
			;;

		-*|--*)
			usage
			;;
        esac
elif [ $# -ge 2 ]; then
	usage
else
	clear
	echo "Please log any changes/updates you have made (Enter if none):"
	echo -n ">> "
	read ENTRY
	if [ "$ENTRY" ]; then
		until [ "$INITIALS" ]; do
			echo -n "Please enter your initials: "
			read INITIALS
		done
		INIT=`echo $INITIALS | tr 'a-z' 'A-Z'`
		echo "$DATE - $INIT - $ENTRY" >> $LOGFILE
	fi
fi

