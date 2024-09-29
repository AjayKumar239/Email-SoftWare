<html>
<head><style>
.myTextbox{
    font-size: 32px;
    size: 30px;
}
</style></head>
<body>
<%
String str=request.getParameter("msg");
if(str!=null)
    out.println("<p><font size=32 color=red>"+str+"</font></p>");
%>
<br><br><br><br><br><br><br><br>
<form name="f1" action="validatelogin.jsp">
<table align="center" width="50%">
<tr>
    <td>Email ID:<input type="text" name="uname" id="uname" class="myTextbox"></td>
</tr>
<tr>
    <td>Password:<input type="password" name="pwd" id="pwd" class="myTextbox"></td>
</tr>
<tr>
    <td><input type="submit" value="Submit"><input type="reset" value="Reset"></td>
</tr>
</table></form></body></html>
