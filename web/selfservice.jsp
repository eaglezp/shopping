<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.eagle.entity.User" %>
<%
    User user = (User)session.getAttribute("user");
    if(user == null){
        return;
    }
%>
<html>
<head>
    <title>UserModify</title>
</head>
<body>
    <a href="usermodify.jsp">ModifyUserInfo</a>
</body>
</html>