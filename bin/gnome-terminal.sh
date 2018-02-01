#!/bin/bash

MAX_X=3048
NEW_X=2800
MAX_Y=748
NEW_Y=700

PROFILE=default



## find coordinates
eval $(xdotool getmouselocation --shell)
if [[ $X -gt ${MAX_X} ]]; then
    X=${NEW_X}
fi

if [[ $Y -gt ${MAX_Y} ]]; then
    Y=${NEW_Y}
fi

if [[ $# -gt 0 ]];then
    PROFILE=$1
fi

if [[ ${PROFILE} == "temp" ]]; then
    BASH_POST_RC=set_ls_color4 gnome-terminal --window-with-profile=temp --geometry +${X}+${Y}&
else
    gnome-terminal --window-with-profile="${PROFILE}" --geometry +${X}+${Y}&
fi
