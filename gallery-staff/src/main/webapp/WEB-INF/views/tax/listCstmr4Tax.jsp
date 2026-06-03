<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<script>
 	
</script>
<table style='width:100%;font-size:0.8em'>
<tr>
	<th width='5%'>&nbsp;</th>
	<th width='15%'>결제일</th>
	<th width='15%'>이름</th>
	<th width='15%'>현금</th>
	<th width='15%'>카드</th>
	<th width='20%'>발급기록</th>
	<th width='10%'>선택</th>
</tr>

<c:set var="flag" value="a"> </c:set>
<c:set var="g_shopId" value="${shopId}"> </c:set>
<c:set var="shopLv" value="${lv}"> </c:set>
<c:choose>
	<c:when test="${!empty listSale }">
		<c:set var="cnt" value="1"></c:set>
		<c:forEach var="sale" items="${listSale }"  varStatus="status">
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
		
			<tr class="listData ${cssClass }" >
				<td align="center">
					<span>${status.count} </span>
				</td>
				<td align="center">
					<fmt:parseDate value="${sale.datetime}" var="dateFmt" pattern="yyyy.MM.dd"/>
					<fmt:formatDate value="${dateFmt}" pattern="yy.MM.dd"/>
				</td>
				<td align="center">${sale.cstmrName}</td>
				
				
				<td align="right">
					<c:set var="payCash" value="${sale.payCash}"> </c:set>
					<fmt:formatNumber type="number" value="${payCash}" />
				</td>
				<td align="right">
					<c:set var="payCard" value="${sale.payCard}"> </c:set>
 					<fmt:formatNumber type="number" value="${ payCard }" />
				</td>
				
				<td align="center">${sale.taxBigo}</td>
				<td align="center">
				
				
				<c:choose>
					<c:when test="${sale.shopId == g_shopId}">
						<input id='btn${sale.saleId}' type='button' onclick="addTax('${sale.saleId}'); return false;" name="chkTax" value='추가'/>
						<span id='shopName${sale.saleId}' class='hiddenShop' hidden>${sale.shopName}</span>
					</c:when>
					<c:otherwise>
						<input id='btn${sale.saleId}' class='hiddenBtn' type='button' onclick="addTax('${sale.saleId}'); return false;" name="chkTax" value='추가' hidden/>
						<span id='shopName${sale.saleId}' class='hiddenShop'>${sale.shopName}</span>
					</c:otherwise>
				</c:choose>
					
				</td>
			</tr>
			<script>
				var tmpSaleObj;
				tmpSaleObj = new SaleObj('${sale.jobId}','${sale.saleId}','${status.count}','${sale.datetime}','${sale.cstmrName}','${payCash}','${payCard}','${sale.cardTy}','${sale.taxBigo}','${sale.shopId}','${sale.shopName}');
				arrSaleObj.push(tmpSaleObj);
// 				console.log('inputId:${sale.jobId}');
// 				console.log('inputId:${sale.cardTy}');
				//mapSaleObj['${sale.saleId}'] = tmpSaleObj;
				mapSaleObj.put('${sale.saleId}', tmpSaleObj);
				//map.get("user_id");				
// 				var tmpSaleObj2 = mapSaleObj['${sale.saleId}'];
// 				console.log('tmpSaleObj2:'+tmpSaleObj2);
// 				console.log('tmpSaleObj2.id:'+tmpSaleObj2.id);
			</script>
		</c:forEach>
<!-- 		<tr>
			<td colspan="2" align="left"><input type="text" placeholder="삭제코드" id="SC"> </td><td rowspan="2" align="center"><button onclick="mergeHistory();" >통합</button> </td>
		</tr>
		<Tr>
			<td colspan="2" align="left"><input type="text" placeholder="통합코드" id="DS"> </td>
		</Tr> -->
	</c:when>
</c:choose>
<script>
	hiddenPay();
</script>
</table>