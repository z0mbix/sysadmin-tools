#!/bin/sh

cd /usr/src/sys/arch/`arch`/conf
config GENERIC
cd ../compile/GENERIC
make clean && make depend && make
make install
echo done
