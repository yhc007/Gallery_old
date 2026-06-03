<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<tr>
	<th>NO</th>
	<th>수금매장</th>
	<th>지급매장</th>
	<th>포인트정산금액</th>
</tr>
<c:choose>
	<c:when test="${!empty listUeTable }">
		<jsp:useBean id="now" class="java.util.Date" />
		<fmt:formatDate value="${now}" pattern="yy-MMdd" var="date" /> 
		<c:set var="count" value="1"></c:set>
		<c:set var="flag" value="a">
		</c:set>
		<c:forEach items="${listUeTable }" var="point" varStatus="status">
		<c:choose>
			<c:when test="${flag eq 'a'}">
				<c:set value="grayClass" var="cssClass"></c:set>
				
				<c:set var="flag" value='b'></c:set>
			</c:when>
			<c:otherwise>
				<c:set value="whiteClass" var="cssClass">
				</c:set>
				<c:set var="flag" value="a">
				</c:set>
			</c:otherwise>
			</c:choose>
			
			<tr class="${cssClass }">
				<td>${status.count }</td>
				<c:if test="${count < 1000 }">
					<c:set var="n" value=""></c:set>
				</c:if>
				<c:if test="${count < 100 }">
					<c:set var="n" value="0"></c:set>
				</c:if>
				<c:if test="${count < 10 }">
					<c:set var="n" value="00"></c:set>
				</c:if>
				<td>${point.usingShop }</td>
				<td>${point.earnShop}</td>
				<td>${point.point }</td>
			</tr>		
			<c:set value="${count +1 }" var="count"></c:set>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<td colspan="4">정산 내역이 없습니다.
	</c:otherwise>
</c:choose>