Option Explicit

Dim QCConnection, Password, TestsFolder, LocalFolder

Set QCConnection = CreateObject("TDApiOle80.TDConnection")

Password = Inputbox("Password", "Enter the password")

WScript.Echo "Connecting..."
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

If (WScript.Arguments.Count < 2) Then
   TestsFolder = Inputbox("Folder", "Enter the test folder path")
   LocalFolder = Inputbox("Local Folder", "Enter the local folder path")
Else
   TestsFolder = WScript.Arguments.Item(0)
   LocalFolder = WScript.Arguments.Item(1)
End If

QCDownloadScripts TestsFolder, LocalFolder

WScript.Echo "Disconnecting..."

QCConnection.Disconnect
QCConnection.Logout
QCConnection.ReleaseConnection

WScript.Echo "Done"


'---------------------------------------------------------------------
' Get the list of tests
'---------------------------------------------------------------------
Sub QCDownloadScripts(TestsFolder, LocalFolder)
   Dim TreeMgr, TestTree, TestFactory, TestList, NodesList()
   Dim i, Test, ChildFrom, TestStorage


   If (InStr(TestsFolder, "DPS") > 0) Then
      Exit Sub
   End If
   
   WScript.Echo TestsFolder
   
   Set TreeMgr = QCConnection.TreeManager
   Set TestTree = TreeMgr.NodeByPath(TestsFolder)
   Set TestFactory = TestTree.TestFactory
   Set TestList = TestFactory.NewList("")

   For i = 1 To TestTree.Count
      Set ChildFrom = TestTree.Child(i)
      QCDownloadScripts TestsFolder & "\" & ChildFrom.Name, _
                        LocalFolder & "\" & ChildFrom.Name

      QCConnection.RefreshConnectionState
      If Not QCConnection.LoggedIn Then
         QCConnection.Login "frueda", Password
      End If
      If Not QCConnection.Connected Then
         QCConnection.Connect "ICRM", "ICRM"
      End If
   Next
 
   For Each Test In TestList
      Set TestStorage = Test.ExtendedStorage
      TestStorage.ClientPath = LocalFolder & "\" & Test.Name
      TestStorage.Load "", True
   Next
End Sub
