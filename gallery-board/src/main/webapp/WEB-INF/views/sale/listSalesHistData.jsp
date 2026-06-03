<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:choose>
	<c:when test="${!empty listsales}">
   		<c:forEach var="sales" items="${listsales}" varStatus="status" >
			<tr class="listData">
			    <td align="center" >${sales.dateTime}</td>		
				<td align="center">${sales.shopName}</td>
				<td align="center" class="frame"><fmt:formatNumber value="${sales.framePrc }" pattern="#,###"/></td>
				<td align="center" class="lens"><fmt:formatNumber value="${sales.lensPrc }" pattern="#,###"/></td>
				<td align="center" class="cash"><fmt:formatNumber value="${sales.payCash }" pattern="#,###"/></td>
				<td align="center" class="card"><fmt:formatNumber value="${sales.payCard }" pattern="#,###"/></td>
				<td align="center" class="total"><fmt:formatNumber value="${sales.total}" pattern="#,###"/></td>
			</tr>　		
			<script> 
				sum(${sales.framePrc},"frame");
				sum(${sales.lensPrc},"lens");
				sum(${sales.payCash},"cash");
				sum(${sales.payCard},"card");
				sum(${sales.total},"total");
			</script>
					
		</c:forEach>
		<tr class="listData">
			<td align="center" class="total">합계</td>
			<td align="center" class="total"></td>
			<td align="center" id="frame" class="total"></td>
			<td align="center" id="lens" class="total"></td>
			<td align="center" id="cash" class="total"></td>
			<td align="center" id="card" class="total"></td>
			<td align="center" id="total" class="total"></td>
		</tr>
	</c:when>		
	<c:otherwise>
		<tr>					
			<td colspan="8" align="center">매출 정보가 없습니다.</td>	
		</tr>
	</c:otherwise>
</c:choose>
