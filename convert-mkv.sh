#!/bin/bash

if [ -z $1 ]; then
	echo Uso: convert-mkv.sh archivo
	exit
fi

FILENAME=${1%.*}.avi

echo "Convirtiendo $1 a $FILENAME..."
ffmpeg -i $1 -c:v copy -c:a copy -ca 2 $FILENAME $2
