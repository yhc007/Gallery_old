<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:choose>
		<c:when test="${!empty profit}">
	   		<c:forEach var="profit" items="${profit}" varStatus="status">
				${profit.shopName}|${profit.trdePrc}|${profit.puchasPrc}line
			</c:forEach>
										
		</c:when>		
		<c:otherwise>
		</c:otherwise>
	</c:choose>
