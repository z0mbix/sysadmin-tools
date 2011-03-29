#!/bin/sh

find / -perm +6000 -type f -exec ls -la {} \;
