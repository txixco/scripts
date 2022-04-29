; ***************************
; * Common Global Variables *
; ***************************

;Menu TRAY, Icon, %ForcePharmaDir%\ForcePharma.exe
SetTitleMatchMode, 2

tomorrow += 1, days
FormatTime date, %tomorrow%, dd/MM/yyyy
filas = 2

VPNStarted = true

; *************
; * Functions *
; *************

GetComment()
{
	FormatTime CurrentDate, , M/dd/yyyy
		Return "frueda " . CurrentDate
}

Explorer(file)
{
	Run explorer.exe %file%
		return
}

CenterWindow(WinTitle, WidthPercent:=50, ShiftPercent:=0)
{
	if (WinTitle = "")
	{
		WinGetTitle WinTitle, A
	}

	Width := A_ScreenWidth * WidthPercent / 100
	Height := A_ScreenHeight * 0.90
	Shift := A_ScreenWidth * ShiftPercent / 100
	X := (A_ScreenWidth/2) - (Width/2) - Shift
	Y := (A_ScreenHeight/2) - (Height/2)

	MyWinWait(WinTitle, "", 10)
	WinRestore %WinTitle%
	WinMove %WinTitle%, , %X%, %Y%, %Width%, %Height%
}

OpenBrowser(URL, WinTitle, WidthPercent=50)
{
    Run "C:\Program Files\Mozilla Firefox\firefox.exe" -new-window %URL%
    ;Run "C:\Program Files\qutebrowser\qutebrowser.exe" --target window %URL%

		CenterWindow(WinTitle, WidthPercent)
}

OpenMultiBrowser(WinTitle, WidthPercent=50, URLs*)
{
    for index, url in URLs
    {
    	if (index = 1)
    	{
    	    OpenBrowser(URL, WinTitle, WidthPercent)
    	}
    	else
    	{
    	    Run "C:\Program Files\Mozilla Firefox\firefox.exe" -new-tab %URL%
    	    ;Run "C:\Program Files\qutebrowser\qutebrowser.exe" --target tab-bg-silent %url%
    	}
    }
}

MyWinWait(WinTitle, WinText, Time)
{
	WinWait %WinTitle%, %WinText%, %Time%
		if ErrorLevel
		{
String := "Timeout opening the window with "
		if (WinTitle <> "")
		{
			String .= "title " . WinTitle
				if (WinText <> "")
				{
					String .= " and "
				}
		}
	if (WinText <> "")
	{
		String .= "text " . WinText
	}

	MsgBox %String%.
		Exit
		}
}

WaitUserInput(WinTitle, WinText, Time)
{
	MyWinWait(WinTitle, WinText, Time)
		WinWaitClose
}

; **************
; * Hotstrings *
; **************

:*:@proton::frueda@protonmail.com
:*:@tuta::frueda@tutanota.com
:*:@outlook::txixco@outlook.com
:*:@txixco::txixco@gmail.com
:*:@frueda::fruedadev@gmail.com
:*:@kindle::txixco_kindle@kindle.com
:*:@paymex::txixco.paymex@gmail.com
:*:@west::fjrueda@west.com
:*:@intrado::fjrueda@intrado.com
:*:@autobot::automationbot@west.com
:*:@rpa::rpa_dev@west.com

:*r:#intcel::+5215541904710
:*:#cel::5541904710
:*:#bncmr::4772913036789909
:*:#hsbc::021180065117382348
:*:#sacmex::2437199632010376
:*:#fctvl::6273181119965742
:*:#imss::21067302816
:*:#env::Windows 7 Enterprise 64bits, Chrome 34
:*:#sf::Salesforce

:*:#ahora::
   FormatTime, CurrentDateTime,, dd/MM/yyyy HH:mm:ss
   SendInput %CurrentDateTime%
   return

:*:#hoy::
   FormatTime, CurrentDateTime,, dd/MM/yyyy
   SendInput %CurrentDateTime%
   return

:*:#semana::
   FormatTime, CurrentDateTime,, YWeek
   SendInput %CurrentDateTime%
   return

:*:#tmtd::Changed the status to 'Automated'
:*:#nvld::Changed the status to 'Invalid'
:*:#dplct::Changed the status to 'Duplicate'
:*r:#jcomment::JIRA ID #AQA-

:*:fjr::Francisco J. Rueda
:*:yw::you're welcome
:*:jf::Jean-François
:*:botw::Breath of the Wild

:*:mdfdb::
    Comment := "Modified by " . GetComment()
    SendInput %Comment%
    Return

:*:crtdb::
    Comment := "Created by " . GetComment()
    SendInput %Comment%
    Return

