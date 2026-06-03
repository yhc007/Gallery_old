<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:choose>
	<c:when test="${!empty listsales}">
   		<c:forEach var="sales" items="${listsales}" varStatus="status" >
			<tr class="listData">
			    <td align="center" >${sales.dateTime}</td>		
				<td align="center">${sales.shopName}</td>
				<td align="center" class="frame">${sales.framePrc }원</td>
				<td align="center" class="lens">${sales.lensPrc }원</td>
				<td align="center" class="cash">${sales.payCash }원</td>
				<td align="center" class="card">${sales.payCard }원</td>
				<td align="center" class="total">${sales.total}원</td>
			</tr>　		
			
					
		</c:forEach>
	</c:when>		
	<c:otherwise>
		<tr>					
			<td colspan="8" align="center">매출 정보가 없습니다.</td>	
		</tr>
	</c:otherwise>
</c:choose>
