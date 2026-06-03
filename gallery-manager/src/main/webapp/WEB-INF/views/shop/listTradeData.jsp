<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<tr>
	<th>NO</th>
	<th>업체</th>	
	<th>매장</th>
	<th>판매액</th>
</tr>
<c:choose>
	<c:when test="${!empty tradeList }">
		<c:set var="flag" value="a">
		</c:set>
	
		<c:forEach var="shop" items="${tradeList }" varStatus="status">
		
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
				<td align="center">${shop.comName }</td>
				<td align="center">${shop.shopName }</td>
				<td align="right"><fmt:formatNumber value="${shop.puchasPrc-shop.rtnPrc}" pattern="#,###"/></td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="4" class="td" align="center">거래내역이 없습니다</td>
		</tr>
	</c:otherwise>
</c:choose>
