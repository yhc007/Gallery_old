<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:choose>
	<c:when test="${!empty listsales}">
		<c:forEach var="sales" items="${listsales}" varStatus="status">${sales.dateTime },${sales.shopName },${sales.framePrc },${sales.lensPrc },${sales.payCash },${sales.payCard },${sales.total }|
		</c:forEach>
	</c:when>
</c:choose>
