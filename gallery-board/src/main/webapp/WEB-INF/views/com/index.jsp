<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.css" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.js"></script>
<title>Gallery Comunity</title>
<script type="text/javascript">
	$(function(){
		var id = window.localStorage.getItem("loginId");
		if(id!=null){
			$("#id").val(id);
			$("input:checkbox[id='chk']").attr("checked", true);
		}
		
	});
	window.sessionStorage.setItem("ty","-1");
	function login(){
		if($("input:checkbox[id='chk']").is(":checked")==true){
			var id = $("#id").val();
			window.localStorage.setItem("loginId", id);
		}else{
			window.localStorage.removeItem("loginId");
		}
		var id = $("#id").val();
		var pwd = $("#pwd").val();
		if(id.length=="0"){
			alert("ID를 입력하세요.");
			$("#id").focus();
			return;
		}else if(pwd.length=="0"){
			alert("패스워드를 입력하세요.");
			$("#pwd").focus();
			return;
		}
		var param = $("#loginForm").serialize();
		var url = "${ctxPath}/admin/comLogin.do";
		
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(result){
				if(result.trim()=="ok"){ 
					location = "${ctxPath}/admin/goIndexPage.do";
					
				}else if(result.trim()=="fail"){
					alert("ID 혹은 패스워드를 확인하세요.");
				}else{
					alert("오류가 발생했습니다.");
				}
			}
		});
	};
	
	
</script>
<style type="text/css">
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
	<%@include file="inclue.jsp" %>
	<br>
	<br>
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