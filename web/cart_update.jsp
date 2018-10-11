<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.eagle.entity.CartItem" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/12
  Time: 0:32
  To change this template use File | Settings | File Templates.
--%>

<jsp:useBean id="cart" class="com.eagle.entity.Cart" scope="session"/>
<%
    request.setCharacterEncoding("UTF-8");
    if(cart == null){
        response.getWriter().print("没有任何购物项");
        return;
    }
    List<CartItem> cartItemList = cart.getCartItemList();
    for(CartItem cartItem : cartItemList){
        String strCount = request.getParameter("p"+cartItem.getProductId());
        if(strCount != null && !strCount.trim().equals("")){
            cartItem.setCount(Integer.parseInt(strCount));
        }
    }
    response.sendRedirect("cart.jsp");
%>

