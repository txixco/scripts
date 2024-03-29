#Persistent			; This keeps the script running permanently.
#SingleInstance		; Only allows one instance of the script to run.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Win+A to change Audio Playback Device
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Space::
	EnvAdd device, 1
	device:=Mod(device, 3)

	Switch device
	{
	    Case 0:
		Run C:\Programs\NirCmd\nircmdc setdefaultsounddevice "Speakers"
		soundToggleBox("Speakers")
		return
	    Case 1:
		Run C:\Programs\NirCmd\nircmdc setdefaultsounddevice "Headphones"
		soundToggleBox("Headphones")
		return
	    Case 2:
		Run C:\Programs\NirCmd\nircmdc setdefaultsounddevice "Headset Earphone"
		soundToggleBox("Headset Earphone")
		return
	}
Return

; Display sound toggle GUI
soundToggleBox(Device)
{
	IfWinExist, soundToggleWin
	{
		Gui, destroy
	}
	
	Gui, +ToolWindow -Caption +0x400000 +alwaysontop
	Gui, Add, text, x35 y8, Default sound: %Device%
	SysGet, screenx, 0
	SysGet, screeny, 1
	xpos:=screenx-275
	ypos:=screeny-100
	Gui, Show, NoActivate x%xpos% y%ypos% h30 w200, soundToggleWin
	
	SetTimer,soundToggleClose, 2000
}
soundToggleClose:
    SetTimer,soundToggleClose, off
    Gui, destroy
Return
