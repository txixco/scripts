#! /bin/bash

if [ -z "$1" ] || [ -z "$2" ]
then
    echo 'dias.sh fecha texto icono'
else
    DIAS=$(($(date +%j -d "$1") - $(date +%j)))
    notify-send -i "$3" "Faltan $DIAS dias para $2"
fi
