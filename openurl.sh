#! /bin/bash

cmd="xdotool getactivewindow windowsize 70% 85% windowmove 15% 10%"

while getopts ":e" opt; do
    case $opt in
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
surf $url &
sleep 2

eval $cmd
