'------------------------------------------------------------ '
'@Function Name: QCSaveToResource 
'@Documentation Saves a text file to the QC Test Resources module 
'@Created By: Joe Colantonio
 '@Return Values: NONE 
'@Example: QcSaveToResource "Joe","qcresourcetest.txt","C:\QTPAUTOMATION\DATA","",""
 '-----------------------------------------------------------
Function QCSaveToResource(QcResourceName,fileNameToSave,fileToSavePath,resourceType,opt)
'************************** 
'Upload a resource
 '************************** 
Set qcConn = QCUtil.QCConnection
 Set oResource = qcConn.QCResourceFactory 
Set oCurrentResources =oResource.NewList("") 
Set oNewResource = Nothing
resourceCount = oCurrentResources.Count
For iNowResourceNum = 1 To resourceCount nowResource = 

 oCurrentResources.Item(iNowResourceNum).Name 	
   if UCase(nowResource) = UCase(QcResourceName) then 
    Set oNewResource = oCurrentResources.Item(iNowResourceNum) 	 
    resourceFound = "True" 	
   end if 

Next

If resourceFound = "True" Then   
 oNewResource.Filename = fileNameToSave 
 oNewResource.ResourceType = "Test Resource" 
 oNewResource.Post    
 oNewResource.UploadResource fileToSavePath, True  
Else   
 reporter.ReportEvent micFail,"Did not find a resource in the Test Resource module named " & QcResourceName,"Verify that a resource exist in the QC Test Resource module!" 
End If

Set oCurrentResources = Nothing 
Set oResource = Nothing

End Function
'------------------------------------------------------------ '
'@Function Name: QCGetResource 
'@Documentation Saves a text file from a QC Test Resource to a local dir 
'@Created By: Joe Colantonio
 '@Return Values: NONE
 '@Example: QCGetResource "qcresourcetest.txt","C:\Temp" 
'-----------------------------------------------------------
Function QCGetResource(resourceName,saveTo)
Set qcConn = QCUtil.QCConnection 
Set oResource = qcConn.QCResourceFactory 
Set oFilter = oResource.Filter
  oFilter.Filter("RSC_FILE_NAME") = resourceName

Set oResourceList = oFilter.NewList

If oResourceList.Count = 1 Then 
  Set oFile = oResourceList.Item(1) oFile.FileName = resourceName oFile.DownloadResource saveTo, True 
End If

Set qcConn = Nothing 
Set oResource = Nothing 
Set oFilter = Nothing 
Set oFlieList = Nothing
 Set oFile = Nothing
End Function