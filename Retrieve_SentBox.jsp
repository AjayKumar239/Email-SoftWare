<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%

String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "emailsoftware";
String userid = "root";
String password = "008769";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
String email_id=session.getAttribute("emailid").toString();

%>



<!DOCTYPE html>
<html>
<head><style>
*{
text-align:center;
}
th,td{
font-size:32px;
}

</style></head>
<body>
    <table border=1 width="90%" align=center><tr><td align=center><a href="inbox.jsp">Inbox</a></td><td align=center><a href="sentbox.jsp">Sentbox</a></td><td align=center><a href="compose.jsp">ComposeMail</a></td><td align=center><a href="logout.jsp">Logout</a></td></tr></table><br><br>
<form action="./delete.jsp">
 
<h1>Retrieve_SentBox  </h1>
<table border="1" align="center" width="80%">
<tr>
<th>MTo</th>
<th>Subject</th>
<th>text</th>
<th> select </th>

</tr>
<%
int mid=0;
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql ="select * from mails where MFrom= '"+email_id +"' and SentBox=1"; 
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
  mid=resultSet.getInt("mid");

%>
<tr>
<td><%=resultSet.getString("MTo") %></td>
<td><%=resultSet.getString("Subject") %></td>
<td><%=resultSet.getString("Mtext") %></td>
<td><input type="checkbox" name="del" value="<%=mid%>">  </td>


</tr>
<%
}
connection.close();
} catch (Exception e) {
out.println("something went wrong!");
}
%>
</table> 
<input type="hidden" name="target" value="sentbox">
<input type="submit"  id="delete"  value="delete">
</form>

<a href="./compose.jsp">Back to composemails</a>
<a href="./inbox.jsp">inbox</a>
</body>
</html>