#!/bin/bash

if [ "$1" == "" ]
then
	ACTION=`zenity --list --title='Apagado' --text='Elija una accion' --column='' --hide-header Hibernar Suspender Apagar Reiniciar`

   # Because of issue in zenity
   ACTION=`echo $ACTION | awk -F '|' '{print $1}'`
else
	ACTION="$1"
fi

if [ "$ACTION" == "Hibernar" ]
then
   ~/scripts/lock.sh
   dbus-send --system --print-reply --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Hibernate
elif [ "$ACTION" == "Suspender" ]
then
   ~/scripts/lock.sh
   dbus-send --system --print-reply --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend
elif [ "$ACTION" == "Apagar" ]
then
   dbus-send --system --print-reply --dest=org.freedesktop.ConsoleKit /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop
elif [ "$ACTION" == "Reiniciar" ]
then
   dbus-send --system --print-reply --dest=org.freedesktop.ConsoleKit /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart
elif [ "$ACTION" == "Ayuda" ]
then
    echo "shutdown.sh [Acción]"
    echo
    echo "Acción puede ser: Hibernar, Suspender, Apagar, Reiniciar, Ayuda."
    echo "Si no se especifica la acción, muestra un cuadro de diálogo para seleccionarla."
else
    echo "'$1' is not a valid action"
fi
