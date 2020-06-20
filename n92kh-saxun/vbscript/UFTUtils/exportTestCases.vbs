Option Explicit

Const xlLeft = -4131 
Const xlRight = -4152 
Const xlCenter = -4108 
Const xlGeneral = 1 

Dim QCConnection,TestFolderPath,sLine ,sQCUrl 
'Return the TDConnection object.
Set QCConnection = CreateObject("TDApiOle80.TDConnection")

Dim sUserName, sPassword

'Specify Username or Enable the Input BOX
sUserName = "ririgoye"
'Specify the Password or Enable the Input Box which will Pop-Up when u run this file. 
sPassword = "ririgoye"

'sQCUrl = "Enter QC link"
'sQCUrl = sQCUrl &(chr(13) & chr(10)) 
'sQCUrl = sQCUrl  & "URL to be entered as  : http://qualitycenter.xxxxxx.com/qcbin"
'Quality Center URL
sQCUrl = Inputbox(sQCUrl , "QC PATH","http://swn01vqaqtp01:8080/qcbin")
QCConnection.InitConnectionEx  sQCUrl 		
'Inputbox(sQCUrl , "QC PATH","http://qualitycenter.xxxxxx.com/qcbin")
QCConnection.Login sUserName, sPassword

If (QCConnection.LoggedIn <> True) Then
    MsgBox "QC User Authentication Failed"
    WScript.Quit
End If

Dim sDomain, sProject
'Specify the Domain Name or Enable the INPUT Box
sDomain = "QR"
sProject = "Releases"

'This will connects to the Project
QCConnection.Connect sDomain, sProject

If (QCConnection.Connected <> True) Then
    MsgBox "QC Project Failed to Connect to " & sProject
    WScript.Quit
End If


TestFolderPath = "Subject\Provisioning Apps"


'Call ExporttestCases Funtion and Pass Folder Path parameter
Call ExportTestCases(TestFolderPath) 

QCConnection.Disconnect

'If the Export is successfull you will get the message Completed. 
msgbox "Completed"

'Logout the QC Session
QCConnection.Logout
QCConnection.ReleaseConnection 





Function ExportTestCases(strNodeByPath)
    Dim Excel, Sheet

    
    Set Excel = CreateObject("Excel.Application") 'Open Excel

Excel.Visible = true
    Excel.WorkBooks.Add() 'Add a new workbook
    'Get the first worksheet.
    Set Sheet = Excel.ActiveSheet
    
    'sheet name as Tests
    Sheet.Name = "Tests"
    
'Specify the Excel Sheet Properties   
 With Sheet.Range("A1:H1")
        .Font.Name = "Arial"
        .Font.FontStyle = "Bold"
        .Font.Size = 10
        .Font.Bold = True
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
        .Interior.ColorIndex = 15 'Light Grey
    End With
    
