;	**************************************
;	* Local Global Variables & Functions *
;	**************************************
#SingleInstance ignore

Application = DM
ForcePharmaDir := GetRegistryKey("ForcePharma", "InstallDir")
WebForceTempDir := ForcePharmaDir
WebForceDir := GetParent(ForcePharmaDir)
Password = clave

#include forcepharma.ahk

;	***************************
;	* Local Hotkeys - Letters *
;	***************************

; ForcePharma synchronization
#Y::
	Run %WebForceDir%\Syncman\Syncman.exe, %WebForceDir%\Syncman
	WinWait SyncMan - Profile, 
	IfWinNotActive SyncMan - Profile, , WinActivate, SyncMan - Profile, 
		WinWaitActive SyncMan - Profile, 
	Send {ENTER}{CTRLDOWN}{PGDN}{CTRLUP}
	MouseClick left,  335,  72
	Sleep 100
	MouseClick left,  297,  192
	Sleep 100
	Send {ALTDOWN}N{ALTUP}
	Return

; Prepare environtment to download a MKDB and do it
#M::
	IfExist C:\Store
		FileRemoveDir C:\Store, 1
	if (ErrorLevel > 0) {
		MsgBox No se ha podido eliminar el directorio C:\Store
		Return
	}
	; Uncomment the else statement for debugging purposes
	; else {
		; MsgBox Se ha eliminado el directorio C:\Store
	; }

	DeleteROFile("%ForcePharmaDir%\fpdb.db")
	DeleteROFile("%ForcePharmaDir%\starter.db")

	Gosub #T
	Goto #Y
