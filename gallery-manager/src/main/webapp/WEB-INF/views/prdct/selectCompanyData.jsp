<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:choose>
		<c:when test="${!empty listCompany}">
	   		<c:forEach var="company" items="${listCompany}" varStatus="status">
					<option value="${company.INum }">${company.CName }</option>
			</c:forEach>
		</c:when>		
		<c:otherwise>
		</c:otherwise>
	</c:choose>
