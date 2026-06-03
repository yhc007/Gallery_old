<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tr>
	<td>상품코드</td>
	<td>제품명</td>
	<td>수량</td>
	<td>판매가격</td>
	<td>비고</td>
</tr>

<%-- <c:choose>
	<c:when test="${!empty FramePrdct || !empty AccPrdct || !empty ClensPrdct || !empty LensPrdct || !empty NewPrdct}">
		<c:forEach var="prdct" items="${FramePrdct }">
			<tr>
				<td>${prdct.prdctId }</td>
				<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
				<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
				<td>${prdct.cnt }</td>
				<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
				<td></td>
			</tr>
			
			<script>
				sum(${prdct.prc * dc});
			</script>
			
		</c:forEach>
			<c:forEach var="prdct" items="${NewPrdct }">
			<tr>
				<td>${prdct.prdctId }</td>
				<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
				<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
				<td>${prdct.cnt }</td>
				<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
				<td></td>
			</tr>
			
			<script>
				sum(${prdct.prc * dc});
			</script>
			
		</c:forEach>
			<c:forEach var="prdct" items="${LensPrdct }">
			<tr>
				<td>${prdct.prdctId }</td>
				<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
				<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
				<td>${prdct.cnt }</td>
				<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
				<td></td>
			</tr>
			
			<script>
				sum(${prdct.prc * dc});
			</script>
			
		</c:forEach>
			<c:forEach var="prdct" items="${ClensPrdct }">
			<tr>
				<td>${prdct.prdctId }</td>
				<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
				<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
				<td>${prdct.cnt }</td>
				<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
				<td></td>
			</tr>
			
			<script>
				sum(${prdct.prc * dc});
			</script>
			
		</c:forEach>
			<c:forEach var="prdct" items="${AccPrdct }">
			<tr>
				<td>${prdct.prdctId }</td>
				<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
				<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
				<td>${prdct.cnt }</td>
				<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
				<td></td>
			</tr>
			<script>
				sum(${prdct.prc * dc});
			</script>
		</c:forEach>
	</c:when>
</c:choose>
	<tr>
		<td></td>
		<td></td>
		<td>총액</td>
		<td class="totalPayment" style="text-align: right;padding-right: 5px;"></td>
		<td></td>
	</tr> --%>
	
