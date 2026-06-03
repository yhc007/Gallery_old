<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>

<script>
var mPrdctId;
var mTrdePrc;
var mCnt;
var mPrdctName;
var mPrdctTy;
function fncGetPrdctInfo(prdctId,trdePrc,prdctCnt, prdctName, prdctTy){
	mPrdctId=prdctId;
	mTrdePrc=trdePrc;
	mCnt = prdctCnt;
	mPrdctName=prdctName;
	mPrdctTy=prdctTy;
	/* console.log('lens name:'+prdctName);
	console.log('lens ty:'+prdctTy); */
}

function fncSelectPrdct(){
	/*
	alert(fncGetSaleId());
	alert(mPrdctId);
	*/
	/*
	alert(jQuery('#prdctCnt').val());
	*/
		
	if(jQuery('#prdctCnt').val()==''){
		alert('<spring:message code="warn.put.data" arguments="수량"/>');
		return;
	}
	
	if(isNaN(jQuery('#prdctCnt').val()))
	{
		alert('<spring:message code="warn.put.data" arguments="숫자"/>');
		return;
	}
	
	if(mCnt<1)
	{
		alert('<spring:message code="warn.cnt.prdct" />');
		return;
	}
	
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
			location.replace(pageUrl);
		}
	}); 
}


</script>
<style>
	#prdctCnt, #submit{
	}
</style>
<table width="100%" border="1" class="transBoxTable listItemJQM">
	<thead>
	<tr>
		<th width="20%" class=list_prdct style="color: #000">브랜드 명</th>
		<th width="30%" class=list_prdct style="color: #000">모델 명</th>
		<th width="10%" class=list_prdct style="color: #000">재고</th>
		<th width="10%" class=list_prdct style="color: #000">구분</th>
		<th width="10%" class=list_prdct style="color: #000">굴절률</th>
		<th width="20%" class=list_prdct style="color: #000">가격</th>
	</tr>
	</thead>
	
	<c:choose>
		<c:when test="${!empty listPrdct}">
			<tr>
			<td colspan="6">
			<div class="byscrll" style="height:200px;overflow:auto;" >
			<table width="100%" border="0">
	   		<c:forEach var="prdct" items="${listPrdct}" varStatus="status">
				<tr onclick="fncGetPrdctInfo('${prdct.prdctId}','${prdct.trdePrc}','${prdct.prdctCnt}','${prdct.prdctName}','${prdct.itemTy}');return false;" height='45px' class="listData">
				    <c:if test="${prdct.brandName eq 'plain' }">
				    	<td width="20%" style="color:white;" align="center">평면</td>
				    </c:if>
				    <c:if test="${prdct.brandName eq 'spare' }">
				    	<td width="20%" style="color:white;" align="center">여벌</td>
				    </c:if>
				    <c:if test="${prdct.brandName eq 'spare_rx' }">
				    	<td width="20%" style="color:white;" align="center">여벌_RX</td>
				    </c:if>
				    <c:if test="${prdct.brandName eq 'spare_mt' }">
				    	<td width="20%" style="color:white;" align="center">여벌_MT</td>
				    </c:if>
				    <c:if test="${prdct.brandName eq 'rx' }">
				    	<td width="20%" style="color:white;" align="center">RX</td>
				    </c:if>
				    <c:if test="${prdct.brandName eq 'rx_mt' }">
				    	<td width="20%" style="color:white;" align="center">RX_MT</td>
				    </c:if>
				    <c:if test="${prdct.brandName eq '변색' }">
				    	<td width="20%" style="color:white;" align="center">변색</td>
				    </c:if>
				    <c:if test="${prdct.brandName eq '편광' }">
				    	<td width="20%" style="color:white;" align="center">편광</td>
				    </c:if>
				    
				    <td width="30%" style="color:white;" align="center">${prdct.prdctName}</td>
				    <td width="10%" style="color:white;" align="center">${prdct.prdctCnt}</td>
				    <td width="10%" style="color:white;" align="center">${prdct.ty1}</td>
				    <td width="10%" style="color:white;" align="center">${prdct.ty2}</td>
				    <td width="20%" style="color:white;" align="right">${prdct.trdePrc}</td>
				</tr>
			</c:forEach>
			</table>
			</div>
			</td>
			</tr>
			<tr>
				<td colspan="6" align="center">
					<button onclick="addPrdct();return false;">선택</button>
					<button onclick="fncCancel();return false;")>취소</button>
				</td>
			</tr>
		</c:when>
		<c:otherwise>	
			<tr>
				<td colspan="6">상품 데이터가 없습니다.</td>
			</tr>
		</c:otherwise>
	</c:choose>
	
	
</table>
<br>
<script type="text/javascript">
	$(".listData").click(function() {
		$("tr.selected").removeClass("selected");
		$(this).addClass("selected");
	});
</script>