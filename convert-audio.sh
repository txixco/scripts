#!/bin/sh
#
# Convierte los archivos WMA de un directorio al formato MP3
# uso: wma2mp3

for f1 in *.wma
do
    f2=`echo $f1 | cut -d '.' -f 1`;
    mplayer "$f1" -ao pcm
    mv audiodump.wav "$f2.wav"
    lame --r3mix "$f2.wav" "$f2.mp3"
    rm "$f2.wav"
done