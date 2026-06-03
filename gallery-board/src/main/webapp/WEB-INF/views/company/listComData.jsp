<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<c:choose>
		<c:when test="${!empty listCom}">
	   		<c:forEach var="company" items="${listCom}" varStatus="status">
				<option value="${company.test }">${company.test2 }</option>
			</c:forEach>
		</c:when>		
	</c:choose>
