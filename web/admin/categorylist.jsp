<%@ page import="com.eagle.entity.Category" %>
<%@ page import="com.eagle.dao.CategoryDao" %>
<%@ page import="java.util.List" %>
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
    List<Category> categoryList = CategoryDao.getCategories();
%>
<html>
<head>
    <title>用户列表</title>
</head>
<body>
<table border="1" align="center">
    <tr>
        <td align="center">ID</td>
        <td align="center">PID</td>
        <td align="center">Name</td>
        <td align="center">描述</td>
        <td align="center">是否是叶子节点</td>
        <td align="center">Grade</td>
        <td align="center">处理</td>
    </tr>
    <%
        for (Category category : categoryList){
            String preStr = "";
            for(int i=1;i<category.getGrade();i++){
                preStr += "----";
            }
    %>
    <tr>
        <td><%=category.getId()%></td>
        <td><%=category.getPid()%></td>
        <td><%=preStr+category.getName()%></td>
        <td><%=category.getDescr()%></td>
        <td><%=category.isLeaf()? 1:0%></td>
        <td><%=category.getGrade()%></td>
        <td>
            <a href="addcategory.jsp?pid=<%=category.getId()%>">添加子类别</a>
        </td>
    </tr>

    <%
        }
    %>
</table>
</body>
</html>
