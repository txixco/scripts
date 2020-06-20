Option Explicit

Dim QCConnectOld, QCConnectNew, Password, TreeMgrOld, TreeMgrNew, FSO, CSVFile

Set QCConnectOld = CreateObject("TDApiOle80.TDConnection")
Set QCConnectNew = CreateObject("TDApiOle80.TDConnection")

Password = Inputbox("Password", "Enter the password")

QCProjectConnect QCConnectOld, "iCRM_Restore"
QCProjectConnect QCConnectNew, "iCRM"

Set FSO = CreateObject("Scripting.FileSystemObject")
Set CSVFile = FSO.CreateTextFile("list.csv", 2, True)

Set TreeMgrOld = QCConnectOld.TreeManager
Set TreeMgrNew = QCConnectNew.TreeManager

QCPrintTests Inputbox("Folder", "Enter the test folder path")

CSVFile.Close

QCDisconnect QCConnectOld
QCDisconnect QCConnectNew

WScript.Echo "Done"


'---------------------------------------------------------------------
' Connect to a project
'---------------------------------------------------------------------
Function QCProjectConnect(QCConnect, Project)
   WScript.Echo "Connecting to " & Project & "..."
   QCConnect.InitConnectionEx "http://swn01vqaqtp01:8080/qcbin"
   QCConnect.Login "frueda", Password

   If Not QCConnect.LoggedIn Then
      WScript.Echo "QC User Authentication Failed"
      WScript.Quit
   End If

   QCConnect.Connect "ICRM", Project

   If Not QCConnect.Connected Then
      WScript.Echo "QC Project Failed to Connect to " & Project
      WScript.Quit
   End If
End Function


'---------------------------------------------------------------------
' Disconnect a project
'---------------------------------------------------------------------
Function QCDisconnect(QCConnect)
   WScript.Echo "Disconnecting..."

   QCConnect.Disconnect
   QCConnect.Logout
   QCConnect.ReleaseConnection
End Function

'---------------------------------------------------------------------
' Get the list of different tests
'---------------------------------------------------------------------
Function QCPrintTests(FolderPath)
   Dim TestTree, TestFactory, TestList, NodesList(), ListFilterOld
   Dim i, CurrentTest, ChildFrom

   WScript.Echo FolderPath

   Set TestTree = TreeMgrOld.NodeByPath(FolderPath)
   Set TestFactory = TestTree.TestFactory
   Set TestList = TestFactory.NewList("")
 
   For Each CurrentTest In TestList
      If QCFindTest(FolderPath, CurrentTest.Name) Is Nothing Then
         QCCopyTest CurrentTest, FolderPath
         WScript.Echo vbTab & FolderPath & "\" & CurrentTest.Name
         CSVFile.WriteLine FolderPath & "\" & CurrentTest.Name
      End If
   Next

   For i = 1 To TestTree.Count
      Set ChildFrom = TestTree.Child(i)
      QCPrintTests FolderPath & "\" & ChildFrom.Name
   Next
End Function


'---------------------------------------------------------------------
' Find a test in a folder
'---------------------------------------------------------------------
Function QCFindTest(FolderPath, TestName)
   Dim TestTree, TestFactory, ListFilter, Filter, Tests

   Set TestTree = TreeMgrNew.NodeByPath(FolderPath)
   Set TestFactory = TestTree.TestFactory
   Set ListFilter = TestFactory.Filter
   ListFilter.Filter("TS_NAME") = """" & TestName & """"
   Set Tests = TestFactory.NewList(ListFilter.Text)

   If (Tests.Count > 0) Then
      Set QCFindTest = Tests(1)
   Else
      Set QCFindTest = Nothing
   End If
End Function


'---------------------------------------------------------------------
' Copy a test between connections
'---------------------------------------------------------------------
Function QCCopyTest(Test, FolderPath)
   Dim SourceFolder, TargetFolder, Iscp, Clipboard

   Set SourceFolder = TreeMgrOld.NodeByPath(FolderPath)
   Set TargetFolder = TreeMgrNew.NodeByPath(FolderPath)

   Set Iscp = SourceFolder.TestFactory
   Clipboard = iscp.CopyToClipBoard(Test.ID, 0, "")

   Set Iscp = TargetFolder.TestFactory
   Iscp.PasteFromClipBoard Clipboard, TargetFolder.NodeID, 1, 1
End Function
