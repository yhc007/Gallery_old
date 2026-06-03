<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:choose>
	<c:when test="${!empty listsales}">
		<c:forEach var="sales" items="${listsales}" varStatus="status">
		${sales.dateTime },${sales.shopName},${sales.framePrc },${sales.sunPrc },${sales.lensPrc },${sales.clensPrc },${sales.disPrc },${sales.accPrc },${sales.payCash },${sales.payCard },${sales.payPoint },${sales.total },${sales.cancel}|
		</c:forEach>
	</c:when>
</c:choose>
