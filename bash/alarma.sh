#!/bin/bash

ACTION=`zenity --list --title='Apagado' --text='Elija una acción' --column='' Hibernar Suspender Apagar Reiniciar`

if [ $ACTION = "Hibernate" ]
then
	dbus-send --system --print-reply --dest=org.freedesktop.ConsoleKit /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop
elif [ $ACTION = "Suspend" ]
then
	dbus-send --system --print-reply --dest=org.freedesktop.ConsoleKit /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart
elif [ $ACTION = "Shutdown" ]
then
	dbus-send --system --print-reply --dest=org.freedesktop.Hal /org/freedesktop/Hal/devices/computer org.freedesktop.Hal.Device.SystemPowerManagement.Suspend int32:0
elif [ $ACTION = "Restart" ]
then
	dbus-send --system --print-reply --dest=org.freedesktop.Hal /org/freedesktop/Hal/devices/computer org.freedesktop.Hal.Device.SystemPowerManagement.Hibernate
fi




