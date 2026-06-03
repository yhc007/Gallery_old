<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${!empty fmlyList}">
	<option>--가족회원--</option>
   		<c:forEach var="cstmr" items="${fmlyList}" varStatus="status">
			<option value="${cstmr.cstmrId }">${cstmr.cstmrName }</option>
		</c:forEach>
	</c:when>		
	<c:otherwise>
		<option>--없음--</option>					
	</c:otherwise>
</c:choose>
