<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.eagle.entity.SalesOrder" %>
<%@ page import="com.eagle.XManager.OrderManager" %>
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
    List<SalesOrder> orderList = new ArrayList<>();

    int pageCount = OrderManager.getInstance().getOrderDAO().getOrders(orderList,pageNo,PAGE_SIZE);

    if(pageNo > pageCount){
        pageNo = pageCount;
    }
%>
<html>
<head>
    <title>订单列表</title>
</head>
<body>
<table border="1" align="center">
    <tr>
        <td align="center">ID</td>
        <td align="center">UserName</td>
        <td align="center">Odate</td>
        <td align="center">Status</td>
        <td align="center">Addr</td>
        <td align="center">OPERATIONS</td>
    </tr>
    <%
        for (SalesOrder order : orderList){
    %>
    <tr>
        <td><%=order.getId()%></td>
        <td><%=order.getUser().getUsername() == null ? "未登陆用户":order.getUser().getUsername()%></td>
        <td><%=order.getOdate()%></td>
        <td><%=order.getStatus()%></td>
        <td><%=order.getAddr()%></td>
        <td>
            <a href="deleteorder.jsp?id=<%=order.getId()%>">删除</a>&nbsp;
            <a href="modifyorder.jsp?id=<%=order.getId()%>">修改</a>
        </td>
    </tr>

    <%
        }
    %>
</table>
<div align="center">
    第<%=pageNo%>页&nbsp;
    共<%=pageCount%>页&nbsp;
    <a href="orderlist.jsp?pageNo=1">首页</a>&nbsp;
    <a href="orderlist.jsp?pageNo=<%=pageNo-1%>">上一页</a>&nbsp;
    <a href="orderlist.jsp?pageNo=<%=pageNo+1 > pageCount ? pageCount : pageNo+1%>">下一页</a>&nbsp;
    <a href="orderlist.jsp?pageNo=<%=pageCount%>">末页</a>
</div>
</body>
</html>