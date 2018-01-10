/**
 * 登录界面js文件
 */
function checkPassword(){
		var pwd = document.getElementById("password").value;
		if(pwd==null||pwd==""){
			document.getElementById("errorMsg").innerText="密码不能为空！";
			return false;
		}else{
			document.getElementById("errorMsg").innerText="";
			return true;
		}		
} 

function getParameter(name){
	     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	     var r = window.location.search.substr(1).match(reg);
	     if(r!=null)return  unescape(r[2]); return null;
}

window.onload = function(){
	var retURL = getParameter("retURL");
	document.getElementById("retURL").value = retURL;
}