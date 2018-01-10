<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.vp.util.Label" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=Label.getString("resetpwd.pagename") %></title>
<link rel="shortcut icon" type="image/x-icon" href="img/cock.ico" >
<link href="css/common.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/resetpwd.js"></script>
<style>
#message1,#message2,#message3{color:red;font-size:12px;}
.nav li:nth-child(3) span{color:#ee0000;}
</style>
</head>
<body>
<div class="menu">
	<jsp:include page="menu.jsp"></jsp:include>
</div>
<form action="SettingAction_resetPassword" method="post">
<div class="resetMainDiv">
	<fieldset class="MainReset">
		<table class="resetTable">
			<tr>
				<td><%=Label.getString("resetpwd.propwd") %>:</td>
				<td><input class="text_input" type="password" name="orinPassword" id="orinPassword" onblur="checkPwd();"></td>
				<td><span id="message1" style="display:inline;"></span></td>
			</tr>	
			<tr>
				<td><%=Label.getString("resetpwd.newpwd") %>:</td>
				<td><input  class="text_input" type="password" name="newPassword" id="newPassword"></td>
				<td><span id="message2" style="display:inline;"></span></td>
			</tr>
			<tr>
				<td><%=Label.getString("resetpwd.renewpwd") %>:</td>
				<td><input  class="text_input" type="password" name="rePassword" id="rePassword"></td>
				<td><span id="message3" style="display:inline;"></span></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input class="submitReset" type="submit" value="<%=Label.getString("common.save") %>" onclick="return resPwd();"/></td>
				<td>&nbsp;</td>
			</tr>
		</table>
	</fieldset>
</div>
</form>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>