#!/usr/local/bin/bash

cd /home/jc/tmp/audio
rm *.wav
adb shell ls /sdcard/Music/*audio*.wav| tr -d '\r' |xargs -L1 adb pull

