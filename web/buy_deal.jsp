<%@ page import="com.eagle.entity.CartItem" %>
<%@ page import="com.eagle.entity.Product" %>
<%@ page import="com.eagle.XManager.ProductManager" %>
<%@ page import="com.eagle.entity.Cart" %><%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/10
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    //检查seesion中是否有购物车Cart
    Cart cart = (Cart)session.getAttribute("cart");
    if(cart == null){
        cart = new Cart();
        session.setAttribute("cart", cart);
    }
%>
<%--//检查session的另外一种写法
<jsp:useBean id="cart" class="com.eagle.entity.Cart" scope="session"/>--%>
<%
    String productId = request.getParameter("id");
    int id = Integer.parseInt(productId);
    CartItem cartItem = new CartItem();
    Product product = ProductManager.getInstance().getProductDAO().loadProductById(id);
    cartItem.setProductId(id);
    cartItem.setNormalPrice(product.getNormalprice());
    cartItem.setMemberPrice(product.getMemberprice());
    System.out.println("product.getMemberprice()-----------------"+product.getMemberprice());
    cartItem.setProductName(product.getName());
    cartItem.setCount(1);
    cart.add(cartItem);
    System.out.println("but_deal.jsp============="+cart);
    response.sendRedirect("cart.jsp");;

%>
<html>
<head>
    <title>购买商品</title>
</head>
<body>

</body>
</html>
