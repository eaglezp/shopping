<%@ page import="com.eagle.entity.Category" %>
<%@ page import="com.eagle.dao.CategoryDao" %>
<%@ page import="com.eagle.entity.Product" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.eagle.XManager.ProductManager" %><%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/7
  Time: 17:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="_sessioncheck.jsp"%>
<%
    String action = request.getParameter("action");
    if(action != null && action.equals("addproduct")){
        String name = new String(request.getParameter("name").getBytes("ISO8859-1"),"utf-8");
        String descr = new String(request.getParameter("descr").getBytes("ISO8859-1"), "utf-8");
        double normalPrice = Double.parseDouble(request.getParameter("normalprice"));
        double memberPrice = Double.parseDouble(request.getParameter("memberprice"));
        int categoryid = Integer.parseInt(request.getParameter("categoryid"));
        Product product = new Product();
        product.setId(-1);
        product.setName(name);
        product.setDescr(descr);
        product.setNormalprice(normalPrice);
        product.setMemberprice(memberPrice);
        product.setCategoryid(categoryid);
        product.setPdate(new Timestamp(System.currentTimeMillis()));
        ProductManager.getInstance().addProduct(product);
        return;
    }
%>
<html>
<head>
    <title>添加产品</title>
</head>
<body>
<form action="addproduct.jsp" method="post">
    <input type="hidden" name="action" value="addproduct">
    <table>
        <tr>
            <td>产品名称:</td>
            <td><input type="text" name="name"/></td>
        </tr>
        <tr>
            <td>产品描述:</td>
            <td><textarea cols="30" rows="8" type="text" name="descr"></textarea></td>
        </tr>
        <tr>
            <td>市场价:</td>
            <td><input type="text" name="normalprice"/></td>
        </tr>
        <tr>
            <td>会员价:</td>
            <td><input type="text" name="memberprice"/></td>
        </tr>
        <tr>
            <td>产品ID:</td>
            <td><input type="text" name="categoryid"/></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="提交"/></td>
        </tr>
    </table>
</form>
</body>
</html>
