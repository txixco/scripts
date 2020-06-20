#InstallKeybdHook
#Persistent
#HotkeyInterval,100
#NoEnv
#NoTrayIcon
#WinActivateForce

SetKeyDelay, –1
SetTitleMatchMode, 2 ; Makes matching the titles easier
SendMode Input
SetWorkingDir %A_ScriptDir%

F11::
{
  WinGetTitle, currentWindowTitle, A
  WinHide, %currentWindowTitle%
  WinActivate, Internet Explorer
  Return
}

F12::
{
  DetectHiddenWindows, On
  WinActivate, %currentWindowTitle%
  Return
}
