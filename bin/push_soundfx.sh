#!/usr/local/bin/bash

source ~/bin/adb_functions.sh
check_opt $*
shift $ARGSHIFT
adb_push  /system/lib/soundfx $*

