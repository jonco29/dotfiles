#!/bin/bash

SHIFT=0
 
while getopts ":a:bcd:" opt; do
  case $opt in
    a)
      echo "-a was triggered, Parameter: $OPTARG" >&2
      let SHIFT++
      let SHIFT++
      ;;
    b)
      echo "-b was triggered!" >&2
      let SHIFT++
      ;;
    c)
      echo "-c was triggered!" >&2
      let SHIFT++
      ;;
    d)
      echo "-d was triggered, Parameter: $OPTARG" >&2
      let SHIFT += 2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

shift $SHIFT
echo now for the remaining arguments...
for i in $*; do
    echo $i
done

