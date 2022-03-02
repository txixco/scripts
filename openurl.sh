#! /bin/bash

cmd="xdotool getactivewindow windowsize 70% 85% windowmove 15% 10%"
kiosk="-k"

while getopts ":ek" opt; do
    case $opt in
    k)
        kiosk="-K"
        ;;
    e)
        cmd="xdotool getactivewindow windowsize 50% 90% windowmove 25% 3%"
        ;;
    \?)
        echo "Invalid Option: -$OPTARG" 1>&2
        exit 1
        ;;

    esac
done
shift $((OPTIND -1))

url=$1; shift

#firefox --new-window $url &
surf $kiosk $url &
sleep 2

eval $cmd
