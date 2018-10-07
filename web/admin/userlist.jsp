<%@ page import="java.util.List" %>
<%@ page import="com.eagle.entity.User" %>
<%@ page import="com.eagle.dao.UserDao" %>
<%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/6
  Time: 5:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="_sessioncheck.jsp"%>
<%
    List<User> userList = UserDao.getUsers();
%>
<html>
<head>
    <title>用户列表</title>
</head>
<body>
    <table border="1" align="center">
        <tr>
            <td align="center">ID</td>
            <td align="center">用户名</td>
            <td align="center">密码</td>
            <td align="center">电话</td>
            <td align="center">地址</td>
            <td align="center">注册日期</td>
            <td align="center">处理</td>
        </tr>
        <%
            for (User user : userList){
        %>
                <tr>
                    <td><%=user.getId()%></td>
                    <td><%=user.getUsername()%></td>
                    <td><%=user.getPassword()%></td>
                    <td><%=user.getPhoneNum()%></td>
                    <td><%=user.getAddr()%></td>
                    <td><%=user.getRdate()%></td>
                    <td>
                        <a href="userdelete.jsp?id=<%=user.getId()%>">DEL</a>
                    </td>
                </tr>

        <%
            }
        %>
    </table>
</body>
</html>
