#!/usr/bin/env bash

pkg="$1"

if [ -z $pkg ]; then
  echo "You must specify a python package"
  exit 1
fi

echo "Creating RPM from python package: ${pkg}..."
fpm \
  -s python \
  --python-bin /usr/bin/python2.7 \
  --python-pip /usr/bin/pip2.7 \
  -t rpm --python-package-name-prefix python27 \
  $pkg

