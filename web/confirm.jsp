<%@ page import="com.eagle.entity.User" %>
<%@ page import="com.eagle.entity.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eagle.entity.Product" %>
<%@ page import="com.eagle.XManager.ProductManager" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/11
  Time: 22:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<jsp:useBean id="cart" class="com.eagle.entity.Cart" scope="session"/>
<%
    User user = (User)session.getAttribute("user");
    if(user == null){
        response.getWriter().print("你尚未<a href='login.jsp'>登陆</a>");
    }
%>
<html>
<head>
    <title>订单确认</title>
</head>
<body>
<form action="cart_update.jsp" method="post">
    <table align="center" border="1">
        <h4 align="center" >商品清单</h4>
        <tr>
            <td align="center">商品ID</td>
            <td align="center">商品名称</td>
            <td align="center">商品单价(<%= user == null ? "市场价":"会员价"%>)</td>
            <td align="center">购买数量</td>
            <td align="center">小计</td>
        </tr>

        <%
            List<CartItem> cartItemList = cart.getCartItemList();
            System.out.println(cartItemList);
            for(CartItem cartItem :cartItemList){
                Product product = ProductManager.getInstance().getProductDAO().loadProductById(cartItem.getProductId());
        %>
        <tr>
            <td align="center"><%=cartItem.getProductId()%></td>
            <td align="center"><%=cartItem.getProductName()%></td>
            <td align="center"><%=user == null ? product.getNormalprice() : product.getMemberprice()%></td>
            <td align="center"><%=cartItem.getCount()%></td>
            <td align="center"><%=user == null ? cartItem.getTotalPriceMap().get("normalPrice") : cartItem.getTotalPriceMap().get("memberPrice")%></td>
        </tr>
        <%
            }
        %>
    </table>
    <div align="center">
        <%
            double totalItemNormalPrice = 0;
            double totalItemMemberlPrice = 0;
            Map<String, Map<String,Double>> priceMap = cart.getTotalPriceMap();
            for(Map.Entry<String,Map<String,Double>> complexentry : priceMap.entrySet()){
                for(Map.Entry<String,Double> simpleentry : complexentry.getValue().entrySet()){
                    if(simpleentry.getKey().equals("normalPrice")){
                        totalItemNormalPrice += simpleentry.getValue();
                        System.out.println("totalItemNormalPrice==="+totalItemNormalPrice);
                    }
                    if(simpleentry.getKey().equals("memberPrice")){
                        totalItemMemberlPrice += simpleentry.getValue();
                        System.out.println("totalItemMemberlPrice-----"+totalItemMemberlPrice);
                    }
                }
            }
        %>
        合计：<%=user == null ? totalItemNormalPrice : totalItemMemberlPrice%>元
    </div>
</form>
</body>
</html>
