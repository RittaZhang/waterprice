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
		//var entered = document.getElementById("isInput").checked;
		var url = "WaterRecordAction_recordInput?u=1";
		/*if(month != null && month != '') {
			url += "&month=" + month;
		}*/
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
</script>
<style>
	.nav li:nth-child(1) span{color:#ee0000;}
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
</div>
&nbsp;&nbsp;
<!-- 显示记录 -->
<div id="print_box">
<c:forEach items="${recordList}" var="record">
	<div id="print_block_${record.user.id}" class="input_block PageNext">
		<div class="info">
			<input type="hidden" id="id_${record.user.id }" value="${record.id }">
			<input type="hidden" id="calc_flag_${record.user.id}" value="true"/>
			<input type="hidden" id="recalc_flag_${record.user.id}" value="true"/>
			<fmt:formatDate value="${record.month}" pattern="yyyy-MM" var="month"/>
			<input type="hidden" value="${month}" id="month_${record.user.id}" class="month">
			<div class="account"><%=Label.getString("billdetail.useraccount") %><span>${record.user.id}</span></div>
			<div class="swift_number" style="display:none;"><%=Label.getString("billdetail.swiftnumber") %><span id="swiftNumber_${record.user.id}">${record.swiftNumber}</span></div>
		</div>
		<table class="top_tb" border="0" cellspacing="0">
			<tr>
				<td><%=Label.getString("billdetail.username") %></td>
				<td>${record.user.lastName}${record.user.firstName}</td>
				<td><%=Label.getString("billdetail.usertype") %></td>
				<td>${record.user.type}</td>
			</tr>
			<tr>
				<td><%=Label.getString("billdetail.useraddress") %></td>
				<td colspan="3">${record.user.address}</td>
			</tr>
		</table>
		<table class="middle_tb" border="0" cellspacing="0">
			<tr>
				<td><%=Label.getString("billdetail.meternumber") %></td>
				<td><%=Label.getString("billdetail.lastmeterquantity") %></td>
				<td><%=Label.getString("billdetail.lastcheckdate") %></td>
				<td><%=Label.getString("billdetail.nowmeterquantity") %></td>
				<td><%=Label.getString("billdetail.checkdate") %></td>
				<td><%=Label.getString("billdetail.quantity") %></td>
				<!--  <td>月份</td>-->
				<td><%=Label.getString("billdetail.unitprice") %></td>
				<td><%=Label.getString("billdetail.additionprice") %></td>
				<td><%=Label.getString("billdetail.totalprice") %></td>
			</tr>
			<tr>
				<td>
					<span id="meterNumber_${record.user.id}">${record.meterNumber}</span>
				</td>
				<td><input type="text" class="lastQuantity" id="lastQuantity_${record.user.id}" value="${record.lastQuantity}"/></td>
				<td>
					<fmt:formatDate value="${record.lastCheckDate}" pattern="yyyy-MM-dd" var="lastCheckDate"/>
					<input type="text" class="lastCheckDate" id="lastCheckDate_${record.user.id}" value="${lastCheckDate}"/>
				</td>
				<td><input type="text" class="nowQuantity" id="nowQuantity_${record.user.id}" value="${record.nowQuantity}"/></td>
				<td>
				    <fmt:formatDate value="${record.nowCheckDate}" pattern="yyyy-MM-dd" var="nowCheckDate"/>
					<input type="text" class="nowCheckDate" id="nowCheckDate_${record.user.id}" value="${nowCheckDate}"/>
				</td>
				<td><input type="text" class="quantity" id="quantity_${record.user.id}" value="${record.quantity}"  disabled/></td>
				<!--  <td>
					<fmt:formatDate value="${record.month}" pattern="yyyy-MM" var="month"/>
					<input type="text" value="${month}" id="month_${record.user.id}" class="month">
				</td>-->
				<td><span id="unitPrice_${record.user.id}">${record.unitPrice}</span></td>
				<td><input type="text" class="additionPrice" id="additionPrice_${record.user.id}" value="${record.additionPrice}"/></td>
				<td><input type="text" class="totalPrice" id="totalPrice_${record.user.id}" value="${record.totalPrice}"  disabled/></td>
			</tr>
		</table>
		<table class="bottom_tb" border="0" cellspacing="0">
			<tr>
				<td><%=Label.getString("billdetail.lastowe") %></td>
				<td><input type="text" id="lastOwe_${record.user.id}" value="${record.lastOwe}"  disabled/></td>
				<td><%=Label.getString("billdetail.nowshouldcollect") %></td>
				<td><input type="text" id="nowShouldCollect_${record.user.id}" value="${record.nowShouldCollect}"  disabled/></td>
				<td><%=Label.getString("billdetail.nowrealcollect") %></td>
				<td><input type="text" id="nowRealCollect_${record.user.id}" value="${record.nowRealCollect}"/></td>
				<td><%=Label.getString("billdetail.nowowe") %></td>
				<td><input type="text" id="nowOwe_${record.user.id}" value="${record.nowOwe}"  disabled/></td>
			</tr>
			<tr>
				<td><%=Label.getString("billdetail.shouldcollectupper") %></td>
				<td colspan="3"><input type="text" id="collectUpper_${record.user.id}" value="${record.collectUpper}"/></td>
				<td ><%=Label.getString("billdetail.meterreader") %></td>
				<td colspan="3"><input type="text" id="meterReader_${record.user.id}" value="${record.meterReader}" class="meterReader"/></td>
			</tr>
			<tr>
				<td><%=Label.getString("billdetail.fixtelephone") %></td>
				<td colspan="2"><%=ConstantUtil.telephoneValue%></td>
				<td><%=Label.getString("billdetail.printdate") %></td>
				<td colspan="2">
					<fmt:formatDate value="${record.printDate}" pattern="yyyy-MM-dd" var="printDate"/>
					<input type="text" value="${printDate}" id="printDate_${record.user.id}" class="printDate"/>
				</td>
				<td colspan="2">(<%=Label.getString("billdetail.sealvalid") %>)</td>
			</tr>
		</table>
		<div class="foot">
			<div class="address"><%=Label.getString("billdetail.address") %>:<span><%=ConstantUtil.addressValue%></span></div>
			<div class="price_method"><%=Label.getString("billdetail.paymethod") %>:<span><input type="text" id="payMethod_${record.user.id}" value="<%=Label.getString("billdetail.cash") %>"/></span></div>
			<div class="collector"><%=Label.getString("billdetail.collector") %>:<span><input type="text" id="tollCollector_${record.user.id}" value="${record.tollCollector}" class="tollCollector"/></span></div>
			<div class="factory"><%=ConstantUtil.printFooter%></div>
		</div>
		<div class="waterOpr">
			<span class="message" id="message_${record.user.id }" style="color:#cc0000;"></span>
			<input type="button" value="<%=Label.getString("common.save") %>" class="common_btn" id="save_btn_${record.user.id }" onclick="doSave('${record.user.id}')"/>
			<!--  <input type="button" value="打印" class="common_btn" id="print_btn_${record.user.id }" onclick="doPrint('${record.user.id}')"/>-->
			<input type="button" value="<%=Label.getString("common.saveAndPrint") %>" class="common_btn" id="saveAndPrint_btn_${record.user.id }" onclick="saveAndPrint('${record.user.id}')"/>
		</div>
	</div>
	<script type="text/javascript">
		$("#nowQuantity_${record.user.id}").change(function(){doCalculate('${record.user.id}');});
		$("#additionPrice_${record.user.id}").change(function(){doCalculate('${record.user.id}');});
		$("#lastQuantity_${record.user.id}").change(function(){doCalculate('${record.user.id}');});
		$("#nowRealCollect_${record.user.id}").change(function(){doCollectCalculate('${record.user.id}');});
	</script>
	<!-- 下面是要打印的报表 -->
	<div id="print_${record.user.id}" class="print_block PageNext" style="display:none">
		<h3><%=ConstantUtil.printTitle %></h3>
		<div class="info">
			<div class="account"><%=Label.getString("billdetail.useraccount") %><span>${record.user.id}</span></div>
			<div class="swift_number"><%=Label.getString("billdetail.swiftnumber") %><span id="p_swiftNumber_${record.user.id }">${record.swiftNumber}</span></div>
		</div>
		<table class="top_tb" border="0" cellspacing="0">
			<tr>
				<td><%=Label.getString("billdetail.username") %></td>
				<td>${record.user.lastName}${record.user.firstName}</td>
				<td><%=Label.getString("billdetail.usertype") %></td>
				<td>${record.user.type}</td>
			</tr>
			<tr>
				<td><%=Label.getString("billdetail.useraddress") %></td>
				<td colspan="3">${record.user.address}</td>
			</tr>
		</table>
		<table class="middle_tb" border="0" cellspacing="0">
			<tr>
				<td><%=Label.getString("billdetail.meternumber") %></td>
				<td><%=Label.getString("billdetail.lastmeterquantity") %></td>
				<td><%=Label.getString("billdetail.lastcheckdate") %></td>
				<td><%=Label.getString("billdetail.nowmeterquantity") %></td>
				<td><%=Label.getString("billdetail.checkdate") %></td>
				<td><%=Label.getString("billdetail.quantity") %></td>
				<!-- <td>月份</td> -->
				<td><%=Label.getString("billdetail.unitprice") %></td>
				<td><%=Label.getString("billdetail.additionprice") %></td>
				<td><%=Label.getString("billdetail.totalprice") %></td>
			</tr>
			<tr>
				<td>${record.user.id}</td>
				<td><span id="p_lastQuantity_${record.user.id }">${record.lastQuantity}</span></td>
				<td><span id="p_lastCheckDate_${record.user.id}">${record.lastCheckDate}</span></td>
				<td><span id="p_nowQuantity_${record.user.id}" >${record.nowQuantity}</span></td>
				<td>
					<fmt:formatDate value="${record.nowCheckDate}" pattern="yyyy-MM-dd" var="nowCheckDate"/>
					<span id="p_nowCheckDate_${record.user.id}">${nowCheckDate}</span>
				</td>
				<td><span id="p_quantity_${record.user.id}"></span></td>
				<!--  <td>
					<fmt:formatDate value="${record.month}" pattern="yyyy-MM" var="month"/>
					<span id="p_month_${record.user.id}" class="month">${month}</span>
				</td>-->
				<td>${record.unitPrice}</td>
				<td><span id="p_additionPrice_${record.user.id}">${record.additionPrice}</span></td>
				<td><span id="p_totalPrice_${record.user.id}">${record.totalPrice}</span></td>
			</tr>
		</table>
		<table class="bottom_tb" border="0" cellspacing="0">
			<tr>
				<td><%=Label.getString("billdetail.lastowe") %></td>
				<td><span id="p_lastOwe_${record.user.id}" >${record.lastOwe}</span></td>
				<td><%=Label.getString("billdetail.nowshouldcollect") %></td>
				<td><span id="p_nowShouldCollect_${record.user.id}" >${record.nowShouldCollect}</span></td>
				<td><%=Label.getString("billdetail.nowrealcollect") %></td>
				<td><span id="p_nowRealCollect_${record.user.id}">${record.nowRealCollect}</span></td>
				<td><%=Label.getString("billdetail.nowowe") %></td>
				<td><span id="p_nowOwe_${record.user.id}">${record.nowOwe}</span></td>
			</tr>
			<tr>
				<td><%=Label.getString("billdetail.shouldcollectupper") %></td>
				<td colspan="3"><span id="p_collectUpper_${record.user.id}" >${record.collectUpper}</span></td>
				<td><%=Label.getString("billdetail.meterreader") %></td>
				<td colspan="3"><span id="p_meterReader_${record.user.id}" class="meterReader_p">${record.meterReader}</span></td>
			</tr>
			<tr>
				<td><%=Label.getString("billdetail.fixtelephone") %></td>
				<td colspan="2"><%=ConstantUtil.telephoneValue%></td>
				<td><%=Label.getString("billdetail.printdate") %></td>
				<td colspan="2">
					<fmt:formatDate value="${record.printDate}" pattern="yyyy-MM-dd" var="printDate"/>
					<span  id="p_printDate_${record.user.id}">${printDate}</span>
				</td>
				<td colspan="2">(<%=Label.getString("billdetail.sealvalid") %>)</td>
			</tr>
		</table>
		<div class="foot">
			<div class="address"><%=Label.getString("billdetail.address") %>:<span><%=ConstantUtil.addressValue%></span></div>
			<div class="price_method"><%=Label.getString("billdetail.paymethod") %>:<span id="p_payMethod_${record.user.id}">${record.payMethod}</span></div>
			<div class="collector"><%=Label.getString("billdetail.collector") %>:<span id="p_tollCollector_${record.user.id}" class="tollCollector_p">${record.tollCollector}</span></div>
			<div class="factory"><%=ConstantUtil.printFooter%></div>
		</div>
	</div>
</c:forEach>
</div>
<!-- 操作区，主要是下一页按钮 -->
<div class="operate" id="next">
	<span>${rows}/${rowCount }</span>
	<input type="button" value="<%=Label.getString("common.nextpage") %>" onclick="searchRecord();" class="common_btn" id="next_btn">
	<script>
		var rows = parseInt("${rows}");
		var rowCount = parseInt("${rowCount }");
		if(rows==rowCount){
			document.getElementById("next_btn").disabled = true;
		}
	</script>
</div>
<div class="operate" id="pagination">
<!-- <div id="New_pagination"></div>-->
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>