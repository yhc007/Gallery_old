<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	
	<c:when test="${!empty listCom}">
		<option value="-1">거래처 선택</option>
		<c:forEach var="com" items="${listCom }">
			<option value="${com.shopNum }">${com.shopName }</option>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<option >없음</option>
	</c:otherwise>
</c:choose>
