/**
 * 重置密码界面js文件
 */
var valid = false;
function checkPwd(){
	var orinPwd = document.getElementById("orinPassword").value;
	var params = {
			"orinPassword":orinPwd
	};
	if(isNull(orinPwd)){
		valid = false;
		return;
	}
	$.ajax({
		url:"json/SettingAction_Async_validatePwd",
		method:"post",
		data:params,
		success:function(data){
			if(data.correct == true){
				valid = true;
				document.getElementById("message1").innerText = "";
			}else{
				valid = false;
				document.getElementById("message1").innerText = "原密码输入不正确";
			}
		},
		error:function(){
			alert("验证出现问题，请重新加载页面试试！");
		}
	});
}
function resPwd(){
	var flag = true;
	var orinPwd=document.getElementById("orinPassword").value;
	var newPwd=document.getElementById("newPassword").value;
	var rePwd=document.getElementById("rePassword").value;
	var mes1=document.getElementById('message1');
	var mes2=document.getElementById('message2');
	var mes3=document.getElementById('message3');
	if(isNull(orinPwd)) {
		mes1.innerText = "请输入原密码";
		flag = false;
	}else if(!valid){
		mes1.innerText = "原密码输入不正确";
	}else{
		mes1.innerText = "";
	}
	if(isNull(newPwd)){
		mes2.innerText = "请输入新密码";
		flag = false;
	}else if(newPwd.indexOf(" ")>=0){
		mes2.innerText = "密码中不能包含空格";
		flag = false;
	}else if(newPwd==orinPwd){
	    mes2.innerText = "新密码与原密码相同";
	    flag = false;
	}else{
		mes2.innerText = "";
	}
	if(newPwd != rePwd){
		mes3.innerText = "两次输入不一致";
		flag = false;
	}else{
		mes3.innerText = "";
	}
	return flag&&valid;
}