VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisOutlookSession"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Function Subfolder(parent As folder, path As String) As folder
    Dim dest As folder
    
    splitted = Split(path, "\")
    Set dest = parent
    For Each current In splitted
        Set dest = dest.Folders(current)
    Next
    
    Set Subfolder = dest
End Function

Sub RemoveAttachment(subject As String, folderPath As String, move As Boolean)
    Dim item As Outlook.MailItem
    Dim attch As Outlook.Attachment
    Dim inbox As folder
    Dim toBeMoved As Object
    
    Set toBeMoved = CreateObject("System.Collections.ArrayList")
    
    Set inbox = Application.Session.GetDefaultFolder(olFolderInbox)
    For Each item In inbox.Items
        If item.subject = subject Then
            For Each attch In item.Attachments
                item.Attachments.Remove 1
            Next
            
            item.Save
            toBeMoved.Add item
        End If
    Next
    
    If move Then
        Set dest = Subfolder(inbox.parent, folderPath)
        For Each item In toBeMoved
            item.move dest
        Next
    End If
End Sub

Sub OnSIPReportMacro()
    RemoveAttachment "Summary of OnSIP Billing Process", "RPA\OnSIP Billing", True
End Sub
