<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="list" width="100%" border="1">
	<colgroup>
		<col width="20%">
		<col width="80%">
	</colgroup>
	<c:choose>
		<c:when test="${!empty listPrdct}">
	   		<c:forEach var="prdct" items="${listPrdct}" varStatus="status">
				<tr onclick="fncGetPrdctInfo('${prdct.prdctId}');return false;" class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->
				    <td align="center">${prdct.rownum }</td>			
				    <td>${prdct.prdctName }</td>
				</tr>			
			</c:forEach>
		</c:when>		
		<c:otherwise>
			<tr>					
				<td colspan="9" align="center">상품 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>	
</table>
<script type="text/javascript">
	$(".listData").click(function() {
		$("tr.selected").removeClass("selected");
		$(this).addClass("selected");
	});
</script>