<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<thead>
	<tr>
		<th>NO</th>
		<th>업체명</th>
		<th>매장</th>
		<th>제품명</th>
		<th>수량</th>
		<th>금액</th>
		<th>날짜</th>
	</tr>
</thead>
<tbody>
<c:choose>
	<c:when test="${!empty listTrde}">
		<c:set var="flag" value="a">
		</c:set>
		<c:forEach var="trde" items="${listTrde }" varStatus="status">
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
				<td>${status.count }</td>
				<td>${trde.shopName }</td>
				<td>${trde.comName }</td>
				<td>${trde.prdctName }</td>
				<td>${trde.cnt }</td>
				<c:set var="prc" value="${trde.puchasPrc }"></c:set>
				<c:set var="tax" value="${prc*0.1-(prc%1) }"></c:set>
				<td><fmt:formatNumber value="${(prc+tax-((prc+tax)%1))*trde.cnt}" pattern="#,###"/></td>
					<c:set var="regtime" value='${trde.updTime}'/>
					<c:set var="time" value="${fn:substring(regtime, 0, 16)}" />
				<td>${time }</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="7" style="text-align: center">거래 목록이 없습니다.</td>
		</tr>
	</c:otherwise>
</c:choose>
</tbody>