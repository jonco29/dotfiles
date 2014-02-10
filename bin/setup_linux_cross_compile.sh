#!/usr/local/bin/bash

# CUR_PWD=$PWD
# jmaguro && cd ../jb2
# source build/envsetup.sh && lunch full_maguro-userdebug
export PATH=$(pwd)/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin:$PATH
export CROSS_COMPILE=arm-eabi-
export ARCH=arm
export SUBARCH=arm

#cd $CUR_PWD

