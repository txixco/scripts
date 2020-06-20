#!/bin/bash

FILENAME=${1%.*}.ogg

echo "Convirtiendo $1 a $FILENAME..."
ffmpeg -loglevel error -i "$1" -acodec libvorbis -ab 128k "$FILENAME"
