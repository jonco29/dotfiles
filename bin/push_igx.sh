#!/usr/local/bin/bash
sudo -S ~/bin/adb push out/target/product/beagleboard/system/lib/libka_algo.so /system/lib
sudo ~/bin/adb push out/target/product/beagleboard/system/lib/libknowles.so /system/lib
sudo ~/bin/adb push out/target/product/beagleboard/system/lib/libaudio.so /system/lib
