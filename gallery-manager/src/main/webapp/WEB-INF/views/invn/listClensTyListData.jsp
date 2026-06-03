<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<option value='-1'>선택</option>
<c:choose>
	<c:when test="${!empty tyList}">
		<c:forEach var="type" items="${tyList}">
			<option value="${type.tyId1 }">${type.tyName }</option>
		</c:forEach>
			<option value="-2">직접입력</option>
	</c:when>
	<c:otherwise>
				<option value="-2">직접입력</option>
	</c:otherwise>
</c:choose>