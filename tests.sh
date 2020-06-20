#!/bin/bash

ICRM_VERSION=`cat ~/scripts/icrm_version`

sleep 0.5

if [ "$1" == "-sv" ]
then
    VERSION=`zenity --entry --title='iCRM Version' --text='Enter the current iCRM version' --entry-text=$ICRM_VERSION`
    if [ "$VERSION" != "" ]
    then
        echo $VERSION > ~/scripts/icrm_version
    fi
elif [ "$1" == "-vo" ] 
then
    xdotool type $ICRM_VERSION
elif [ "$1" == "-v" ]
then
    zenity --info --title='iCRM Version' --text="The current iCRM version is <b>$ICRM_VERSION</b>"
else
    xdotool key Tab Tab Tab
    xdotool type $ICRM_VERSION
    xdotool key Return
    sleep 0.5
    xdotool key ctrl+w
fi
