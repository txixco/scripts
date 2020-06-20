#!/bin/bash

if [ "$1" == "" ]; then
	ORDEN="start"
else
	ORDEN=$1
fi

function ordenar(){
	if [ "$2" != "" ]; then
		PREVIO="HOME=$2"
	else
		PREVIO=""
	fi

#	echo "-- $PREVIO dropbox $1"
	eval "$PREVIO dropbox $1"
}

ordenar "stop"
ordenar "stop" "~/.dropbox-alt"

if [ "$ORDEN" != "stop" ]; then
	ordenar $ORDEN
	ordenar $ORDEN "~/.dropbox-alt"
fi
