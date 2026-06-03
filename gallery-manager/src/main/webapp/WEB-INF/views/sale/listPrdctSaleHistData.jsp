<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${!empty listsale}">
   		<c:forEach var="sale" items="${listsale}" varStatus="status">
			<tr class="listData">
			   <td align="center">${sale.saleId }</td>		
				<td align="center">${sale.shopName }</td>
				<td align="center">${sale.cstmrName }</td>
				<td align="center">${sale.prdctName }</td>
				<td align="center">${sale.prdctCnt }</td>
				<td align="center">${sale.price }</td>
				<td align="center">${sale.resultCd }</td>
				<td align="center">${sale.dateTime }</td>
			</tr>			
		</c:forEach>
	</c:when>		
	<c:otherwise>
		<tr>					
			<td colspan="7" align="center">판매 정보가 없습니다.</td>	
		</tr>
	</c:otherwise>
</c:choose>