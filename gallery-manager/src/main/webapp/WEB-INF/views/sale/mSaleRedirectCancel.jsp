<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
<meta name="viewport" content="target-densitydpi=low-dpi, width=device-width,initial-scale=1.0" />
	<title>Result Cancel</title>

</head>


<script>

function cls(){
	window.open('','_self','');
	window.close();
}

function blg(){
	window.android2.callAndroid('c');
}
</script>

<body>
<h1>
	결제 취소 하였습니다.
</h1>

<input type="button" onclick="blg();return false;" value="돌아가기">

<h3>버튼이 동작하지 않을 경우 브라우저를 종료시켜 주십시오.</h3>
</body>
</html>
