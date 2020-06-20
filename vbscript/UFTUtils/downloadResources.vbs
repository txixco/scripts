Option Explicit

Dim QCConnection, Resource, ResourceName, Password

Set QCConnection = CreateObject("TDApiOle80.TDConnection")

Password = Inputbox("Password", "Enter the password")

QCConnection.InitConnectionEx "http://swn01vqaqtp01:8080/qcbin"
QCConnection.Login "frueda", Password

If Not QCConnection.LoggedIn Then
   WScript.Echo "QC User Authentication Failed"
   WScript.Quit
End If

QCConnection.Connect "ICRM", "ICRM"

If Not QCConnection.Connected Then
   WScript.Echo "QC Project Failed to Connect to ICRM"
   WScript.Quit
End If

Set Resource = QCConnection.QCResourceFactory

QCGetResource Inputbox("ResourceName", "Resource Name"), _
              Inputbox("SaveTo", "Save To")

'QCGetResource "DT.*\.xls", "C:\iCRMData"

QCConnection.Disconnect
QCConnection.Logout
QCConnection.ReleaseConnection 

'---------------------------------------------------------------------
' Saves a text file from a QC Test Resource to a local dir
'---------------------------------------------------------------------
Function QCGetResource(ResourceName,Target)
   Dim Filter, ResourceList, File, i, Founded, RegEx

   Set Filter = Resource.Filter
   Filter.Filter("RSC_FILE_NAME") = ""
   Set ResourceList = Filter.NewList

   Set RegEx = New RegExp
   RegEx.Pattern = ResourceName

   For i = 1 To ResourceList.Count
      Set File = ResourceList.Item(i)
      If RegEx.Test(File.FileName) Then
         Founded = Founded + 1
         WScript.Echo "Downloading " & File.FileName & "..."
         File.DownloadResource Target, True
      End If       
   Next

   WScript.Echo Founded & " resource(s) downloaded to " & Target
End Function