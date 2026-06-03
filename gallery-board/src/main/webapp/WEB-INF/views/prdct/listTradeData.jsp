<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<table  class='tablesorter-ice' border="1" style="border-collapse: collapse;width:90%; text-align: center;font-size: 11px;" id="tradeDetail" >
<thead>
	<tr style="font-size: 11px">
		<th>NO.</th>
		<th >날짜</th>
		<th >협력사</th>
		<th>매장</th>
		<th>단가</th>
		<th>수량</th>
		<th>공급가</th>
		<th>할부</th>
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
				<tr class='${cssClass}'>
					<td>${status.count }</td>
					<c:set var="day" value="${trde.deliverTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set>
					<c:set var="month" value="${fn:substring(thisMonth,5,6)}"></c:set>
					<td>${date }</td>
					<td>${trde.comName }</td>
					<td>${trde.shopName }</td>
					<td style="text-align: right; padding-left: 50px"><fmt:formatNumber value="${trde.puchasPrc }" pattern="#,###"/></td></td>
					<td>${trde.cnt }</td>
					
					
					
					
					<!--공급가  -->
					<c:set var="sum" value="${(trde.cnt * trde.puchasPrc)}"></c:set>
					<td style="text-align: right; padding-left: 50px">
						<c:choose>
							<c:when test="${trde.devide!=0 }">
								<c:set var="sum" value="${sum/trde.devide}"></c:set>
								<fmt:formatNumber value="${(trde.cnt * trde.puchasPrc)/trde.devide}" pattern="#,###" />/<fmt:formatNumber value="${trde.cnt * trde.puchasPrc}" pattern="#,###" /></td>
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${sum}" pattern="#,###" /></td>	
							</c:otherwise>	
						</c:choose>
						
						
					
					
					
					<c:if test="${trde.devide eq '0'}">
						<td>일시불</td>
					</c:if>
					<c:if test="${trde.devide eq '1'}">
						<td>이월</td>
					</c:if>
					<c:if test="${trde.devide eq '2'}">
						<td>${trde.dueMonth-(trde.dueMonth-month)}/2개월</td>
					</c:if>
					<c:if test="${trde.devide eq '3'}">
						<td>${trde.dueMonth-(trde.dueMonth-month)}/3개월</td>
					</c:if>
					<c:if test="${trde.devide eq '4'}">
						<td>${trde.dueMonth-(trde.dueMonth-month)}/4개월</td>
					</c:if>
					<c:if test="${trde.devide eq '5'}">
						<td>${trde.dueMonth-(trde.dueMonth-month)}/5개월</td>
					</c:if>
					<c:if test="${trde.devide eq '6'}">
						<td>${trde.dueMonth-(trde.dueMonth-month)}/6개월</td>
					</c:if>
					

			
					<c:set var="tax2" value="${trde.cnt * trde.puchasPrc * 0.1}"></c:set>		
					<!-- 부가세 -->
					<td style="text-align: right; padding-left: 50px">
						<c:choose>
							<c:when test="${trde.devide!=0 }">
								<c:set var="tax2" value="${tax2/trde.devide}"></c:set>
								<fmt:formatNumber value="${tax2}" pattern="#,###" />
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${tax2}" pattern="#,###" />	
							</c:otherwise>
						</c:choose>
						
					</td>
					
					
					
					<c:set var="total" value="${((trde.cnt * trde.puchasPrc) + (trde.cnt * trde.puchasPrc * 0.1))}"></c:set>
					<!-- 합계 -->
					<td style="text-align: right; padding-left: 50px">
						<c:choose>
							<c:when test="${trde.devide!=0 }">
							<c:set var="total" value="${((trde.cnt * trde.puchasPrc) + (trde.cnt * trde.puchasPrc * 0.1))/trde.devide}"></c:set>
								<fmt:formatNumber value="${total}" pattern="#,###" /></td>
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${total}" pattern="#,###" /></td>	
							</c:otherwise>
						</c:choose>
						
					<c:set var="rate" value="${trde.tax/100 }"></c:set>
					
					
					
					<!-- 수수료 -->
					<c:set var="tax" value="${((trde.cnt * trde.puchasPrc) + (trde.cnt * trde.puchasPrc * 0.1)) * rate }"></c:set>
					<td style="text-align: right; padding-left: 50px">
						<c:choose>
							<c:when test="${trde.devide!=0 }">
								<c:set var="tax" value="${((trde.cnt * trde.puchasPrc) + (trde.cnt * trde.puchasPrc * 0.1)) * rate /trde.devide}"></c:set>
								<fmt:formatNumber value="${tax}" pattern="#,###" /></td>
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${tax}" pattern="#,###" /></td>	
							</c:otherwise>
						</c:choose>
						
				</tr>
				<script>
					getSum2(${sum},"sum");
					getSum2(${tax2},"tax2");
					getSum2(${total},"total");
					getSum2(${tax},"tax");
				</script>				
			</c:forEach>
			<tr>
				<td>합계</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td class="sum_" style="text-align: right; padding-left: 50px"></td>
				<td></td>
				<td class="tax2_" style="text-align: right; padding-left: 50px"></td>
				<td class="total_" style="text-align: right; padding-left: 50px"></td>
				<td class="tax_" style="text-align: right; padding-left: 50px"></td>
			</tr>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
</tbody>
</table>