<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.vp.util.ConstantUtil"  %>
<%@ page import="com.vp.util.Label" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=Label.getString("recordinput.pagename") %></title>
<link href="css/common.css" rel="stylesheet" type="text/css"/>
<link rel="shortcut icon" type="image/x-icon" href="img/cock.ico" >
<link href="css/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
<link href="css/pagination.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/datepicker-zh-CN.js"></script>
<script type="text/javascript" src="js/convert.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/jquery.pagination.js"></script>
<script type="text/javascript">	
	$(document).ready(function(){
		selectionInit();
		registerChangeEvent();
		var rowCount = parseInt("${rowCount}");
		$("#New_pagination").pagination(rowCount,{
			items_per_page:parseInt("${noinputPageSize}"),
			next_text:"<%=Label.getString("common.nextpage") %>",
			prev_text:"<%=Label.getString("common.prevpage") %>",
			current_page:parseInt("${currentPage}"),
			num_display_entries:5,
			num_edge_entries:2,
			load_first_page:false,
	        callback:searchRecord
		});
		setSortClass();
		$("#meterReader").change(function(){
			$(".meterReader").val($(this).val());
			$(".meterReader_p").text($(this).val());
		});
		$("#collector").change(function(){
			$(".tollCollector").val($(this).val());
			$(".tollCollector_p").text($(this).val());
		});
	});
	$(function(){
		$.datepicker.setDefaults( $.datepicker.regional[ 'zh-CN' ] );
		$("#month,input.month").datepicker({
			"showAnim":"slideDown",
			showButtonPanel: true,
			changeMonth: true,
		    changeYear: true,
		    dateFormat:"yy-mm",
		    autoSize: true
		});
		$("input.lastCheckDate,input.nowCheckDate,input.printDate").datepicker({
			"showAnim":"slideDown",
			showButtonPanel: true,
			changeMonth: true,
		    changeYear: true,
		    dateFormat:"yy-mm-dd",
		    autoSize: true
		});
	});
	function searchRecord(new_page_index, pagination_container){
		//var month = document.getElementById("year").value+"-"+document.getElementById("month").value;
		var userId = document.getElementById("userId").value;
		var userZone = document.getElementById("userZone").value;
		var userType = document.getElementById("userType").value;
		var selectMeterReader = document.getElementById("meterReader").value;
		var selectCollector = document.getElementById("collector").value;
		var order = document.getElementById("order").value;
		var by = document.getElementById("by").value;
		var url = "UserAction_noInput?u=1";
		if(by==null||by==''){
			by = "u.id";
		}
		if(order==null||order==''){
			order = "asc";
		}
		if(userId != null && userId != '') {
			url += "&userId=" + userId;
		}
		if(userZone != null && userZone != '') {
			url += "&userZone=" + userZone;
		}
		if(userType != null && userType != '') {
			url += "&userType=" + userType;
		}
		if(meterReader != null && meterReader != '') {
			url += "&selectMeterReader=" + selectMeterReader;
		}
		if(collector != null && collector != '') {
			url += "&selectCollector=" + selectCollector;
		}
		if(new_page_index == undefined){
			new_page_index=0;
		}
		url += "&by="+by+"&order="+order;
		url += "&currentPage="+new_page_index;
		location.href = url;
		
	}
	function selectionInit(){
		var selectZone = '${userZone}';
		var selectMeterReader = '${selectMeterReader}';
		var selectCollector = '${selectCollector}';
		var userType = "${userType}";
		//var entered = '${entered}';
		var rowCount = parseInt("${rowCount}");
		var oSel1 = document.getElementById("userZone").options;
		var typeOptions = document.getElementById("userType").options;
		var oSel2 = document.getElementById("meterReader").options;
		var oSel3 = document.getElementById("collector").options;
		var isInput = document.getElementById("isInput");
		for (var i = 0; i < oSel1.length; i++) { 
			if(selectZone == oSel1[i].value){
				oSel1[i].selected = true;
				break;
			}
		}
		for (var j = 0; j < oSel2.length; j++) { 
			if(selectMeterReader == oSel2[j].value){
				oSel2[j].selected = true;
				break;
			}
		}
		for (var k = 0; k < typeOptions.length; k++) { 
			if(userType == typeOptions[k].value){
				typeOptions[k].selected = true;
				break;
			}
		}
		for (var k = 0; k < oSel3.length; k++) { 
			if(selectCollector == oSel3[k].value){
				oSel3[k].selected = true;
				break;
			}
		}
	}
	function setOrderBy(by){
		document.getElementById("by").value = by;
		var order = document.getElementById("order").value;
		if(order == "asc"){
			document.getElementById("order").value = "desc";
		}else{
			document.getElementById("order").value = "asc";
		}
		searchRecord();
	}
	function setSortClass(){
		var order = document.getElementById("order").value;
		var by = document.getElementById("by").value;
		by = by.replace(".","_");
		if(order == "desc"){
			$(".userview th a#"+by+"_a").addClass("sortDesc");
		}else{
			$(".userview th a#"+by+"_a").addClass("sortAsc");
		}
	}
	function showInput(userId){
		$("#inputTr_"+userId).toggle();
	}
