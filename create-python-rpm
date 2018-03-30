#!/usr/bin/env bash

pkg="$1"

if [ -z $pkg ]; then
  echo "You must specify a python package"
  exit 1
fi

echo "Creating RPM from python package: ${pkg}..."
fpm \
  -s python \
  -t rpm \
  $pkg
