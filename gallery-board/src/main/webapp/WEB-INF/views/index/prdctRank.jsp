<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:choose>
		<c:when test="${!empty prdctRank}">
	   		<c:forEach var="prdct" items="${prdctRank}" varStatus="status">
				${prdct.prdctName}|http://106.240.234.114:8080/media${prdct.img}|${prdct.prc}|${prdct.prdctCount }line
			</c:forEach>
										
		</c:when>		
		<c:otherwise>
		</c:otherwise>
	</c:choose>
