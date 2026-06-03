<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<thead>
	<tr style="font-size: 11px">
		<th style="width: 10mm">NO.</th>
		<th style="width: 20mm">매장</th>
		<th style="width: 20mm">프레임</th>
		<th style="width: 20mm">렌즈</th>
		<th style="width: 20mm">콘텍트렌즈</th>
		<th style="width: 10mm">렌즈용액</th>
		<th style="width: 20mm">기타</th>
		<th style="width: 20mm">총액</th>
		<th style="width: 20mm">부가세</th>
		<th style="width: 20mm">합계</th>
		<th style="width: 20mm">수수료</th>
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
					<td>${trde.shopName }</td>
					<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${trde.frameTotal }" pattern="#,###"/></td>
					<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${trde.lensTotal }" pattern="#,###"/></td>
					<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${trde.clensTotal }" pattern="#,###"/></td>
					<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${trde.accTotal }" pattern="#,###"/></td>
					<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${trde.etcTotal }" pattern="#,###"/></td>
					<c:set var="total" value="${trde.frameTotal + trde.lensTotal + trde.clensTotal + trde.accTotal + trde.etcTotal }"></c:set>
					<c:set var="tax" value="${(trde.frameTotal + trde.lensTotal + trde.clensTotal + trde.accTotal + trde.etcTotal) * 0.1}"></c:set>
					<c:set var="devide" value="${(trde.frameDevide + trde.lensDevide + trde.clensDevide + trde.accDevide + trde.etcDevide)}"></c:set>
					<c:if test="${total == devide }">
						<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${total}" pattern="#,###"/></td>
					</c:if>
					<c:if test="${total != devide }">
						<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${devide}" pattern="#,###"/>/<fmt:formatNumber value="${total}" pattern="#,###"/></td>
					</c:if>
					<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${tax }" pattern="#,###"/></td>
					<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${devide + tax }" pattern="#,###"/></td>
					<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${trde.revenue }" pattern="#,###"/></td>
				</tr>
				
				<script>
					sumAll('frameTotal','${trde.frameTotal}');
					sumAll('lensTotal','${trde.lensTotal}');
					sumAll('clensTotal','${trde.clensTotal}');
					sumAll('accTotal','${trde.accTotal}');
					sumAll('etcTotal','${trde.etcTotal}');
					sumAll('sum_','${devide}');
					sumAll('tax_','${tax}');
					sumAll('total_','${devide + tax}');
					sumAll('revenue','${trde.revenue}');
				</script>
			</c:forEach>
			
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
	<tr>
				<td>합계</td>
				<td></td>
				<td class="frameTotal" style="text-align: right; padding-left: 10px"></td>
				<td class="lensTotal" style="text-align: right; padding-left: 10px"></td>
				<td class="clensTotal" style="text-align: right; padding-left: 10px"></td>
				<td class="accTotal" style="text-align: right; padding-left: 10px"></td>
				<td class="etcTotal" style="text-align: right; padding-left: 10px"></td>
				<td class="sum_" style="text-align: right; padding-left: 10px"></td>
				<td class="tax_" style="text-align: right; padding-left: 10px"></td>
				<td class="total_" style="text-align: right; padding-left: 10px"></td>
				<td class="revenue" style="text-align: right; padding-left: 10px"></td>
	</tr>
</tbody>
