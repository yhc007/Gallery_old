<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type='text/javascript' src='https://www.google.com/jsapi'></script>
<script type="text/javascript">
	$(function(){
		// $("#submit").click(login);
		var id = window.localStorage.getItem("loginId");
		if(id!=null){
			$("#id").val(id);
			$("input:checkbox[id='chk']").attr("checked", true);
		}
	});

	function login(){

		if($("input:checkbox[id='chk']").is(":checked")==true){
			var id = $("#id").val();
			window.localStorage.setItem("loginId", id);
		}else{
			window.localStorage.removeItem("loginId");
		}

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
			url : '${ctxPath}/admin/login.do',
			type : "post",
			dataType : "text",
			data : "id=" + id + "&pwd=" + pwd + "&shopTy="+"shop",
			success : function(data){
				if(data.trim()=="success"){
					location.href="${ctxPath}/chart/chart.do";
				}else if(data.trim()=="fail"){
					alert("ID혹은 비밀번호를 확인해 주세요.");
				}
			}
		});
	}
</script>
<style type="text/css">
	input[id='id'],input[id='pwd']{
		background-image: url("${ctxPath}/images/partner/blank.png");
		background-size : 100% 100%;
		border: 0;
		height: 30px;
		width : 120px;
		outline : 0;
		padding-left: 10px;
		font-size: 20px;
	}
	.label{
		width: 60%;
	}
	#loginTable{
		border: 5px solid #b0e0e6;
		border-radius:0.5em;
		padding : 20px;
	}
</style>
</head>
<body>
	<center>
	<form action="" id="loginForm">
		<table id="loginTable">
			<tr>
				<td><img src="${ctxPath }/images/partner/id.png" class="label" onkeydown = "if(event.keyCode==13) login();"></td>
				<td><input type="text" id="id" name="id"></td>
			</tr>
			<tr>
				<td><img src="${ctxPath }/images/partner/pwd.png" class="label" onkeydown = "if(event.keyCode==13) login();"></td>
				<td><input type="password" id="pwd" name="pwd"></td>
			</tr>
			<tr>
				<td></td><td align="right">아이디 저장<input type="checkbox" id="chk"> </td>
			</tr>
			<tr align="center">
				<td colspan="2"><button id="submit" onclick="login(); return false;">확인</button></td>
		</table>
	</form>
	</center>
</body>
</html>
