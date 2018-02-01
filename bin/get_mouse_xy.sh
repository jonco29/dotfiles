#!/bin/bash
## this will print the x/y location as +x+y -- used in firing up gvim and gnome terminal
xdotool getmouselocation|sed 's,\s\+screen.*$,,;s,\s\+,,;s,[xy]:,+,g'
