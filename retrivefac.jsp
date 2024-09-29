<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page session="true" %>
<%

String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "project";
String userid = "root";
String password = "008769";

try {
    Class.forName(driver);
} catch (ClassNotFoundException e) {
    e.printStackTrace();
    out.println("JDBC Driver not found.");
    return;
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
ArrayList<String> selectedMembers = (ArrayList<String>) session.getAttribute("id");
if (selectedMembers == null) {
    selectedMembers = new ArrayList<>();
}

String[] newSelections = request.getParameterValues("id");
if (newSelections != null) {
    for (String selection : newSelections) {
        if (!selectedMembers.contains(selection)) {
            selectedMembers.add(selection);
        }
    }
    session.setAttribute("id", selectedMembers);
}
%>
<!DOCTYPE html>
<html>
<head>
    <style>
        * {
            text-align: center;
        }
        th, td {
            font-size: 32px;
        }
    </style>
</head>
<body>
    <form action="Clear.jsp" method="post">
        <table border="1" align="center" width="80%">
            <h1>Selected Faculty:</h1>
            <tr>
                <th>ID</th>
                <th>FACULTY</th>
                <th>DEPARTMENT</th>
            </tr>
            <%
            if (!selectedMembers.isEmpty()) {
                try {
                    connection = DriverManager.getConnection(connectionUrl + database, userid, password);
                    statement = connection.createStatement();

                    for (String member : selectedMembers) {
                        String[] parts = member.split(":");
                        String mid = parts[0];
                        resultSet = statement.executeQuery("SELECT * FROM department WHERE sel=1);
                        while (resultSet.next()) {
            %>
            <tr>
                <td><%= resultSet.getInt("id") %></td>
                <td><%= resultSet.getString("facality") %></td>
                <td><%= resultSet.getString("department") %></td>
            </tr>
            <%
                        }
                    }

                } catch (SQLException e) {
                    out.println("SQL Error: " + e.getMessage());
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
                    if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
                    if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                }
            } else {
                out.println("No records selected.");
            }
            %>
        </table>
        <input type="submit" value="Delete Faculty "   style="align-items: center; width: 100px; height: 30px;  margin-top: 20px; background-color: aqua; color: rgb(15, 13, 13); border-radius: 5px;"/>
    </form>
    <input type="submit" value="Back "   style="align-items: center; width: 100px; height: 30px;  margin-top: 20px; background-color: aqua; color: rgb(15, 13, 13); border-radius: 5px;"/>
    <a href="./select.jsp">Select Faculty</a>
</body>
</html>
