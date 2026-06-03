<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script>

//----------------------
//화면 초기 실행
jQuery(document).ready(function(){

});
//----------------------


var mPrdctId;
function fncGetPrdctInfo(prdctId){
	 var url = '../prdct/getPrdctData.do';
	 mPrdctId=prdctId;
	 //var userId = $('#userId').getValue();

	 jQuery.ajax({
			url: url,
			type : "post",
			data : "prdctId=" + prdctId,
			dataType	: "json",
			beforeSend	: function(){
			},
			success		: function(data){
				document.prdctListForm.prdctImg.src=data.imgPath;
			}

		});
}
function fncAcptReqAction(code){
	fncSavePrdctActpAction(code,jQuery('#prdctDetailForm input[name=prdctId]').val());
}

//상품 선택
function fncSelect(){
	if(mPrdctId==null){
		alert("상품을 선택하세요");
		return;
	}
	var url = 'addEventPrdctAction.do'; // 추가;
	var msg;
	 $.ajax({
		url 	: url,
		type 	: "post",
		data 	: "prdctId="+mPrdctId+"&eventId="+jQuery('#listEventForm2 input[name=eventId]').val(),
		dataType	: "text",
		beforeSend	: function(){

		},
		success: function(data){
			if(data=="duple"){
				alert('<spring:message code="add.duple" arguments="상품"/>');
			}else if(data=="success"){
				alert('<spring:message code="add.success" />');
			}else if(data=="fail"){
				alert('<spring:message code="fail" />');
			}else if(data=="upsuccess"){
				alert('<spring:message code="update.success" />');
			}
			  //성공시....

			fncCancel();
			fncListEventPrdctData(jQuery('#listEventForm2 input[name=eventId]').val());
		}

	});
}

//닫기
function fncCancel(){
	jQuery('#dialog').dialog( 'close' );
}

/*
 * 이벤트 데이타 리스트 보드 페이징
 */
function fncListPrdctData(){
	var url = 'listPrdctData.do';
	 //jQuery('#listEventForm2 input[name=eventId]').val()
	//javax
	 $.ajax({
		url		: url,
		type 	: "post",
		data 	: "prdctName=" +jQuery('#prdctListForm input[name=prdctName]').val()+"&eventId="+jQuery('#listEventForm2 input[name=eventId]').val() ,
		dataType	: "html",
		beforeSend	: function(){
		},
		success: function(data){
			jQuery('#listSearchedPrdctDiv').html(data);
		}
	});
	//fncEventDetailClear();
}
</script>




<!-- <div id="content"> -->
<div id="popupCnts">
	<form name="prdctListForm" id="prdctListForm" method="post"
		action="">
		<input type="hidden" id='prdctId' name='prdctId' />
		<table style="width:100%" border="0">
			<tr>
				<td width="80%" valign="top">


					<table style="width:100%" border="0">
						<colgroup>
							<col width="20%">
							<col width="80%">
						</colgroup>
						<tr>
							<td colspan="2">
								<input id="prdctName" name="prdctName" type="text">
								<button onclick="fncListPrdctData();return false;">검색</button>
							</td>
						</tr>
						<tr>
							<th>NO</th>
							<th>모델 명</th>
						</tr>
						<tr>
							<td colspan="2">
								<div class="byscrll" style="height:200;overflow:auto;" >
								<div id="listSearchedPrdctDiv">
								</div>
								</div>
							</td>
						</tr>
					</table>
				</td>
				<td width="20%">
					<a style="display:display" href="#"><img id="prdctImg" width=200 /></a>
				</td>
			</tr>
		</table>


		<div id="btn_sctn" align="right">
				<a
					href="#" class="btn1" id='deny'
					onclick="fncSelect();return false;">선택</a>
				<a
					href="#" class="btn1" id='cancel'
					onclick="fncCancel();return false;">취소</a>
		</div>
	</form>


</div>
<!--//content-->





