<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<center>
<table style="width: 100%; height: 300" class="list" 
				border="1">
	<tr>
		<th>NO</th>
		<th>매장</th>
		<th>프레임</th>
		<th>선글라스</th>
		<th>렌즈</th>
		<th>콘텍트 렌즈</th>
		<th>팩렌즈</th>	
		<th>렌즈 용액</th>
		<th>현금</th>
		<th>카드</th>
		<th>포인트</th>
		<th>합계</th>
		
	</tr>
<c:choose>
			
	<c:when test="${!empty listsales}">
			<c:set var="flag" value="a">
			</c:set>
   		<c:forEach var="sales" items="${listsales}" varStatus="status" >
			
			<c:choose>
			<c:when test="${flag eq 'a'}">
				<c:set value="grayClass" var="cssClass"></c:set>
				
				<c:set var="flag" value='b'></c:set>
			</c:when>
			<c:otherwise>
				<c:set value="whiteClass" var="cssClass">
				</c:set>
				<c:set var="flag" value="a">
				</c:set>
			</c:otherwise>
			</c:choose>
			
			
			<tr class="${cssClass }" >
				<td align="center" >${status.count}</td>
				<td align="center" >${sales.shopName}</td>
				<td align="center" class="frame"><fmt:formatNumber value="${sales.framePrc }" pattern="#,###"/></td>
				<td align="center" class="lens"><fmt:formatNumber value="${sales.sunPrc }" pattern="#,###"/></td>
				<td align="center" class="lens"><fmt:formatNumber value="${sales.lensPrc }" pattern="#,###"/></td>
				<td align="center" class="lens"><fmt:formatNumber value="${sales.clensPrc }" pattern="#,###"/></td>
				<td align="center" class="lens"><fmt:formatNumber value="${sales.disPrc }" pattern="#,###"/></td>
				<td align="center" class="lens"><fmt:formatNumber value="${sales.accPrc }" pattern="#,###"/></td>
				<td align="center" class="cash"><fmt:formatNumber value="${sales.payCash }" pattern="#,###"/></td>
				<td align="center" class="card"><fmt:formatNumber value="${sales.payCard }" pattern="#,###"/></td>
				<td align="center" class="card"><fmt:formatNumber value="${sales.payPoint }" pattern="#,###"/></td>
				<td align="center" class="total"><fmt:formatNumber value="${sales.total}" pattern="#,###"/></td>
			</tr>　		
			<script> 
				sum(${sales.framePrc},"frame_");
				sum(${sales.sunPrc},"sun_");
				sum(${sales.lensPrc},"lens_");
				sum(${sales.clensPrc},"clens_");
				sum(${sales.disPrc},"dis_");
				sum(${sales.accPrc},"acc_");
				sum(${sales.payCash},"cash_");
				sum(${sales.payCard},"card_")
				sum(${sales.payPoint},"point_");
				sum(${sales.total},"total_");
			</script>
			
		</c:forEach>
		<tr class="listData">
			<td align="center" class="total">합계</td>
			<td align="center" class="total"></td>
			<td align="center" id="frame_" class="total"></td>
			<td align="center" id="sun_" class="total"></td>
			<td align="center" id="lens_" class="total"></td>
			<td align="center" id="clens_" class="total"></td>
			<td align="center" id="dis_" class="total"></td>
			<td align="center" id="acc_" class="total"></td>
			<td align="center" id="cash_" class="total"></td>
			<td align="center" id="card_" class="total"></td>
			<td align="center" id="point_" class="total"></td>
			<td align="center" id="total_" class="total"></td>
		</tr>
	</c:when>		
	<c:otherwise>
		<tr style="text-align: center">					
			<td colspan="12" align="center">매출 정보가 없습니다.</td>	
		</tr>
	</c:otherwise>
</c:choose>
</table>
</center>
