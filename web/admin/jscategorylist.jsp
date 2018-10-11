<%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/8
  Time: 1:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="_sessioncheck.jsp"%>
<%@page import="com.eagle.entity.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eagle.dao.CategoryDAO" %>
<%@ page import="java.util.Iterator" %>
<%
    List<Category> categoryList = CategoryDAO.getCategories();
%>
<html>
<head>
    <script language="javascript" src="script/TV20.js"></script>
    <script language="javascript">
        function t(key,parentKey) {
            document.forms["form"].pid.value = key;
        }
    </script>
</head>

<body>
<script language="javascript">
    addNode(-1,0,"所有类别","images/top.gif");
    <%
        for (Iterator<Category> it = categoryList.iterator();it.hasNext();){
            Category category = it.next();
    %>
        addNode(<%=category.getPid()%>,<%=category.getId()%>,"<%=category.getName()%>","images/top.gif");
    <%
        }
    %>
    showTV();
    addListener("click","t");
</script>
<table align="center" border="1">
    <form name="form" action="addcategory.jsp" method="post">
        <input type="hidden" name="action" value="addcategory">
        PID:<input type="text" name="pid" readonly/><br>
        NAME:<input type="text" name="name"/><br>
        DESCR:<input type="text" name="descr"/><br>
        <input type="submit" value="提交">
    </form>
</table>
</body>
</html>
