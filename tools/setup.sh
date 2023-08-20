#!/bin/sh

TOOLCHAIN_BASE=../am-toolchains/brcm-arm-hnd
export TOOLCHAIN_BASE=$(realpath $TOOLCHAIN_BASE)
export LD_LIBRARY_PATH=$LD_LIBRARY:$TOOLCHAIN_BASE/crosstools-arm-gcc-9.2-linux-4.19-glibc-2.30-binutils-2.32/lib
PATH=$PATH:$TOOLCHAIN_BASE/crosstools-arm-gcc-9.2-linux-4.19-glibc-2.30-binutils-2.32/bin

