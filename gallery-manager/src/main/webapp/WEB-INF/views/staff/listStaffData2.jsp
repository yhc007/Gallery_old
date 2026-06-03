<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${!empty staffList }">
		<option value="-1">선택</option>
		<c:forEach var="staff" items="${staffList }">
			<option value="${staff.staffId }">${staff.staffName }</option>
		</c:forEach>
	</c:when>
</c:choose>
