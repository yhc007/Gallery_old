<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:choose>
	<c:when test="${!empty comList }">
		<c:set var="flag" value="a">
		</c:set>
	
		<c:forEach var="shop" items="${comList }" varStatus="status">
		
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
				<td>${shop.shopName }</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="4" class="td" align="center">거래내역이 없습니다</td>
		</tr>
	</c:otherwise>
</c:choose>