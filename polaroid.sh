#!/bin/bash

width=$1
shift
expr=($@)
border=$(echo "scale=2; $width*0.05" | bc)

for file in "${expr[@]}"
do
	filename="${file%.*}"

	convert $file -resize $width -bordercolor white -border $border  -bordercolor black -border 1 \( -clone 0 -background gray -shadow 80x3+10+10 \) -reverse -background none -layers merge +repage $filename.png
done
