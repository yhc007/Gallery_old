<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="list" width="100%" border="1">
	<colgroup>
		<col width="5%">
		<col width="20%">
		<col width="20%">
		<col width="20%">
		<col width="10%">
		<col width="10%">
		<col width="15%">
	</colgroup>
	<thead>
	<tr>
		<th>NO</th>
		<th>이벤트 명</th>
		<th>시작 날짜</th>
		<th>종료 날짜</th>
		<th>할인 율</th>
		<th>모델 선택</th>
		<th>참여 모델 수</th>
		<th>시행 여부</th>
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listEvent}">
	   		<c:forEach var="event" items="${listEvent}" varStatus="status">
				<tr onclick="fncGetEventInfo('${event.eventId}');return false;" class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->
				    <td align="center">${event.rownum }</td>			
				    <td>${event.eventName }</td>
				    <td align="center">${event.startTimeStr }</td>
				    <td align="center">${event.endTimeStr }</td>
				    <td align="center">${event.dscnt }</td>
				    <td align="center">${event.eventTyMsg }</td>
				    <td align="center">${event.prdctCnt }</td>
				    <td align="center">${event.eventStatTyMsg }</td>
				</tr>			
			</c:forEach>
			
			<script>
				makePagingButton("${pv.currentPage}","${pv.startPage}","${pv.endPage}","${pv.totalPage}","fncListEventData");
			</script>
		</c:when>		
		<c:otherwise>
			<tr>					
				<td colspan="9" align="center">이벤트 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<br>
	<div align="center" id="paging_button_div">
</div>
