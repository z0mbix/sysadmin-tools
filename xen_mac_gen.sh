#!/bin/bash
#
# Generate MAC address for use with Xen
#
# Use range 00:16:3e:xx:xx:xx as per Xen docs:
#
# http://wiki.xensource.com/xenwiki/XenNetworking#head-d5446face7e308f577e5aee1c72cf9d156903722
#
printf '00:16:3E:%02x:%02x:%02x\n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256]
