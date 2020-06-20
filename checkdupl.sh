#!/bin/bash

SEP=$(printf '=%.0s' {1..80})

if [ -z "$1" ]; then
	echo "Usage: checkdupl.sh destination"
	exit
else
	IP="192.168.10.$1"
fi

ARPING=$(arping -D -I wlan0 -c 2 $IP)
STATUS=$?

MSG="$SEP\n$(date)\n$SEP\n$ARPING\n\nStatus: $STATUS\n$SEP\n"

echo -e "$MSG"  

if [ $STATUS -gt 0 ]; then
	echo -e $MSG >> /var/log/checkdupl.log
	zenity --warning --text="$MSG" --title="Duplicated IP" --display=:0.0
fi
