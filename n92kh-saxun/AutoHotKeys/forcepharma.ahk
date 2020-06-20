;	***************************************
;	* Common Global Variables & Functions *
;	***************************************

Menu TRAY, Icon, %ForcePharmaDir%\ForcePharma.exe

; Get the value for a registry key
GetRegistryKey(regPath, key) {
	regPath = Software\Dendrite\%regPath%
	RegRead value, HKCU, %regPath%, %key%
	if ErrorLevel
	{
		RegRead value, HKLM, %regPath%, %key%
		if ErrorLevel
			return ""
	}
	
	return value
}

; Get the parent for a directory
GetParent(directory) {
	parent := ""
	StringSplit	paths, directory, "\"
	n := --paths0
	Loop %n%
	{
		thisPath := paths%A_Index%
		parent := (A_Index = 1) ? thisPath : parent . "\" . thisPath
	}

	return parent
}

; Delete a read-only file
DeleteROFile(file) {
	FileSetAttrib -R, %file%
	FileDelete %file%
	
	if (ErroLevel > 0) {
		MsgBox No se ha podido eliminar el archivo %file%
		Exit
	}
	; Uncomment the else statement for debugging purposes
	; else {
		; MsgBox Se ha eliminado el archivo %file%
	; }
}	

;	**************
;	* Hotstrings *
;	**************

:*:evr::ExternalValidation_R.dll	; Ending character not needed
:c:fp::ForcePharma					; Case sensitive

;	*********************
;	* Hotkeys - Letters *
;	*********************

