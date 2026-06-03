<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<c:choose>
	<c:when test="${!empty brandList }">
		<option value="-1">선택</option>
		<c:forEach var="prdct" items="${brandList }">
			<option value="${prdct.prdctId }">${prdct.prdctName }</option>
		</c:forEach>
		<option value="-2">직접입력</option>
	</c:when>
	<c:otherwise>
			<option value="-1">상품이 없습니다.</option>
			<option value="-2">직접입력</option>
		</c:otherwise>
		
</c:choose>
