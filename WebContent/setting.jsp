<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.vp.util.ConstantUtil"%>
<%@ page import="com.vp.util.Label" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=Label.getString("setting.pagename") %></title>
<link rel="shortcut icon" type="image/x-icon" href="img/cock.ico" >
<link href="css/common.css" rel="stylesheet" type="text/css"/>
<link href="css/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/datepicker-zh-CN.js"></script>
<script type="text/javascript" src="js/setting.js"></script>
<style>
	.nav li:nth-child(2) span{color:#ee0000;}
	#backup_msg,#restore_msg{color:#f00;}
</style>
</head>
<body>
<div class="menu">
	<jsp:include page="menu.jsp"></jsp:include>
</div>
<form action="SettingAction_saveSet" method="post">
<div class="settingMain">
	<table  class="tableMenu" border="1" cellspacing="0">
		<tr>
			<th colspan="2"><%=Label.getString("setting.title") %></th>
		</tr>
		<tr>
			<td><%=Label.getString("setting.normalunit") %></td>
			<td><input type="text" name="normal" value="${normal}"/></td>
		</tr>
		<tr>
			<td><%=Label.getString("setting.businessunit") %></td>
			<td><input type="text" name="business" value="${business}"/></td>
		</tr>
		<tr>
			<td><%=Label.getString("setting.printheader") %></td>
			<td><input type="text" name="tbHeader" value="${tbHeader}"/></td>
		</tr>
		<tr>
			<td><%=Label.getString("setting.fixtelephone") %></td>
			<td><input type="text" name="telephone" value="${telephone}"/></td>
		</tr>
		<tr>
			<td><%=Label.getString("setting.address") %></td>
			<td><input type="text" name="address" value="${address}"/></td>
		</tr>
		<tr>
			<td><%=Label.getString("setting.footer") %></td>
			<td><input type="text" name="footer" value="${footer}"/></td>
		</tr>
		<tr>
			<td><%=Label.getString("setting.inputmonth") %></td>
			<td><input type="text" id="operateDate" name="operateDate" value="${operateDate}"/></td>
		</tr>
		<tr>
			<td><%=Label.getString("setting.curmonthnumber") %></td>
			<td><%=ConstantUtil.curMonthSwiftNumber%></td>
		</tr>
		<tr>
			<td colspan="2">
				<input class="submitSetting" type="submit" value="<%=Label.getString("common.save") %>">
				<input class="submitSetting" type="button" onclick="javascript:history.back();" value="<%=Label.getString("common.cancel") %>">
			</td>
		</tr>
	</table>
</div>
</form>
<div class="backupTitle"><%=Label.getString("setting.backuptitle") %></div>
<div class="tips">
	<div><strong style="color:#f00;font-family:华文行楷;font-size:18px;">注意事项：</strong></div>
	<div class="content">
	&nbsp;&nbsp;※ 备份数据库时，直接点击<strong>备份</strong>按钮，等到提示<strong style="color:#f00;">备份完成</strong>时，说明备份完成。
	备份文件存放在D盘:/backup/目录下,您可以定时将其拷贝到其他介质。<br>
	&nbsp;&nbsp;※ 还原备份时,首先点击<strong>选择文件</strong>按钮，选择你要还原的数据库备份文件(.sql文件),然后点击<strong>还原备份</strong>
	按钮，等到提示<strong style="color:#f00;">还原成功</strong>后，表示还原完成。
	</div>
</div>
<div class="backup">
	<table>
		<tr>
			<td><a href="javascript:void(0)" id="backup_btn"><%=Label.getString("setting.backup") %></a></td>
			<td><span id="backup_msg"></span></td>
		</tr>
		<tr>
			<td colspan="2"><ul id="dl"></ul></td>
		</tr>
		<tr>
			<td>
				<form enctype="multipart/form-data" method="post" action="json/DbAction_Async_restore" id="upload_form">
					<a href="javascript:void(0)" id="file_btn"><%=Label.getString("setting.selectfile") %><input type="file" id="file_to_upload" name="file"/></a>
				</form>
			</td>
			<td><span id="fileName"></span></td>
		</tr>
		<tr>
			<td><a href="javascript:void(0)" id="restore_btn"><%=Label.getString("setting.retore") %></a></td>
			<td><span id="restore_msg"></span></td>
		</tr>
	</table>
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>