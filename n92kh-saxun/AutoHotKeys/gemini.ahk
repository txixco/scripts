;	***************************************
;	* Common Global Variables & Functions *
;	***************************************

;Menu TRAY, Icon, %ForcePharmaDir%\ForcePharma.exe
#SingleInstance ignore

;	**************
;	* Hotstrings *
;	**************

#HotString o			; Omit the ending character
;#HotString EndChars `t	; Only tab is the EndChar

#IfWinActive ahk_class Notepad++
:cb0:getgemini::
	return

#IfWinActive ahk_class MozillaUIWindowClass
:c:getgemini::
	BlockInput On
	SetKeyDelay 80
;	Loop Read, D:\Seguridad\Plantillas\gemini.html
	SendRaw `tpepe: 25px; `n
	BlockInput Off
	return

:*:gmnfile::<span class="file"></span>{Left 7}
:*:gmntable::<span class="table"></span>{Left 7}

::li::<li></li>{Left 5}
::p::<p></p>{Left 4}
::scrbk::SR05__BK.sql{Left 7}

#IfWinActive

;	***********
;	* HotKeys *
;	***********

