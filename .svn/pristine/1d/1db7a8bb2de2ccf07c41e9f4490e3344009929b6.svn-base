/**
 * 公用js文件，提供一些通用的方法
 */
function isNull(value){
	return value == null || value == "" || value == undefined;
}

function registerChangeEvent(){
	$(".input_block input[type=text]").change(function(){
		var id = $(this).prop("id");
		var p_id = "p_"+id;
		$("#"+p_id).text($(this).val());
	});
	$(".input_block input[type=text]").each(function(){
		if($(this).val() == '0.0'){
			$(this).val(0);
		}
	});
	$(".print_block span").each(function(){
		if($(this).text() == '0.0'){
			$(this).text(0);
		}
	});
	$(".input_block input[type=text]").focus(function(){
		if($(this).val() == '0'){
			$(this).val('');
		}
	});
	$(".input_block input[type=text]").blur(function(){
		if($(this).val() == ''&& $(this).prop("id").indexOf("Date")==-1){
			$(this).val('0');
		}
	});
	$(".input_block input.lastQuantity ").each(function(){
		if($(this).val() == "0"||$(this).val() == ""){
			$(this).prop("disabled",false);
		}else{
			$(this).prop("disabled",true);
		}
	});
	$(".input_block input.lastCheckDate").each(function(){
		if(isNull($(this).val())){
			$(this).prop("disabled",false);
		}else{
			$(this).prop("disabled",true);
		}
	});
}
/**
 * 保存并打印
 * @param userId
 */
function saveAndPrint(userId){
	doSave(userId,true);
}
/**
 * 只保存，若printFlag为true,则保存并打印
 * @param userId
 * @param printFlag
 */
