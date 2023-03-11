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

ShowHotkeys(FileName)
{
    FileRead MyText, %FileName%

    Gui -Caption +AlwaysOnTop +Disabled -SysMenu +Owner
    Gui Color, AAAAAA
    Gui +LastFound
    WinSet Transparent, 220
    Gui Add, Text, , %MyText%
    Gui Show, NoActivate, Hotkeys for Spotify
}

CenterWindow(WinTitle, Width:=-1, WidthPercent:=50, ShiftPercent:=0)
{
	if (WinTitle = "")
	{
		WinGetTitle WinTitle, A
	}

    if (Width = -1)
    {
	    Width := A_ScreenWidth * WidthPercent / 100
    }

	Height := A_ScreenHeight * 0.90
	Shift := A_ScreenWidth * ShiftPercent / 100
	X := (A_ScreenWidth/2) - (Width/2) - Shift
	Y := (A_ScreenHeight/2) - (Height/2)

	MyWinWait(WinTitle, "", 10)
	WinRestore %WinTitle%
	WinMove %WinTitle%, , %X%, %Y%, %Width%, %Height%
}

OpenBrowser(URL, WinTitle, WidthPercent=50, Alternative=False)
{
    if (Alternative)
    {
        Run "C:\Program Files\qutebrowser\qutebrowser.exe" --target window %URL%
    }
    else
    {
        Run "C:\Users\RuedaFranciscoJose\AppData\Local\Vivaldi\Application\vivaldi.exe" /new-window %URL%
        ;Run "C:\Program Files\Mozilla Firefox\firefox.exe" -new-window %URL%
    }

    CenterWindow(WinTitle, , WidthPercent)
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


