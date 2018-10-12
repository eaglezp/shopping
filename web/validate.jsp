<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="com.eagle.util.DB" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/12
  Time: 21:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    response.setContentType("text/xml");
    response.setHeader("Cache-Control","no-store");

    String username = request.getParameter("username");
    Connection connection = null;
    ResultSet resultSet = null;
    Statement statement = null;
    try {
        connection = DB.getConn();
        String sql = "select count(*) from user where username='"+username+"'";
        statement = connection.createStatement();
        resultSet = statement.executeQuery(sql);
        if(resultSet.next()){
            response.getWriter().write("<msg>"+resultSet.getInt(1)+"</msg>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        DB.close(statement);
        DB.close(connection);
    }

%>
