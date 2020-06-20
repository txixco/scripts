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

::abbr::
	SendInput <abbr title="%clipboard%"></abbr>{Left 7}
	return

::afxmsg::AfxMessageBox(){Left 1}

:*:{}::
	SendInput {{}{Enter}{Enter}{}}{Up}{Tab}
	return
	