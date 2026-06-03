<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/cstmrHstryLib.jsp"%>

<script>
	var mPrdctId;
	var mTrdePrc;
	
	function getVisitListforFrame() {
		//location.replace("${ctxPath}/cstmrHstry/indexCstmrHstryForm.do");
		var url = '${ctxPath}/cstmrHstry/listVisitData.do';

		//javax
		$.ajax({
			url : url,
			type : "post",
			data : "cstmrId=" + '${cstmrId}',
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				jQuery('#dateFrame').html(data);

			}
		});
	};

	function fncSaveEdit() {

		var checkStaffId = document.getElementById('staffId').innerHTML;
		if (checkStaffId != '${staffVo.staffId}') {
			alert("다른 스태프의 작업을 수정할 수 없습니다.");
			return;
		}

		if (writable == false) {
			alert('<spring:message code="warn.check.writable"/>');
			return;
		}
		var url = 'updateVisitAction.do';

		param = jQuery('#checkForm').serialize();

		//alert(param);

		$.ajax({
			url : url,
			type : "post",
			data : param,
			dataType : "text",
			beforeSend : function() {
			},
			success : function(data) {
				if (data == "success") {
					alert("저장 완료.");
					writable = false;
				} else if (data == "fail") {
					alert('<spring:message code="fail"/>');
				}
			}
		});
	}
	
	function saleMemoUpdateH(){
		//console.log('run saleMemoUpdateH g_saleId:'+g_saleId);
		if(g_saleId==''||g_saleId==0){
			//console.log('처방 생성이 되지 않아 저장되지 않습니다.');
			return;
		}
		var url = '${ctxPath}/sale/saleMemoUpdate.do';
		var memo = $("#memo_txtH").val();
		//console.log('length:'+memo.length);
		if(memo.length>250)
		{
			alert('250자 내로 저장 가능합니다.');
			return;
		}
		memo = encodeURIComponent(memo);
		//javax
		$.ajax({
			url	 : url,
			type : "post",
			data : "memo=" + memo + "&saleId=" + g_saleId,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				if(data!='success'){
					alert('메모 저장 실패');
				}else{
					//alert('메모 저장 성공');
				}
		}
		}); 
	}
</script>
<style>

#staffListH >tr>td{
	bgcolor:#FFFFFF;
	color:black;
}

#staffTableH
{
	font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
	width:100%;
	border-collapse:collapse;
}
#staffTableH td, #staffTableH th 
{
	font-size:13px;
	/* border:1px solid #98bf21; */
	border:1px solid #000000;
	padding:3px 7px 2px 7px;
}
#staffTableH th 
{
	font-size:1.1em;
	text-align:left;
	padding-top:5px;
	padding-bottom:4px;
	background-color:#A7C942;
	color:#ffffff;
}
#staffTableH tr.alt td 
{
color:#000000;
background-color:#EAF2D3;
}

#saveMemoH{
	-webkit-appearance: none;
	width:48px;
	height:32px;
}
</style>

<div id="cstmrHistForm" >
<table id="staffTableH" border='1'>
	<tr align='center'>
		<td width='20%' class='alt'>매장</td>
		<td width='20%'><span id="shopNameH" name="shopName" ></span></td>
		<td width='10%' class='alt' rowspan='3'>메모</td>
		<td width='40%'rowspan='3'>
			<textarea rows="3" cols="60" id="memo_txtH" placeholder="메모 작성 후 우측 저장버튼을 누르시면 저장됩니다."></textarea>
		</td>
	</tr>
	<tr align='center'>
		<td class='alt' >처방일</td>
		<td><input id='visitDateH' type='date'/></td>
	</tr>
	<tr align='center'>
		<td class='alt' >직원</td>
		<td>
			<span id="staffNameH"></span><span id="staffIdH"  hidden ></span><span id="saleIdH"  hidden ></span>
			<c:choose>
				<c:when test="${!empty listStaff}">
					<select>
						<option value=''>---사용자변경---</option>
						<c:forEach items="${listStaff}" var="item" varStatus="status">
							<c:choose>
								<c:when test='${staffVo.staffName == item.staffName}'>
									<option selected value="${item.staffId}">${item.staffName}</option>
								</c:when>
								<c:otherwise>
									<option value="${item.staffId}" > ${item.staffName}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</c:when>
				<c:otherwise>
					${staffVo.staffName}
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</table>


</div>
