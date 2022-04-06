VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisOutlookSession"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True

Sub RemoveAttachment()
    Dim item As Outlook.MailItem
    Dim attch As Outlook.Attachment
    Dim parent As folder
    
    Set parent = Application.Session.GetDefaultFolder(olFolderInbox).parent
    For Each item In Application.ActiveExplorer.CurrentFolder.Items
        If item.Subject = "Summary of OnSIP Billing Process" Then
            For Each attch In item.Attachments
                item.Attachments.Remove 1
            Next
            
            item.Move parent.Folders("RPA").Folders("OnSIP Billing")
        End If
    Next
End Sub
