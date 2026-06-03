<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${!empty cardPayList}">
		<c:forEach var="card" items="${cardPayList }">
			(${card.cardName }카드 : ${card.payCard })<br>
		</c:forEach>
	</c:when>
</c:choose>