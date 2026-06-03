<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<c:choose>
	<c:when test="${!empty shopName }">
		<c:forEach var="shop" items="${shopName }">
			<option value="${shop.shopId }">${shop.shopName }</option>
		</c:forEach>
	</c:when>
</c:choose>
