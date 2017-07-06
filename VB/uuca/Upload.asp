<%@ Language=VBScript %>
<!--#include virtual="/includes/writelog.asp"-->
<!--#include virtual="/includes/loader.asp"-->
<%
Server.ScriptTimeout = 900
'If form is posted
   Response.Buffer = True

   ' load object
   Dim load
      Set load = new Loader
      WriteToLog "1"

      ' calling initialize method
      load.initialize
      WriteToLog "2"

   ' File binary data
   Dim fileData
      fileData = load.getFileData("file")
      WriteToLog "3"
   ' File name
   Dim fileName
      fileName = LCase(load.getFileName("file"))
      WriteToLog "4"
   ' File path
   Dim filePath
      filePath = load.getFilePath("file")
      WriteToLog "5"
   ' File path complete
   Dim filePathComplete
      filePathComplete = load.getFilePathComplete("file")
      WriteToLog "6"
   ' File size
   Dim fileSize
      fileSize = load.getFileSize("file")
      WriteToLog "7"
   ' File size translated
   Dim fileSizeTranslated
      fileSizeTranslated = load.getFileSizeTranslated("file")
      WriteToLog "8"
   ' Content Type
   Dim contentType
      contentType = load.getContentType("file")
      WriteToLog "9"
   ' No. of Form elements
   Dim countElements
      countElements = load.Count
      WriteToLog "10"
   ' Value of text input field "name"
   Dim nameInput
      nameInput = load.getValue("name")
      WriteToLog "11"
   ' Path where file will be uploaded
   Dim pathToFile
      pathToFile = Server.mapPath("/_private/") & "\EMSData.mdb"
      WriteToLog "Before saveToFile call"
   ' Uploading file data
   Dim fileUploaded
      fileUploaded = load.saveToFile("file", pathToFile)
      WriteToLog "After saveToFile call: fileUploaded = " & fileUploaded

   ' destroying load object
   Set load = Nothing
   CloseLog
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE>Calendar Database Upload</TITLE>
</HEAD>
<BODY>
<a href=Default.asp>[Home]</a><BR>
<%If fileUploaded = true then%>
	File <%=fileName%> Uploaded!<br>
	File was of type <%=contentType%> and of size <%=fileSizeTranslated%>.
<%else%>
	Error Uploading File
<%end if%>
</BODY>
</HTML>

