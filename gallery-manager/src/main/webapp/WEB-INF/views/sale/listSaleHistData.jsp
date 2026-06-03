<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:choose>
	<c:when test="${!empty listsale}">
   		<c:forEach var="sale" items="${listsale}" varStatus="status">
			<tr class="listData">
			    <td align="center">${sale.saleId }</td>		
				<td align="center">${sale.shopName }</td>
				<td align="center">${sale.userName }</td>
				<td align="center">${sale.userAddr }</td>
				<td align="center">${sale.userPhone }</td>
				<td align="center" class="price"><fmt:formatNumber value="${sale.price }" pattern="#,###"/></td>
				<td align="center">${sale.result }</td>
				<td align="center">${sale.regtime }</td>
			</tr>		
			<script> 
				sum(${sale.price});
			</script>	
			
		</c:forEach>
		<tr class="listData">
			<td align="center" class="total">합계</td>
			<td align="center" class="total"></td>
			<td align="center" class="total"></td>
			<td align="center" class="total"></td>
			<td align="center" class="total"></td>
			<td align="center" class="total" id="total"></td>
			<td align="center" class="total"></td>
			<td align="center"  class="total"></td>
		</tr>
	</c:when>		
	<c:otherwise>
		<tr>					
			<td colspan="8" align="center">판매 정보가 없습니다.</td>	
		</tr>
	</c:otherwise>
</c:choose>