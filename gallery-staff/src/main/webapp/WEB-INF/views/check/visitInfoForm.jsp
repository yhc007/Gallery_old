<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script>
var mPrdctId;
var mTrdePrc;
function fncGetPrdctInfo(prdctId,trdePrc){
	mPrdctId=prdctId;
	mTrdePrc=trdePrc;
}

function fncSelectPrdct(){
	/*
	alert(fncGetSaleId());
	alert(mPrdctId);
	*/
	/*
	alert(jQuery('#prdctCnt').val());
	*/
	var url = 'addSalePrdct.do';
	 
	//javax
	 $.ajax({
		url		: url,
		type 	: "post",
		data 	: "prdctId="+mPrdctId+"&prc="+mTrdePrc+"&saleId="+fncGetSaleId()+"&prdctCnt="+jQuery('#prdctCnt').val(),
		dataType	: "text",
		beforeSend	: function(){
		},
		success: function(data){
			getSelectedPrdctListData();
			mPrdctId=null;
			mTrdePrc=null;
			jQuery('#dialog').dialog( 'destroy' );
			jQuery('#dialog').html('');
		}
	}); 
}

function getCnt(){
	if(mPrdctId==null){
		alert('<spring:message code="warn.choice.item" arguments="상품"/>');
		return;
	}
	
	var url = 'checkSalePrdctCount.do';
	 
	//javax
	 $.ajax({
		url		: url,
		type 	: "post",
		data 	: "prdctId="+mPrdctId+"&prc="+mTrdePrc+"&saleId="+fncGetSaleId(),
		dataType	: "text",
		beforeSend	: function(){
		},
		success: function(data){
			if(data=="duple"){
				alert('<spring:message code="warn.choice.duple" arguments="상품"/>');
			}else if(data=="ok"){
				jQuery('#dialog').dialog( 'destroy' );
				jQuery('#dialog').html('');
				jQuery('#dialog').html(
					"<html><body><table border='0' width='100%'><tr><td align='center'><input id='prdctCnt' name='prdctCnt' size='1'></td></tr><tr><td align='center'><button class='btnNumberCheck' onclick='fncSelectPrdct();return false;'>확인</button></td></tr></table></body></html>"
				);
				
				jQuery('#dialog').dialog({
					//bgiframe: true
					 title: "수량 선택"
					 , modal: true
				     , width: 100 // 가로 크기
				     , background: "#000"
					 , close: function(event, ui){
					}, success:  function(data) {
						console.log("hihi");
					} 
				});	
			}else{
				
			}
			
		}
	});
}

function fncCancel(){
	jQuery('#dialog').dialog( 'destroy' );
	jQuery('#dialog').html('');
}

</script>
<table class="list" width="100%" border="1">
<colgroup>
	<col width="34%">
	<col width="34%">
	<col width="32%">
</colgroup>
	<thead>
	<tr>
		<th style="color:black;align:center;" >브랜드 명</th>
		<th style="color:black;" align="center">모델 명</th>
		<th style="color:black;" align="center">가격</th>
	</tr>
	</thead>
	
	<c:choose>
		<c:when test="${!empty listPrdct}">
		
			<tr>
			<td colspan="4">
			<div class="byscrll" style="height:100px;overflow:auto;" >
			<table width="100%" border="0">
			<colgroup>
				<col width="35%">
				<col width="35%">
				<col width="30%">
			</colgroup>
	   		<c:forEach var="prdct" items="${listPrdct}" varStatus="status">
				<tr onclick="fncGetPrdctInfo('${prdct.prdctId}','${prdct.trdePrc}');return false;" class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->
				     
				    <td style="color:black;" align="center">${prdct.brandName}</td>		
				    <td style="color:black;" align="center">${prdct.prdctName}</td>
				    <td style="color:black;" align="center">${prdct.trdePrc}</td>
				</tr>			
			</c:forEach>
			</table>
			</div>
			</td>
			</tr>
			<tr>
			<td colspan="9" align="center"><button onclick="getCnt();return false;">선택</button>     <button onclick="fncCancel();return false;")>취소</button></td>
			</tr>
		</c:when>
		<c:otherwise>	
			<tr>
				<td colspan="3">상품 데이터가 없습니다.</td>
		</c:otherwise>
	</c:choose>
	
	</tr>
</table>
<br>
<script type="text/javascript">
	$(".listData").click(function() {
		$("tr.selected").removeClass("selected");
		$(this).addClass("selected");
	});
</script> --%>