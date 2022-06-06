#!/bin/bash

WND_FOCUS=$(xdotool getwindowfocus)
WND_TITLE=$(xprop -id $WND_FOCUS WM_CLASS)
LOOKFOR='"([^"]*)"'

if [[ "$WND_TITLE" =~ $LOOKFOR ]]; then
	WND_TITLE=${BASH_REMATCH[1]}
fi

#zenity --info --title='Shortcuts help' --text=$WND_TITLE

make -f ~/scripts/shortcuts.mk $WND_TITLE
