<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<tr>
	<th>브랜드명</th> <th>상품명</th><th>등록일자</th>
</tr>
	<c:choose>
		<c:when test="${!empty listPrdct}">
	   		<c:forEach var="prdct" items="${listPrdct}" varStatus="status">
				<tr onclick="getPrdctInfo(${prdct.prdctId})">
					<td align="text">${prdct.brandName }</td>
					<td align="text">${prdct.prdctName }</td>
					<td align="text">${prdct.datetime }</td>
				</tr>
			</c:forEach>
			
		</c:when>
		<c:otherwise>
								
		</c:otherwise>
	</c:choose>
