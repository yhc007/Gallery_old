<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<Tr>
	<th>매장</th>
	<th>제품명</th>
	<th>수량</th>
	<th>날짜</th>
</Tr>
<c:choose>
	<c:when test="${!empty trdeList }">
		<c:set var="flag" value="a">
		</c:set>
		<c:forEach var="prdct" items="${trdeList }">
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
			<tr class="${cssClass }" onclick="modifyDate('${prdct.id}','${prdct.deliverTime }')">
				<td align="center">${prdct.shopName }</td>
				<td align="center">${prdct.prdctName }</td>
				<td align="center">${prdct.cnt }</td>
				<td align="center">${prdct.deliverTime }</td>
			</tr>		
		</c:forEach>
	</c:when>
</c:choose>
