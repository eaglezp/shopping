<%@ page import="com.eagle.dao.UserManager" %>
<%@include file="_sessioncheck.jsp"%>
<%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/6
  Time: 6:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    UserManager.deleteUsers(id);
%>
<html>
<head>
    <title>用户删除</title>
</head>
<body>
<p>删除成功！</p>
</body>
</html>