; Business Rules
#B::
	WinWait CLAVE - [, 
	IfWinNotActive CLAVE - [, , WinActivate, CLAVE - [, 
	WinWaitActive CLAVE - [, 
	Send {ALTDOWN}v{ALTUP}{ENTER}aa{RIGHT}r
	
	Return

; Business Objects
#+B::
	Gosub #B
	
	WinWait CLAVE - [Reglas de Negocios, 
	IfWinNotActive CLAVE - [Reglas de Negocios, , WinActivate, CLAVE - [Reglas de Negocios, 
	WinWaitActive CLAVE - [Reglas de Negocios, 
	MouseClick left,  542,  99

	Return

; Open a customer; chage if another customer
#C::
	; IfWinNotActive CLAVE, , WinActivate, CLAVE 
	; WinWaitActive CLAVE
	MouseClick left,  119,  192
	MouseClick left,  119,  192
	Send astiguetta{Tab 4}per-linea 03 o10{Enter}
	Sleep 2000
	MouseClick left,  65,  357
	MouseClick left,  65,  357
	; Sleep 100
	; WinWait CLAVE - [, 
	; IfWinNotActive CLAVE - [, , WinActivate, CLAVE - [, 
	; WinWaitActive CLAVE - [, 
	; MouseClick left,  339,  101
	; Sleep 100
	Return

; Edit dn_all_codes
#D::
	IfWinNotActive CLAVE, , WinActivate, CLAVE 
	WinWaitActive CLAVE
	IfWinNotActive DN_AL_CODES, , WinActivate, CLAVE 
	Send {ALTDOWN}v{ALTUP}{ENTER}aa{RIGHT}d
	MouseClick Left, 264, 124
	Send %clipboard%
	
	Return
	
; Consolidate dn_all_codes
#+D::
	IfWinNotActive CLAVE, , WinActivate, CLAVE 
	WinWaitActive CLAVE
	IfWinNotActive DN_AL_CODES, , WinActivate, CLAVE 
	Send {ALTDOWN}v{ALTUP}{ENTER}aa{RIGHT}c
	
	Return
	
#F::
	IfWinExist CLAVE 
	{
		IfWinNotActive CLAVE, , WinActivate, CLAVE, 
		WinWaitActive CLAVE, 
	}
	else
	{
		Run %ForcePharmaDir%\ForcePharma.exe, %WebForceTempDir%
		WinWait Seleccionar Usuario, 
		IfWinNotActive Seleccionar Usuario, , WinActivate, Seleccionar Usuario, 
		WinWaitActive Seleccionar Usuario, 
		Send %Password%{Enter}
	}
	return

; Set DFC Show Screen Numbers
#+N::
	RegRead currentValue, HKCU, Software\Dendrite\Force Pharma\Settings, DFC Show Screen Numbers
	if ErrorLevel
		RegWrite REG_DWORD, HKLM, Software\Dendrite\Force Pharma\Settings, DFC Show Screen Numbers, 1
	else
		RegWrite REG_DWORD, HKCU, Software\Dendrite\Force Pharma\Settings, DFC Show Screen Numbers, 1

	Gosub #T

	Return

; Set RebuildDictionary
#R::
	RegRead currentValue, HKCU, Software\Dendrite\Force Pharma\Private, LastProductLegal
	if ErrorLevel
		RegWrite REG_DWORD, HKLM, Software\Dendrite\Force Pharma\Private, ReBuildDictionary, 1
	else
		RegWrite REG_DWORD, HKCU, Software\Dendrite\Force Pharma\Private, ReBuildDictionary, 1
	
	Return

; Remove temporary files
#T::
	FileDelete %WebForceTempDir%\*.log
	if (ErrorLevel > 0) {
		MsgBox No se han podido eliminar los temporales
		Return
	}

	FileDelete %WebForceTempDir%\*.err
	if (ErrorLevel > 0) {
		MsgBox No se han podido eliminar los temporales
		Return
	}

	FileDelete %WebForceTempDir%\*.utl
	if (ErrorLevel > 0) {
		MsgBox No se han podido eliminar los temporales
		Return
	}

	FileDelete %WebForceTempDir%\*.ld
	if (ErrorLevel > 0) {
		MsgBox No se han podido eliminar los temporales
		Return
	}

	FileDelete %WebForceTempDir%\*.usr
	if (ErrorLevel > 0) {
		MsgBox No se han podido eliminar los temporales
		Return
	}

	FileDelete %WebForceTempDir%\*.lan
	if (ErrorLevel > 0) {
		MsgBox No se han podido eliminar los temporales
		Return
	}

	FileDelete %WebForceTempDir%\*.ul
	if (ErrorLevel > 0) {
		MsgBox No se han podido eliminar los temporales
		Return
	}

	Return
	
; Copy the last compiled ExternalValidation_R.dll
#X::
	IfExist %ForcePharmaDir%\ExternalValidation_R.dll 
		FileSetAttrib -R, %ForcePharmaDir%\ExternalValidation_R.dll

	FileCopy X:\ExternalValidation_R.dll, %ForcePharmaDir%, 1
	if (ErrorLevel > 0) {
		MsgBox No se ha podido copiar el archivo
		Return
	}

	MsgBox El archivo ExternalValidation_R.dll se ha copiado satisfactoriamente

	Return

;	********************
;	* Hotkeys - Others *
;	********************

; Encrypt HTML
#F2::
	HtmlDir := GetRegistryKey("Force Pharma\Settings", "HTML_DIR")
	Run C:\WebForce Tools\EncryptHtml.exe %HtmlDir%
	
	return
	
; Decrypt HTML
#F3::
	HtmlDir := GetRegistryKey("Force Pharma\Settings", "HTML_DIR")
	Run C:\WebForce Tools\EncryptHtml.exe -d %HtmlDir%
	
	return
	
; Copy the setup.db to Staging
#Right::
	MsgBox 4, HotKeys VisiForce, ¿Está seguro de que quiere copiar el archivo setup.db a Staging?
	IfMsgBox No
		return

	if (Application = HO) {
		Run net stop "Adaptive Server Anywhere - Setup"
		sleep 3000
	}

	IfExist S:\SanofiAventis\LA\V1_7_1\SR05\PC\Databases\setup.db
		FileSetAttrib -R, S:\SanofiAventis\LA\V1_7_1\SR05\PC\Databases\setup.db

	FileCopy %ForcePharmaDir%\setup.db, S:\SanofiAventis\LA\V1_7_1\SR05\PC\Databases, 1
	if (ErrorLevel > 0)
		MsgBox No se ha podido copiar el archivo

	if (Application = HO)
		Run net start "Adaptive Server Anywhere - Setup"

	MsgBox El archivo setup.db se ha enviado satisfactoriamente
	Return

; Copy the setup.db from Staging
#Left::
	if (Application = HO) {
		Run net stop "Adaptive Server Anywhere - Setup"
		sleep 3000
	}

	IfExist %ForcePharmaDir%\setup.db
		FileSetAttrib -R, %ForcePharmaDir%\setup.db

	FileCopy S:\SanofiAventis\LA\V1_7_1\SR05\PC\Databases\setup.db, %ForcePharmaDir%, 1
	if (ErrorLevel > 0) {
		MsgBox No se ha podido copiar el archivo
		Return
	}

	Gosub #T

	if (Application = HO)
		Run net start "Adaptive Server Anywhere - Setup"

	MsgBox El archivo setup.db se ha recibido satisfactoriamente
	Return
