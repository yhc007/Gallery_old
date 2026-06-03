<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<option value="-1">선택</option>
	<c:choose>
		<c:when test="${!empty listShop}">
	   		<c:forEach var="shop" items="${listShop}" varStatus="status">
				
				<option value="${shop.shopId }">${shop.shopName }</option>
			</c:forEach>
			
		</c:when>		
		<c:otherwise>
		</c:otherwise>
	</c:choose>
