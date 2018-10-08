<%@ page import="java.util.List" %>
<%@ page import="com.eagle.entity.Product" %>
<%@ page import="com.eagle.XManager.ProductManager" %>
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
    final int PAGE_SIZE = 5;
    int pageNo = 1;
    String pageNoStr = request.getParameter("pageNo");
    if(pageNoStr != null){
        pageNo = Integer.parseInt(pageNoStr);
    }
    if(pageNo < 1){
        pageNo = 1;
    }
    List<Product> productList = new ArrayList<>();

    int pageCount = ProductManager.getInstance().getProductDAO().getProducts(productList,pageNo,PAGE_SIZE);

    if(pageNo > pageCount){
        pageNo = pageCount;
    }
%>
<html>
<head>
    <title>产品列表</title>
</head>
<body>
<table border="1" align="center">
    <tr>
        <td align="center">ID</td>
        <td align="center">Name</td>
        <td align="center">描述</td>
        <td align="center">市场价</td>
        <td align="center">会员价</td>
        <td align="center">上价日期</td>
        <td align="center">类别ID</td>
        <td align="center">处理</td>
    </tr>
    <%
        for (Product product : productList){
    %>
    <tr>
        <td><%=product.getId()%></td>
        <td><%=product.getName()%></td>
        <td><%=product.getDescr()%></td>
        <td><%=product.getNormalprice()%></td>
        <td><%=product.getMemberprice()%></td>
        <td><%=product.getPdate()%></td>
        <td><%=product.getCategoryid()%></td>
        <td>
            <a href="deleteproduct.jsp?id=<%=product.getId()%>">删除</a>&nbsp;
            <a href="modifyproduct.jsp?id=<%=product.getId()%>">修改</a>
        </td>
    </tr>

    <%
        }
    %>
</table>
<div align="center">
    第<%=pageNo%>页&nbsp;
    共<%=pageCount%>页&nbsp;
    <a href="productlist.jsp?pageNo=1">首页</a>&nbsp;
    <a href="productlist.jsp?pageNo=<%=pageNo-1%>">上一页</a>&nbsp;
    <a href="productlist.jsp?pageNo=<%=pageNo+1 > pageCount ? pageCount : pageNo+1%>">下一页</a>&nbsp;
    <a href="productlist.jsp?pageNo=<%=pageCount%>">末页</a>
</div>
</body>
</html>