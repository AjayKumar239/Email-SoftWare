<%@ page import="java.sql.*" %>
<html>
<head>
    <style>
        .myTextBox {
            font-size: 32px;
        }
        .myButton {
            font-size: 32px;
        }
    </style>
</head>
<body>
<br><br><br><br><br><br><br><br>
<%
String str = request.getParameter("msg");
String emailid = "";
if (session.getAttribute("emailid") != null)
    emailid = session.getAttribute("emailid").toString();
if (str != null)
    out.println("<font size=32 color=red>" + str + "</font>");
int mid = Integer.parseInt(request.getParameter("mid"));
String driver = "com.mysql.cj.jdbc.Driver";
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
String mfrom = "", mto = "", subject = "", mtext = "", attachment = "";

try {
    connection = DriverManager.getConnection(connectionUrl + database, userid, password);
    statement = connection.createStatement();
    String sql = "select * from mails where mid=" + mid;
    resultSet = statement.executeQuery(sql);
    if (resultSet.next()) {
        mfrom = resultSet.getString("MFrom");
        mto = resultSet.getString("MTo");
        subject = resultSet.getString("subject");
        mtext = resultSet.getString("Mtext");
        mid = resultSet.getInt("mid");
%>
        <form name="f1" action="delete1.jsp" method="post">
            <table align="center" width="65%" border="0">
                <tr>
                    <td class="myTextBox">From:</td>
                    <td><input type="text" class="myTextBox" name="mfrom" id="mfrom" value="<%= mfrom %>" readonly></td>
                </tr>
                <tr>
                    <td class="myTextBox">To:</td>
                    <td><input type="text" class="myTextBox" name="mto" id="mto" value="<%= mto %>" readonly></td>
                </tr>
                <tr>
                    <td class="myTextBox">Subject:</td>
                    <td><input type="text" class="myTextBox" name="subj" id="subj" value="<%= subject %>" readonly></td>
                </tr>
                <tr>
                    <td class="myTextBox">Text:</td>
                    <td><textarea name="mtext" id="mtext" class="myTextBox" readonly><%= mtext %></textarea></td>
                </tr>
                <tr>
                    <td></td>
                    <td><br><br><input type="hidden" name="mid" value="<%= mid %>"></td>
                </tr>
            </table>
            <input type="hidden" name="target" value="sentbox">
            <input type="submit" id="delete" value="delete" name="del"  style="align-items: center; width: 100px; height: 30px; margin-left: 450px; margin-top: 20px;background-color: aqua; color: rgb(15, 13, 13); border-radius: 5px;">
        </form>
<%
    }
    connection.close();
} catch (Exception e) {
    out.println("Something went wrong!");
   
}
%>
</body>
</html>
