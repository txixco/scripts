#!/bin/bash

CLIPBOARD=`xclip -o`
STRING="`cat ~/scripts/string`"
REVISION="`cat ~/scripts/icrm_version`"

sleep 0.5

if [ "$1" == "" ]
then
    STRING=`zenity --entry --title='HotStrings String' --text='Enter the current string' --entry-text="$STRING"`

    if [ "$STRING" != "" ]
    then
        echo $STRING > ~/scripts/string
    fi    
elif [ "$1" == "fjr" ]
then
    xdotool type 'Francisco J. Rueda'
elif [ "$1" == "txixco" ]
then
    xdotool type 'txixco@gmail.com'
elif [ "$1" == "frueda" ]
then
    xdotool type 'fjrueda@intercall.com'
elif [ "$1" == "imss" ]
then
    xdotool type '21067302816'
elif [ "$1" == "rfc" ]
then
    xdotool type 'RUCF731010579'
elif [ "$1" == "curp" ]
then
    xdotool type 'RUCF731010HNEDLR09'
elif [ "$1" == "fctvl" ]
then
    xdotool type '6273181119965742'
elif [ "$1" == "str" ]
then
    NEWSTRING=${STRING//'%C'/$CLIPBOARD}
    xdotool type "$NEWSTRING"
elif [ "$1" == "ctrx" ]
then
    xdotool type 'NTRCLL101jn'
    xdotool key Shift+Tab
    xdotool type 'frueda'
    xdotool key Return
elif [ "$1" == "env" ]
then
    xdotool type "Windows 7, IE 8, Rev. $REVISION"
elif [ "$1" == "tlmx" ]
then
    xdotool type '5556978071'
    xdotool key Tab
    xdotool type 'TLMX101c'
    xdotool key Return
elif [ "$1" == "inm" ]
then
    xdotool type '2007865'
    xdotool key Tab
    xdotool type '89893'
    xdotool key Tab
    xdotool key Return
    sleep 2
    xdotool key Down
elif [ "$1" == "bncmr" ]
then
    xdotool type '4931612275711651'
else
    zenity --info --title='Fluxbox Hotstrings' --text="Hotstring no válido"
fi
