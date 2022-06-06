#!/bin/bash

COMMAND=`zenity --list --title='Modo' --text='Elija un modo' --column='Modo' --column='Comando' --hide-header --hide-column=1 atrabajar.sh Trabajar adescansar.sh Ocio`

eval "$COMMAND"
