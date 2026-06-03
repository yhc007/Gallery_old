<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<script>

function format(number) {
	var pattern = /(-?[0-9]+)([0-9]{3})/;
	 
	while(pattern.test(number)) {
	  number = number.replace(pattern,"$1,$2");
	}

	return number;
	}

var g_cancelSaleId=0;

function fncCancel() {
	console.log("run fcnCancel");
	console.log("g_cancelSaleId:"+g_cancelSaleId);
	var cancelMemo=$("#cancelReason").val();
	var cancelCd = document.getElementById('slct_cancel_info').value;
	if(cancelCd == -1){
		alert("반품 사유를 선택하세요.");
		return;
	}
	
	/* var checkInvn4Return = "${ctxPath}/payment/checkInvn4Return.do"; */
	/* $.ajax({
		url : checkInvn4Return
		,type : "post"
		,data : "saleId=" + g_cancelSaleId
		,dataType : "text"
		,success : function(data) {
			if(data=='success'){
				console.log('반품 대상 제품이 있습니다.');
				jQuery('#canclePrdctDlg').html('');
				jQuery('#canclePrdctDlg').html(
					rtn_prdct_dlg_txt
				);
				
				 jQuery('#canclePrdctDlg').dialog({
					 //bgiframe: true
					 title: "재고 처리"
					 , modal: true
					 , width: 400 // 가로 크기
					 , height : 200
					 , background: "#000"
					 , close: function(event, ui){
					 }, success:  function(data) {
					 console.log($("#cancelReason").val());
					 } 
				});
			}else{
				console.log('반품 대상 제품이 없습니다.');
			}
			//location.replace('${ctxPath}/shop/indexShopCstrmForm.do');
		}
	}); */
	
	//return;
	var cancelUrl = "${ctxPath}/payment/cancelPayment.do";
	
	$.ajax({
		url : cancelUrl
		,type : "post"
		,data : "saleId=" + g_cancelSaleId + "&cancelMemo="+cancelMemo+"&cancelCd="+cancelCd
		,dataType : "text"
		,success : function(data) {
		if(data=='success'){
			alert("반품이 성공하였습니다.");
		}
		else
		{
			alert("반품에 실패하였습니다. 재로그인 후 다시 시도 바랍니다.");
		}
			location.replace('${ctxPath}/shop/indexShopCstrmForm.do');
		}
	});
}

function fncCancelPurchased(saleId, shopId)
{
	console.log("run fncCancelPurchased.");
	console.log("saleId:"+saleId);
	console.log("shopId:"+shopId);
	console.log("crt_shopId:"+'${shopVo.shopId}');	
	
	g_cancelSaleId=saleId;
	if(shopId != '${shopVo.shopId}'){
		alert('타매장 매출을 취소하실 수 없습니다.');
		return;
	}
	if(confirm("반품 하시겠습니까?")){
	var checkInvn4Return = "${ctxPath}/payment/checkInvn4Return.do";
	 $.ajax({
		url : checkInvn4Return
		,type : "post"
		,data : "saleId=" + g_cancelSaleId
		,dataType : "text"
		,success : function(data) {
			jQuery('#canclePrdctDlg').html('');
			jQuery('#canclePrdctDlg').html(data);
				jQuery('#canclePrdctDlg').dialog({
					//bgiframe: true
					title: "재고 처리"
					, modal: true
					, width: 800 // 가로 크기
					, height : 'auto'
					, background: "#000"
					, close: function(event, ui){
					}, success:  function(data) {
						console.log($("#cancelReason").val());
					}
				});
			//location.replace('${ctxPath}/shop/indexShopCstrmForm.do');
			}
		});
	}else{
		return;
	}
}
function fncShowPrdct(saleId)
{
	console.log("run fncShowPrdct.");
	console.log("saleId:"+saleId);
	console.log("구매물품 리스트 기능입니다.");	
}

</script>


<style>
	#cancelMemo
	{
		style.display :'none';
	}
	td,th{
		font-size: 15px;
	}
</style>
<table class="listPurchased transBoxTile" width="100%" border="0" >

	<thead>
	<tr>
		<th>매장명</th>
		<th>방문일</th>
		<!-- <th>구매물품</th> -->
		<th>현금결제</th>
		<th>카드결제</th>
		<th>포인트결제</th>
		<th>총합</th>
		<th>구매취소</th>
	</tr>
	<tr>
		<td height="3" colspan="7"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listSaleOffHist}">
	   		<c:forEach var="listSold" items="${listSaleOffHist}" varStatus="status">
				<tr>
					<td align="center">${listSold.shopName}</td>		
				    <td align="center">${listSold.datetime}</td>
					<%-- <td align="center"><a class="checkproccess" href="#" onclick="fncShowPrdct('${listSold.saleId}'); return false;"><img src="<c:url value="/images/button/Select_p.png" />" width="25px" height="25px" /></a></td> --%>
				    <td align="center"><fmt:formatNumber value="${listSold.payCash}" pattern="#,###"/></td>
				    <td align="center"><fmt:formatNumber value="${listSold.payCard}" pattern="#,###"/></td>
				    <td align="center"><fmt:formatNumber value="${listSold.payPoint}" pattern="#,###"/></td>
					<td align="center"><fmt:formatNumber value="${listSold.totalPrice}" pattern="#,###"/></td>
					<td align="center">
					<c:choose>
					<c:when test='${listSold.cancel == 0}'>
						<a class="checkproccess" href="#" onclick="fncCancelPurchased('${listSold.saleId}','${listSold.shopId}'); return false;">
							<img src="<c:url value="/images/button/Select_c.png" />" width="25px" height="25px" />
						</a>
					</c:when>
					<c:otherwise>
						${listSold.cancelDate}
					</c:otherwise>
					</c:choose>
					
					
					</td>
				</tr>
				
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>					
				<td colspan="7" align="center">신규 시스템 구매 데이터가 없습니다.</td>	
			</tr>
			<tr>
				<td colspan="7"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
			</tr>
		</c:otherwise>
		
	</c:choose>
	<c:choose>
		<c:when test="${!empty listSaleOffHistOld}">
	   		<c:forEach var="listSold" items="${listSaleOffHistOld}" varStatus="status">
				<tr>
					<td align="center">${listSold.shopName}</td>		
				    <td align="center">${listSold.datetime}</td>
				    <%-- <td align="center"><a class="checkproccess" href="#" onclick="fncShowPrdct('${listSold.saleId}'); return false;"><img src="<c:url value="/images/button/Select_p.png" />" width="25px" height="25px" /></a></td> --%>
				    <td align="center"><fmt:formatNumber value="${listSold.payCash*listSold.oldDigit}" pattern="#,###"/></td>
				    <td align="center"><fmt:formatNumber value="${listSold.payCard*listSold.oldDigit}" pattern="#,###"/></td>
				    <td align="center"><fmt:formatNumber value="${listSold.payPoint*listSold.oldDigit}" pattern="#,###"/></td>
					<td align="center"><fmt:formatNumber value="${listSold.ognPrice*listSold.oldDigit}" pattern="#,###"/></td>
				    <td align="center"><%-- <a class="checkproccess" href="#" onclick="fncCancelPurchased('${listSold.saleId}'); return false;"><img src="<c:url value="/images/button/Select_c.png" />" width="25px" height="25px" /></a> --%></td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="7"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
			</tr>
			<tr>					
				<td colspan="7" align="center">이전 시스템 구매 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
		
	</c:choose>
</table>
<div id=canclePrdctDlg></div>