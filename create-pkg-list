#!/bin/sh
#
# Description:
#   Save a list of all currently installed packages
# Requirements:
#   BSD pkg tools, and Linux lsb-release package
#

OS=`uname`

if [ $OS == "FreeBSD" ] || [ $OS == "OpenBSD" ] || [ $OS == "NetBSD" ]; then
	pkg_info | cut -f1 -d' ' > $OS.pkgs
fi

if [ $OS == "Linux" ]; then
	DISTRO=`lsb_release -is`
	if [ $DISTRO == "Ubuntu" ] || [ $DISTRO == "Debian" ]; then
		dpkg --get-selections > $OS-pkgs
	fi
	if [ $DISTRO == "RedHatEnterpriseServer" ] || [ $DISTRO == "CentOS" ]; then
		rpm -qa > $OS.pkgs
	fi
fi
