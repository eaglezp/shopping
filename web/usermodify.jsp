<%@ page import="com.eagle.entity.User" %>
<%@ page import="com.eagle.dao.UserDao" %><%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/7
  Time: 14:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User)session.getAttribute("user");
    if(user == null){
        return;
    }
%>
<%
    String action = request.getParameter("action");
    if(action != null && action.equals("modify")){
        String username = new String(request.getParameter("username").getBytes("ISO8859-1"),"utf-8");
        String password = request.getParameter("pwd");
        String phone = request.getParameter("phone");
        String addr = new String(request.getParameter("addr").getBytes("ISO8859-1"), "utf-8");
        user.setUsername(username);
        user.setPassword(password);
        user.setPhoneNum(phone);
        user.setAddr(addr);
        UserDao.updateUser(user);
        return;
    }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form name="form" action="usermodify.jsp" method="post">
    <input type="hidden" name="action" value="modify"/>
    <table width="750" align="center" border="2">
        <tr>
            <td colspan="2" align="center">UserModify</td>
        </tr>
        <tr>
            <td align="center">Username</td>
            <td>
                <input type=text name="username" size="30" maxlength="10" value="<%=user.getUsername()%>">
            </td>
        </tr>
        <tr>
            <td align="center">Password</td>
            <td>
                <input type=password name="pwd" size="15" maxlength="12" value="<%=user.getPassword()%>">
            </td>
        </tr>
        <tr>
            <td align="center">Phone</td>
            <td><input type="text" name="phone" size="12" maxlength="15" value="<%=user.getPhoneNum()%>"/></td>
        </tr>
        <tr>
            <td align="center">Addr</td>
            <td>
                <textarea rows="12" cols="80" name="addr"><%=user.getAddr()%></textarea>
            </td>
        </tr>

        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="Submit">
                <input type="reset" value="Reset">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
