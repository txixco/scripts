;	**************************************
;	* Local Global Variables & Functions *
;	**************************************
#SingleInstance ignore

Application = HO
ForcePharmaDir := GetRegistryKey("ForcePharma", "InstallDir")
WebForceTempDir = C:\Documents and Settings\vfadmin\Force Pharma
WebForceDir := GetParent(ForcePharmaDir)
Password = 

#include forcepharma.ahk
