#!/bin/bash

mkdir new

for i in $( ls *.$1 ); do
	FILENAME="${i%.*}"
	OLDNAME=$FILENAME.old.$1
	TITLE="${FILENAME/_/ }"
	TITLE="${TITLE/-/ }"

	echo "Setting title of $i to '$TITLE'..."
	#	exiftool -QuickTime:title="$TITLE" $i
	mv $i $OLDNAME
	ffmpeg -i $OLDNAME -vcodec copy -acodec copy -metadata title="$TITLE" $i
done
