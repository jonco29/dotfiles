#!/usr/local/bin/bash

ARGSHIFT=0
REMOUNT=0
ADDTL_ARGS=""

function show_help {
    cat <<jcEOF
$0 [-hr] <file to push to to /system/lib>
where:
    -h  -- help (this screen)
    -r  -- force adb remount
jcEOF
exit 1
}

function check_opt {
    if [ $# -gt 0 ]; then
        :
    else
        show_help
    fi

    while getopts ":rs:h" opt; do
        case $opt in
            r) 
                REMOUNT=1
                (( ARGSHIFT++ ))
                ;;
            s) 
                ADDTL_ARGS="-s $OPTARG "
                (( ARGSHIFT++ ))
                (( ARGSHIFT++ ))
                ;;
            h)
                show_help
                ;;
        esac
    done
    #echo ADDTL_ARGS: $ADDTL_ARGS
    shift $ARGSHIFT
}

function adb_push {
    if [[ $REMOUNT == 1 ]]; then
        echo adb remount 
        adb $ADDTL_ARGS remount 
    fi
    TARGET=$1
    shift


    for i in $*; do 
        echo adb $ADDTL_ARGS push ${ANDROID_PRODUCT_OUT}${TARGET}/$i ${TARGET}
        adb $ADDTL_ARGS push ${ANDROID_PRODUCT_OUT}${TARGET}/$i ${TARGET}
    done
}

function pid()
{
   local EXE="$1"
   if [ "$EXE" ] ; then
       local PID=`adb $ADDTL_ARGS shell ps | fgrep $1 | sed -e 's/[^ ]* *\([0-9]*\).*/\1/'`
       echo "$PID"
   else
       echo "usage: pid name"
   fi
}



function adb_kill {
    for i in $*; do
        echo adb $ADDTL_ARGS shell kill $(pid $i)
        adb $ADDTL_ARGS shell kill $(pid $i)
    done
}

#check_opt $*
#echo this is argshift: $ARGSHIFT
#shift $ARGSHIFT
#local_test /system/lib $*

