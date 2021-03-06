# !/bin/bash
amixer sset Master $1 
channels=`amixer get Master | grep channels: | awk '{printf $3}'`

if [[ $channels == "Front" ]]
then
	mute=`amixer get Master | grep "Front Left:" | awk '{printf $7}' | cut -b2-4` 
	volume=`amixer get Master | grep "Front Left:" | awk '{print ""$4""}'`

elif [[ $channels == "Mono" ]]
then
	mute=`amixer get Master | grep Mono: | awk '{printf $6}' | cut -b2-4` 
	volume=`amixer get Master | grep Mono: | awk '{print ""$3""}'`
fi

limits=`amixer get Master | grep Limits | awk '{print ""$5""}'`
volume_level=`expr $volume "*" 100 "/" $limits`

if [[ $mute == "off" ]]
then
	notify-send " " -i audio-volume-muted -h int:value:0 -h string:x-canonical-private-synchronous:volume 
else
	if [[ $volume_level -gt 70 ]]
	then
		notify-send " " -i audio-volume-high -h int:value:$volume_level -h string:x-canonical-private-synchronous:volume &
	elif [[ $volume_level -gt 30 ]]
	then
		notify-send " " -i audio-volume-medium -h int:value:$volume_level -h string:x-canonical-private-synchronous:volume & 
	elif [[ $volume_level -gt 0 ]]
	then
		notify-send " " -i audio-volume-low -h int:value:$volume_level -h string:x-canonical-private-synchronous:volume & 
	elif [[ $volume_level == "0" ]]
	then
		notify-send " " -i audio-volume-muted -h int:value:$volume_level -h string:x-canonical-private-synchronous:volume &
	fi
fi
