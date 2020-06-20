Option Explicit

Dim qtApp, qtTest, qtResources
Dim i, testFile, FileName

Set qtApp = createobject("Quicktest.Application")

testFile = WScript.Arguments.Item(0)

WScript.Echo "Opening app..."
If Not qtApp.launched Then 
    qtApp.Launch 
    qtApp.Visible=True
End If

WScript.Echo "Opening script..."
qtApp.Open testFile, False

Set qtTest = qtApp.Test

WScript.Echo "Re-linking libraries..."
Set qtResources = qtTest.Settings.Resources.Libraries
For i = 1 To qtResources.Count
    FileName = GetFileName(qtResources(i))
    If (qtResources(i) <> FileName) Then
        qtResources.Remove qtResources(i)
        qtResources.Add FileName, 1
    Else
        WScript.Echo "Library already fixed"
    End If
Next

WScript.Echo "Re-linking repositories..."
Set qtResources = qtTest.Settings.Resources.Libraries
For i = 1 To qtResources.Count
    FileName = GetFileName(qtResources(i))
    If (qtResources(i) <> FileName) Then
        qtResources.Remove qtResources(i)
        qtResources.Add FileName, 1
    Else
        WScript.Echo "Repository already fixed"
    End If
Next

qtTest.Save

WScript.Echo "Exiting..."

Set qtApp = Nothing

Function GetFileName(Resource)
    Dim Items

    Items = Split(Resource, "\")

    GetFileName = Items(Ubound(Items))
End Function