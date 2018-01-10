<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.vp.util.Label" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=Label.getString("userview.pagename") %></title>
<link rel="shortcut icon" type="image/x-icon" href="img/cock.ico" >

<link href="css/pagination.css" rel="stylesheet" type="text/css"/>
<link href="css/common.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jquery.pagination.js"></script>
<script>
	$(document).ready(function(){
		selectionInit();
		var rowCount = parseInt("${rowCount}");
		$("#New_pagination").pagination(rowCount,{
			items_per_page:parseInt("${pageSize}"),
			next_text:"<%=Label.getString("common.nextpage") %>",
			prev_text:"<%=Label.getString("common.prevpage") %>",
			current_page:parseInt("${currentPage}"),
			num_display_entries:5,
			num_edge_entries:2,
			load_first_page:false,
	        callback:searchUser
		});
		setSortClass();
	});
	function selectionInit(){
		var editType='${userType}';
		var editZone='${userZone}';
		var oSel1=document.getElementById("userType").options;
		var oSel2=document.getElementById("userZone").options;
		for (var i = 0; i < oSel1.length; i++) { 
			if(editType == oSel1[i].value){
				oSel1[i].selected = true;
				break;
			}
		}
		for (var j = 0; j < oSel2.length; j++) { 
			if(editZone == oSel2[j].value){
				oSel2[j].selected = true;
				break;
			}
		}
	}
	function searchUser(new_page_index, pagination_container){
		var selId=document.getElementById("selectId").value;
		var userType = document.getElementById("userType").value;
		var userZone= document.getElementById("userZone").value;
		var order = document.getElementById("order").value;
		var by = document.getElementById("by").value;
		var url = "UserAction_searchUser?u=1"
		if(selId != null && selId != ''){
			url += "&selId="+selId;	
		}if(userType != null && userType != ''){
			url += "&userType="+userType;	
		}if(userZone != null && userZone != ''){
			url += "&userZone="+userZone;	
		}if(new_page_index == undefined){
			new_page_index=0;
		}
		if(by==null||by==''){
			by = "id";
		}
		if(order==null||order==''){
			order = "asc";
		}
		url += "&by="+by+"&order="+order;
		url += "&currentPage="+new_page_index;
		location.href = url;
		
	}
	
	function setOrderBy(by){
		document.getElementById("by").value = by;
		var order = document.getElementById("order").value;
		if(order == "asc"){
			document.getElementById("order").value = "desc";
		}else{
			document.getElementById("order").value = "asc";
		}
		searchUser();
	}
	function setSortClass(){
		var order = document.getElementById("order").value;
		var by = document.getElementById("by").value;
		if(order == "desc"){
			$(".userview th a#"+by+"_a").addClass("sortDesc");
		}else{
			$(".userview th a#"+by+"_a").addClass("sortAsc");
		}
	}
</script>
<style>
	.nav li:nth-child(6) span{color:#ee0000;}
	.userview th img{display:none;}
	
</style>
</head>
<body>
<div class="menu">
	<jsp:include page="menu.jsp"></jsp:include>
</div>
<div>
&nbsp;&nbsp;
</div>
<div class="condition">
	<a href="UserAction_preEdit"><input value="<%=Label.getString("userview.adduser") %>" type="button" class="common_btn"/></a>
	<%=Label.getString("useredit.useraccount") %><input type="text"  name="user.id" id="selectId" value="${selId}" />
	<%=Label.getString("useredit.usertype") %><select name="user.type" id="userType" class="common_select">
		<option value="">--<%=Label.getString("common.plzselect") %>--</option>
		<option value="<%=Label.getString("useredit.normal") %>"><%=Label.getString("useredit.normal") %></option>
		<option value="<%=Label.getString("useredit.business") %>"><%=Label.getString("useredit.business") %></option>
	</select>
	<%=Label.getString("useredit.zone") %><select name="user.zone" id="userZone" class="common_select">
		<option value="">--<%=Label.getString("common.plzselect") %>--</option>
	<c:forEach items="${zoneList}" var="zone">
		<option value="${zone}">${zone}</option>
	</c:forEach>
	</select>
	<input type="button" value="<%=Label.getString("common.search") %>" onclick="return searchUser();" class="common_btn"/>
	<input type="hidden" value="${order}" id="order">
	<input type="hidden" value="${by}" id="by">	
</div>
<div class="userview">
	<table border="1" cellspacing="0" class="outer_tb">
		<tr class="outer_tr">
		
			<th><a onclick="setOrderBy('id')" id="id_a"><%=Label.getString("useredit.useraccount") %><img src="img/arrow_up.png"></a></th>
			<th><a onclick="setOrderBy('lastName')" id="lastName_a">用户姓名<img src="img/arrow_up.png"></a></th>
			<!-- <th><%=Label.getString("useredit.firstname") %></th> -->
			<th><a onclick="setOrderBy('type')" id="type_a" ><%=Label.getString("useredit.usertype") %><img src="img/arrow_up.png"></a></th>
			<th><a onclick="setOrderBy('zone')" id="zone_a" ><%=Label.getString("useredit.zone") %><img src="img/arrow_up.png"></a></th>
			<th><a onclick="setOrderBy('address')" id="address_a" ><%=Label.getString("useredit.useraddress") %><img src="img/arrow_up.png"></a></th>
			<th>最近缴费月份</th>
			<th><%=Label.getString("common.operate") %></th>
		</tr>
		<c:forEach items="${userList}" var="us">
		<tr class="outer_tr">
			<td>${us.id}</td>
			<td>${us.lastName}${us.firstName}</td>
			<!--  <td></td>-->
			<td>${us.type}</td>
			<td>${us.zone}</td>
			<td>${us.address}</td>
			<td>
				<fmt:formatDate value="${us.latestMonth}" pattern="yyyy-MM" var="latestMonth"/>
				<span>${latestMonth}</span>
			</td>
			<td>
			<a href="UserAction_deleteUser?id=${us.id}" onclick= "if(confirm('<%=Label.getString("common.deletealt") %>')==false) return false;"><%=Label.getString("common.delete") %></a> | <a href="UserAction_preEdit?id=${us.id}"><%=Label.getString("common.edit") %></a>
			</td>
			
		</tr>
		</c:forEach>
	</table>
</div>
<div class="userMessage">
	<font color="red">${message}</font>
</div>
&nbsp;
<div id="New_pagination" class="userOpr">
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>