:*:rucf::RUCF731010579
:*:curp::RUCF731010HNEDLR09

::mgus::
   SendInput +{Tab}^+{Right}
   bak = %clipboard%
   SendInput ^{Insert}
   ClipWait
   SendInput {Tab 4}Ok, muchas gracias %clipboard%.{Enter 2}Un saludo.{Enter}
   Sleep 1000
   clipboard = %bak%
   return

::gus::Gracias por adelantado y un saludo,
::sld::
   SendInput Un saludo.{Enter}
   return

::tbr::Thanks and best regards.
::tia::Thanks in advance and best regards.

; Emojis
:*:#besos::`:kissing_heart`:`:kissing_heart`:`:kissing_heart`:
;:*::)::🙂
;:*:|)::😊
;:*:;)::😉
;:*:B)::😎
;:*:;P::😜
;:*::P::😛
;:*::D::😄
;:*:|D::😁
;:*:XD::😂
;:*::B::🤭
;:*:O:)::😇
;:*::(::😟
;:*:K(::😔
;:*::,(::😢

; *********************
; * Hotkeys - Letters *
; *********************

$Space::
	GetKeyState scrollState, ScrollLock,  T
	if scrollState = D
	   Send _
	else
	   Send {Space}
	return

#A::
	OpenBrowser("https://alexa.amazon.com.mx", "Amazon Alexa", 70)
	return

#B::
	OpenBrowser("https://www.bible.com/", "Biblia")
	return

#^B::
	OpenBrowser("https://my.bible.com/es-ES/users/txixco/reading-plans/64-reading-gods-story/subscription/597501492", "Mozilla Firefox")
	return

#!B::
	Months := ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
	FormatTime Day, , d
	FormatTime Month, , M
	URL := "http://www.spurgeon.com.mx/chequera/" . Day . Months[Month] . ".html"
	OpenBrowser(URL, "Meditaciones Diarias")

	return

#C::
    Comment := GetComment()
    Send %Comment%
    return

#^C::
    counter = 1
    return

#+C::
    Send [%counter%]
    counter++
    return

#+D::
    Input key, L1
    if (key = "D")
    {
        OpenBrowser("https://dle.rae.es/?w=diccionario", "Diccionario")
    } else if (key = "W") {
        OpenBrowser("https://www.wordreference.com", "WordReference", 70)
    } else if (key = "T") {
        OpenBrowser("https://www.deepl.com/translator", "DeepL Translate", 70)
    }

    return

#E::
    Run "C:\Programs\Misc\Explorer++.exe"
    return

#F::
    Run "C:\Program Files (x86)\FileSeek\FileSeek.exe"

    return

#+F::
    OpenBrowser("http://feedly.com/", "All")

    return

#H::
    Run "%A_ProgramFiles%\IrfanView\i_view64.exe" C:\Users\frueda\Data\Downloads\horario.jpg /hide=15 /pos=(271,53)
    return

#I::
    Send 2528116{Tab}Sg286T32
    return

#J::
    Send http://jira.dev.iconf.net/browse/%clipboard%
    Return

#K::
	Run "C:\Dropbox\Documents\scripts\killall.bat" chromedriver.exe
	Return

!w:: Send <
!v:: Send >

#M::
	Run "%LINKS_PATH%\Utils\muCommander.lnk"
	return

#+M::
    OpenBrowser("https://www.google.com/maps", "Google Maps", 70)
    return

#!M::
    Input key, L1
    if (key = "W")
    {
        Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Webex\Webex.lnk"
    } else if (key = "M")
    {
        Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Teams.lnk"
    }

    return

#N::
    Run "%LINKS_PATH%\Utils\Neovim"
    return

#!N::
    Run "C:\Users\frueda\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Emacs-27.1\Emacs.lnk"
	
    return

#+N::
    Run "%A_Programs%\Joplin.lnk"

    return

; Open the selected file in the last activated window
#O::
   SendInput ^{Insert}
   ClipWait
   SendInput !{Tab}
   SendInput ^�
   Sleep 500
   SendInput +{Insert}

   return

#P::
    SendInput frueda@protonmail.com{Tab}5541904710
    return

#!P::
    SendInput Francisco J Rueda C{Tab}4815153008293403{Tab}11{Tab}2023{Tab}
    return

#Q::
    Run "C:\Program Files\qutebrowser\qutebrowser.exe" --target window
    return

#!R::
    OpenBrowser("https://read.amazon.com/", "Kindle")
    return

#S::
    Input key, L1
    if (key = "A")
    {
    	OpenBrowser("https://nx15083.your-storageshare.de/apps/files", "Storage Share", 70)
    } else if (key = "C") {
    	OpenBrowser("https://nx15083.your-storageshare.de/apps/calendar", "Storage Share", 70)
    } else if (key = "T") {
    	OpenBrowser("https://nx15083.your-storageshare.de/apps/contacts", "Storage Share", 70)
    }


    return

#T::
    Run "%LINKS_PATH%\Utils\Debian.lnk"
    CenterWindow("~", 70)
    Return

#!T::
    Run powershell.exe
    Return

; Change selected text case - To upper
#+T::
    bak = %clipboard%	; So it can be restored
    Send ^{Insert}
    ClipWait
    StringUpper clipboard, clipboard
    Send %clipboard%
    clipboard = %bak%

    return

; Change selected text case - To lower
;#!T::
;    bak = %clipboard%	; So it can be restored
;    Send ^{Insert}
;    ClipWait
;    StringLower clipboard, clipboard
;    Send %clipboard%
;    clipboard = %bak%
;    return

; Change selected text case - To title
#!+T::
	bak = %clipboard%	; So it can be restored
	Send ^{Insert}
	ClipWait
	StringLower clipboard, clipboard, T
	Send +{Insert}
	clipboard = %bak%

	return

#U::
    Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\UiPath\UiPath Studio"
    return

#^V::
    Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Cisco\Cisco AnyConnect Secure Mobility Client\Cisco AnyConnect Secure Mobility Client"
    MyWinWait("Cisco AnyConnect Secure Mobility Client", "", 30)
    ControlClick Disconnect, Cisco AnyConnect Secure Mobility Client
    if !ErrorLevel
	Exit

    ControlClick Connect, Cisco AnyConnect Secure Mobility Client

;    WaitUserInput("Cisco AnyConnect | ", "", 30)
;    MyWinWait("Cisco AnyConnect | ", "", 30)
;    Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Entrust\IdentityGuard Soft Token"
;    MyWinWait("Entrust IdentityGuard Token", "West-frueda", 30)
;    ControlClick X267 Y127, Entrust IdentityGuard Token
;    Sleep 1000
;    Send !{F4}
;    Sleep 1000
;    Send +{Insert}{Enter}

    return

#W::
  if GeometryMode = true
  {
	Gui, 2:Hide
    GeometryMode = false
  }
  Else
  {
	MouseGetPos,,, WinId
	WinGetTitle, WinTitle, ahk_id %WinId%
	Gui, 2:Show, NoActivate
    GeometryMode = true
  }
  Return

#^W::
    CenterWindow("")
    return

#!W::
    CenterWindow("", 70)
    return

#^!W::
    CenterWindow("", 70, 10)
    return

; Open Outlook
#Z::Run outlook.exe

; New items on Outlook
#+Z::
    Input key, L1
    if (key = "M")
    {
    	Run outlook.exe /c ipm.note
    } else if (key = "A") {
    	Run outlook.exe /c ipm.appointment
    } else if (key = "T") {
    	Run outlook.exe /c ipm.task
    } else if (key = "N") {
    	Run outlook.exe /c ipm.stickynote
    } else if (key = "J") {
    	Run outlook.exe /c ipm.activity
    }

    return

; Open alternative emails
#!Z::OpenMultiBrowser("ProtonMail", 70, "https://beta.protonmail.com/u/0/inbox", "https://mail.tutanota.com")

; *************************
; * Hotkeys - Non-Letters *
; *************************

; Send more than one zeros
^0:: Send 00
!0:: Send 000

; Unicode characters
<^>!4:: Send €
<^>!`:: Send º
<^>!+`:: Send ª

; Enclose between parentheses
#8::
	bak = %clipboard%	; So it can be restored
	Send ^{Insert}
	ClipWait
	clipboard = (%clipboard%)
	Send +{Insert}
	clipboard = %bak%
	return

; Window dependent help
#F1::
    IfWinActive WebStorm
    {
        Run "C:\Dropbox\My Ebooks\WebStorm_ReferenceCard_Windows_Linux.pdf"
    }

    return

; Show selection length
#F2::
	bak = %clipboard%	; So it can be restored
	Send ^{Insert}
	ClipWait
    MsgBox % "Longitud: " . StrLen(clipboard)
	Send +{Insert}
	clipboard = %bak%
	return

; Titulize a string
!#F2::
    bak = %clipboard%	; So it can be restored
    Send ^{Insert}
    ClipWait
    clipboard := RegExReplace(clipboard, " (.)?", "$U1")
    clipboard := RegExReplace(clipboard, "([-_]+)(.)?", "$1$U2")
    Send +{Insert}
    clipboard = %bak%
    return

; Decamel-case a string
^#F2::
    string := RegExReplace(clipboard, "([A-Z][a-z0-9]*)", " $1")
    string := RegExReplace(string, "(^[a-z])", "$U1")
    Send %string%
    return

; Constantize a string
+#F2::
    string := RegExReplace(clipboard, "([A-Z][a-z0-9]*)", "_$U1")
    string := RegExReplace(string, "(^[a-z])", "$U1")
    Send %string%
    return

; Actions for this script
#F4::Edit
#F5::Reload
#F6::Suspend

; WordReference Engish-Spanish
#F8::
	bak = %clipboard%	; So it can be restored
	Send ^{Insert}
	ClipWait
	StringLower clipboard, clipboard, T
	Run http://www.wordreference.com/es/translation.asp?tranword=%clipboard%
	clipboard = %bak%
	return

; WordReference Spanish-Engish
#+F8::
	bak = %clipboard%	; So it can be restored
	Send ^{Insert}
	ClipWait
	StringLower clipboard, clipboard, T
	Run http://www.wordreference.com/es/en/translation.asp?spen=%clipboard%
	clipboard = %bak%
	return

; Temporal HotKeys

#F9::
    SendInput {Tab %tabs%}
    return

#!F9::
	InputBox tabs, Set variables, Number of repetitions?, , , , , , , , %tabs%

	return

#+F9::
    bak = %clipboard%	; So it can be restored
    Send ^{Insert}
    ClipWait
    clipboard := RegExReplace(clipboard, "_", "")
    Send +{Insert}
    clipboard = %bak%
    return

#^F9::
    InputBox string, Set variables, String to write?, , , , , , , , %string%
    Sleep 500
    Send %string%
    return

!F9::
   WinMinimize A

   return

!F10::
   WinGet MX, MinMax, A
   If MX
      WinRestore A
   Else
      WinMaximize A

   return

!+F10::
   WinRestore A
   WinMove A, ,317, 11, 800, 850

   return

#F12::
   Gui -Caption +ToolWindow
   Gui Add, MonthCal, x0 y0 HwndCalHwnd

   WinGetPos,,, CalW, CalH, % "ahk_id " CalHwnd
   WinGetPos,,,, trayH, ahk_class Shell_TrayWnd

   Gui Show, % "x " ( os := -9999 ) " y" ( A_ScreenHeight - CalH - trayH ) " w" CalW " h" CalH, GUICal
   ControlGet, clkHwnd, Hwnd,, TrayClockWClass1, ahk_class Shell_TrayWnd

   Return

; Append selected text to the clipboard, separated by ', '
!Insert::
	bak = %clipboard%
	Send ^{Insert}
	ClipWait
	clipboard = %bak%, %clipboard%
;	Sort clipboard, N D,
	return

; Copy without the n first characters
#Insert::
    Send ^{Insert}
    ClipWait
    clipboard = SubStr(%clipboard%, %InitChar%)
    return

#+Insert::
   	InputBox InitChar, Set variables, Number of characters?, , , , , , , , %InitChar%
    return

#Delete::
Pause::
    Run "%LINKS_PATH%\Utils\MoveIt.lnk"
    return

; Snapshots

#PrintScreen::
    Run "%A_ProgramFiles%\IrfanView\i_view64.exe" /capture=0 /clipcopy
    return

#!PrintScreen::
    Run "%A_ProgramFiles%\IrfanView\i_view64.exe" /capture=2 /clipcopy
    return

#+!PrintScreen::
    Run "%A_ProgramFiles%\IrfanView\i_view64.exe" /capture=3 /clipcopy
    return

#^PrintScreen::
    Run "%A_ProgramFiles%\IrfanView\i_view64.exe" /capture=4 /clipcopy
    return

; *********************
; * Hotkeys - Unicode *
; *********************

<^>!<::Send {U+00AB}
<^>!>::Send {U+00BB}

; *********************
; * Multimedia Faking *
; *********************
^#Up::
  Send {Volume_Up}
  return

^+#Up::
  Send {Volume_Up 5}
  return

^#Down::
  Send {Volume_Down}
  return

^+#Down::
  Send {Volume_Down 5}
  return

^#Left::
  Send {Media_Prev}
  return

^#Right::
  Send {Media_Next}
  return

^#Space::
  Send {Media_Play_Pause}
  return

; *******************
; * Multimedia Real *
; *******************

#^Insert::
^Media_Play_Pause:: Run "%A_appdata%\Spotify\Spotify.exe"

#!Insert::
!Media_Play_Pause:: 
    Input key, L1
    if (key = "D")
    {
    	Run "%LINKS_PATH%\Spotify\Demon Hunter.url"
    } else if (key = "F") {
    	Run "%LINKS_PATH%\Spotify\Electronic Focus.url"
    } else if (key = "L") {
    	Run "%LINKS_PATH%\Spotify\Learning Music.url"
    } else if (key = "M") {
    	Run "%LINKS_PATH%\Spotify\MercyMe.url"
    } else if (key = "R") {
    	Run "%LINKS_PATH%\Spotify\Piano Prayer.url"
    } else if (key = "P") {
    	Run "%LINKS_PATH%\Spotify\Techno-praise.url"
    }

    return
Run "%A_appdata%\Spotify\Spotify.exe"

!Browser_Home:: Run C:\Programs\qutebrowser\qutebrowser.exe

^Browser_Home:: OpenBrowser(clipboard, "qutebrowser")

; ***************************
; * Hotkeys - Geometry Mode *
; ***************************

; Move/Resize window to the right
^Right::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinX++
    	Gosub MoveWindow
  } else {
    	Send ^{Right}
  }
  return

^+Right::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinX += 10
    	Gosub MoveWindow
  } else {
    	Send ^+{Right}
  }
  return

!Right::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinW += 5
	Gosub MoveWindow
  } else {
    	Send !{Right}
  }
  return

