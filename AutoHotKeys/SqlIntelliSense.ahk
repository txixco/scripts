#SingleInstance ignore

SetKeyDelay, 0

; Read tables
Loop Read, Tables.txt
	TableNames%A_Index% = %A_LoopReadLine%

; Use the Input command to watch for commands that the user types:
Loop 
{
	; Get all keys till endkey:
	Input, InputWord, V, {F6}{Enter}{Space}{Escape}{Up}{Down}{Left}{Right}, 
	InputKey = %ErrorLevel%
	
	; Tooltip is hidden in these cases:
	if InputKey in EndKey:Enter,EndKey:Escape,EndKey:Space,EndKey:Up,EndKey:Down,EndKey:Left,EndKey:Right
	{
		Menu TablesList, Add, Temp, Prueba
		Menu TablesList, Delete, 
		Continue
	}

	; Compensate for any indentation that is present:
	StringReplace, InputWord, InputWord, %A_Space%,, All
	StringReplace, InputWord, InputWord, %A_Tab%,, All
	if InputWord =
		Continue
	
	; Match word with table
	i := 0
	StringLen nCount, InputWord
	Loop 
	{
		ThisTable := TableNames%A_Index%
		if ThisTable =
			break
		
		StringLeft ThisTablePart, ThisTable, %nCount%
		if (InputWord = ThisTablePart)
		{
			Menu TablesList, Add, %ThisTable%, Prueba
			i++
		}
	}

	; If no match then resume watching user input
	if i = 0
		Continue

	; Show matched command to guide the user:
	ThisTableName := TableNames%i%
	Menu TablesList, Color, FFFF00
	Menu TablesList, Show, A_CaretX, A_CaretY + 20 event
}
