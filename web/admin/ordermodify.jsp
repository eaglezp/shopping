<%@ page import="com.eagle.XManager.OrderManager" %>
<%@ page import="com.eagle.entity.SalesOrder" %><%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/12
  Time: 9:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String idStr = request.getParameter("id");
    int id = Integer.parseInt(idStr);
    SalesOrder order = OrderManager.getInstance().getOrderDAO().loadOrderById(id);
    String action = request.getParameter("action");
    if(action != null && action.equals("modify")){
        int status = Integer.parseInt(request.getParameter("status"));
        order.setStatus(status);
        OrderManager.getInstance().getOrderDAO().updateStatus(order);
    }
%>
<html>
<head>
    <title>订单修改</title>
</head>
<body>
下单人：<%=order.getUser().getUsername()== null ? "未登陆订单":order.getUser().getUsername()%><br>
<form name="form" action="ordermodify.jsp" method="post">
    <input type="hidden" name="id" value="<%=id%>"/>
    <input type="hidden" name="action" value="modify"/>
    <select name="status">
        <option value="0">未处理</option>
        <option value="1">已处理</option>
        <option value="2">废单</option>
    </select>
    <input type="submit" value="提交">
</form>
</html>
