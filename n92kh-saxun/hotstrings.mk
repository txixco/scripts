CLIPBOARD:=`xclip -o`
STRING:="`cat ~/scripts/string`"
REVISION:="`cat ~/scripts/icrm_version`"

PREEXEC:=$(shell sleep 0.5)

.DEFAULT:
	zenity --info --title='Fluxbox Hotstrings' --text="Hotstring no válido"

fjr:
	xdotool type 'Francisco J. Rueda'

txixco:
	xdotool type 'txixco@gmail.com'

frueda:
	xdotool type 'fjrueda@intercall.com'

imss:
	xdotool type '21067302816'

rfc:
	xdotool type 'RUCF731010579'

curp:
	xdotool type 'RUCF731010HNEDLR09'

fctvl:
	xdotool type '6273181119965742'

str:
	NEWSTRING:=${STRING//'%C'/$CLIPBOARD}
	xdotool type "$NEWSTRING"

ctrx:
	xdotool type 'NTRCLL101jn'
	xdotool key Shift+Tab
	xdotool type 'frueda'
	xdotool key Return

env:
	xdotool type "Windows 7, IE 8, Rev. $REVISION"

tlmx:
	xdotool type '5556978071'
	xdotool key Tab
	xdotool type 'TLMX101c'
	xdotool key Return

inm:
	xdotool type '2007865'
	xdotool key Tab
	xdotool type '89893'
	xdotool key Tab
	xdotool key Return
	sleep 2
	xdotool key Down

bncmr:
	xdotool type '4931612275711651'

wpdt:
	xdotool type "Weekly Update - Week #$(shell date +%W)"
	xdotool key Tab
	xdotool type "Short Summary:"
	xdotool key Return
	xdotool type "    Automation of test cases"
	xdotool key Return
	xdotool type "Accomplished this week:"
	xdotool key Return
	xdotool type "    Automated some tests about owner's Unicode Info button."
	xdotool key Return
	xdotool type "Planned for next week:"
	xdotool key Return
	xdotool type "    Automation of assigned test cases."
	xdotool key Return