function doSave(userId,printFlag){
	//var flag = doCalculate(userId)&&doCollectCalculate(userId);
	var calc_flag = $("#calc_flag_"+userId).val();
	var recalc_flag = $("#recalc_flag_"+userId).val();
	var flag = calc_flag=="true"&&recalc_flag=="true";
	if(!flag){
		alert("数据录入不正确，请检查并重新输入！");
		return;
	}
	var params = {
			"record.id":$("#id_"+userId).val(),
			"record.user.id":userId,
			"record.month":$("#month_"+userId).val()+"-01",
			"record.swiftNumber":$("#swiftNumber_"+userId).text(),
			"record.meterNumber":$("#meterNumber_"+userId).text(),
			"record.meterReader":$("#swiftNumber_"+userId).val(),
			"record.lastQuantity":$("#lastQuantity_"+userId).val(),
			"record.lastCheckDate":$("#lastCheckDate_"+userId).val(),
			"record.nowQuantity":$("#nowQuantity_"+userId).val(),
			"record.nowCheckDate":$("#nowCheckDate_"+userId).val(),
			"record.quantity":$("#quantity_"+userId).val(),
			"record.unitPrice":$("#unitPrice_"+userId).text(),
			"record.additionPrice":$("#additionPrice_"+userId).val(),
			"record.totalPrice":$("#totalPrice_"+userId).val(),
			"record.lastOwe":$("#lastOwe_"+userId).val(),
			"record.nowShouldCollect":$("#nowShouldCollect_"+userId).val(),
			"record.nowRealCollect":$("#nowRealCollect_"+userId).val(),
			"record.nowOwe":$("#nowOwe_"+userId).val(),
			"record.collectUpper":$("#collectUpper_"+userId).val(),
			"record.meterReader":$("#meterReader_"+userId).val(),
			"record.printDate":$("#printDate_"+userId).val(),
			"record.payMethod":$("#payMethod_"+userId).val(),
			"record.tollCollector":$("#tollCollector_"+userId).val(),
			"record.status":0,
	};
	$.ajax({
		url:"json/WaterRecordAction_Async_save",
		method:"post",
		data:params,
		success:function(data){
			$("#message_"+userId).text(data.message);
			$("#p_swiftNumber_"+userId).text(data.swiftNumber);
			$("#swiftNumber_"+userId).val(data.swiftNumber);
			console.log(data.swiftNumber+";;"+$("#p_swiftNumber_"+userId).text());
			if(printFlag){
				doPrint(userId);
			}
		},
		error:function(){
			alert("保存失败！请再次输入");
		}
	});
}
function doPrint(userId){//userId:打印的元素的id
	var flag = doCalculate(userId)&&doCollectCalculate(userId);
	if(!flag){
		if(!confirm("您的数据录入有错误,确定打印吗？")){
			return;
		}
	}
	var printObj = document.getElementById("print_"+userId);
	$(".cmpy,.menu,.condition,.main_block,.footer").hide();
	var iframe = document.createElement("iframe");
	var doc = null;
	iframe.setAttribute('style','position:absolute;width:0px;height:0px;left:-500px;top:-500px;');
	document.body.appendChild(iframe);
	doc = iframe.contentWindow.document;
	//引入打印专有的css样式，ww
	//doc.write('<link rel="stylesheet" type="text/css" href="css/print.css">');
	doc.write('<style>.cmpy{display:none;width:600px;}');
	doc.write('.menu,.condition,.main_block,.footer{width:600px;margin:0px auto;display:none;}');
	doc.write('table{width:100%;}');
	doc.write('#print_box{margin:10px auto;width:600px;height:360px;}');
	doc.write('.Noprint{display:none;}');
	doc.write('.PageNext{page-break-after:avoid;}');
	doc.write('.print_block{width:600px;margin:0px auto;height:310px;}');
	doc.write('.info,table,.foot{font-size:14px;}');
	doc.write('.print_block .info .account{float:left;width:200px;padding-left:3px;height:30px;line-height:30px;}');
	doc.write('.print_block .account span{padding-left:25px;}');
	doc.write('.print_block .info .swift_number{float:left;width:390px;text-align:right;height:30px;line-height:30px;}');
	doc.write('.print_block .swift_number span{padding-right:20px;margin-left:10px;}');
	doc.write('.print_block h3{text-align:center;margin:10px 0 10px 0;}');
	doc.write('.print_block .top_tb,.print_block .middle_tb,.print_block .bottom_tb{width:600px;}');
	doc.write('.print_block td{padding-left:3px;height:24px;}');
	doc.write('.print_block .top_tb,.print_block .middle_tb,.print_block .bottom_tb{border-bottom:1px solid;}');
	doc.write('.print_block .top_tb td,.print_block .bottom_tb td{border-right:1px solid;}');
	doc.write('.print_block .top_tb td{border-top:1px solid;}');
	doc.write('.print_block .top_tb td:first-child,.print_block .bottom_tb td:first-child{border-left:1px solid;width:12%;}');
	doc.write('.print_block .top_tb td:nth-child(2){width:49%;}');
	doc.write('.print_block .top_tb td:nth-child(3){width:12%;}');
	doc.write('.print_block .bottom_tb tr:nth-child(2) td{border-top:1px solid;border-bottom:1px solid;}');
	doc.write('.print_block .middle_tb tr:nth-child(2){height:55px;}');
	doc.write('.print_block .middle_tb tr:nth-child(2) td{border-right:0;border-left:0;}');
	doc.write('.print_block .middle_tb tr:first-child td{border-left:1px solid;border-bottom:1px solid;}');
	doc.write('.print_block .middle_tb tr td:first-child{border-left:1px solid ;}');
	doc.write('.print_block .middle_tb tr td:last-child{border-right:1px solid ;}');
	doc.write('.print_block .bottom_tb tr:last-child td:last-child{text-align:center;}');
	doc.write('.print_block .bottom_tb tr:first-child td{width:12%;}');
	doc.write('.print_block .bottom_tb tr:first-child td:nth-child(6){width:16%;}');
	doc.write('.print_block .foot{height:24px;line-height:24px;margin-top:5px;}');
	doc.write('.print_block .foot .address{width:130px;float:left;padding-left:3px;}');
	doc.write('.print_block .foot .address span{padding-left:10px;}');
	doc.write('.print_block .foot .price_method{width:170px;float:left;text-align:center;}');
	doc.write('.print_block .foot .price_method span{padding-left:10px;}');
	doc.write('.print_block .foot .collector{width:150px;float:left;text-align:center;}');
	doc.write('.print_block .foot .collector span{padding-left:10px;}');
	doc.write('.print_block .factory{font-size:12px;padding-left:3px;float:left;text-align:center;width:140px;}</style>');
	//doc.write('<OBJECT  id=WebBrowser  classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 style="display:none"></OBJECT>');
	doc.write('<div id="print_block" class="print_block PageNext">'+printObj.innerHTML+'</div>');
	doc.close();
	iframe.contentWindow.focus();
	iframe.contentWindow.print();
	if(navigator.userAgent.indexOf("MSIE")>0){
		document.body.removeChild(iframe);
	}
	$(".cmpy,.menu,.condition,.main_block,.footer").show();
	return false;
}
function doCalculate(userId){
	var flag = true;
	var lastQuantity = $("#lastQuantity_"+userId).val();//上次表数
	var nowQuantity = $("#nowQuantity_"+userId).val();//本次表数
	var quantity = $("#quantity_"+userId).val();//用水量
	var unitPrice = $("#unitPrice_"+userId).text();//单价
	var additionPrice = $("#additionPrice_"+userId).val();//追缴水费
	var totalPrice = $("#totalPrice_"+userId).val();//金额
	var lastOwe = $("#lastOwe_"+userId).val();//上期累欠
	var nowShouldCollect = $("#nowShouldCollect_"+userId).val();//本期应收
	var nowRealCollect = $("#nowRealCollect_"+userId).val();//本期实收
	var nowOwe = $("#nowOwe_"+userId).val();//本期累欠
	var collectUpper = $("#collectUpper_"+userId).val();//应收大写
	if(isNull(lastQuantity)){
		lastQuantity = 0;
	}
	if(isNull(nowQuantity)){
		nowQuantity = 0;
	}
	if(isNaN(nowQuantity) || _nowQuantity < _lastQuantity){
		alert("本次表数输入不正确，请重新输入!");
		flag = false;
	}
	
	if(isNaN(additionPrice) || _additionPrice < 0){
		alert("追缴水费输入不正确，请重新输入!");
		flag =  false;
	}
	var _nowQuantity = parseInt(nowQuantity);
	var _lastQuantity = parseInt(lastQuantity);
	if(_nowQuantity<_lastQuantity){
		alert("本次表数不能小于上次表数");
		flag = false;
	}
	var _additionPrice = parseFloat(additionPrice);
	var _unitPrice = parseFloat(unitPrice);
	var _lastOwe = parseFloat(lastOwe);
	if(flag){
		quantity = _nowQuantity - _lastQuantity;//计算用水量
		$("#quantity_"+userId).val(quantity);
		$("#p_quantity_"+userId).text(quantity);
		var _totalPrice = round(quantity * _unitPrice + _additionPrice);//计算金额
		$("#totalPrice_"+userId).val(_totalPrice);
		$("#p_totalPrice_"+userId).text(_totalPrice);
		if(isNull(lastOwe)){
			lastOwe = 0;
		}
		var _nowShouldCollect = round(_lastOwe + _totalPrice);//计算本期应收
		$("#nowShouldCollect_"+userId).val(_nowShouldCollect);
		$("#p_nowShouldCollect_"+userId).text(_nowShouldCollect);
		var _nowRealCollect = 0;
		//if(nowRealCollect == "0"||isNaN(nowRealCollect)){
			_nowRealCollect = _nowShouldCollect;//本期实收
		//}else{
			 //_nowRealCollect = parseFloat(nowRealCollect);
		//}
		$("#nowRealCollect_"+userId).val(_nowRealCollect);
		$("#p_nowRealCollect_"+userId).text(_nowRealCollect);
		nowOwe = round(_nowShouldCollect - _nowRealCollect);//本期累欠
		$("#nowOwe_"+userId).val(nowOwe);
		$("#p_nowOwe_"+userId).text(nowOwe);
		if(_nowShouldCollect>=0) collectUpper = convertCurrency(_nowShouldCollect);//应收大写
		$("#collectUpper_"+userId).val(collectUpper);
		$("#p_collectUpper_"+userId).text(collectUpper);
	}
	$("#calc_flag_"+userId).val(flag.toString());
	return flag;
}
function doCollectCalculate(userId){
	var flag = true;
	var nowRealCollect = $("#nowRealCollect_"+userId).val();//本次实收
	var nowShouldCollect = $("#nowShouldCollect_"+userId).val();//本期应收
	if(!nowRealCollect || isNaN(nowRealCollect)){
		alert("本次实收输入有误！");
		flag = false;
	}
	if(flag){
		var _nowRealCollect = parseFloat(nowRealCollect);
		var _nowShouldCollect = parseFloat(nowShouldCollect);
		$("#p_nowRealCollect_"+userId).text(_nowRealCollect);
		var nowOwe = round(_nowShouldCollect-_nowRealCollect);//本期累欠
		$("#nowOwe_"+userId).val(nowOwe);
		$("#p_nowOwe_"+userId).text(nowOwe);
	}
	$("#recalc_flag_"+userId).val(flag.toString());
	return flag;
}

function round(digit){
	var number = new Number(digit);
	return parseFloat(number.toFixed(2));
}
