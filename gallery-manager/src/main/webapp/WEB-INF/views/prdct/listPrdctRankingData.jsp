<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<tr>
	<th>NO</th>
	<th>매장</th>	
	<th>제품</th>
	<th>단가</th>
	<th>수량</th>
	<th>합계</th>
</tr>
<c:choose>
	<c:when test="${!empty prdctList }">
		<c:set var="flag" value="a">
		</c:set>
	
		<c:forEach var="prdct" items="${prdctList }" varStatus="status">
		
			<c:choose>
			<c:when test="${flag eq 'a'}">
				<c:set value="grayClass" var="cssClass"></c:set>
				
				<c:set var="flag" value='b'></c:set>
			</c:when>
			<c:otherwise>
				<c:set value="whiteClass" var="cssClass">
				</c:set>
				<c:set var="flag" value="a">
				</c:set>
			</c:otherwise>
			</c:choose>
			
			<tr class="${cssClass }">
				<td align="center">${status.count }</td>
				<td align="center">${prdct.shopName }</td>
				<td align="center">${prdct.prdctName }</td>
				<td align="right"><fmt:formatNumber value="${prdct.puchasPrc}" pattern="#,###"/></td>
				<td align="center">${prdct.cnt }</td>
				<td align="right"><fmt:formatNumber value="${prdct.sum}" pattern="#,###"/></td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="6" class="td" align="center">제품이 없습니다</td>
		</tr>
	</c:otherwise>
</c:choose>
