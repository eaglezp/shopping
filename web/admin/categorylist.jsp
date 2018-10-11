<%@ page import="com.eagle.entity.Category" %>
<%@ page import="com.eagle.dao.CategoryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
    int pageNo = 1;
    final int PAGE_SIZE = 5;
    String pagenoStr = request.getParameter("pageno");
    if(pagenoStr != null && !pagenoStr.trim().equals("")){
        pageNo = Integer.parseInt(pagenoStr);
    }
    if(pageNo < 1){
        pageNo = 1;
    }
    List<Category> categoryList = new ArrayList<>();
    int pageCount = CategoryDAO.getCategories(categoryList,pageNo,PAGE_SIZE);
    if(pageNo > pageCount){
        pageNo = pageCount;
    }
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
        <td align="center">叶子节点</td>
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
        <td><%=category.isLeaf()? "是":"否"%></td>
        <td><%=category.getGrade()%></td>
        <td>
            <%
                if(category.getGrade() != 3){
            %>
                    <a href="addcategory.jsp?pid=<%=category.getId()%>">添加子类别</a>
            <%
                }
            %>
            <%
                if(category.getGrade() == 3){
            %>
                    <a href="addproduct.jsp?categoryid=<%=category.getId()%>">添加商品</a>
            <%
                }
            %>
        </td>
    </tr>

    <%
        }
    %>
</table>
<div align="center">
    第<%=pageNo%>页&nbsp;
    共<%=pageCount%>页&nbsp;
    <a href="categorylist.jsp?pageno=1">首页</a>&nbsp;
    <a href="categorylist.jsp?pageno=<%=pageNo-1%>">上一页</a>&nbsp;
    <a href="categorylist.jsp?pageno=<%=pageNo+1>pageCount ? pageCount:pageNo+1%>">下一页</a>&nbsp;
    <a href="categorylist.jsp?pageno=<%=pageCount%>">末页</a>
</div>
</body>
</html>
