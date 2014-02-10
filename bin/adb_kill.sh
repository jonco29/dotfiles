#!/usr/local/bin/bash

source ~/bin/adb_functions.sh
check_opt $*
#echo this is argshift: $ARGSHIFT
shift $ARGSHIFT
adb_kill $*
echo new pid for $* is `pid $*`


