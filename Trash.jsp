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
                    <table border=1 width="90%" align=center>
                        <tr>
                            <td align=center><a href="./inbox.jsp">Inbox</a></td>
                            <td align=center><a href="SentBox.jsp">Sentbox</a></td>
                            <td align=center><a href="compose.jsp">ComposeMail</a></td>
                            <td align=center><a href="logout.jsp">Logout</a></td>
                        </tr>
                    </table><br><br>
                    <form action="deleteMails.jsp">
                        <center>
                            <h1>My SentBox</h1>
                        </center><br><br>
                        <table border="1" align="center" width="60%">
                            <tr>
                                <th>To</th>
                                <th>From</th>
                                <th>Subject</th>
                                <th><input type=button class="myButton" value="Delete"></th>
                            </tr>
                            <% String id=request.getParameter("uname"); String driver="com.mysql.jdbc.Driver" ; String
                                connectionUrl="jdbc:mysql://localhost:3306/" ; 
                                String database="emailsoftware" ; String
                                userid="root" ; 
                                String password="008769" ;
                                 try { 
                                    Class.forName(driver);
                                 } catch (ClassNotFoundException e)
                                  { e.printStackTrace(); 
                                }
                                 Connection connection=null;
                                Statement statement=null;
                                 ResultSet resultSet=null; 
                                 String user_id=session.getAttribute("emailid").toString(); 
                                 String user_pwd=request.getParameter("pwd");
                                  int flag=0; 
                                  int mid=0;
                                  try{
                                connection=DriverManager.getConnection(connectionUrl+database, userid, password);
                                statement=connection.createStatement(); 
                                String sql = "SELECT * FROM mails WHERE (MFrom = '" + user_id + "' AND setbox = 0) OR (MTo = '" + user_id + "' AND Inbox = 0)";

                                resultSet = statement.executeQuery(sql); 
                                
                                while(resultSet.next())
                                {
                                     mid=resultSet.getInt("mid");
                                
                                 %>



                                <tr>
                                    <td>
                                        <%=resultSet.getString("MTo") %>
                                    </td>
                                    <td>
                                        <%=resultSet.getString("MFrom") %>
                                    </td>
                                    <td><a href="ReadMail1.jsp?mid=<%=mid%>">
                                        <%=resultSet.getString("subject")%>
                                    </a></td>
                                    <td><input type="checkbox" name="del" value="<%=mid%>">  </td>


                                </tr>
                                <% 
                            } 
                            %>
                        </table>
                        <input type="hidden" name="target" value="sentbox">
                        <input type="submit" id="delete" value="delete"  style="align-items: center; width: 100px; height: 30px; margin-left: 450px; margin-top: 20px;background-color: aqua; color: rgb(15, 13, 13); border-radius: 5px;">

                    </form>
                    <% connection.close(); 
                } catch (Exception e)
                 { out.println("Something went wrong !"); 
                }
                 %>