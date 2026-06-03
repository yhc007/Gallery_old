<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<table class="list" width="100%" border="1">
<colgroup>
	
	<col width="16%">
	<col width="25%">
	<col width="8%">
	<col width="8%">
	<col width="8%">
	<col width="20%">
</colgroup>
	<thead>
	<tr>
		
		<th onclick="fncListPrdctInvnHistDataOutPut('brandName')">브랜드 명</th>
		<th onclick="fncListPrdctInvnHistDataOutPut('prdctName')">모델 명</th>
		<th onclick="fncListPrdctInvnHistDataOutPut('invntycd')">분류</th>
		<th onclick="fncListPrdctInvnHistDataOutPut('cnt')">수량</th>
		<th onclick="fncListPrdctInvnHistDataOutPut('remaind')">재고</th>
		<th onclick="fncListPrdctInvnHistDataOutPut('regtime')">등록일시</th>
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listPrdct}">
	   		<c:forEach var="prdct" items="${listPrdct}" varStatus="status">
				<tr  class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->
				    <td>${prdct.brandName}</td>		
				    <td>${prdct.prdctName}</td>
				    <td align="center">${prdct.invnTyCdMsg}</td>
				    <td align="center">${prdct.cnt}</td>
				    <td align="center">${prdct.remaind}</td>
				    <c:set var="regtime" value='${prdct.regTime}'/>
				    <c:set var="time" value="${fn:substring(regtime, 0, 16)}" />
				    <td align="center">${time}</td>
				</tr>			
			</c:forEach>
			
			<script>
				makePagingButton("${pv.currentPage}","${pv.startPage}","${pv.endPage}","${pv.totalPage}","fncListPrdctInvnHistData");
			</script>
		</c:when>
		<c:otherwise>
			<tr>					
				<td colspan="6" align="center">이력 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<br>
<div align="center" id="paging_button_div">
</div>
