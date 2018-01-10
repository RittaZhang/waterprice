<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.vp.util.Label" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<div class="top">
	<span class="sysname"><%=Label.getString("menu.sysname") %></span>
	<span class="status">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="LoginAction_logout">
			<%=Label.getString("menu.logout") %>
		</a>
	</span>
</div>
<div class="nav">
	<ul>
		<li><a href="WaterRecordAction_recordInput"><span><%=Label.getString("menu.recordinput") %></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a></li>
		<li><a href="SettingAction_preSet"><span><%=Label.getString("menu.syssetting") %></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a></li>
		<li><a href="resetpwd.jsp"><span><%=Label.getString("menu.resetpwd") %></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a></li>
		<li><a href="zone.jsp"><span><%=Label.getString("menu.zonemanage") %></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a></li>
		<li><a href="WorkerAction_list"><span><%=Label.getString("menu.workermanage") %></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a></li>
		<li><a href="UserAction_searchUser"><span><%=Label.getString("menu.usermanage") %></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a></li>
		<li><a href="WaterRecordAction_queryRecord"><span>已收费(修改记录)</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a></li>
		<li><a href="UserAction_noInput"><span>未收费(用水录入)</span></a></li>
	</ul>
</div>
<div style="clear:both;height:5px;border-bottom:1px solid #ccc;width:968px;margin:0 auto;"></div>
</body>
</html>