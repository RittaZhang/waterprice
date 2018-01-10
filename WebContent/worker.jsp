<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.vp.util.Label" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=Label.getString("worker.pagename") %></title>
<link rel="shortcut icon" type="image/x-icon" href="img/cock.ico" >
<link href="css/common.css" rel="stylesheet" type="text/css"/>
<link href="css/pagination.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/jquery.pagination.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		showWorker({});
		$("#add").click(addWorker);
		
		var rowCount = parseInt("${rowCount}");
		$("#New_pagination").pagination(rowCount,{
			items_per_page:parseInt("${pageSize}"),
			next_text:"<%=Label.getString("common.nextpage") %>",
			prev_text:"<%=Label.getString("common.prevpage") %>",
			current_page:"${currentPage}",
			num_display_entries:5,
			num_edge_entries:2,
			load_first_page:false,
	        callback:searchWorker
		});
	});
	function showWorker(params){
		$.ajax({
			url:"json/WorkerAction_Async_list",
			method:"post",
			data:params,
			success:function(data){
				total_html = parseJson(data);
				$("#results").html(total_html);
				$("#New_pagination").pagination(data.rowCount,{
					items_per_page:data.pageSize,
					next_text:"<%=Label.getString("common.nextpage") %>",
					prev_text:"<%=Label.getString("common.prevpage") %>",
					current_page:data.currentPage,
					num_display_entries:5,
					num_edge_entries:2,
					load_first_page:false,
			        callback:searchWorker
				});
			},
			error:function(message){
				alert(message);
			}
			
		});
	}
	function addWorker(){
		var workerName = $("#workerName").val();
		var params = {
			"worker.name":workerName
		};
		workerName = $.trim(workerName);
		if(workerName){
			$.ajax({
				url:"json/WorkerAction_Async_save",
				method:"post",
				data:params,
				success:function(data){
					if(data.error){
						alert(data.error);
					}
					total_html = parseJson(data);
					$("#results").html(total_html);
					$("#workerName").val("");
					$("#New_pagination").pagination(data.rowCount,{
						items_per_page:data.pageSize,
						next_text:"<%=Label.getString("common.nextpage") %>",
						prev_text:"<%=Label.getString("common.prevpage") %>",
						current_page:data.currentPage,
						num_display_entries:5,
						num_edge_entries:2,
						load_first_page:false,
				        callback:searchWorker
					});
				},
				error:function(message){
					alert("<%=Label.getString("common.addfaild") %>,"+message);
				}
			});
		}else{
			alert("<%=Label.getString("worker.plzinput") %>");
			$("#workerName").val("");
		}
		
	} 
	function deleteWorker(id){
		if(confirm('<%=Label.getString("common.deletealt") %>')==false){
			return false;
		}
		var params = {
				"id":id
		};
		$.ajax({
			url:"json/WorkerAction_Async_delete",
			method:"post",
			data:params,
			success:function(data){
				console.log(data);
				total_html = parseJson(data);
				$("#results").html(total_html);
				$("#New_pagination").pagination(data.rowCount,{
					items_per_page:data.pageSize,
					next_text:"<%=Label.getString("common.nextpage") %>",
					prev_text:"<%=Label.getString("common.prevpage") %>",
					current_page:data.currentPage,
					num_display_entries:5,
					num_edge_entries:2,
					load_first_page:false,
			        callback:searchWorker
				});
			},
			error:function(){
				alert("<%=Label.getString("common.deletefaild") %>");
			}
		});
	}
	function parseJson(data){
		if(typeof data == "object"){
			var items = data.items;
			var total_html = '<table border="1" cellspacing="0" class="workerTab">';
			total_html += '<tr>';
			total_html += '<th><%=Label.getString("common.index") %></th>';
			total_html += '<th><%=Label.getString("worker.name") %></th>';
			total_html += '<th><%=Label.getString("common.operate") %></th>';
			total_html += '</tr>';
			var prevCount = data.pageSize*data.currentPage;
			for(var i=0;i<items.length;i++){
				var item = items[i];
				total_html += '<tr>';
				total_html += '<td>'+(i+1+prevCount)+'</td>';
				total_html += '<td>'+item.name+'</td>';
				total_html += '<td><a href="javascript:void(0)" onclick="deleteWorker('+item.id+')"><%=Label.getString("common.delete") %></a></td>';
				total_html += '</tr>';
			}
			total_html += '</table>';
			return total_html;
		}else{
			return '<table><tr><th><%=Label.getString("common.index") %></th><th><%=Label.getString("worker.name") %></th><th><%=Label.getString("common.operate") %></th></tr></table>';
		} 
	}
	function searchWorker(new_page_index, pagination_container){
		var params = {
				currentPage:new_page_index
		};
		showWorker(params);
	}
</script>
<style>
	.nav li:nth-child(5) span{color:#ee0000;}
</style>
</head>
<body>
<div class="menu">
	<jsp:include page="menu.jsp"></jsp:include>
</div>
<div class="workerMain">
	<table class="addWorker">
		<tr>
			<th></th>
			<th><%=Label.getString("worker.workername") %></th>
			<th><%=Label.getString("common.operate") %></th>
		</tr>
		<tr>
			<td colspan="2"><input type="text" name="worker.name" id="workerName"/></td>
			<td><a href="javascript:void(0)" id="add"><input type="button" value=" <%=Label.getString("common.add") %>" class="common_btn"/></a></td>
		</tr>
	</table>
	<div id="results" class="workerTable">
		
	</div>
</div>
<div class="paginate">
	<div id="New_pagination" class="opr"></div>
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>