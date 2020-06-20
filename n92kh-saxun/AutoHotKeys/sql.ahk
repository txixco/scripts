#SingleInstance ignore

;IfExist %A_ProgramFiles%\Sybase\win32\dbisql.exe
;	Menu TRAY, Icon, %A_ProgramFiles%\Sybase\win32\dbisql.exe
;else IfExist %A_ProgramFiles%\Sybase\SQL Anywhere 7\win32\dbisql.exe
;	Menu TRAY, Icon, %A_ProgramFiles%\Sybase\SQL Anywhere 7\win32\dbisql.exe


#include SqlIntelliSense.ahk

;	**************
;	* HotStrings *
;	**************

:r0:select::
	Send select *{Enter}from {Enter}where {Up}{End}{End}
	KeyWait Tab, D
	KeyWait Tab	
	Send {BS}{Down}{End}{End}
	return

:r0:update::
	Send update {Enter}set {Enter}where {Up 2}{End}
	KeyWait Tab, D
	KeyWait Tab	
	Send {BS}{Down}{End}{End}
	KeyWait Tab, D
	KeyWait Tab	
	Send {BS}{Down}{End}{End}
	return

:r0:insert::
	Send insert into  (){Enter}values (){Up}{Right 3}
	KeyWait Tab, D
	KeyWait Tab	
	Send {BS}{End}{Left}
	KeyWait Tab, D	
	KeyWait Tab
	Send {BS}{Down}{End}{Left}
	return

:r0:delete::
	Send delete from {Enter}where {up}{End}{End}
	KeyWait Tab, D
	KeyWait Tab	
	Send {BS}{Down}{End}{End}
	return

:r0:join::
	Send join  on (){Left 6}
	KeyWait Tab, D
	KeyWait Tab	
	Send {BS}{End}{Left}
	return

::odby::order by 
::odbyd::order by desc{Left 5}


;	***********
;	* HotKeys *
;	***********

; Write Lower() around selection
#+l::
	bak = %clipboard%
	Send ^{Insert}
	Send Lower(%clipboard%)
	clipboard = %bak%
	return

; Write Upper() around selection
#+u::
	bak = %clipboard%
	Send ^{Insert}
	Send Upper(%clipboard%)
	clipboard = %bak%
	return

; Write Count() around selection
#+c::
	bak = %clipboard%
	Send ^{Insert}
	Send Count(%clipboard%)
	clipboard = %bak%
	return

; Active/Inactive script
#S::Suspend
