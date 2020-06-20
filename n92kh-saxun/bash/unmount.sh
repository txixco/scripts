#!/bin/bash

if [ "$1" == "" ]
then
   MOUNTS=`mount | grep '/media/' | awk '{ print $1 " " $3 }'`
   DEVICE=`zenity --list --title='Desmontar' --text='Elija un dispositivo a desmontar' --column='' --column='' --hide-header $MOUNTS`

   # Because of issue in zenity
   DEVICE=`echo $DEVICE | awk -F '|' '{print $1}'`
else
	DEVICE="$1"
fi

if [ "$DEVICE" != "" ]
then
    udisks --unmount $DEVICE
fi
