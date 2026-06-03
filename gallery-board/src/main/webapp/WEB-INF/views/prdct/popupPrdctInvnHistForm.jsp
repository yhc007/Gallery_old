<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script>
	
//----------------------
//화면 초기 실행 
jQuery(document).ready(function(){
	
	document.getElementById("pprdctName").innerHTML='${prdctVo.prdctName}';
	document.getElementById("pbrandName").innerHTML='${prdctVo.brandName}';
	document.getElementById("pmnfCountry").innerHTML='${prdctVo.mnfCountry}';
	document.getElementById("pprdctTy").innerHTML='${prdctVo.prdctTyCdMsg}';
	document.getElementById("pinvnTyCd").innerHTML='${prdctVo.invnTyCdMsg}';
	document.getElementById("pcnt").innerHTML='${prdctVo.cnt}';
	jQuery('#listPrdctForm2 TEXTAREA[name=bigo]').val('${prdctVo.bigo}');
	 
});
//----------------------

function fncAcptReqAction(code){
	fncSavePrdctActpAction(code,jQuery('#prdctDetailForm input[name=prdctId]').val());
}
//닫기
function fncCancel(){
	jQuery('#dialog').dialog( 'close' );
}


</script> 
 
	 
		

<!-- <div id="content"> -->
<div id="popupCnts" >			
	<form name="listPrdctForm2"  id="listPrdctForm2" method="post" action="">
		<input type="hidden" id='prdctId' name='prdctId'>
		
		<div id="listBrandDiv"> 
		</div>
		
		
		<table width="100%" border="1" class="detail"> 
			<br>
			<tbody>
			
			<tr>
				<th style="width:20%"><label for="">모델 </label></th>
				<td style="width:30%">
					<p id='pprdctName' title='모델 명'></p>
				</td>
				<th style="width:20%"><label for="">타입</label></th>
				<td style="width:30%">
					<p id='pprdctTy' title='타입'></p>
				</td>
			</tr>
			<tr>
				<th style="width:20%"><label for="">제조 국</label></th>
				<td style="width:30%">
					<p id='pmnfCountry' title='제조 국'></p>
				</td>
				<th style="width:20%"><label for="">브랜드 명</label></th>
				<td style="width:30%">
					<p id='pbrandName'></p>
				</td>
			</tr>
			<tr>
				
				<th><label for="">분류</label></th>
				<td>
					<p id='pinvnTyCd'></p>
				</td>
				<th><label for="">수량</label></th>
				<td>
					<p id='pcnt'></p>
				</td>
			</tr>
			<tr>
				<th><label for="">비고</label></th>
				<td colspan="3"><TEXTAREA  readonly="readonly" id="bigo" name="bigo" ROWS="5" style="width:90%"></TEXTAREA></td>
			</tr>
			</tbody>
		</table>

		
		<br>
		<div id="btn_sctn" align="right">
			<button onclick="fncCancel();return false;">확인</button>
		</div>
		
	</form>


</div><!--//content-->




	
	 