<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">
 var cstmrId = '${cstmrId}';
 
 
 function modify(){
	var url = "${ctxPath}/cstmr/cstmrInfoUpdate.do"; 
	var cpwd = $("#cpwd").val();
	var npwd = $("#npwd").val();
	var ncpwd = $("#ncpwd").val();
	var param = "cstmrId=" + cstmrId + "&checkPw=" + cpwd + "&newPw=" + npwd;
	if(cpwd==""||npwd==""||ncpwd==""){
		alert("비밀번호를 입력하세요.");
		return;
	}else if(ncpwd!=npwd){
		alert("비밀번호가 일치 하지 않습니다.");
		document.getElementById("npwd").focus();
		return;
	}
	
	
	$.ajax({
		url : url,
		type:"post",
		data : param,
		success : function(result){
			console.log(result)
			if(result.trim()=="pwError"){ 
				alert("이전 비밀번호가 일치하지 않습니다.");
				document.getElementById("cpwd").focus();
			}else if(result.trim()=="success"){ 
				alert("비밀번호가 변경되었습니다.");
				/* location.href="${ctxPath}/cstmr/mlistCstmrData.do?cstmrId=" + cstmrId; */
				history.back(-1);
			}
		},
		error : function(e1, e2, e3){
			alert(e2)
		}
	});
 };
</script>
<style type="text/css">
body {
	background-image: url('../${ctxPat}/images/shop3.jpg');
	background-size: 100% 100%;
}
.edit{
	display : none;
	height : 29px;
	font-size : 20px;
}
table {
	color: white;
	background-color: black;
	opacity: 0.7;
	font-weight : bold;
	border : 10px solid #696969;
	font-size : 25px;
}
#title{
	font-size : 50px;
	font-weight : bold;
}

td {
	padding: 5px;
	text-align : center;
}
</style>
</head>
<body>
	<Center><span id="title">비밀번호 변경</span></Center>
	<br> 
	<center>	
	<table width="80%">
		<tr>
			<Td>이전 비밀번호</td><Td> <input type="password" id="cpwd"> </Td>
		</tr>
		<tr>
			<Td>변경 비밀번호</td><Td> <input type="password" id="npwd"> </Td>
		</tr>
		<tr>
			<Td>비밀번호 확인</td><Td> <input type="password" id="ncpwd"> </Td>
		</tr>
		<tr>
			<td colspan="2" align="center"><button onclick="modify()">확인</button></td>
		</tr>
	</table>
	</center>
	
</body>
</html>