<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.vp.util.Label" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=Label.getString("billview.pagename") %></title>
<link rel="shortcut icon" type="image/x-icon" href="img/cock.ico" >
<link href="css/common.css" rel="stylesheet" type="text/css"/>
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
			items_per_page:parseInt("${billPageSize}"),
			next_text:"<%=Label.getString("common.nextpage") %>",
			prev_text:"<%=Label.getString("common.prevpage") %>",
			current_page:parseInt("${currentPage}"),
			num_display_entries:5,
			num_edge_entries:2,
			load_first_page:false,
	        callback:searchRecord
		});
		setSortClass();
	});
	$(function(){
		$.datepicker.setDefaults( $.datepicker.regional[ 'zh-CN' ] );
		$("input.date,input.printDate").datepicker({
			"showAnim":"slideDown",
			showButtonPanel: true,
			changeMonth: true,
		    changeYear: true,
		    dateFormat:"yy-mm-dd",
		    autoSize: true
		});
	});
	function searchRecord(new_page_index, pagination_container){
		var month = document.getElementById("year").value+"-";
		var mon = document.getElementById("month").value;
		var userId = document.getElementById("userId").value;
		var userZone = document.getElementById("userZone").value;
		//var selectCollector = document.getElementById("collector").value;
		var order = document.getElementById("order").value;
		var by = document.getElementById("by").value;
		var checkDate = document.getElementById("checkDate").value;
		var printDate = document.getElementById("printDate").value;
		var url = "WaterRecordAction_queryRecord?u=1";
		if(mon != null && mon != '') {
			month += mon;
			url += "&month=" + month;
		}
		if(userId != null && userId != '') {
			url += "&userId=" + userId;
		}
		if(userZone != null && userZone != '') {
			url += "&userZone=" + userZone;
		}
		/*if(collector != null && collector != '') {
			url += "&selectCollector=" + selectCollector;
		}*/
		if(by==null||by==''){
			by = "u.id";
		}
		if(order==null||order==''){
			order = "asc";
		}
		url += "&by="+by+"&order="+order;
		if(checkDate != null && checkDate != '') {
			url += "&checkDate=" + checkDate;
		}
		if(printDate != null && printDate != '') {
			url += "&printDate=" + printDate;
		}
		if(new_page_index == undefined){
			new_page_index=0;
		}
		
		//if(entered){
			url += "&currentPage="+new_page_index;
		//}
		location.href = url;
		
	}
	function selectionInit(){
		var selectZone = '${userZone}';
		//var selectMeterReader = '${selectMeterReader}';
		var selectCollector = '${selectCollector}';
		var rowCount = parseInt("${rowCount}");
		var oSel1 = document.getElementById("userZone").options;
		//var oSel3 = document.getElementById("collector").options;
		for (var i = 0; i < oSel1.length; i++) { 
			if(selectZone == oSel1[i].value){
				oSel1[i].selected = true;
				break;
			}
		}
		/*for (var k = 0; k < oSel3.length; k++) { 
			if(selectCollector == oSel3[k].value){
				oSel3[k].selected = true;
				break;
			}
		}*/
		
		initMonth();
	}
	
	function initMonth(){
		var d = new Date();
		var year = d.getFullYear();
		var year_select = document.getElementById("year");
		for(y=year-2;y<year+5;y++){
			year_select.options.add(new Option(y+"<%=Label.getString("common.year") %>",y));
		}
		var yn = "${month}";
		var yearOps = document.getElementById("year").options;
		var monthOps = document.getElementById("month").options;
		if(yn){
			var curY = yn.substring(0,yn.indexOf("-"));
			var curM = yn.substring(yn.indexOf("-")+1);
			for (var j = 0; j < yearOps.length; j++) { 
				if(curY == yearOps[j].value){
					yearOps[j].selected = true;
					break;
				}
			}
			for (var j = 0; j < monthOps.length; j++) { 
				if(curM == monthOps[j].value){
					monthOps[j].selected = true;
					break;
				}
			}
		}else{
			for (var j = 0; j < yearOps.length; j++) { 
				if(year == yearOps[j].value){
					yearOps[j].selected = true;
					break;
				}
			}
		}
		
	}
	
	function batchSave(){
		var recordList = "[";
		$(".billview table tr").each(function(index,el){
			if(index == 0) return;
			if(index == 1){
				var record = "{";
			}else{
				var record = ",{";
			}
			record+= "\"id\":"+$(this).find(".id").val()+",";
			record+="\"printDate\":\""+$(this).find(".printDate").val()+"\",";
			record+="\"nowShouldCollect\":"+$(this).find(".nowShouldCollect").val()+",";
			record+="\"nowRealCollect\":"+$(this).find(".nowRealCollect").val()+",";
			record+="\"tollCollector\":\""+$(this).find(".tollCollector").val()+"\"";
			record+="}";
			recordList+=record;
		});
		recordList += "]";
		console.log(recordList)
		var params = {
			"jsonStr":recordList
		};
		console.log(params);
		$.ajax({
			url:"json/WaterRecordAction_Async_batchSave",
			data:params,
			method:"post",
			dataType:"json",
			success:function(data){
				$("#msg").text(data.message);
			},
			error:function(data){
				$("#msg").text(data.message);
				console.log(data);
			}
		});
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
			$(".billview th a#"+by+"_a").addClass("sortDesc");
		}else{
			$(".billview th a#"+by+"_a").addClass("sortAsc");
		}
	}
