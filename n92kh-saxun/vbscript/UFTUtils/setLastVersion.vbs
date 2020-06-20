Option Explicit

Dim QCConnection, Password

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


QCSetLastVersion Inputbox("Folder", "Enter the test folder path")
'QCSetLastVersion "Subject\iCRMR\Regression\Additional Tools\ResPlus Dial In"

WScript.Echo "Disconnecting..."
QCConnection.Disconnect
QCConnection.Logout
QCConnection.ReleaseConnection

WScript.Echo "Done"

'---------------------------------------------------------------------
' Set the last version as current for every testcase in the folder
'---------------------------------------------------------------------
Function QCSetLastVersion(FolderPath)
   Dim TreeMgr, TestTree, TestFactory, TestList, NodesList()
   Dim i, CurrentTest, ChildFrom, vcs, CurrentVersion, LastVersion

   WScript.Echo FolderPath
   
   Set TreeMgr = QCConnection.TreeManager
   Set TestTree = TreeMgr.NodeByPath(FolderPath)
   Set TestFactory = TestTree.TestFactory
   Set TestList = TestFactory.NewList("")

   For i = 1 To TestTree.Count
      Set ChildFrom = TestTree.Child(i)
      QCSetLastVersion(FolderPath & "\" & ChildFrom.Name)
   Next

   For Each CurrentTest in TestList
      Set vcs = CurrentTest.VCS
      CurrentVersion = CInt(vcs.CurrentVersion)
      LastVersion = vcs.VersionsEx.Count

      If (CurrentVersion < LastVersion) Then
         vcs.CheckOut LastVersion, "", False
         vcs.CheckIn False, "Recovering the version number to the last one"
      End If
   Next
End Function
