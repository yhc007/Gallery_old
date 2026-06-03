<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:choose>
		<c:when test="${!empty staffChart}">
	   		<c:forEach var="staff" items="${staffChart}" varStatus="status">
				${staff.staffName}|${staff.prc}|${staff.staffSalesAvg }|${staff.staffId }line
			</c:forEach>
										
		</c:when>		
		<c:otherwise>
		</c:otherwise>
	</c:choose>