</script>
<style>
	.nav li:nth-child(7) span{color:#ee0000;}
	.billDiv{min-height:520px;}
	.billDiv .billview{width:900px;margin:20px auto;}
	.billDiv .billMessage{text-align:center;width:800px;margin:0 auto;}
	.billDiv .billMessage #msg{display:inline-block;width:320px;}
	.billDiv .billview table{width:100%;text-align:left;}
	.billDiv .billview table tr th:last-child{text-align:center;}
	.billDiv .billview table tr td:nth-child(2),.billDiv .billview table tr td:nth-child(5){width:11%;}
	.billDiv .billview table tr td:nth-child(3){width:12%;}
	.billDiv .billview table tr td:nth-child(4){width:20%;}
	.billDiv .billview table tr td:nth-child(6){width:10%;}
	.billDiv .billview table tr td:nth-child(7),.billDiv .billview table tr td:nth-child(8){width:9%;}
	.billDiv .billview table tr td:nth-child(9){width:10%;}
	.billDiv .billview table tr td:nth-child(8) input,.billDiv .billview table tr td:nth-child(9) input{width:95%;}
	.billDiv .billview table tr td:last-child{width:10%;text-align:center;}
	.billDiv .billview th img{display:none;}
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
	<select id="year" class="common_select">
	</select>-<select id="month" class="common_select">
		<!--  <option value=""><%=Label.getString("common.plzselect") %></option>-->
		<option value="01">01<%=Label.getString("common.month") %></option>
		<option value="02">02<%=Label.getString("common.month") %></option>
		<option value="03">03<%=Label.getString("common.month") %></option>
		<option value="04">04<%=Label.getString("common.month") %></option>
		<option value="05">05<%=Label.getString("common.month") %></option>
		<option value="06">06<%=Label.getString("common.month") %></option>
		<option value="07">07<%=Label.getString("common.month") %></option>
		<option value="08">08<%=Label.getString("common.month") %></option>
		<option value="09">09<%=Label.getString("common.month") %></option>
		<option value="10">10<%=Label.getString("common.month") %></option>
		<option value="11">11<%=Label.getString("common.month") %></option>
		<option value="12">12<%=Label.getString("common.month") %></option>
	</select>
	<%=Label.getString("billview.useraccount") %><input type="text" id="userId" value="${userId}"/>
	<%=Label.getString("billview.zone") %><select id="userZone" class="common_select">
		    	<option value="">--<%=Label.getString("common.plzselect") %>--</option>
				<c:forEach items="${zoneList}" var="zone">
					<option value="${zone}">${zone}</option>
				</c:forEach>
			</select>
	<!-- 抄表员<select id="meterReader" class="common_select">
				<c:forEach items="${workerList}" var="worker">
					<option value="${worker}">${worker}</option>
				</c:forEach>
			</select> -->
	<%=Label.getString("billview.checkdate") %><input type="text" class="date" id="checkDate" value="${checkDate }"/>
	<%=Label.getString("billview.printdate") %><input type="text" class="date" id="printDate" value="${printDate }"/>
	<!--  收费员<select id="collector" class="common_select">
				<c:forEach items="${workerList}" var="worker">
					<option value="${worker}">${worker}</option>
				</c:forEach>
			</select>-->
	<input type="button" value=" <%=Label.getString("common.search") %> " onclick="return searchRecord();" class="common_btn"/>	
	<input type="hidden" value="${order}" id="order">
	<input type="hidden" value="${by}" id="by">	
</div>
<div class="billDiv">
<div class="billview">
	<table border="1" cellspacing="0">
		<tr>
			<th><a onclick="setOrderBy('w.swiftNumber')" id="w_swiftNumber_a"><%=Label.getString("billview.swiftNumber") %><img src="img/arrow_up.png"></a></th>
			<th><a onclick="setOrderBy('u.id')" id="u_id_a"><%=Label.getString("billview.useraccount") %><img src="img/arrow_up.png"></a></th>
			<th><a onclick="setOrderBy('u.lastName')" id="u_lastName_a"><%=Label.getString("billview.username") %><img src="img/arrow_up.png"></a></th>
			<th><a onclick="setOrderBy('u.zone')" id="u_zone_a"><%=Label.getString("billview.zone") %><img src="img/arrow_up.png"></a></th>
			<th><%=Label.getString("billview.usertype") %></th>
			<th><a onclick="setOrderBy('w.printDate')" id="w_printDate_a"><%=Label.getString("billview.printdate") %><img src="img/arrow_up.png"></a></th>
			<th><%=Label.getString("billview.nowshouldcollect") %></th>
			<th><%=Label.getString("billview.nowrealcollect") %></th>
			<th><%=Label.getString("billview.collector") %></th>
			<th><%=Label.getString("common.operate") %></th>
		</tr>
		
		<c:forEach items="${recordList}" var="rd">
		<tr>
			<td>${rd.swiftNumber}</td>
			<td>${rd.user.id}<input type="hidden" value="${rd.id }" class="id" name="rd.id"/></td>
			<td>${rd.user.lastName}${rd.user.firstName}</td>
			<td>${rd.user.zone}</td>
			<td>${rd.user.type}</td>
			<td><input type="text" value="${rd.printDate }" id="printDate_${rd.id }" class="printDate" name="rd.printDate"/></td>
			<td>${rd.nowShouldCollect}<input type="hidden" value="${rd.nowShouldCollect }" class="nowShouldCollect"/></td>
			<td><input type="text" value="${rd.nowRealCollect }" id="nowRealCollect_${rd.id }" class="nowRealCollect" name="rd.nowRealCollect"/></td>
			<td><input type="text" value="${rd.tollCollector }" id="tollCollector_${rd.id }" class="tollCollector" name="rd.tollCollector"/></td>
			<td>
			<a href="WaterRecordAction_detail?id=${rd.id}"><%=Label.getString("common.detail") %></a> 
			<!-- | <a href="WaterRecordAction_preEdit?id=${rd.id}">编辑</a> -->
			</td>
			
		</tr>
		</c:forEach>
	</table>
</div>
<div class="billMessage">
	<span style="color:green"><%=Label.getString("billview.alt") %></span>
	<input type="button" value="<%=Label.getString("common.save") %>" class="common_btn" id="batcn_save_btn" onclick="batchSave();">
	<span id="msg" style="color:red;text-align:left;padding-left:10px;"></span>
</div>
</div>
&nbsp;
<div id="New_pagination" class="userOpr">
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>