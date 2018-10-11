<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.eagle.entity.User" %>
<%@ page import="com.eagle.entity.SalesOrder" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.eagle.XManager.OrderManager" %><%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/12
  Time: 4:26
  To change this template use File | Settings | File Templates.
--%>

<jsp:useBean id="cart" class="com.eagle.entity.Cart" scope="session"/>
<%
    if(cart == null){
        response.getWriter().print("没有任何购物项");
        return;
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    String addr = request.getParameter("addr");
    SalesOrder salesOrder = new SalesOrder();
    salesOrder.setAddr(addr);
    salesOrder.setCart(cart);
    salesOrder.setOdate(new Timestamp(System.currentTimeMillis()));
    salesOrder.setStatus(0);
    User user = (User)session.getAttribute("user");
    if(user == null){
        user = new User();
        user.setId(-1);
    }
    salesOrder.setUser(user);
    boolean isOk = OrderManager.getInstance().getOrderDAO().saveOrder(salesOrder);
    if(isOk){
        session.removeAttribute("cart");
    }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
谢谢在本站购物！
</body>
</html>
