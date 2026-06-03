<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:choose>
			
	<c:when test="${!empty listsales}">
	
			<c:set var="flag" value="a">
			</c:set>
			<c:set var="docuCount" value="0"/>
			
   		<c:forEach var="sales" items="${listsales}" varStatus="status" >
			<c:if test="${not empty sales.cstmrCd}" >
			
			 <c:set var="docuCount" value="${docuCount + 1}"/>
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
					<%-- <td align="center" >${status.count}</td> --%>
					<td align="center" >${docuCount}</td>
				   <c:set var="datetime" value='${sales.dateTime}'/>
				   <c:set var="time" value="${fn:substring(datetime, 5, 10)}" />
				   <td align="center">${time }</td>
					<td align="center" onclick="showCstmrCd('${sales.cstmrCd}')">${sales.cstmrName}</td>
					<td align="center" class="frame"><fmt:formatNumber value="${sales.framePrc }" pattern="#,###"/></td>
					<td align="center" class="lens"><fmt:formatNumber value="${sales.sunPrc }" pattern="#,###"/></td>
					<td align="center" class="lens"><fmt:formatNumber value="${sales.lensPrc }" pattern="#,###"/></td>
					<td align="center" class="lens"><fmt:formatNumber value="${sales.clensPrc }" pattern="#,###"/></td>
					<td align="center" class="lens"><fmt:formatNumber value="${sales.disPrc }" pattern="#,###"/></td>
					<td align="center" class="lens"><fmt:formatNumber value="${sales.accPrc }" pattern="#,###"/></td>
					<td align="center" class="cash"><fmt:formatNumber value="${sales.payCash }" pattern="#,###"/></td>
					<td align="center" class="card"><fmt:formatNumber value="${sales.payCard }" pattern="#,###"/></td>
					<td align="center">${sales.cardCom}</td>
					<td align="center" class="card"><fmt:formatNumber value="${sales.payPoint }" pattern="#,###"/></td>
					<td align="center" class="total"><fmt:formatNumber value="${sales.dscntPrice}" pattern="#,###"/></td>
					<td align="center" class="card"><fmt:formatNumber value="${sales.etcDscnt }" pattern="#,###"/></td>
					<td align="center" class="total"><fmt:formatNumber value="${sales.total}" pattern="#,###"/></td>
					
					<c:choose>
						<c:when test="${ sales.payStatus eq '0' }">
							<td align="center" >${sales.payStatus} </td>
						</c:when>
						<c:otherwise>
							<td align="center" style='color:red'>${sales.payStatus} </td>
						</c:otherwise>
					</c:choose>
					<td align="center" class="total">${sales.cancel}</td>
					<td align="center" >${sales.phone}</td>
					<%-- <c:if test="${sales.total < 0 }">
						<td align="center">취소</td>
					</c:if>
					
					<c:if test="${sales.total >= 0 }">
						<td></td>
					</c:if> --%>
				</tr>
		
			
			<script>
			
				sum(${sales.framePrc},"frame");
				sum(${sales.sunPrc},"sun");
				sum(${sales.lensPrc},"lens");
				sum(${sales.clensPrc},"clens");
				sum(${sales.disPrc},"dis");
				sum(${sales.accPrc},"acc");
				sum(${sales.payCash},"cash");
				sum(${sales.payCard},"card")
				sum(${sales.payPoint},"point");
				sum(${sales.etcDscnt},"etcDscnt");
				sum(${sales.dscntPrice},"dscntPrice");
				sum(${sales.total},"total");
				sum(${sales.payStatus},"remained");
			</script>
			</c:if>
		</c:forEach>
		<tr class="listData">
			<td align="center" class="total">합계</td>
			<td align="center" class="total"></td>
			<td align="center" class="total"></td>
			<td align="center" id="frame" class="total"></td>
			<td align="center" id="sun" class="total"></td>
			<td align="center" id="lens" class="total"></td>
			<td align="center" id="clens" class="total"></td>
			<td align="center" id="dis" class="total"></td>
			<td align="center" id="acc" class="total"></td>
			<td align="center" id="cash" class="cash"></td>
			<td align="center" id="card" class="card"></td>
			<td align="center" class="total"></td>
			<td align="center" id="point" class="total"></td>
			<td align="center" id="dscntPrice" class="total"></td>
			<td align="center" id="etcDscnt" class="card"></td>
			<td align="center" id="total" class="total"></td>
			<td align="center" id="remained" class="total"></td>
			<td></td>
			<td></td>
		</tr>
	</c:when>		
	<c:otherwise>
		<tr>					
			<td colspan="16" align="center">매출 정보가 없습니다.</td>	
		</tr>
	</c:otherwise>
</c:choose>
