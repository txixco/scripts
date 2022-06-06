#! /bin/bash

DIRECTORY="." && [ -n "$1" ] && DIRECTORY="$1"

echo "Cleaning $DIRECTORY"
echo

#cd "$DIRECTORY"
for FILE in $DIRECTORY/*.NEF
do
	if [ ! -f "${FILE%.*}.JPG" ]; then
		rm "$FILE"
 		echo "$FILE removed"
	fi
done
