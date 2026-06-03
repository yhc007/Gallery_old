<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:choose>
		<c:when test="${!empty shopSales}">
	   		<c:forEach var="sales" items="${shopSales}" varStatus="status">
				${sales.shopName}/${sales.yesterDay }/${sales.toDay }-
			</c:forEach>
										
		</c:when>		
		<c:otherwise>
		</c:otherwise>
	</c:choose>
