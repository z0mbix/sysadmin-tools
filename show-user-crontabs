#!/bin/sh

for user in $(cat /etc/passwd | cut -f1 -d:); do
    crontab -l -u $user
done
