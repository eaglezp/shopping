<%@ page import="com.eagle.entity.User" %>
<%@ page import="com.eagle.dao.UserManager" %>
<%
    String action = request.getParameter("action");
    if(action != null && action.equals("register")){
        String username = new String(request.getParameter("username").getBytes("ISO8859-1"),"utf-8");
        String password = request.getParameter("pwd");
        String phone = request.getParameter("phone");
        String addr = new String(request.getParameter("addr").getBytes("ISO8859-1"), "utf-8");
        User user = new User(username,password,phone,addr);
        UserManager.saveUser(user);
        return;
    }

%>
<html>
	<head>
		<title>UserRegister</title>
		<script language=JavaScript src="script/regcheckdata.js"></script>
	</head>
	<body>
		<form name="form" action="register.jsp" method="post" onSubmit="return checkdata()">
			<input type="hidden" name="action" value="register"/>
            <table width="750" align="center" border="2">
				<tr>
					<td colspan="2" align="center">UserRegister</td>
				</tr>
				<tr>
					<td align="center">Username</td>
					<td>
						<input type=text name="username" size="30" maxlength="10">
					</td>
				</tr>
				<tr>
					<td align="center">Password</td>
					<td>
						<input type=password name="pwd" size="15" maxlength="12">
					</td>
				</tr>
				<tr>
					<td align="center">SUREPassword</td>
					<td>
						<input type=password name="pwd2" size="15" maxlength="12">
					</td>
				</tr>
                <tr>
                    <td align="center">Phone</td>
                    <td><input type="text" name="phone" size="12" maxlength="15"/></td>
                </tr>
				<tr>
					<td align="center">Addr</td>
					<td>
						<textarea rows="12" cols="80" name="addr"></textarea>
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