#!/bin/bash

nombre=`date +%Y%m%d%H%M%S`
params=''

case $1 in
[vV])
   params=`xprop | sed -n 's/WM_CLASS(STRING) = "\([^"]*\)", "[^"]*"/\1/p'`
   params="-window $params"
  ;;
[pP])
  params='-window root'
  ;;
esac

import $params ~/.screenshots/$nombre.jpg
eog ~/.screenshots/$nombre.jpg
rm ~/.screenshots/$nombre.jpg