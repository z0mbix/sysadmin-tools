#!/usr/bin/env bash

getent passwd | awk -F: '($3>600) && ($3<10000) && ($3>maxuid) { maxuid=$3; } END { print maxuid+1; }'
