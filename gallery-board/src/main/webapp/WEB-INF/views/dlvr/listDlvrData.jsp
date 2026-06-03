<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${!empty listdlvr}">
   		<c:forEach var="dlvr" items="${listdlvr}" varStatus="status">
			<tr class="listData">
			    <td align="center">${dlvr.saleId }</td>		
				<td align="center">${dlvr.cstmrName }</td>
				<td align="center">${dlvr.addr }</td>
				<td align="center">${dlvr.phone }</td>
				<td align="center">${dlvr.dlvrStatTyCd }</td>
				<td align="center">${dlvr.regtime }</td>
				<td align="center">${dlvr.uptime }</td>
			</tr>			
		</c:forEach>
	</c:when>		
	<c:otherwise>
		<tr>					
			<td colspan="7" align="center">배송 정보가 없습니다.</td>	
		</tr>
	</c:otherwise>
</c:choose>