!+Right::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinW += 50
    	Gosub MoveWindow
  } else {
    	Send !+{Right}
  }
  return

; Move/Resize window to the left
^Left::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinX--
    Gosub MoveWindow
  } else {
    Send ^{Left}
  }
  return

^+Left::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinX -= 10
    Gosub MoveWindow
  } else {
    Send ^+{Left}
  }
  return

!Left::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinW -= 5
    Gosub MoveWindow
  } else {
    Send !{Left}
  }
  return

!+Left::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinW -= 50
    Gosub MoveWindow
  } else {
    Send !+{Left}
  }
  return

; Move window down
^Down::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinY++
    Gosub MoveWindow
  } else {
    Send ^{Down}
  }
  return

^+Down::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinY += 10
    Gosub MoveWindow
  } else {
    Send ^+{Down}
  }
  return

!Down::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinH += 5
    Gosub MoveWindow
  } else {
    Send !{Down}
  }
  return

!+Down::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinH += 50
    Gosub MoveWindow
  } else {
    Send !+{Down}
  }
  return

; Move window up
^Up::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinY--
    Gosub MoveWindow
  } else {
    Send ^{Up}
  }
  return

^+Up::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinY -= 10
	Gosub MoveWindow
  } else {
    Send ^+{Up}
  }
  return

