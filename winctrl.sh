#!/bin/bash

# xdotool getactivewindow windowsize 70% 85% windowmove 15% 7%

if [[ $# -ne 2 ]]
then
    echo "Wrong number of arguments, it should be 2"
    exit 1
fi

kDIMENSIONSRE='^([0-9]+)x([0-9]+)$'
dimensions=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')

if [[ $dimensions =~ $kDIMENSIONSRE ]]
then
    max_width=${BASH_REMATCH[1]}
    max_height=${BASH_REMATCH[2]}
else
    printf "Cannot get the dimensions"
    exit 2
fi

width=$((max_width * $1 / 100))
height=$((max_height * $2 / 100))
pos_x=$(((max_width - width) / 2))
pos_y=$(((max_height - height) / 2))

printf "Screen Width: $max_width\nScreen Height: $max_height\n"
printf "Dimensions: $pos_x,$pos_y,$width,$height\n"

wmctrl -r :ACTIVE: -b remove,maximized_horz,maximized,vert
wmctrl -r :ACTIVE: -e 0,$pos_x,$pos_y,$width,$height
