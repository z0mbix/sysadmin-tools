#!/bin/bash
#
# Description:
#   Check if IP is valid:
# Requirements:
#   A Shell
# Usage:
#   ./validate-ip.sh [ipaddress]
#
IP=$1

if [[ $IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
  OIFS=$IFS
  IFS='.'
  IP=($IP)
  IFS=$OIFS
  if [[ ${IP[0]} -le 255 && ${IP[1]} -le 255 && ${IP[2]} -le 255 && ${IP[3]} -le 255 ]]; then
    echo "valid IP"
    exit
  else
    echo "Invalid IP"
    exit 1
  fi
fi
