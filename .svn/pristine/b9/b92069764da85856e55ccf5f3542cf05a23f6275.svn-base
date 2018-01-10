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
<title><%=Label.getString("billdetail.pagename") %></title>
<link rel="shortcut icon" type="image/x-icon" href="img/cock.ico" >
<link href="css/common.css" rel="stylesheet" type="text/css"/>
<link href="css/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
<link href="css/pagination.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/datepicker-zh-CN.js"></script>
<script type="text/javascript" src="js/convert.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		registerChangeEvent();
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
		initShow();
	});
	
	function initShow(){
		var recordId = "${record.id }";
		if(isNull(recordId)){
			$("#billTitle").text("添加一条收据");
			$(".swift_number").hide();
			$("#print_btn_${record.user.id }").hide();
		}else{
			$("#billTitle").text("编辑一条收据");
			$(".swift_number").show();
		}
	}
	function goBack(){
		var fromPage = "${fromPage}";
		if(fromPage=="useredit"){
			history.back();
		}else{
			location.href='WaterRecordAction_goBack';
		}
	}
</script>
<style type="text/css">
	.nav li:nth-child(7) span{color:#ee0000;}
</style>
</head>
<body>
<div class="menu">
	<jsp:include page="menu.jsp"></jsp:include>
</div>
&nbsp;&nbsp;
<div class="bill_title">
	<span id="billTitle">添加一条收据</span>
</div>
<div id="print_block_${record.user.id}" class="input_block PageNext">
		<div class="info">
			<input type="hidden" id="id_${record.user.id }" value="${record.id }">
			<input type="hidden" id="calc_flag_${record.user.id}" value="true"/>
			<input type="hidden" id="recalc_flag_${record.user.id}" value="true"/>
			<div class="account"><%=Label.getString("billdetail.useraccount") %><span>${record.user.id}</span></div>
			<div class="swift_number"><%=Label.getString("billdetail.swiftnumber") %><span id="swiftNumber_${record.user.id}">${record.swiftNumber}</span></div>
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
					<fmt:formatDate value="${record.month}" pattern="yyyy-MM" var="month"/>
					<input type="hidden" value="${month}" id="month_${record.user.id}" class="month">
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
				<td><%=Label.getString("billdetail.meterreader") %></td>
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
			<input type="button" value="<%=Label.getString("common.print") %>" class="common_btn" id="print_btn_${record.user.id }" onclick="doPrint('${record.user.id}')"/>
			<input type="button" value="<%=Label.getString("common.saveAndPrint") %>" class="common_btn" id="saveAndPrint_btn_${record.user.id }" onclick="saveAndPrint('${record.user.id}')"/>
			<input class="common_btn" type="button" onclick="goBack();" value="返回">
		</div>
		<script>
		$("#nowQuantity_${record.user.id}").change(function(){doCalculate('${record.user.id}');});
		$("#additionPrice_${record.user.id}").change(function(){doCalculate('${record.user.id}');});
		$("#lastQuantity_${record.user.id}").change(function(){doCalculate('${record.user.id}');});
		$("#nowRealCollect_${record.user.id}").change(function(){doCollectCalculate('${record.user.id}');});
		</script>
	</div>
	<!-- 下面是要打印的报表 -->
	<div id="print_${record.user.id}" class="print_block PageNext" style="display:none">
		<h3><%=ConstantUtil.printTitle %></h3>
		<div class="info">
			<div class="account"><%=Label.getString("billdetail.useraccount") %><span>${record.user.id}</span></div>
			<div class="swift_number"><%=Label.getString("billdetail.swiftnumber") %><span id="swiftNumber_${record.user.id}">${record.swiftNumber}</span></div>
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
				<td>${record.user.id}</td>
				<td><span id="p_lastQuantity_${record.user.id }">${record.lastQuantity}</span></td>
				<td><span id="p_lastCheckDate_${record.user.id}">${record.lastCheckDate}</span></td>
				<td><span id="p_nowQuantity_${record.user.id}" >${record.nowQuantity}</span></td>
				<td>
					<fmt:formatDate value="${record.nowCheckDate}" pattern="yyyy-MM-dd" var="nowCheckDate"/>
					<span id="p_nowCheckDate_${record.user.id}">${nowCheckDate}</span>
				</td>
				<td><span id="p_quantity_${record.user.id}"></span></td>
				<!-- <td>
					<fmt:formatDate value="${record.month}" pattern="yyyy-MM" var="month"/>
					<span id="p_month_${record.user.id}" class="month">${month}</span>
				</td> -->
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
</body>
</html>