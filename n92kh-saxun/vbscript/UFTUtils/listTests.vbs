Option Explicit

Dim QCConnection, Password, TreeMgr, Filter, FSO, CSVFile

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

Set TreeMgr = QCConnection.TreeManager
Set Filter = BuildFilter(Inputbox("Filter", "Enter the filter String"))

Set FSO = CreateObject("Scripting.FileSystemObject")
Set CSVFile = FSO.CreateTextFile("list.csv", 2, True)

QCPrintTests Inputbox("Folder", "Enter the test folder path"), Filter.Text

CSVFile.Close

WScript.Echo "Disconnecting..."

QCConnection.Disconnect
QCConnection.Logout
QCConnection.ReleaseConnection

WScript.Echo "Done"


'---------------------------------------------------------------------
' Get the list of tests
'---------------------------------------------------------------------
Function QCPrintTests(FolderPath, FilterText)
   Dim TestTree, TestFactory, TestList, NodesList(), ListFilter
   Dim i, CurrentTest, ChildFrom


   WScript.Echo FolderPath
   
   Set TestTree = TreeMgr.NodeByPath(FolderPath)
   Set TestFactory = TestTree.TestFactory
   Set TestList = TestFactory.NewList(FilterText)

   For i = 1 To TestTree.Count
      Set ChildFrom = TestTree.Child(i)
      QCPrintTests FolderPath & "\" & ChildFrom.Name, FilterText
   Next
 
   For Each CurrentTest In TestList
      CSVFile.WriteLine CurrentTest.Field("TS_USER_03") & "," & CurrentTest.Name
   Next
End Function

'---------------------------------------------------------------------
' Build the filter using a string
'---------------------------------------------------------------------
Function BuildFilter(FilterString)
   Dim TestTree, TestFactory, Filter, Elements, ListFilter

   Set TestTree = TreeMgr.NodeByPath("Subject")
   Set TestFactory = TestTree.TestFactory
   Set ListFilter = TestFactory.Filter

   For Each Filter In Split(FilterString, "|")
      Elements = Split(Filter, "=")
      ListFilter.Filter(Elements(0)) = Elements(1)
   Next

   Set BuildFilter = ListFilter
End Function
