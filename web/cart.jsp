<%@ page import="com.eagle.entity.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/11
  Time: 20:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<jsp:useBean id="cart" class="com.eagle.entity.Cart" scope="session"/>
    <%
        System.out.println("cart.jsp----------cart="+cart);
        if(cart == null){
            response.getWriter().print("没有任何购物项");
            return;
        }
    %>
<html>
<head>
    <title>购物车</title>
</head>
<body>
<form action="cart_update.jsp" method="post">
    <table align="center" border="1">
        <h4 align="center" >商品清单</h4>
        <tr>
            <td align="center">商品ID</td>
            <td align="center">商品名称</td>
            <td align="center">商品单价</td>
            <td align="center">购买数量</td>
            <td align="center">小计</td>
        </tr>

        <%
            List<CartItem> cartItemList = cart.getCartItemList();
            System.out.println("cart0000="+cart);
            for(CartItem cartItem :cartItemList){
        %>
        <tr>
            <td align="center"><%=cartItem.getProductId()%></td>
            <td align="center"><%=cartItem.getProductName()%></td>
            <td align="center"><%=cartItem.getNormalPrice()%></td>
            <td align="center">
                <input name="p<%=cartItem.getProductId()%>" value="<%=cartItem.getCount()%>"/>
            </td>
            <td align="center"><%=cartItem.getTotalPriceMap().get("normalPrice")%></td>
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
        合计：<%=totalItemNormalPrice%>元<br>
        <input type="submit" value="修改数量">
        <input type="button" onclick="document.location.href='confirm.jsp'" value="确认订单"></div>
    </div>
</form>
</body>
</html>
