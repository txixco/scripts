#!/bin/sh

/opt/google/chrome/google-chrome %U --user-data-dir=~/.config/google-chrome/programacion/ &
emacs -l ~/java/Utilidades/src/myutils/vcalendar/files &
aterm -name prgterm
