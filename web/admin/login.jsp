<%
    String action = request.getParameter("action");
    if(action != null && action.equals("login")){
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if(username == null || !username.trim().equals("admin")){

        } else if (password == null || !password.trim().equals("123456")){

        } else {
            session.setAttribute("adminLogined", "true");
            response.sendRedirect("adminindex.jsp");
        }
    }
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>AdministratorLogin</title>
</head>
<body>
    <form action="login.jsp" method="post">
        <input type="hidden" name="action" value="login"/>
        Username:<input type="text" name="username"/><br>
        Password:<input type="password" name="password"/><br>
        <input type="submit" value="SUBMIT"/>
    </form>
</body>
</html>