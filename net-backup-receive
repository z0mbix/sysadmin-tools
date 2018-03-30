#!/bin/sh
#
# Server script to wait on port $PORT for data and dd it to $IMAGE
#

IMAGE=/usr/data/Backups/wrap_backup-`date '+%d%m%y'`.img bs=512
BACKUP_PORT=9000
nc -l $BACKUP_PORT | dd of=$IMAGE
