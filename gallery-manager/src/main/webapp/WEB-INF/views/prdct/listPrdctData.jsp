<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<table class="list" width="100%" border="1">
<colgroup>
	<col width="5%">
	<col width="11%">
	<col width="20%">
	<col width="10%">
	<col width="10%">
	<col width="10%">
	<col width="8%">
	<col width="8%">
	<col width="8%">
	<col width="10%">
</colgroup>
	<thead>
	<tr>
		<th>NO</th>
		<th>브랜드 명</th>
		<th>모델 명</th>
		<th>매장</th>
		<th>거래처</th>
		<th>상품 종류</th>
		<th>스틸샷</th>
		<th>Multi<br>이미지</th>
		<th>영상</th>
		<th>배송날짜</th>
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listPrdct}">
	   		<c:forEach var="prdct" items="${listPrdct}" varStatus="status">
				<tr onclick="fncGetPrdctInfo('${prdct.prdctId}');return false;" class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->
				    <td>${prdct.rownum}</td>	
				    <td>${prdct.brandName}</td>		
				    <td>${prdct.prdctName}</td>
				    <td align="center">${prdct.shopName}</td>
				    <td align="center">${prdct.comName}</td>
				    <td align="center">${prdct.prdctTyCdMsg}</td>
				    <td align="center">
				    	<c:choose>
				    		<c:when test="${prdct.imgPath!=null}">
				    			O
				    		</c:when>
				    		<c:otherwise>
				    			X
				    		</c:otherwise>
				    	</c:choose>
				    </td>
				    <td align="center">
				    	<c:choose>
				    		<c:when test="${prdct.multiImgCnt!=0}">
				    			O
				    		</c:when>
				    		<c:otherwise>
				    			X
				    		</c:otherwise>
				    	</c:choose>
				    </td>
				    <td align="center">
				    	<c:choose>
				    		<c:when test="${prdct.videoCd!=null}">
				    			O
				    		</c:when>
				    		<c:otherwise>
				    			X
				    		</c:otherwise>
				    	</c:choose>
				    </td>
				    <td align="center">${prdct.whDate}</td>
				</tr>			
			</c:forEach>
			
			<script>
				makePagingButton("${pv.currentPage}","${pv.startPage}","${pv.endPage}","${pv.totalPage}","fncListPrdctData");
			</script>
		</c:when>
		<c:otherwise>
			<tr>					
				<td colspan="10" align="center">상품 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<br>
<div align="center" id="paging_button_div">
</div>
