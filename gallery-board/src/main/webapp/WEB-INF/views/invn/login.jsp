<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<title>Gallery Comunity</title>
<script type="text/javascript">
$(function(){
	$("#submit").click(login);
});

function login(){
	var id = $("#id").val();
	var pwd = $("#pwd").val();
	
	if(id.length==0){
		alert("ID를 입력하세요.");
		document.getElementById("id").focus();
		return;
	}else if(pwd.length==0){
		alert("비밀번호를 입력하세요.");
		document.getElementById("pwd").focus();
		return;
	}
	
	$.ajax({
		url : '${ctxPath}/invn/login.do',
		type : "post",
		dataType : "text",
		data : "id=" + id + "&pwd=" + pwd + "&shopTy=invn",
		success : function(data){
			if(data.trim()=="success"){
				location.href="${ctxPath}/invn/srchPrdct.do";
			}else if(data.trim()=="fail"){
				alert("ID혹은 비밀번호를 확인해 주세요.");
			}
		}
	});
}
</script>
<style type="text/css">
	body{
			background-image: url("${ctxPath}/images/bg_staff.jpg");
		
		}
	input{
		height: 50px;
		width :200px;
	}
	*{
		font-size: 20px;
	}
	button{
		margin-top : 10px;
		height: 50px;
		width: 100px;
	}
</style>
</head>
<body>
<%@include file="include.jsp"%>
<hr>
<center>
		<input id="id" type="text" placeholder="ID를 입력하세요." onkeydown = "if(event.keyCode==13) login();"><br>
		<input id="pwd" type="password" placeholder="비밀번호를 입력하세요." onkeydown = "if(event.keyCode==13) login();"><br>
		<button id="submit">확인</button>
</center>
</body>
</html>
