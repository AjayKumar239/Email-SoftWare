<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    String driver = "com.mysql.jdbc.Driver";
    String connectionUrl = "jdbc:mysql://localhost:3306/";
    String database = "project";
    String userid = "root";
    String password = "008769";
    String[] selectedIds = request.getParameterValues("id");

    try {
        Class.forName(driver);
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
%>
<!DOCTYPE html>
<html>

<head>
    <style>
        * {
            text-align: center;
        }

        th,
        td {
            font-size: 32px;
        }
    </style>
</head>

<body>
    <%
        if (selectedIds != null && selectedIds.length > 0) {
            List<String> idList = new ArrayList<>();
            for (String id : selectedIds) {
                idList.add("'" + id + "'");
            }
            String idString = String.join(",", idList);

            try {
                connection = DriverManager.getConnection(connectionUrl + database, userid, password);
                statement = connection.createStatement();
                String sql = "SELECT * FROM department WHERE id IN (" + idString + ")";
                resultSet = statement.executeQuery(sql);

                if (resultSet.next()) {
    %>
    <table border="1" align="center" width="60%">
        <tr>
            <th>ID</th>
            <th>FACALITY</th>
            <th>DEPARTMENT</th>
        </tr>
        <%
                    do {
        %>
        <tr>
            <td>
                <%= resultSet.getString("id") %>
            </td>
            <td>
                <%= resultSet.getString("facality") %>
            </td>
            <td>
                <%= resultSet.getString("department") %>
            </td>
        </tr>
        <%
                    } while (resultSet.next());
        %>
    </table>
    <%
                } else {
                    out.println("No faculty selected.");
                }
                connection.close();
            } catch (Exception e) {
                out.println("Something went wrong");
            }
        } else {
            out.println("No faculty selected.");
        }
    %>
</body>

</html>
