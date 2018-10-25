#!/bin/bash

set -e

PREFIX="$(pwd)/dist"

cd sources
./configure --with-cmodel=medany "--prefix=$PREFIX"

if [ -z "$TEMP" ]; then
	TEMP='/tmp'
fi

pushd riscv-gcc
ITEMS=('gmp-6.1.0.tar.bz2' 'mpfr-3.1.4.tar.bz2' 'mpc-1.0.3.tar.gz' 'isl-0.18.tar.bz2')
for I in "${ITEMS[@]}" ; do
	if [ -e "$I" ]; then
		continue
	fi
	wget -c -O "$TEMP/$I.download" "http://gcc.gnu.org/pub/gcc/infrastructure/$I"
	mv "$TEMP/$I.download" "$I"
done
popd &>/dev/null

make -j$(( $(nproc) - 1 ))
cd ..

set -x
cd dist
tar -cJf ../toolchain.tar.xz *

