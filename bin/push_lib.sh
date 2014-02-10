#!/usr/local/bin/bash

source ~/bin/adb_functions.sh
check_opt $*
#echo this is argshift: $ARGSHIFT
shift $ARGSHIFT
for i in $*; do
    adb_push  /system/lib $i
done

