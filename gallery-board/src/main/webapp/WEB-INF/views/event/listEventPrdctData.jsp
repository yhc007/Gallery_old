<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="list" width="100%" border="1">
	<colgroup>
		<col width="30%">
		<col width="70%">
	</colgroup>
	<thead>
	<tr>
		<th>NO</th>
		<th>상품 명</th>
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listEventPrdct}">
	   		<c:forEach var="event" items="${listEventPrdct}" varStatus="status">
				<tr onclick="fncGetEventInfo('${event.eventId}');return false;" class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->
				    <td align="center">${event.rownum }</td>			
				    <td>${event.prdctName }</td>
				</tr>			
			</c:forEach>
		</c:when>		
		<c:otherwise>
			<tr>					
				<td colspan="9" align="center">이벤트 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
	<tr>
		<td colspan="9" align="center"><button onclick="fncSearchPopup();return false;">추가하기</button></td>
	</tr>
	
</table>
