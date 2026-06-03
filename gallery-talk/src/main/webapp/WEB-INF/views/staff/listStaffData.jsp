<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="list" width="100%" border="1">
	<colgroup>
		<col width="10%">
		<col width="20%">
		<col width="20%">
		<col width="20%">
		<col width="30%">
	</colgroup>
	<thead>
	<tr>
		<th>NO</th>
		<th>소속 매장</th>
		<th>이름</th>
		<th>직책</th>
		<th>전화번호</th>
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listStaff}">
	   		<c:forEach var="staff" items="${listStaff}" varStatus="status">
				<tr onclick="fncGetStaffInfo('${staff.staffId}');return false;" class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->
				    <td>${staff.rownum }</td>
				    <td>${staff.shopName }</td>			
				    <td>${staff.staffName }</td>
				    <td>${staff.position }</td>
				    <td>${staff.phone }</td>
				</tr>			
			</c:forEach>
			
			<script>
				makePagingButton("${pv.currentPage}","${pv.startPage}","${pv.endPage}","${pv.totalPage}","fncListStaffData");
			</script>
		</c:when>		
		<c:otherwise>
			<tr>					
				<td colspan="9" align="center">점원 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<br>
	<div align="center" id="paging_button_div">
</div>
