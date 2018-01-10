<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.vp.util.Label" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>水费管理</title>
<link rel="shortcut icon" type="image/x-icon" href="img/cock.ico" >
<link href="css/common.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/login.js"></script>
<script>

	//window.open("/waterprice/login.jsp",'','top=0,left=0,location=no,resizable=yes');
	//window.close();
</script>
</head>
<body>
<div class="login">
<div class="top">
	<%=Label.getString("login.sysname") %>
</div>
</div>
<div class="loginMainDiv" id="div1">
	<form action="LoginAction_login" method="POST">
		
		<fieldset class="MainSet">
			<font class="loginTitle"><strong><%=Label.getString("login.title") %></strong></font> 
			<div class="textDiv">
			<p>
				<input class="text_input" type="password" name="password" id="password" placeholder="<%=Label.getString("login.pwdalt") %>" />
				<input type="hidden" value="" id="retURL" name="retURL">
			</p>
			<div>
				<span class="errorText" id="errorMsg">${errorMessage}</span>
			</div>
			<p>
				<input class="loginButton" type="submit" value="<%=Label.getString("login.loginbtn") %>" onclick="return checkPassword();"/>
			</p>
			</div>
		</fieldset>
	</form>
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>