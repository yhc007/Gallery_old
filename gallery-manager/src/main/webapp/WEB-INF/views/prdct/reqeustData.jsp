<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/lib.jsp"%>
		<tr>
			<th>브랜드</th><th>제품</th><th>거래처</th><th>매입가</th><th>판매가</th><th>날짜</th>
		</tr>
	<c:choose>
		<c:when test="${!empty prdctList}">
	   		<c:forEach var="prdct" items="${prdctList}" varStatus="status">
				<tr>
					<td>${prdct.brandName }</td>
					<td>${prdct.prdctName }</td>
					<td>${prdct.comName }</td>
					<td>${prdct.puchasPrc }</td>
					<td>${prdct.salePrc }</td>
					<td>${prdct.datetime }</td>
				</tr>
			</c:forEach>
		</c:when>
	</c:choose>			
			
