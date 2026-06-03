<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">
</script>
<style type="text/css">
	body{
		background-image: url('../${ctxPat}/images/shop2.jpg');
		background-size: 100% 100%;
	}
	table {
	color: white;
	background-color: black;
	opacity: 0.7;
	font-weight : bold;
	border : 10px solid #696969;
	font-size : 25px;
	text-align : center;
}
#title{
	font-size : 50px;
	font-weight : bold;
}
.h{
	border-bottom : 1px solid white;
	padding-bottom :10px;
}
</style>
</head>
<body>
	<Center><span id="title">구매내역</span></Center> 
				<br>
	<Center>
	<table width="80%">
		<tr class='h'>
			<td>Shop</td><td>Date</td><td>Price</td><td>Model</td><td>Result</td>
		</tr>
	<c:choose>
		<c:when test="${!empty buyList }">
			<c:forEach var="buy" items="${buyList}">
				<tr>
					<td>${buy.shopName }</td>
					<td>${buy.datetime }</td>
					<td>${buy.ognPrice }</td>
					<td>${buy.frame} &nbsp;&nbsp; ${buy.lens}</td>
					<td>${buy.result}</td>
				</tr>
			</c:forEach>
		</c:when>
			<c:otherwise>
				<tr>
					<td colspan="5" align="center">구매내역이 없습니다.</td>
				</tr>
			</c:otherwise>
	</c:choose>
	</table>
	</Center>
</body>
</html>