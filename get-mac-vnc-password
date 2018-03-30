#!/bin/sh
#
# Description:
#   Get the VNC password from MAC OS X
# Requires:
#   Perl and permissions to access the VNC password file (root)
# Usage:
#   sudo ./get_mac_vnc_password.sh
#
FILE=/Library/Preferences/com.apple.VNCSettings.txt
if [ `uname` == "Darwin" ]; then
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
