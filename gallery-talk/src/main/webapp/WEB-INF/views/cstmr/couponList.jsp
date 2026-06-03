<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">
</script>
<style type="text/css">
	body{
		background-image: url('../${ctxPat}/images/shop5.jpg');
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
<Center><span id="title">쿠폰함</span></Center> 
				<br>
	<Center>
	<table width="80%">
		<tr>
			<td>Coupon</td><td>Number</td><td>Open</td><td>Close</td><td>Item</td>
		</tr>
	<c:choose>
		<c:when test="${!empty couponList }">
			<c:forEach var="coupon" items="${couponList }">
				<tr>
					<td>${coupon.couponName }</td>
					<td>${coupon.couponCd }</td>
					<td>${coupon.startDate }</td>
					<td>${coupon.endDate }</td>
					<c:if test="${coupon.dscntPrc >= 100}">
						<td>${coupon.dscntPrc }원</td>
					</c:if>
					<c:if test="${coupon.dscntPrcnt <= 100}">
						<td>${coupon.dscntPrcnt }%</td>
					</c:if>
				</tr>
			</c:forEach>
		</c:when>
			<c:otherwise>
				<tr>
					<td colspan="5" align="center">쿠폰이 없습니다.</td>
				</tr>
			</c:otherwise>
	</c:choose>
	</table>
	</Center>
</body>
</html>