<%@ page import="com.eagle.entity.User" %>
<%@ page import="com.eagle.dao.UserDao" %>
<%@ page import="com.eagle.excepton.UserNotFoundException" %>
<%@ page import="com.eagle.excepton.PasswordNotCorrection" %><%
    String action = request.getParameter("action");
    if(action != null && action.equals("login")){
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = null;
        try{
            user = UserDao.isValidate(username,password);
        }catch (UserNotFoundException e){
            return;
        }catch (PasswordNotCorrection e){
            return;
        }
        session.setAttribute("user", user);
        response.sendRedirect("selfservice.jsp?id="+user.getId());
    }
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>UserLogin</title>
</head>
<body>
    <form action="login.jsp" method="post">
        <input type="hidden" name="action" value="login"/>
        Username:<input type="text" name="username"/><br>
        Password:<input type="password" name="password"/><br>
        <input type="submit" value="LOGIN"/>
    </form>
</body>
</html>