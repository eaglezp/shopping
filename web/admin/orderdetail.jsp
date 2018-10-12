<%@ page import="com.eagle.entity.SalesOrder" %>
<%@ page import="com.eagle.XManager.OrderManager" %>
<%@ page import="com.eagle.entity.SalesItem" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/12
  Time: 7:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String idStr = request.getParameter("id");
    int id = Integer.parseInt(idStr);
    SalesOrder order = OrderManager.getInstance().getOrderDAO().loadOrderById(id);
%>
<html>
<head>
    <title>订单详情</title>
    <script>
        function showproductinfo(descr) {
            document.getElementById("productinfo").innerHTML="<font size='3' color='red'>"+descr+"</font>";
        }
    </script>
</head>
<body>
下单人：<%=order.getUser().getUsername()== null ? "未登陆订单":order.getUser().getUsername()%><br>
<table border="1" align="center">
    <tr>
        <td>名称</td>
        <td>价格</td>
        <td>数量</td>
    </tr>
    <%
        List<SalesItem> salesItemList = OrderManager.getInstance().getOrderDAO().getAllSalesItem(order.getId());
        for(SalesItem salesItem : salesItemList){
    %>   <tr>
            <td onmousemove="showproductinfo('<%=salesItem.getProduct().getDescr()%>')"><%=salesItem.getProduct().getName()%></td>
            <td><%=salesItem.getUnitprice()%></td>
            <td><%=salesItem.getPcount()%></td>
         </tr>
    <%
        }
    %>
</table>
<div align="center" style="border:5px double purple;width: 400px" id="productinfo" >
</div>
</body>
</html>
