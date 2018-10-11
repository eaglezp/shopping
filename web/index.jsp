<%@ page import="com.eagle.entity.Product" %>
<%@ page import="com.eagle.XManager.ProductManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    int pageNo  = 1;
    final int PAGE_SIZE = 5;

    String pageNoStr = request.getParameter("pageNo");
    if(pageNoStr != null){
        pageNo = Integer.parseInt(pageNoStr);
    }

    if(pageNo < 1){
        pageNo = 1;
    }

    List<Product> productList = new ArrayList<>();
    int pageCount = ProductManager.getInstance().getProductDAO().getProducts(productList,pageNo,PAGE_SIZE);
    if(pageNo > pageCount){
        pageNo = pageCount;
    }
%>
<html>
<head>
    <title></title>
</head>
<body>
<form action="index.jsp" method="post">
    <input type="hidden" name="action" value="nextpage"/>
    <table width="750" height="1300" border="1" align="center">
        <tr>
            <td>NAME</td>
            <td>NORMALPRICE</td>
            <td>MEMBERPRICE</td>
            <td>DESCR</td>
            <td>CATEGORY</td>
            <td>OPERATION</td>
        </tr>
        <%
            for(Product product : productList){
        %>
            <tr>
                <td><%=product.getName()%></td>
                <td><%=product.getNormalprice()%></td>
                <td><%=product.getMemberprice()%></td>
                <td><%=product.getDescr()%></td>
                <td><%=product.getCategory().getName()%></td>
                <td><a href="buy_deal.jsp?id=<%=product.getId()%>" title="购买">BUY</a></td>
            </tr>
        <%
            }
        %>

    </table>
    <div align="center">
        第<%=pageNo%>页&nbsp;
        共<%=pageCount%>页&nbsp;
        <a href="index.jsp?pageNo=1">首页</a>&nbsp;
        <a href="index.jsp?pageNo=<%=pageNo-1 < 0 ? 1 : pageNo-1 %>">上一页</a>&nbsp;
        <a href="index.jsp?pageNo=<%=pageNo+1 > pageCount ? pageCount : pageNo+1%>">下一页</a>&nbsp;
        <a href="index.jsp?pageNo=<%=pageCount%>">末页</a>
    </div>
</form>
</body>
</html>
