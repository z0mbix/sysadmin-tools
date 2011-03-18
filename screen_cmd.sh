#!/bin/sh
#
# Description:
#   Runs a command in a fresh screen
# Requirements:
#   Screen
#

# Get the current directory and the name of command
wd=`pwd`
cmd=$1
shift

# Are we inside screen?
if [ -z "$STY" ]; then
	# Not inside screen, so just run the command
	$cmd $*
else
	# Change directory so the relative paths/filenames work
	screen -X chdir $wd

	# Ask screen to run the command
	if [ $cmd == "ssh" ]; then
   		screen -X screen -t ""${1##*@}"" $cmd $*
	else
		screen -X screen -t "$cmd $*" $cmd $*
	fi
fi
