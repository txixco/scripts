#!/bin/bash

eval "mplayer ~/scripts/egg_timer.wav &"
eval "notify-send \"Alarma\" \"Ya son las $1\" -i appointment-new &"
