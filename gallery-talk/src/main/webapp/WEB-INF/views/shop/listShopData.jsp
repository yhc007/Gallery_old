<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="list" width="100%" border="1">
	<colgroup>
		<col width="20%">
		<col width="80%">
	</colgroup>
	<thead>
	<tr>
		<th>NO</th>
		<th>매장 명</th>
	</tr>
	</thead>
	
	<c:choose>
		<c:when test="${!empty listShop}">
	   		<c:forEach var="shop" items="${listShop}" varStatus="status">
				<tr onclick="fncGetShopInfo('${shop.shopId}');return false;" class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->
				    <td>${shop.rownum }</td>			
				    <td>${shop.shopName }</td>
				</tr>			
			</c:forEach>
			
			<script>
				makePagingButton("${pv.currentPage}","${pv.startPage}","${pv.endPage}","${pv.totalPage}","fncListShopData");
			</script>
		</c:when>		
		<c:otherwise>
			<tr>					
				<td colspan="9" align="center">매장 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<br>
<div align="center" id="paging_button_div">
</div>