<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
<meta name="viewport" content="target-densitydpi=low-dpi, width=device-width,initial-scale=1.0" />
	<title>Result Fail</title>

</head>
<script type="text/javascript">

function cls(){
	window.open('', '_self', '');
	window.close();
}	

function closeWindow() {
    window.open('','_parent','');
    window.close();
}
</script>


<body>
<h1>
	결제 실패 하였습니다.		
</h1>
	<input type="button" onclick="cls();return false;" value="창닫기">
	
	<input type="button" value="창닫기2" onClick="window.close()">
	
	<a href="#" onclick="close_window();return false;">창닫기3</a> 
	
	<a href="javascript:closeWindow();">Close Window</a>
</a>
</body>
</html>
