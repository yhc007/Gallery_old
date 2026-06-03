<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${!empty shopList}">
   		<c:forEach var="shop" items="${shopList}" varStatus="status">
			<option value="${shop.shopId }">${shop.shopName }</option>
		</c:forEach>
	</c:when>		
	<c:otherwise>
			<option value="">매장 정보가 없습니다.</option>
	</c:otherwise>
</c:choose>