#!/usr/local/bin/bash

source ~/bin/adb_functions.sh
check_opt $*
shift $ARGSHIFT
for i in $*; do
    adb_push  /system/bin $i
done


