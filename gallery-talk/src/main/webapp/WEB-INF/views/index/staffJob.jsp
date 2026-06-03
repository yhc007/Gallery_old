<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:choose>
		<c:when test="${!empty staffJob}">
	   		<c:forEach var="staff" items="${staffJob}" varStatus="status">
				${staff.staffName}|${staff.selectPrdct}|${staff.chkeyes}|${staff.asmbly}|${staff.payment}|${staff.dlvl}|line
			</c:forEach>
		</c:when>		
		<c:otherwise>
		</c:otherwise>
	</c:choose>
