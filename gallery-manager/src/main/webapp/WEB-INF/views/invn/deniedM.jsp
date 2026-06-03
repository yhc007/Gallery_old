<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
<style type="text/css">
	body{
		background-image: url("${ctxPath}/images/bg_staff.jpg");
	}
</style>
</head>
<body>
<%@include file="includeM.jsp"%>
<hr>
<center>
		사용권한이 없습니다.<br><br>
		<font style="font-size: 12px"><a href="${ctxPath }/invn/indexM.do">로그인</a></font>
</center>
</body>
</html>
