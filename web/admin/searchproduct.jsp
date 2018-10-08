<%@ page import="com.eagle.entity.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eagle.XManager.ProductManager" %>
<%@ page import="com.eagle.entity.Category" %>
<%@ page import="com.eagle.dao.CategoryDao" %>
<%@ page import="java.sql.Timestamp" %>
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
    List<Category> categoryList = CategoryDao.getCategories();
    String action = request.getParameter("action");
    if(action != null && action.equals("complexsearch")) {
        String keyword = new String(request.getParameter("keyword").getBytes("ISO8859-1"), "utf-8");
        double lowNormalPrice = Double.parseDouble(request.getParameter("lownormalprice"));
        double highNormalPrice = Double.parseDouble(request.getParameter("highnormalprice"));
        double lowMemberPrice = Double.parseDouble(request.getParameter("lowmemberprice"));
        double highMemberPrice = Double.parseDouble(request.getParameter("highmemberprice"));
        int categoryid = Integer.parseInt(request.getParameter("categoryid"));
        int[] ids = new int[1];
        ids[0] = categoryid;
        Timestamp startdate = null;
        Timestamp enddate = null;
        String startdateStr = request.getParameter("startdate");
        String enddateStr = request.getParameter("enddate");
        if (startdateStr != null && !startdateStr.trim().equals("")) {
            startdate = Timestamp.valueOf(startdateStr);
        }
        if (enddateStr != null && !enddateStr.trim().equals("")) {
            enddate = Timestamp.valueOf(enddateStr);
        }

        List<Product> productList = ProductManager.getInstance().getProductDAO().findProducts(ids, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, startdate, enddate, 1, 3);
        System.out.println("productList.size():" + productList.size());
 %>
        <table border="1" align="center">
            <tr>
                <td align="center">ID</td>
                <td align="center">Name</td>
                <td align="center">描述</td>
                <td align="center">市场价</td>
                <td align="center">会员价</td>
                <td align="center">上架日期</td>
                <td align="center">类别ID</td>
            </tr>
            <%
                for (Product product : productList){
            %>
            <tr>
                <td><%=product.getId()%></td>
                <td><%=product.getName()%></td>
                <td><%=product.getDescr()%></td>
                <td><%=product.getNormalprice()%></td>
                <td><%=product.getMemberprice()%></td>
                <td><%=product.getPdate()%></td>
                <td><%=product.getCategoryid()%></td>
            </tr>

            <%
                }
            %>
        </table>
<%
        return;
    }
%>

<html>
<head>
    <title>搜索产品</title>
    <script>
        function checkdata() {
            var lownormalprice = document.getElementById("lownormalprice");
            var highnormalprice = document.getElementById("highnormalprice");
            var lowmemberprice = document.getElementById("lowmemberprice");
            var highmemberprice = document.getElementById("highmemberprice");
            if(lownormalprice.value == null || lownormalprice.value == ""){
                lownormalprice.value = -1;
            }
            if(highnormalprice.value == null || highnormalprice.value == ""){
                highnormalprice.value = -1;
            }
            debugger;
            if(lowmemberprice.value == null || lowmemberprice.value == ""){
                lowmemberprice.value = -1;
            }
            if(highmemberprice.value == null || highmemberprice.value == ""){
                highmemberprice.value = -1;
            }
        }
    </script>
</head>
<body>
<form action="searchproduct.jsp" method="post" onsubmit="return checkdata()" name="searchform">
    <input type="hidden" name="action" value="complexsearch">
    <table>
        <tr>
            <td>
                <select name="categoryid">
                    <option value="0" selected>所有类型</option>
                    <%
                        for(Category category : categoryList){
                            String preStr = "";
                            for(int i=1;i<category.getGrade();i++){
                                preStr += "--";
                            }
                    %>
                            <option name="categoryid" value="<%=category.getId()%>"><%=preStr+category.getName()%></option>
                    <%
                        }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td>关键字:</td>
            <td><input type="text" name="keyword"/></td>
        </tr>
        <tr>
            <td>市场价:</td>
            <td>From:<input type="text" name="lownormalprice" id="lownormalprice"/></td>
            <td>To:<input type="text" name="highnormalprice" id="highnormalprice"/></td>
        </tr>
        <tr>
            <td>会员价:</td>
            <td>From:<input type="text" name="lowmemberprice" id="lowmemberprice"/></td>
            <td>To:<input type="text" name="highmemberprice" id="highmemberprice"/></td>
        </tr>
        <tr>
            <td>日期:</td>
            <td>From:<input type="text" name="startdate" id="startdate"/></td>
            <td>To:<input type="text" name="enddate" id="enddate"/></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="搜索"/></td>
        </tr>
    </table>
</form>
</body>
</html>