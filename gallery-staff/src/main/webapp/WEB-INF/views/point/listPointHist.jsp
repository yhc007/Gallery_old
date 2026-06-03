<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" scope="request"/> 
<c:set var="newline" value="<%= \"\n\" %>" />

<script>

var total = 0;
function fncSum(prc){
	
	total+=Number(prc);
	console.log("합계 : " + +total);
	$("#total").html(format(String(total)));
}

function format(number){
	var pattern = /(-?[0-9]+)([0-9]{3})/;

	while(pattern.test(number)) {
	  number = number.replace(pattern,"$1,$2");
	}

	return number;
}
</script>
<style>
	/* td,th{
		font-size: 13px;
	} */
	.grayClass{
	background-color: #d3d3d3;
	color : black;
	}
	
	.whiteClass{
		background-color: #2E2E2E;
	color : white;
	}
</style>
<table  width="100%" border="0" data-role='none' >
	<thead>
	
	<tr>
		<th style="text-align:center" >사용일</th>
		<th style="text-align:center" >처방일</th>
		<th style="text-align:center" >회원번호</th>
		<th style="text-align:center" >사용자</th>
		<th style="text-align:center" >포인트</th>
		<th style="text-align:center" >적립/사용</th>
	</tr>
	</thead>
	
	<c:set var="flag" value="a"></c:set>
	
	<c:choose>
		<c:when test="${!empty listPointHist}">
	   		<c:forEach var="pointHist" items="${listPointHist}" varStatus="status">
	   		
	   		<c:choose>
			<c:when test="${flag eq 'a'}">
				<c:set value="grayClass" var="cssClass"></c:set>
				<c:set var="flag" value='b'></c:set>
			</c:when>
			<c:otherwise>
				<c:set value="whiteClass" var="cssClass"></c:set>
				<c:set var="flag" value="a"></c:set>
			</c:otherwise>
			</c:choose>
			
				<tr class="${cssClass }">		
				    <td align="center">${pointHist.dateTime}</td>
				    <c:choose>
						<c:when test="${!empty pointHist.saleDate}">
							<td align="center">${pointHist.saleDate}</td>
						</c:when>
						<c:otherwise>
							<td align="center">관리자</td>
						</c:otherwise>
					</c:choose>
				    
				    <td align="center">${pointHist.fmlyCd}</td>
				    <td align="center">${pointHist.cstmrName}</td>
				    <td align="center">${pointHist.point*100}</td>
				    <td align="center">${pointHist.pointStatus}</td>
				</tr>	
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>					
				<td colspan="5" align="center">적립 내역이 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<br>
