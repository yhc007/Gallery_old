<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:choose>
		<c:when test="${!empty staffList}">
	   		<c:forEach var="staff" items="${staffList}" varStatus="status">
				
				<option value="${staff.staffId }">${staff.staffName }</option>
			</c:forEach>
		</c:when>		
		<c:otherwise>
		</c:otherwise>
	</c:choose>
