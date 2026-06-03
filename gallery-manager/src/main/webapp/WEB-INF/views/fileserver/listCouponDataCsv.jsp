<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:choose>
	<c:when test="${!empty couponList }">
		<%-- <jsp:useBean id="now" class="java.util.Date" /> --%>
		<fmt:formatDate value="${now}" pattern="yy-MMdd" var="date" /> 
		<c:forEach var="coupon" items="${couponList }" varStatus="status">
				${status.count },${coupon.couponCd},${coupon.cstmrName },${coupon.cstmrCd },${coupon.lastShopName },${coupon.email },${coupon.cellphone },${coupon.usingDate },${coupon.shopName },${coupon.memo }|
		</c:forEach>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>