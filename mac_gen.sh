#!/bin/bash
#
# Generate MAC address for use with Xen
#
# Use range 00:16:3e:xx:xx:xx as per Xen docs:
#
# http://wiki.xensource.com/xenwiki/XenNetworking#head-d5446face7e308f577e5aee1c72cf9d156903722
#

if [ -z $1 ]; then
    echo "You must specify xen, kvm or vmware"
    echo "Example: $0 xen"
    exit 1
fi

case "$1" in
    xen)
        prefix="00:16:3E"
        ;;
    kvm)
        prefix="52:54:00"
        ;;
    vmware)
        prefix="00:50:56"
        ;;
esac

printf "${prefix}:%02x:%02x:%02x\n" $[RANDOM%256] $[RANDOM%256] $[RANDOM%256]
