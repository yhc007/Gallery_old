<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<script>

total = 0;
function fncSum(prc){
	total+=parseInt(prc);
	document.getElementById("total_txt").innerHTML=total;
	
}
</script>
<table class="staffList" width="100%" border="1">
<colgroup>
	<col width="30%">
	<col width="20%">
	<col width="10%">
	<col width="20%">
	<col width="20%">
</colgroup>
	<thead>
	<tr>
		<th>모델 명</th>
		<th>가격</th>
		<th>수량</th>
		<th align="center">계</th>
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listPrdct}">
	   		<c:forEach var="prdct" items="${listPrdct}" varStatus="status">
				<tr class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->		
				    <td>${prdct.prdctName}</td>
				    <td align="center">${prdct.prc}</td>
				    <td align="center">${prdct.prdctCnt}</td>
				    <td align="center">${prdct.prc*prdct.prdctCnt}</td>   
				</tr>	
				<script>
			    	fncSum('${prdct.prc*prdct.prdctCnt}');
			    </script>		
			</c:forEach>
			<c:forEach var="newPrdct" items="${newPrdct}" varStatus="status">
				<tr class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->		
				    <td>${newPrdct.prdctName}</td>
				    <td align="center">${newPrdct.prc}</td>
				    <td align="center">${newPrdct.prdctCnt}</td>
				    <td align="center">${newPrdct.prc*newPrdct.prdctCnt}</td>   
				</tr>	
				<script>
			    	fncSum('${newPrdct.prc*newPrdct.prdctCnt}');
			    </script>		
			</c:forEach>
			<tr>
				<td align="center">합계</td>
				<td colspan="3" align="center"><p id="total_txt"></p></td>
			</tr>
			<tr>
				<td colspan="4" align="center"> <button>결제</button></td>
			</tr>
		</c:when>
		<c:otherwise>
			<tr>					
				<td colspan="4" align="center">상품 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<br>
