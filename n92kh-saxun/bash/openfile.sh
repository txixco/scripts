#!/bin/bash

LIST=

for FILE in $1/*
do
    LIST+=" $FILE $(basename $FILE)"
done

FILE=$(zenity --list --title=$1 --column='' --column='' --text='Seleccione un archivo a abrir' --hide-column=1 --hide-header $LIST)

if [ "$FILE" != "" ]
then
    gnome-open $FILE
fi
