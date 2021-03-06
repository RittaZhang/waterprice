<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.vp.util.ConstantUtil"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/convert.js"></script>
<link rel="stylesheet" type="text/css" href="css/print.css"/>
<script language="javascript">
	$(document).ready(function(){
		$("#print_btn").click(function(){
			$(this).hide();
			doPrint('print_block'); 
			$(this).show();
			//printPreview();
		});
	});
	
	function doPrint(pid){//pid:打印的元素的id
		var printObj = document.getElementById(pid);
		var iframe = document.createElement("iframe");
		var doc = null;
		iframe.setAttribute('style','position:absolute;width:0px;height:0px;left:-500px;top:-500px;');
		document.body.appendChild(iframe);
		doc = iframe.contentWindow.document;
		//引入打印专有的css样式，ww
		doc.write('<link rel="stylesheet" type="text/css" href="css/print.css">');
		doc.write('<OBJECT  id=WebBrowser  classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 style="display:none"></OBJECT>');
		doc.write('<div id="print_block" class="print_block PageNext">'+printObj.innerHTML+'</div>');
		doc.close();
		iframe.contentWindow.focus();
		iframe.contentWindow.print();
		//iframe.contentDocument.all.WebBrowser.ExecWB(7,1);//打印
		//iframe.contentDocument.all.WebBrowser.ExecWB(6,1);//打印
		//iframe.contentDocument.all.WebBrowser.ExecWB(6,6);//直接打印
		//iframe.contentDocument.all.WebBrowser.ExecWB(7,1);//打印预览
		//iframe.contentDocument.all.WebBrowser.ExecWB(8,1);//打印设置
		if(navigator.userAgent.indexOf("MSIE")>0){
			document.body.removeChild(iframe);
		}
		return false;
	}
	//打印预览
	function printPreview(){
		document.all.WebBrowser.ExecWB(7,1);
	}
</script>
<style>
	#printObj{width:968px;margin:10px auto;}
</style>
</head>
<body>
<!-- http://www.cnblogs.com/robertfang/articles/1599551.html
	http://wenku.baidu.com/link?url=PHsPJMYlueDbZfqqmXKMJWny8X5I6ufuiGRXMDvhMcjaGsOQGDzCEsOWROJSoVWEd1Aea8Bx8Aoa4ACfZkJbQCAaxAPdVwS1yKl_NFsRMf7
 -->
</body>

<div id="printObj">
	<div id="print_block" class="print_block PageNext">
		<h3><%=ConstantUtil.printTitle %></h3>
		<div class="info">
			<div class="account">用户帐号<span>0798</span></div>
			<div class="swift_number">No.<span>J2015122619180798</span></div>
		</div>
		<table class="top_tb" border="0" cellspacing="0">
			<tr>
				<td>用户姓名</td>
				<td>李小龙</td>
				<td>用户类型</td>
				<td>居民用水</td>
			</tr>
			<tr>
				<td>用户地址</td>
				<td colspan="3">南关区亚泰大街6789号</td>
			</tr>
		</table>
		<table class="middle_tb" border="0" cellspacing="0">
			<tr>
				<td>表号</td>
				<td>上次表数</td>
				<td>上次查表时间</td>
				<td>表数</td>
				<td>查表时间</td>
				<td>用水量</td>
				<td>月份</td>
				<td>单价</td>
				<td>追缴费用</td>
				<td>金额</td>
			</tr>
			<tr>
				<td>0798</td>
				<td>23</td>
				<td>2015-11-11</td>
				<td>25</td>
				<td>2015-11-11</td>
				<td>2</td>
				<td>2015-12</td>
				<td>3.9</td>
				<td>0</td>
				<td>7.8</td>
			</tr>
		</table>
		<table class="bottom_tb" border="0" cellspacing="0">
			<tr>
				<td>上期累欠</td>
				<td>0</td>
				<td>本期应收</td>
				<td>7.8</td>
				<td>本期实收</td>
				<td>7.8</td>
				<td>本次累欠</td>
				<td>0</td>
			</tr>
			<tr>
				<td>实收大写</td>
				<td colspan="3">柒圆捌角</td>
				<td >抄表员</td>
				<td colspan="3">成龙</td>
			</tr>
			<tr>
				<td>报修电话</td>
				<td colspan="2">88888</td>
				<td>日期</td>
				<td colspan="2">2015-12-02</td>
				<td colspan="2">(盖章有效)</td>
			</tr>
		</table>
		<div class="foot">
			<div class="address">地址:<span>乌拉街内</span></div>
			<div class="price_method">收费方式:<span>现金</span></div>
			<div class="collector">收费员:<span>李连杰</span></div>
		</div>
		<div class="factory">乌拉街供水厂</div>
	</div>
	<div class="opr">
		<input type="button" value="打印" id="print_btn"/><br/>
	</div>
</div>
</html>