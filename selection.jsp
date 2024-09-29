<%@page import="java.sql.DriverManager" %>
    <%@page import="java.sql.ResultSet" %>
        <%@page import="java.sql.Statement" %>
            <%@page import="java.sql.Connection" %>
                <html>

                <head>
                    <style>
                        th,
                        td {
                            font-size: 32px;
                        }

                        .myCheckBox {
                            font-size: 32px;
                            width: 48px;
                        }

                        .myButton {
                            font-size: 32px;

                        }
                    </style>
                </head>

                <body>

                    <form >                       <center>
                            <input type="checkbox" id="check" name="check">
                        </center><br><br>
                        <table border="1" align="center" width="60%">
                            <tr>
                                <th>ID</th>
                                <th>FACALITY</th>
                                <th>SELECT</th>

                            </tr>
                            <% String driver="com.mysql.jdbc.Driver" ; String
                                connectionUrl="jdbc:mysql://localhost:3306/" ; String database="project" ; String
                                userid="root" ; String password="008769" ; try { Class.forName(driver); } catch
                                (ClassNotFoundException e) { e.printStackTrace(); } Connection connection=null;
                                Statement statement=null;
                                 ResultSet resultSet=null;
                                 
                                   String user_pwd=request.getParameter("facality");
                                String user_pwd=request.getParameter("department"); 
                                int flag=0;
                                 int id=0;
                                 try{
                                connection=DriverManager.getConnection(connectionUrl+database, userid, password);
                                statement=connection.createStatement();
                                 String sql="select * from department " ;
                                resultSet=statement.executeQuery(sql);
                                 while(resultSet.next()) {
                                mid=resultSet.getInt("id"); %>
                                <tr>
                                    <td>
                                        <%=resultSet.getString("id") %>
                                    </td>
                                    <td>
                                        <%=resultSet.getString("facality") %>
                                    </td>
                                    <td>
                                        <%=resultSet.getString("department") %>
                                    </td>
                                    <td>
                                        <input type="checkbox" name="del" value="<%=id%>">
                                    </td>


                                </tr>
                                <% } %>
                        </table>
                        <input type="hidden" name="target" value="select">
                        <input type="submit" id="delete" value="select"
                            style="align-items: center; width: 100px; height: 30px; margin-left: 450px; margin-top: 20px;background-color: aqua; color: rgb(15, 13, 13); border-radius: 5px;">

                    </form>
                    <% connection.close(); } catch (Exception e) { out.println("Something went wrong !"); } %>