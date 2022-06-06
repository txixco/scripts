#!/bin/bash

if [ "$1" != "-q" ]; then
	sleep 51
fi

wget -O - http://freedns.afraid.org/dynamic/update.php?Y3MyUVB1b0ZIdEFnbVVzbGNiU05YNGt0OjEzMTQwNzg5

read -n1 -r -p "Press any key to continue..." key
