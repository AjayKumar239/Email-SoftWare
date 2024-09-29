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
                            width: 32px;
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
                            <td align=center><a href="inbox.jsp">Inbox</a></td>
                            <td align=center><a href="sentbox.jsp">Sentbox</a></td>
                            <td align=center><a href="Trash.jsp">Trash</a></td>
                            <td align=center><a href="compose.jsp">ComposeMail</a></td><td align=center><a href="logout.jsp">Logout</a></td></tr>
                        </tr>
                    </table><br><br>
                    <form action="deleteMails.jsp">
                    <center>
                        <h1>My SentBox</h1>
                    </center><br>
                    <table border="1" align="center" width="60%">
                        <tr>
                            <th>From</th>
                            <th>Subject</th>
                            <!-- <th><input type=button class="myButton" value="Delete"></th> -->
                             <th>Select</th>
                        </tr>
                        <% String id=request.getParameter("uname");
                         String driver="com.mysql.jdbc.Driver" ; 
                         String connectionUrl="jdbc:mysql://localhost:3306/" ;
                          String database="emailsoftware" ; 
                          String userid="root" ;
                        String password="008769" ;
                         try {
                             Class.forName(driver); 
                            }
                             catch(ClassNotFoundException e) {
                                 e.printStackTrace(); 
                                } 
                             Connection connection=null;
                              Statement statement=null;
                               ResultSet resultSet=null;
                                String user_id=session.getAttribute("emailid").toString(); 
                                String user_pwd=request.getParameter("pwd"); 
                                
                                try{
                            connection=DriverManager.getConnection(connectionUrl+database, userid, password);
                            statement=connection.createStatement();
                             String sql="select * from mails where MTo='"+user_id+"' and inbox=1";
                            resultSet=statement.executeQuery(sql); 
                            int mid;
                            while(resultSet.next()){
                                 mid=Integer.parseInt(resultSet.getString("mid")); 
                                 %>
                            <tr>
                                <td>
                                    <%=resultSet.getString("MFrom") %>
                                </td>
                                <td><a href="ReadMail1.jsp?mid=<%=mid%>">
                                        <%=resultSet.getString("subject")%>
                                    </a></td>
                                <td align=center><input type=checkbox class="myCheckBox" name="del" value="<%=mid%>"></td>

                            </tr>
                            <% 
                        }
                         %>
                    </table>
                    <input type="hidden" name="target" value="inbox">
                    <input type="submit"  id="delete"  value="delete"  style="align-items: center; width: 100px; height: 30px; margin-left: 450px; margin-top: 20px;background-color: aqua; color: rgb(15, 13, 13); border-radius: 5px;">
 
                </form>
                    <% connection.close(); 
                } catch (Exception e)
                 { out.println("Something went wrong !");
                 } %>