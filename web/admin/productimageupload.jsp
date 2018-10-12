<%--
  Created by IntelliJ IDEA.
  User: Peng
  Date: 2018/10/12
  Time: 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form name="fileupload" method="post" action="../FileUploadServlet" enctype="multipart/form-data">
    <input type="file" name="upload"/>
    <input type="submit" value="上传"/>
</form>
</body>
</html>
