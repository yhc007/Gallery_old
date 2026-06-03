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
	
function fncCancelPurchased(saleId)
{
	alert("반품 기능입니다. 구현 중입니다.");
	/* alert("cancel saleId is "+saleId); */
	/* var url = '${ctxPath}/prdct/updateDeliveryCheck.do';
	
	$.ajax({
		url		: url,
		type 	: "post",
		data : "saleId=" + saleId,
		dataType	: "text",
		success: function(data){
			if(data=="success"){
				alert("취소 완료.");
				
			}else if(data=="fail"){
				alert('<spring:message code="fail"/>');
			}				
		}
	}); */
}

function fncCancelPurchasedNew(saleId)
{
	alert("반품 기능입니다. 구현 중입니다.");
	/* alert("cancel_new saleId is "+saleId); */
}


</script>
<style>
	td,th{
		font-size: 15px;
	}
</style>
<table class="listPurchased transBoxTile" width="100%" border="0" >

	<thead>
	<tr>
		<th>방문일</th>
		<th>이미지</th>
		<th>모델명</th>
		<th>브랜드</th>
		<th>수량</th>
		<th style="text-align: right;">가격</th>
		<th style="text-align: right;">합계</th>
		<!-- <th>구매취소</th>> -->
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listPurchased || !empty listPurchasedNewPrdct}">
	   		<c:forEach var="purchased" items="${listPurchased}" varStatus="status">
				<tr>
					<td align="center">
						<fmt:parseDate value="${purchased.datetime}" var="dateFmt" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${dateFmt}" pattern="yy-MM-dd"/>
					</td>		
				    <td><img src="${purchased.imgPath}" width=150></td>
				    <td align="center">${purchased.prdctName}</td>
				    <td align="center">${purchased.brandName}</td>
				    <td align="center">${purchased.prdctCnt}</td>
				    <td align="center" style="text-align: right;"><fmt:formatNumber value="${purchased.prc}" pattern="#,###"/></td>
				    <td align="center" style="text-align: right;"><fmt:formatNumber value="${purchased.prc*purchased.prdctCnt}" pattern="#,###"/></td>
				    
				</tr>	
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>					
				<td colspan="6" align="center">신규 시스템 구매 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<table class="listPurchased transBoxTile" width="100%" border="0" >
	<thead>
	<tr>
		<th>방문일</th>
		<th>매장</th>
		<th>담당자</th>
		<th>제품</th>
		<th style="text-align: right;">가격</th>
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listPurchasedOld}">
	   		<c:forEach var="purchased" items="${listPurchasedOld}" varStatus="status">
				<tr>
					<td>${purchased.datetime}</td>
   				    <%-- <td align="center">
						<fmt:parseDate value="${purchased.datetime}" var="dateFmt" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${dateFmt}" pattern="yy-MM-dd"/>
					</td> --%>
				    <td align="center">${purchased.shopName}</td>
				    <td align="center">${purchased.damdangName}</td>
					<td>
					 ${purchased.gframe1},${purchased.gframe2},${purchased.gframe3},${purchased.glens1},${purchased.glens2},${purchased.glens3}
					 ,${purchased.clensR},${purchased.clensL}
					</td>
				    <td align="center" style="text-align: right;"><fmt:formatNumber value="${purchased.ognPrice*1000}" pattern="#,###"/></td>
				</tr>	
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>					
				<td colspan="6" align="center"> 과거 시스템 구매기록이 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<br>
