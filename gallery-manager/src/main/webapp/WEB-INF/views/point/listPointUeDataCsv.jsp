<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:choose>
	<c:when test="${!empty listUeTable }">
		<jsp:useBean id="now" class="java.util.Date" />
		<fmt:formatDate value="${now}" pattern="yy-MMdd" var="date" /> 
		<c:set var="count" value="1"></c:set>
		<c:forEach var="point" items="${listUeTable }" varStatus="status">
				${status.count }
				<c:if test="${count < 1000 }">
					<c:set var="n" value=""></c:set>
				</c:if>
				<c:if test="${count < 100 }">
					<c:set var="n" value="0"></c:set>
				</c:if>
				<c:if test="${count < 10 }">
					<c:set var="n" value="00"></c:set>
				</c:if>
				,${point.usingShop }, ${point.earnShop}, ${point.point }|
			<c:set value="${count +1 }" var="count"></c:set>
		</c:forEach>
	</c:when>
	<c:otherwise>
		fail
	</c:otherwise>
</c:choose>