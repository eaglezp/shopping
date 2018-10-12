<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.eagle.entity.User" %>
<%@ page import="com.eagle.dao.UserDao" %>
<%
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    if(action != null && action.equals("register")){
        String username = request.getParameter("username");
        String password = request.getParameter("pwd");
        String phone = request.getParameter("phone");
        String addr = request.getParameter("addr");
        User user = new User(username,password,phone,addr);
        UserDao.saveUser(user);
        return;
    }

%>
<html>
	<head>
		<title>UserRegister</title>
		<script language=JavaScript src="admin/script/regcheckdata.js"></script>
		<script>
            var req;
			function validateUserName() {
			    var username = document.getElementById("username");
                var url = "validate.jsp?username="+escape(username.value);
                if(window.XMLHttpRequest){
                    req = new XMLHttpRequest();
                } else if(window.ActiveXObject){
                    req = ActiveXObject("Mircosoft.XMLHttp");
                }
                req.open("GET",url,true);
                req.onreadystatechange=callback;
                req.send(null);
            }

            function callback() {
                if(req.readyState == 4){
                    if(req.status == 200){
                        //alert(req.responseText);
                        var msg = req.responseXML.getElementsByTagName("msg")[0];
                        setMsg(msg.childNodes[0].nodeValue);
                    }
                }
            }

            function setMsg(msg) {
			    if(msg == 0){
                    document.getElementById("msg").innerHTML = "<font color='#32cd32'>用户名可用</font>";
                }else{
                    document.getElementById("msg").innerHTML = "<font color='red'>用户名已存在</font>";
                }
            }

		</script>
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
						<input type=text name="username" id="username" size="30" maxlength="10" onblur="validateUserName();">
                        <span id="msg"></span>
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