</script>
<style>
	.nav li:nth-child(8) span{color:#ee0000;}
	.userview th img{display:none;}
	.input_tr{display:none;}
</style>
</head>
<body>
<div class="menu">
	<jsp:include page="menu.jsp"></jsp:include>
</div>
&nbsp;&nbsp;
<!-- 查询条件 -->
<div class="condition">	
	<!--  <input type="text" id="month" value="${month}"/>
	<select id="year" class="common_select">
	</select>-<select id="month" class="common_select">
		<option value="01">01月</option>
		<option value="02">02月</option>
		<option value="03">03月</option>
		<option value="04">04月</option>
		<option value="05">05月</option>
		<option value="06">06月</option>
		<option value="07">07月</option>
		<option value="08">08月</option>
		<option value="09">09月</option>
		<option value="10">10月</option>
		<option value="11">11月</option>
		<option value="12">12月</option>
	</select>-->
	<%=Label.getString("billdetail.month") %>:<%=ConstantUtil.operateDate.substring(0, ConstantUtil.operateDate.lastIndexOf("-")) %>
	<%=Label.getString("billdetail.useraccount") %><input type="text" id="userId" value="${userId}"/>
	<%=Label.getString("billview.zone") %><select id="userZone" class="common_select">
		    	<option value="">--<%=Label.getString("common.plzselect") %>--</option>
				<c:forEach items="${zoneList}" var="zone">
					<option value="${zone}">${zone}</option>
				</c:forEach>
			</select>
	<%=Label.getString("billdetail.usertype") %><select id="userType" class="common_select">
		<option value="">--<%=Label.getString("common.plzselect") %>--</option>
		<option value="<%=Label.getString("useredit.normal") %>"><%=Label.getString("useredit.normal") %></option>
		<option value="<%=Label.getString("useredit.business") %>"><%=Label.getString("useredit.business") %></option>
	</select>
	<%=Label.getString("billdetail.meterreader") %><select id="meterReader" class="common_select">
				<c:forEach items="${workerList}" var="worker">
					<option value="${worker}">${worker}</option>
				</c:forEach>
			</select>
	<%=Label.getString("billdetail.collector") %><select id="collector" class="common_select">
				<c:forEach items="${workerList}" var="worker">
					<option value="${worker}">${worker}</option>
				</c:forEach>
			</select>
	<!-- 水量录入<input type="checkbox" id="isInput" checked="${entered}"/> -->
	<input type="button" value="<%=Label.getString("common.search") %>" onclick="return searchRecord();" class="common_btn"/>	
	<input type="hidden" value="${order}" id="order">
	<input type="hidden" value="${by}" id="by">	
</div>
&nbsp;&nbsp;
<!-- 显示记录 -->
<div class="userview">
<table border="1" cellspacing="0" class="outer_tb">
		<tr class="outer_tr">
		
			<th><a onclick="setOrderBy('u.id')" id="u_id_a"><%=Label.getString("useredit.useraccount") %><img src="img/arrow_up.png"></a></th>
			<th><a onclick="setOrderBy('u.lastName')" id="u_lastName_a">用户姓名<img src="img/arrow_up.png"></a></th>
			<!--  <th><%=Label.getString("useredit.firstname") %></th>-->
			<th><a onclick="setOrderBy('u.type')" id="u_type_a" ><%=Label.getString("useredit.usertype") %><img src="img/arrow_up.png"></a></th>
			<th><a onclick="setOrderBy('u.zone')" id="u_zone_a" ><%=Label.getString("useredit.zone") %><img src="img/arrow_up.png"></a></th>
			<th><a onclick="setOrderBy('u.address')" id="u_address_a" ><%=Label.getString("useredit.useraddress") %><img src="img/arrow_up.png"></a></th>
			<th><%=Label.getString("common.operate") %></th>
		</tr>
<c:forEach items="${recordList}" var="record">
	<tr class="outer_tr">
		<td>${record.user.id}</td>
		<td>${record.user.lastName}</td>
		<!--  <td>${record.user.firstName}</td>-->
		<td>${record.user.type}</td>
		<td>${record.user.zone}</td>
		<td>${record.user.address}</td>
		<td>
		<a href="UserAction_preEdit?id=${record.user.id}"><%=Label.getString("common.detail") %></a>&nbsp;|
		<a href="WaterRecordAction_recordAdd?userId=${record.user.id }&selectMeterReader=${selectMeterReader }&selectCollector=${selectCollector}">用水录入</a> 
		</td>
	</tr>
</c:forEach>
</table>
</div>
&nbsp;
<div id="New_pagination" class="userOpr">
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>