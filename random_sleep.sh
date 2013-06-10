#!/bin/bash
#
# Description:
#   Wait a random time in seconds between 0 and MAX_SLEEP then exit
#
# Requirements:
#  Bash Shell
#
# Example usage:
#   random_wait.sh [secs]
#   random_wait.sh && puppet agent --no-daemonize --onetime
#   random_wait.sh 60 && 
#

MAX_SLEEP=300

if [ $1 ]; then
    MAX_SLEEP=$1
fi

sleep $(($RANDOM % $MAX_SLEEP))