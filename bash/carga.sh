#!/bin/bash

for f in `ls $@`; do
    fullname=$(basename "$f")
    name="${fullname%.*}"

    echo Cargando $name
    sqlldr usrcobamex@cobdprod/3ktc0b4m3x! control=ta_enganches.ctl data=$fullname log=$name.log skip=1
done
