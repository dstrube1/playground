<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE>Server Variables</TITLE>
</HEAD>
<BODY>
<a href=Default.asp>[Home]</a><BR>
<%
for each x in Request.ServerVariables
  response.write(x & " = " & Request.ServerVariables(x) & "<br />")
next
 %>

</BODY>
</HTML>
