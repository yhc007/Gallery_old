<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<thead>
	<tr>
		<th>NO</th>
		<th>월</th>
		<th>방문수</th>
	</tr>
</thead>

<tfoot>
	<tr>
		<th>NO</th>
		<th>월</th>
		<th>방문수</th>
	</tr>
</tfoot>

<tbody>
<c:choose>
	<c:when test="${!empty listCntVisitor }">
		<c:forEach var="visit" items="${listCntVisitor }" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td>${visit.monthly }</td>
				<td><fmt:formatNumber value="${visit.visitCnt }" pattern="#,###"/></td>
			</tr>			
		</c:forEach>
	</c:when>
		
	<c:otherwise>
	</c:otherwise>
</c:choose>
</tbody>