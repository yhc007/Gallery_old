<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<script>

var total = 0;
function fncSum(prc){
	
	total+=Number(prc);
	console.log("합계 : " + +total);
	$("#total").html(format(String(total)));
}

function format(number) {
	var pattern = /(-?[0-9]+)([0-9]{3})/;
	 
	while(pattern.test(number)) {
	  number = number.replace(pattern,"$1,$2");
	}

	return number;
	}
</script>
<style>
	td,th{
		font-size: 15px;
	}
</style>
<table class="listPurchased transBoxTile" width="80%" border="0" >

	<thead>
	<tr>
		<th>날짜</th>
		<th>회원번호</th>
		<th>사용자</th>
		<th>포인트</th>
		<th>적립/사용</th>
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listPointHist}">
	   		<c:forEach var="pointHist" items="${listPointHist}" varStatus="status">
				<tr>		
				    <td align="center">${pointHist.dateTime}</td>
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
