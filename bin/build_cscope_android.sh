#!/bin/bash

if [[ -e tags ]]; then
    rm -rf tags
fi;

echo "finding all *.[chsS] files"
find . -iname '*.[chSs]' -print > cscope.files

echo "finding all *.[ch]pp files"
find . -iname '*.[ch]pp' -print >> cscope.files

echo "finding all *.cc files"
find . -iname '*.cc' -print >> cscope.files

echo "building ctags..."
ctags -L  cscope.files

echo building cscope database
cscope  -i cscope.files -b -k


cscope -C 
