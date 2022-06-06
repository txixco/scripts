#!/bin/bash

#killall -9 synergy &
#killall -9 synergys &

dropbox.sh stop
dropbox start &

skype.sh 0
skype &
