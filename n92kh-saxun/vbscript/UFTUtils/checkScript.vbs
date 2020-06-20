Option Explicit

Dim qtApp, qtTest, qtLibraries, qtActions, qtRepositories
Dim i, j, testFile, FileName

Set qtApp = createobject("Quicktest.Application")

testFile = WScript.Arguments.Item(0)

WScript.Echo "Checking script " & testFile & "..."

If Not qtApp.launched Then 
   WScript.Echo "Checking script " & testFile & "..."
    qtApp.Launch 
    qtApp.Visible=False
End If

qtApp.Open testFile, False

Set qtTest = qtApp.Test

Set qtLibraries = qtTest.Settings.Resources.Libraries
For i = 1 To qtLibraries.Count
    FileName = GetFileName(qtLibraries(i))
    If (Left(Trim(qtLibraries(i)), 1) = "[") Then
        WScript.Echo "   Library " & FileName & " pointing to ALM"
    End If
Next

Set qtActions = qtTest.Actions
For i = 1 To qtTest.Actions.Count
    FileName = GetFileName(qtActions(i).Location)
    If (Left(Trim(qtActions(i).Location), 1) = "[") Then
        WScript.Echo "   Action " & FileName & " pointing to ALM"
    End If

    Set qtRepositories = qtActions(i).ObjectRepositories
    For j = 1 to qtRepositories.Count
        FileName = GetFileName(qtRepositories(j))
        If (Left(Trim(qtRepositories(j)), 1) = "[") Then
            WScript.Echo "   Repository " & FileName & " pointing to ALM"
        End If
    Next
Next

Set qtApp = Nothing

Function GetFileName(Resource)
    Dim Items

    Items = Split(Resource, "\")

    GetFileName = Items(Ubound(Items))
End Function