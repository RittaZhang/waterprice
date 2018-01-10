/**
 * 系统设定页面js文件
 */
$(function(){
	$.datepicker.setDefaults( $.datepicker.regional[ 'zh-CN' ] );
	$("#operateDate").datepicker({
		"showAnim":"slideDown",
		showButtonPanel: true,
		changeMonth: true,
	    changeYear: true,
	    dateFormat:"yy-mm",
	    autoSize: true
	});
});

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
	/*document.getElementById("file_btn").onclick = function(){
		document.getElementById("file_to_upload").click();
	};*/
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
	var file = document.getElementById("file_to_upload").files[0];
	if(file){
		var fileName = file.name;
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
			alert("文件选择错误，必须是后缀名为.sql的备份文件！");
		}
	}else{
		alert("请选择要还原的文件！")
	}
	
}
