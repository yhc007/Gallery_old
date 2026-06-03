<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<thead>
	<tr>
		<th>NO.</th>
		<!-- <th>날짜</th> -->
		<th onclick="getTradeGroupData('comName')">협력사</th> 
		<th onclick="getTradeGroupData('shopName')">매장</th>
		<th onclick="getTradeGroupData('cnt')">수량</th>
		<th>공급가</th>
		<th>부가세</th>
		<th>합계</th>
		<th>수수료</th>
	</tr>	
</thead>
<tbody>
	<c:choose>
		<c:when test="${!empty trdeList}">
		<c:set var="flag" value="a">
		</c:set>
	   		<c:forEach var="trde" items="${trdeList}" varStatus="status">
	   		
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
			
				<tr class='${cssClass}'  onclick="getDetail('${trde.test1}','${trde.shopId }')">
					<%-- <c:set var="day" value="${trde.deliverTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set> --%>
					
					<td>${status.count }</td>
					<%-- <td>${date }</td> --%>
					<td>${trde.comName }</td>
					<td>${trde.shopName }</td>
					<td>${trde.cnt }</td>
					
					<c:set var="sum" value="${trde.devide}"></c:set>
					<c:set var="tax2" value="${trde.devide * 0.1}"></c:set>
					<c:set var="total" value="${sum + tax2}"></c:set>
					
					<%-- <c:if test="${trde.test1==1035}">
						<c:set var="tax" value="${trde.total * 5/100}"></c:set>
					</c:if>
					<c:if test="${trde.test1!=1035}"> --%>
						<c:set var="tax" value="${total * trde.tax/100}"></c:set>
					<%-- </c:if> --%>
					
					<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${sum }" pattern="#,###"/></td>
					<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${tax2}" pattern="#,###"/></td>
					<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${total}" pattern="#,###"/></td>
					<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${tax}" pattern="#,###"/></td>
				<script>
					getSum(${sum},"sum");
					getSum(${tax2},"tax2");
					getSum(${total},"total");
					getSum(${tax},"tax"); 
				</script>				
			</c:forEach>
			<tr>
				<td>합계</td>
				<!-- <td></td> -->
				<td></td>
				<td></td>
				<td></td>
				<td class="sum" style="text-align: right; padding-right: 10px"></td>
				<td class="tax2" style="text-align: right; padding-right: 10px"></td>
				<td class="total" style="text-align: right; padding-right: 10px"></td>
				<td class="tax" style="text-align: right; padding-right: 10px"></td>
			</tr>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
</tbody>