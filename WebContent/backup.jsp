<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/common.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#backup_btn").click(doBackup);
		
		$("#file_to_upload").change(function(){
			var file = this.files[0];
			var type = file.type;
			var size = file.size;
			var name = file.name;
			$("#fileName").text(name);
		});
		$("#restore_btn").click(doRestore);
	});
	
	function doBackup(){
		$("#backup_msg").text("正在备份，请稍等片刻。。。");
		$.ajax({
			url:"json/DbAction_Async_backup",
			method:"post",
			success:function(data){
				alert(data.message);
				$("#backup_msg").text(data.message);
				$("#dl").append('<a href="'+data.backupName+'">'+data.backupName+'</a><br/>');
			},
			error:function(data){
				alert(data.message);
				console.log(message);
			}
		});
	}
	function doRestore(){
		var fileName = document.getElementById("file_to_upload").files[0].name;
		if(fileName&&fileName.indexOf('.sql')>0){
			$("#restore_msg").text("正在还原，请稍等片刻。。。");
			var fd = new FormData(document.getElementById("upload_form"));
			$.ajax({
				url:"json/DbAction_Async_restore",
				type:"post",
				data:fd,
				processData:false,
				contentType:false,
				success:function(data,status){
					console.log(data);
					alert(data.message);
					$("#restore_msg").text(data.message);
				},
				error:function(data){
					console.log(data.message);
					alert(data.message);
				}
			});
		}else{
			alert("请选择要还原的文件！")
		}
		
	}
	window.open("/waterprice/login.jsp",'','top=0,left=0,location=no,resizable=yes,scrollbars=yes');
	window.opener = null;
	window.open("","_self");
	window.close();
</script>
<style>
	.nav li:nth-child(7) span{color:#e00;}
	#backup_msg,#restore_msg{color:#f00;}
</style>
</head>
<body>
<div class="menu">
	<jsp:include page="menu.jsp"></jsp:include>
</div>
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
			<td><a href="javascript:void(0)" id="backup_btn">备份</a></td>
			<td><span id="backup_msg"></span></td>
		</tr>
		<tr>
			<td colspan="2"><ul id="dl"></ul></td>
		</tr>
		<tr>
			<td>
				<form enctype="multipart/form-data" method="post" action="json/DbAction_Async_restore" id="upload_form">
					<a href="javascript:void(0)" id="file_btn">选择文件<input type="file" id="file_to_upload" name="file"/></a>
				</form>
			</td>
			<td><span id="fileName"></span></td>
		</tr>
		<tr>
			<td><a href="javascript:void(0)" id="restore_btn">还原备份</a></td>
			<td><span id="restore_msg"></span></td>
		</tr>
	</table>
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>