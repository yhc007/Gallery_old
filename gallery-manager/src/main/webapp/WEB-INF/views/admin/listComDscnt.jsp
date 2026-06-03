<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<thead>
	<tr>
		<th>NO</th>
		<th>협력사</th>
		<th>매장</th>
		<th>건수</th>
		<th>총액</th>
	</tr>
</thead>

<tfoot>
	<tr>
		<th>NO</th>
		<th>협력사</th>
		<th>매장</th>
		<th>건수</th>
		<th>총액</th>
	</tr>
</tfoot>

<tbody>
<c:choose>
	<c:when test="${!empty dscntList }">
		<c:forEach var="dscnt" items="${dscntList }" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td>${dscnt.comName }</td>
				<td>${dscnt.shopName }</td>
				<td><fmt:formatNumber value="${dscnt.cnt }" pattern="#,###"/></td>
				<td><fmt:formatNumber value="${dscnt.prc }" pattern="#,###"/></td>
			</tr>			
		</c:forEach>
	</c:when>
		
	<c:otherwise>
	</c:otherwise>
</c:choose>
</tbody>