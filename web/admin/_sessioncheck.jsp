<%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/6
  Time: 17:28
  To change this template use File | Settings | File Templates.
--%>
<%
    String admin = (String)session.getAttribute("adminLogined");
    if(admin == null || !admin.equals("true")){
        response.sendRedirect("login.jsp");
    }
%>