'Excel Sheet Column Header Values
    Sheet.Cells(1, 1) = "Subject (Folder Name)"
    Sheet.Cells(1, 2) = "Test Name (Manual Test Plan Name)"
    Sheet.Cells(1, 3) = "Description"
    Sheet.Cells(1, 4) = "Designer (Owner)"
    Sheet.Cells(1, 5) = "Status"
    Sheet.Cells(1, 6) = "Step Name"
    Sheet.Cells(1, 7) = "Step Description(Action)"
    Sheet.Cells(1, 8) = "Expected Result"
    Sheet.Cells(1, 9) = "Application ID"
     Sheet.Cells(1, 10) = " Project Identifier"
     Sheet.Cells(1,11) = "Count"

    'Call PrintFields(TestFactory)  
    Dim TreeMgr, TestTree, TestFactory, TestList
    
    'Connection to TreeManager which Represents the System tree and containing a subject tree and all hierarchial field trees
    Set TreeMgr = QCConnection.TreeManager

    'Specify the folder path in TestPlan, all the tests under that folder will be exported.

    'Gets the node at specified TreePath and strNodeByPath is a a Subject\.... folder path
    Set TestTree = TreeMgr.NodeByPath(strNodeByPath)
   
    'To Get the a list from all from Node, NewList will bring all the testcases from the perticular node
    Set TestFactory = TestTree.TestFactory
    Set TestList = TestFactory.NewList("")

    'Specify Array to contain all nodes of subject tree.
    Dim NodesList()
   
    'To Protedct all the Nodes specify as Preserve
    ReDim Preserve NodesList(0)

    'Assign root node of subject tree as NodeByPath node.
    NodesList(0) = TestTree.Path
    
    ' Call Function Getnodes list which will gets subnodes and return list in array NodesList
    Call GetNodesList(TestTree, NodesList)

    Dim Row, Node, TestCase, Counter
   'Starts saving Testcases from the 2nd Row
    Row = 2
    Counter = 1
    For Each Node In NodesList
        Set TestTree = TreeMgr.NodeByPath(Node)
        Set TestFactory = TestTree.TestFactory
        Set TestList = TestFactory.NewList("") 'Get a list of all from node.

        'Iterate through all the tests.
        For Each TestCase In TestList
            Dim DesignStepFactory, DesignStep, DesignStepList
            Set DesignStepFactory = TestCase.DesignStepFactory
            Set DesignStepList = DesignStepFactory.NewList("")
                    Sheet.Cells(Row, 1).Value = TestCase.Field("TS_SUBJECT").Path
                    Sheet.Cells(Row, 2).Value = TestCase.Field("TS_NAME")
	        Sheet.Cells(Row, 3).Value =stripHTML( TestCase.Field("TS_DESCRIPTION"))   
                Sheet.Cells(Row, 4).Value = TestCase.Field("TS_RESPONSIBLE")
                Sheet.Cells(Row, 5).Value = TestCase.Field("TS_STATUS")
                    Sheet.Cells(Row, 9).Value = TestCase.Field("TS_User_02")
	        Sheet.Cells(Row, 10).Value = TestCase.Field("TS_User_05")
	         Sheet.Cells(Row, 11).Value = Counter
	         Sheet.Cells(Row, 12).Value = DesignStepList.Count
	         Counter = Counter + 1
	         Row = Row + 1
           ' If DesignStepList.Count = 0 Then
                'Save a specified set of fields.
	   ' Sheet.Cells(Row, 1).Value = TestCase.Field("TS_SUBJECT").Path
          '      Sheet.Cells(Row, 2).Value = TestCase.Field("TS_NAME")
         '       Sheet.Cells(Row, 3).Value = stripHTML(TestCase.Field("TS_DESCRIPTION"))
	 '   Sheet.Cells(Row, 9).Value = TestCase.Field("TS_User_02")
	'    Sheet.Cells(Row, 10).Value = TestCase.Field("TS_User_05")
        '  Row = Row + 1

          '  Else
           '     For Each DesignStep In DesignStepList 
            '       'Save a specified set of fields.
             '       Sheet.Cells(Row, 4).Value = TestCase.Field("TS_RESPONSIBLE")
              '      Sheet.Cells(Row, 5).Value = TestCase.Field("TS_STATUS")
               '     
                '    'Save the specified design steps.
                 '   Sheet.Cells(Row, 6).Value =  stripHTML(DesignStep.StepName)
                  '  Sheet.Cells(Row, 7).Value =  stripHTML(DesignStep.StepDescription)
                   ' Sheet.Cells(Row, 8).Value =  stripHTML(DesignStep.StepExpectedResult)
                   ' Row = Row + 1
                   
                'Next
           ' End If
        Next
    Next
    
    'Call PrintFields(DesignStepFactory)
    
    Excel.Columns.AutoFit
    
    'Set the Column width for the following columns.
    Excel.Columns("C").ColumnWidth = 80 'Description
    Excel.Columns("G").ColumnWidth = 80 'Step Description(Action)
    Excel.Columns("H").ColumnWidth = 80 'Expected Result
    
    'Set Auto Filter mode.
    If Not Sheet.AutoFilterMode Then
        Sheet.Range("A1").AutoFilter
    End If
    
    'Freeze first row.
    Sheet.Range("A2").Select
    Excel.ActiveWindow.FreezePanes = True   
    
    'Save the newly created workbook and close Excel.
    Excel.ActiveWorkbook.SaveAs("C:\" & sProject & "_TESTCASES.xls")
    Excel.Quit
    
    Set Excel = Nothing
    Set DesignStepList = Nothing
    Set DesignStepFactory = Nothing
    Set TestList = Nothing
    Set TestFactory = Nothing
    Set TestTree = Nothing  
    Set TreeMgr = Nothing
End Function



Function GetNodesList(ByVal Node, ByRef NodesList)
    Dim i
    'Run on all children nodes
    For i = 1 To Node.Count
        Dim NewUpper
        'Add more space to dynamic array
        NewUpper = UBound(NodesList) + 1
        ReDim Preserve NodesList(NewUpper)
        
        'Add node path to array
        NodesList(NewUpper) = Node.Child(i).Path
        
        'If current node has a child then get path on child nodes too.
        If Node.Child(i).Count >= 1 Then
            Call GetNodesList(Node.Child(i), NodesList)
        End If
    Next
End Function



''
'Strips all the HTML tags from a string.
'
'@param:    strHTML A string with HTML tagges embedded.
'
'@return:               A string with all HTML tags stripped.
Function stripHTML(strHTML)
    'Strips the HTML tags from strHTML
    Dim objRegExp, strOutput
    Set objRegExp = New Regexp
    
    objRegExp.IgnoreCase = True
    objRegExp.Global = True
    objRegExp.Pattern = "<(.|\n)+?>"
    
    'Replace all line breaks with VB line breaks
    strOutput = Replace(strHTML, "<br>", vbLf)

    
    'Replace all HTML tag matches with the empty string
	If left(strOutput,6) = "<html>" Then
		strOutput = objRegExp.Replace(strOutput, "")
	End If
    
    
    'Replace all &lt;, &gt;, and &quot; with <, >, and "
    strOutput = Replace(strOutput, "&lt;", "<")
    strOutput = Replace(strOutput, "&gt;", ">")
    strOutput = Replace(strOutput, "&quot;", Chr(34))
    
    Set objRegExp = Nothing
    
    stripHTML = strOutput    'Return the value of strOutput
End Function



''
'Truncates a string to 32,767 characters for excel.
'
'@param:    strText String to be truncated.
'
'@return:               Truncated string.
Function Truncate(strText)
    'Excel Max Cell Length = 32,767 
    Dim sNotice
    sNotice = vbLf & "Contents Truncated..."
    
    If Len(strText) > 32767 Then
        strText = Left(strText, 32767 - Len(sNotice))
        strText = strText & sNotice
    End If
    
    Truncate = strText
End Function

