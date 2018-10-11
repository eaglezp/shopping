<%@ page import="com.eagle.entity.Product" %>
<%@ page import="com.eagle.XManager.ProductManager" %>
<%@ page import="com.eagle.entity.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eagle.dao.CategoryDao" %>

<%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/6
  Time: 5:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="_sessioncheck.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
   String productId = request.getParameter("id");
   Product product = ProductManager.getInstance().getProductDAO().loadProductById(productId);
%>

<%
    String action = request.getParameter("action");
    if(action != null && action.trim().equals("modifyproduct")){
        String name = request.getParameter("name");
        String descr = request.getParameter("descr");
        System.out.println("name+descr:"+name+"+"+descr);
        double normalPrice = Double.parseDouble(request.getParameter("normalprice"));
        double memberPrice = Double.parseDouble(request.getParameter("memberprice"));
        String categoryidStr = request.getParameter("categoryid");
        Product mProduct = new Product();
        mProduct.setId(Integer.parseInt(productId));
        mProduct.setName(name);
        mProduct.setCategoryid(Integer.parseInt(categoryidStr));
        mProduct.setDescr(descr);
        mProduct.setNormalprice(normalPrice);
        mProduct.setMemberprice(memberPrice);
        int result = ProductManager.getInstance().getProductDAO().updateProduct(mProduct);
        System.out.println("result:"+result);
    }
%>
<html>
<head>
    <title>修改产品</title>
</head>
<body>
<form action="modifyproduct.jsp" method="post">
<table>
    <input type="hidden" name="action" value="modifyproduct"/>
    <input type="hidden" name="id" value="<%=product.getId()%>"/>
    <tr>
        <td>产品名称:</td>
        <td><input type="text" name="name" value="<%=product.getName()%>"/></td>
    </tr>
    <tr>
        <td>产品描述:</td>
        <td><textarea cols="30" rows="8" type="text" name="descr"><%=product.getDescr()%></textarea></td>
    </tr>
    <tr>
        <td>市场价:</td>
        <td><input type="text" name="normalprice" value="<%=product.getNormalprice()%>"/></td>
    </tr>
    <tr>
        <td>会员价:</td>
        <td><input type="text" name="memberprice" value="<%=product.getMemberprice()%>"/></td>
    </tr>
    <tr>
        <td>类别:</td>
        <%--<td>
            <select name="categoryid">
                <option value="<%=product.getCategoryid()%>">
                    <%=product.getCategory().getName()%>
                </option>
            </select>
        </td>--%>
        <td>
            <select name="categoryid">
                <%
                    List<Category> categoryList = CategoryDao.getCategories();
                    for(Category category : categoryList){
                        String preStr = "";
                        for(int i=1;i<category.getGrade();i++){
                            preStr += "--";
                        }
                %>
                <option value="<%=category.getId()%>" <%=category.getId() == product.getCategoryid() ? "selected":""%> <%=category.getGrade() != 3 ? "disabled":""%>><%=preStr+category.getName()%></option>
                <%
                    }
                %>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2"><input type="submit" value="提交"/></td>
    </tr>
</table>
</form>
</body>
</html>