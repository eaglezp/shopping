<%@ page import="com.eagle.entity.Category" %>
<%@ page import="com.eagle.dao.CategoryDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/7
  Time: 17:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="_sessioncheck.jsp"%>
<%
    String pidStr = request.getParameter("pid");
    int pid = 0;
    if(pidStr != null){
        pid = Integer.parseInt(pidStr);
    }
    String action = request.getParameter("action");
    if(action != null && action.equals("addcategory")){
        String name = new String(request.getParameter("name").getBytes("ISO8859-1"),"utf-8");
        String descr = new String(request.getParameter("descr").getBytes("ISO8859-1"), "utf-8");
        if(pid == 0){
            CategoryDAO.addTopCategory(name,descr);
        }else{
            CategoryDAO.addChildCategory(pid,name,descr);

        }

        return;
    }

%>
<html>
<head>
    <title>添加分类</title>
</head>
<body>
<form action="addcategory.jsp" method="post">
    <input type="hidden" name="action" value="addcategory">
    <input type="hidden" name="pid" value="<%=pid%>">
    <table>
        <tr>
            <td>类型名称:</td>
            <td><input type="text" name="name"/></td>
        </tr>
        <tr>
            <td>类别描述:</td>
            <td><textarea cols="30" rows="8" type="text" name="descr"></textarea></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="提交"/></td>
        </tr>
    </table>
</form>
</body>
</html>
