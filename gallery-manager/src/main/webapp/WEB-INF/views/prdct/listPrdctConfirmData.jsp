<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="list" width="100%" border="1">
	<colgroup>
		<col width="5%">
		<col width="30%">
		<col width="45%">
		<col width="10%">
		<col width="10%">
	</colgroup>
	<thead>
	<tr>
		<th>NO</th>
		<th>브랜드</th>
		<th>모델 명</th>
		<th>상품 종류</th>
		<th>승인 상태</th>
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listPrdct}">
	   		<c:forEach var="prdct" items="${listPrdct}" varStatus="status">
				<tr onclick="fncGetPrdctComfirmInfo('${prdct.prdctId}');return false;" class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->
				    <td>${prdct.rownum}</td>
				    <td>${prdct.brandName }</td>			
				    <td>${prdct.prdctName }</td>
				    <td>${prdct.prdctTyCdMsg}</td>
				    <td>${prdct.prdctStatTyCdMsg}</td>
				</tr>			
			</c:forEach>
			
			<script>
				makePagingButton("${pv.currentPage}","${pv.startPage}","${pv.endPage}","${pv.totalPage}","fncListPrdctData");
			</script>
						
		</c:when>		
		<c:otherwise>
			<tr>					
				<td colspan="9" align="center">상품 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<br>
<div align="center" id="paging_button_div">
</div>
