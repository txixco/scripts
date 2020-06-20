#!/bin/sh

if [ "$1" != "" ]; then
	PROFILE="--user-data-dir=~/.config/google-chrome/$1/"
fi

echo "google-chrome --app=https://mail.google.com/mail/#inbox $PROFILE --class=GMail --name=GMail &"
google-chrome --app=https://mail.google.com/mail/#inbox $PROFILE --class=GMail --name=GMail &