!Up::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinH -= 5
    Gosub MoveWindow
  } else {
    Send !{Up}
  }
  return

!+Up::
  if GeometryMode = true
  {
	WinGetPos WinX, WinY, WinW, WinH, A
	WinH -= 50
    Gosub MoveWindow
  } else {
    Send !+{Up}
  }
  return

MoveWindow:
    WinMove A, , WinX, WinY, WinW, WinH
    return


; *******************
; * Window movement *
; *******************
#+Left::
	WinGetPos WinX, WinY, WinW, WinH, A
	WinX -= 10
	Gosub MoveWindow

	return

#+Right::
	WinGetPos WinX, WinY, WinW, WinH, A
	WinX += 10
	Gosub MoveWindow

	return

#+Up::
	WinGetPos WinX, WinY, WinW, WinH, A
	WinY -= 10
	Gosub MoveWindow

	return

#+Down::
	WinGetPos WinX, WinY, WinW, WinH, A
	WinY += 10
	Gosub MoveWindow

	return

#!Left::
	WinGetPos WinX, WinY, WinW, WinH, A
	WinX += 5
	WinW -= 10
	Gosub MoveWindow

	return

#!Right::
	WinGetPos WinX, WinY, WinW, WinH, A
	WinX -= 5
	WinW += 10
	Gosub MoveWindow

	return

#!Up::
	WinGetPos WinX, WinY, WinW, WinH, A
	WinY += 5
	WinH -= 10
	Gosub MoveWindow

	return

#!Down::
	WinGetPos WinX, WinY, WinW, WinH, A
	WinY -= 5
	WinH += 10
	Gosub MoveWindow

	return


; *************************
; * Hotkeys - Emacs rules *
; *************************
#IfWinActive, ahk_class Emacs
^SPACE::Send ^{Space}
#IfWinActive


; *****************
; * Other scripts *
; *****************

;#include programacion.ahk
;#include VirtuaWin.ahk
;#include sql.ahk
