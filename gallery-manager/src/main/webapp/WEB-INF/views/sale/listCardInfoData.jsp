<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<center>
	<table width="90%" border="1" style="border-collapse: collapse;">
		<c:choose>
			<c:when test="${!empty listCard}">
				<c:forEach var="card" items="${listCard }">
					<tr>
						<th>${card.cardName }</th>
						<td align="right"><fmt:formatNumber value="${card.payCard }" pattern="#,###"/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise> 
				<tr>
					<td colspan="2">매출 정보가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
</center>