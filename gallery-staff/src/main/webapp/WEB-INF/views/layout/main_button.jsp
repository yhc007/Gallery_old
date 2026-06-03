<%@ page contentType="text/html;charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"
	scope="request" />

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<%@ include file="/WEB-INF/views/include/asLib.jsp"%>

<script type="text/javascript">


//화면 초기 실행 
jQuery(document).ready(function(){
	console.log('init_Test');
	var result = '${saleVo.result}';
	console.log('saleVo.result:'+result);
	if(result=='11111')
	{
		newWindow();
	}else{
		getSaleMemo();
	}
	
	
	/* $( "#fo_title" ).hide(); */
});


function newWindow(){
	console.log('run newWindow');
	
	var url = "${ctxPath}/cstmrHstry/indexCstmrHstryForm.do";
	
	$.ajax({
		url : url,
		dataType : "html",
		type : "post",
		success : function(data){
			//console.log(data);
			jQuery('#cstmrHist').html(data);
			jQuery('#cstmrHist').dialog({
				//bgiframe: true
				 title: "처방 내역"
				 , modal: true
			     , width: 800 // 가로 크기
			     , height : 800
			     , background: "#000"
			     , position:{my:"center",at:"bottom",of:"#tile" }
				 , close: function(event, ui){
					//location.replace("${ctxPath}/check/indexCheckEyesForm.do");

					//alert('cstmrId:'+'${cstmrId}');
					window.sessionStorage.setItem("popup",0);
					var form=document.createElement("form");
					  form.name='tempPost';
					  form.method='post';
					  form.action='${ctxPath}/sale/indexSaleForm.do';  

					  var input=document.createElement("input");
					  input.type="hidden";
					  input.name='cstmrId';
					  input.value= '${cstmrId}';
					  $(form).append(input);

					  $('body').append(form);
					  jQuery('#cstmrHist').html('');
					  form.submit();
					  
				}, success:  function(data) {
					
				} 
			});
			}
	});
}
/* 
var slctBtn = '${slctBtn}';
var chckBtn = '${chckBtn}';
var asblBtn = '${asblBtn}';
var paymBtn = '${paymBtn}';
var dlvrBtn = '${dlvrBtn}';

console.log('slctBtn:'+slctBtn);
console.log('chckBtn:'+chckBtn);
console.log('asblBtn:'+asblBtn);
console.log('paymBtn:'+paymBtn);
console.log('dlvrBtn:'+dlvrBtn);
 */
function goPrdctProcess(){
	location.replace("${ctxPath}/prdct/indexPrdctProcessForm.do");
	
};

function goCheckProcess(){
	/* directSave(); */
	location.replace("${ctxPath}/check/indexCheckEyesForm.do");
};

function goPrdctAssembly(){
	location.replace("${ctxPath}/prdct/indexPrdctAssemblyForm.do");
};

function goPrdctPayment(){
	location.replace("${ctxPath}/prdct/indexPrdctPaymentForm.do");
};

function goPrdctDelivery(){
	location.replace("${ctxPath}/prdct/indexPrdctDeliveryForm.do");
};



/* function directSave()
{
	console.log("run directSave");
	alert('run directSave');
	if(slctBtn == '1_F' ||slctBtn =='1_U')
	{
		
	}else if(chckBtn == '1_F' ||chckBtn =='1_U'){
		bbb();
	}else if(asblBtn == '1_F' ||asblBtn =='1_U'){
		
	}else if(paymBtn == '1_F' ||paymBtn =='1_U'){
		
	}else if(dlvrBtn == '1_F' ||dlvrBtn =='1_U'){
		
	}

} */
/* function fncSaveChck() {
	
	console.log("run fncSaveChck");
	alert('run fncChck');
	if (writable == false) {
		alert('<spring:message code="warn.check.writable"/>');
		return;
	}
	var url = '${ctxPath}/check/insertVisitAction.do';
	var url = 'insertVisitAction.do';

	param = jQuery('#checkForm').serialize();
	console.log(param)
	
	//javax
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
				location.replace("${ctxPath}/check/indexCheckEyesForm.do");

			} else if (data == "fail") {
				alert('<spring:message code="fail"/>');
			}
		}
	});

} */


function fncGoStaffPage(shopId){
	console.log("shopId:"+shopId);
	var form=document.createElement("form");
	  form.name='tempPost';
	  form.method='post';
	  form.action='${ctxPath}/staff/indexStaffForm.do';  
	  
		if(shopId==''||shopId=='"null"')
			shopId=window.sessionStorage.getItem("gShopId");
		else
			shopId=parseInt(shopId)
	  
	  
	  var input=document.createElement("input");
	  input.type="hidden";
	  input.name='shopId';
	  input.value= shopId;
	  $(form).append(input);
	  $('body').append(form); 
	  form.submit();
};

function staffLogin(staffId) {
	var form = document.createElement("form");
	form.name = 'tempPost';
	form.method = 'post';
	form.action = '${ctxPath}/staff/staffLogin.do';

	var input=document.createElement("input");
	  input.type="hidden";
	  input.name='staffId';
	  input.value= staffId;
	  $(form).append(input);
	  $('body').append(form); 
	  form.submit();
};

function goPurchasedPage(){
	location.replace("${ctxPath}/cstmrHstry/indexCstmrHstryForm.do");

}
function getSaleOffHist(){
	console.log("run getSaleOffHist()");
	jQuery.ajax({  
		url: '${ctxPath}/payment/listSaleOffHist.do'
		, type: "POST"
		, data 	: "cstmrId="+'${cstmrId}'
		, dataType: "html"
		, success:  function(data) {
			jQuery('#dlgSaleOffHist').html(data);
		}
	});	// end ajax	
	jQuery('#dlgSaleOffHist').dialog({
		//bgiframe: true
		 title: "결제내역"
		 , modal: true
	     , width: 800 // 가로 크기
	     , background: "#000"
	     , position:{my:"center",at:"bottom",of:"#tile" }
		 , close: function(event, ui){
		}, success:  function(data) {
			
		} 
	});	
}


function getPrdct(){
	jQuery.ajax({  
		url: '${ctxPath}/prdct/popupSelectPrdctForm.do'
		, type: "POST"
		, data: null
		, dataType: "html"
		, beforeSend: function(xhr){
			
		}
		, success:  function(data) {
			jQuery('#dialog').html(data);
		}	
	});	// end ajax	
	
	jQuery('#dialog').dialog({
		//bgiframe: true
		 title: "상품 선택"
		 , modal: true
	     , width: 900 // 가로 크기
	     , background: "#000"
	     , position:{my:"center",at:"bottom",of:"#tile" }
		 , close: function(event, ui){
		}, success:  function(data) {
			
		} 
	});	
};
function getToday()
{
	var date = new Date();
	var day = date.getDate();
	var month = date.getMonth() + 1;
	var year = date.getFullYear();

	if (month < 10) month = "0" + month;
	if (day < 10) day = "0" + day;

	var today = year + "." + month + "." + day;
	return today;
}

var header;
$(function() {
	header = $("#asBoardTbl").html();
	$("#saleDateTile" ).datepicker({ dateFormat: 'yy.mm.dd'});
	$('#saleDateTile').datepicker('setDate', new Date());
	
	var sessionDay = window.sessionStorage.getItem("dateTile");
	var today = getToday();
	if(sessionDay!=null){
		if(today!=sessionDay)
		{
			 document.getElementById("saleDateTile").style.color = "red";
		}else{
			document.getElementById("saleDateTile").style.color = "blue";
		}
		document.getElementById("saleDateTile").value = sessionDay;	
	}else{
		sessionDay =  today;
		document.getElementById("saleDateTile").value = sessionDay;
		window.sessionStorage.setItem("dateTile", sessionDay);
		
	}
		
}); 
function setDateTile()
{
	var today = getToday();
	var tileValue = document.getElementById("saleDateTile").value;
	
	window.sessionStorage.setItem("dateTile",tileValue);
	console.log("session dateTile:" + window.sessionStorage.getItem("dateTile"));
	if(today!=tileValue)
	{
		document.getElementById("saleDateTile").style.color = "red";
	}else{
		document.getElementById("saleDateTile").style.color = "blue";
	}
	
}

var memo = false;
function goPrint(){
	location.href="${ctxPath}/prdct/indexPrdctProcessFormPrint.do";
	//location.href="http://ilmol.com/wp/wp-content/uploads/html5.pdf";
}
function showMemo(){
	
	var saleId = '${saleVo.saleId}';
	if('undefined'==saleId || saleId=='')
	{
		var s_Alert='선택, 검안 단계중 하나가 완료 되어야 처방이 생성 되면서 메모가 저장됩니다.';
		$("#memo_txt").html(s_Alert);
	}
	console.log('saleVo.saleId:'+saleId);
	console.log('type saleId'+typeof(saleId));
	if(!memo){
		$("#memo_txt").slideDown(500);
		$("#memo").text("접기");
		memo = true;
	}else{
		$("#memo").text("메모");
		memo = false;
		saleMemoUpdate();
		$("#memo_txt").slideUp(500);
	}
}
function getSaleMemo(){
	console.log('run getSaleMemo');
	
	var saleId = '${saleVo.saleId}';
	if(saleId=='')
	{
		console.log('처방 생성이 되지 않아 불러올 메모가 없습니다.');
		return;
	}
	var url = '${ctxPath}/sale/getSaleMemo.do';
	$.ajax({
		url	 : url,
		type : "post",
		data : "saleId=" + saleId,
		dataType	: "text",
		success: function(data){
			document.getElementById("memo_txt").value = decodeURIComponent(data);
		}
	}); 
};
 
function saleMemoUpdate(){
	var saleId = '${saleVo.saleId}';
	if(saleId=='')
	{
		console.log('처방 생성이 되지 않아 저장되지 않습니다.');
		return;
	}
	var url = '${ctxPath}/sale/saleMemoUpdate.do';
	var memo = $("#memo_txt").val();
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
		data : "memo=" + memo + "&saleId=" + saleId,
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

function setFmly(sample)
{
	if(sample.value==''){
		console.log('value is empty:'+sample.value);
		return;
	}else{
		console.log('value2:'+sample.value);
		window.sessionStorage.setItem("popup",1);
		fncGoFmly(sample.value);
	}
	
}
function fncGoFmly(cstmrId)
{	
	console.log("typeof(cstmrId):"+typeof(cstmrId));
	console.log('run fncGoFmly');
	if ( typeof(cstmrId) != "object" ) {
		console.log('cstmrId1:'+cstmrId);
	}else{
		cstmrId = Number(cstmrId.value);
		console.log('cstmrId2:'+cstmrId);
	}
	var form=document.createElement("form");
	form.name='tempPost';
	form.method='post';
	form.action='${ctxPath}/sale/indexSaleForm.do';  
	  
	var input=document.createElement("input");
	  input.type="hidden";
	  input.name='cstmrId';
	  input.value= cstmrId;
	  $(form).append(input);
	  	  
	  $('body').append(form); 
	  form.submit();
}


function fncChgStaff(staffId)
{
	url='${ctxPath}/staff/changeStaff.do';
	console.log('staffId:'+staffId.value);
	console.log('shopId:'+'${shopVo.shopId}');
	var numStaffId = Number(staffId.value);
	
	var shopId=-1;
	if('${shopVo.shopId}'==''||'${shopVo.shopId}'=='"null"')
		shopId=window.sessionStorage.getItem("gShopId");
	else
		shopId=parseInt('${shopVo.shopId}')
		
	$.ajax({
		url	 : url,
		type : "post",
		data : "staffId=" + numStaffId+"&shopId="+shopId,
		dataType	: "text",
		beforeSend	: function(){
		},
		success: function(data){
			if(data!='success'){
				alert('전환 실패. 로그아웃 후 이용 바랍니다.');
			}else{
				fncGoFmly('${cstmrId}');
			}
		}
	}); 
	
	
}

function galleryCummunity(){
	var form = document.createElement("form");
	
	form.method = "post";
	form.action = "https://jaguar.s4g.kr/community/board/main.do";
	
	var input = document.createElement("input");
	input.type = "hidden";
	input.name = "shopTy";
	input.value = 1;
	
	var shopId=-1;
	if('${shopVo.shopId}'==''||'${shopVo.shopId}'=='"null"')
		shopId=window.sessionStorage.getItem("gShopId");
	else
		shopId=parseInt('${shopVo.shopId}')
	
	
	var input2 = document.createElement("input");
	input2.type = "hidden";
	input2.name = "shopId";
	input2.value = shopId;
	
	$(form).append(input);
	$(form).append(input2);
	
	$("#body").append(form);
	document.body.appendChild(form);
	form.submit();
}

// function galleryManager(){
// 	$.ajax({
// 		url : 'https://jaguar.s4g.kr/Manager/admin/login.do',
// 		type : "post",
// 		dataType : "text",
// 		data : "id=" + "${shopVo.id}" + "&pwd=" + "${shopVo.pwd}" + "&shopTy="+"shop",
// 		success : function(data){
// 			if(data.trim()=="success"){
// 				location.href="https://jaguar.s4g.kr/Manager/chart/chart.do";
// 			}else if(data.trim()=="fail"){
// 				alert("ID혹은 비밀번호를 확인해 주세요.");
// 			}
// 		}
// 	}); 

}

function dlgSearchCstmr()
{
	
	var url = '${ctxPath}/cstmr/cstmrListDlg.do';
	 
	//javax
	 $.ajax({
		url		: url,
		type 	: "post",
		//data 	: "cstmrId="+'${cstmrId}',
		dataType	: "html",
		beforeSend	: function(){
		},
		success: function(data){
			//jQuery('#dlgSearchResult').html('');
			jQuery('#dlgSearchResult').html(data);
		}
	});
	
	jQuery('#dlgSearchResult').dialog({
		title: '최근 검색',
		modal: true,
		width: "auto",
		height : "auto",
		background: "#000",
		position:{
			my:"left top",
			at:"left top",
			of:window },
		
	});
}
	
</script>

<style>
.pnt {
	cursor: pointer;
}

#saleDateTile {
	text-align: center;
	color: #00F;
	font-family: "맑은 고딕 Bold";
	font-weight: bold;
	font-size: 18px;
	text-align: center;
	width: 100%;
	height: 100%;
}

#memo {
	height: 50px;
	width: 50px;
}

#memo_txt {
	font-size: 20px;
	display: none;
}

#cmnt, #mng, #as {
	cursor: pointer;
}

#asBoardDiv {
	display: none;
}
</style>
<div align="center" id="tile">
	<div class="transBoxTile">
		<table class="listCstmr" width="800px" border="0.5">
			<tr>
				<td width="135" height="26"
					onclick="staffLogin(${staffVo.staffId});return false;">매장고객</td>
				<td width="135" height="26"><a onclick="galleryCummunity()"
					id='cmnt'>커뮤니티</a></td>
				<td width="135" height="26"><a onclick="dlgSearchCstmr()"
					id='srch'>최근검색</a></td>
				<td width="135" height="26"><a onclick="galleryManager()"
					id="mng"> 매장관리</td>
				<td width="135" height="26"><a onclick="getAsBoard()" id="as">
						A/S 관리</td>
				<td width="135" height="26"><a
					onclick="fncGoStaffPage('${shopVo.shopId}');return false;">Log-out</td>
			</tr>
			<tr id='fo_title'>
				<td height="44" colspan="5"><div class="head_title">
						Gallery Eyewear</br> Cloud System
					</div></td>
				<td height="44"><img
					src="https://jaguar.s4g.kr/media${staff.imgPath}" width="135"
					height="135" /></td>
			</tr>
			<tr class="c1" bgcolor="#FFFFFF">
				<td class="c1"><c:choose>
						<c:when test="${!empty listFmly}">

							<select id='slctFmly' onChange="setFmly(this);">
								<option value=''>---가족회원---</option>
								<c:forEach items="${listFmly}" var="item" varStatus="status">
									<c:choose>
										<c:when test='${cstmrName == item.cstmrName}'>
											<option selected value="${item.cstmrId}">${item.cstmrName}
												님</option>
										</c:when>
										<c:otherwise>
											<option value="${item.cstmrId}">${item.cstmrName} 님
											</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</c:when>
						<c:otherwise>
							${cstmrName } 님
						</c:otherwise>
					</c:choose></td>
				<td width="170" class="c1"><input type="text" id='saleDateTile'
					onChange="setDateTile();"></input></td>
				<td width="100">&nbsp;</td>
				<td height="24">
					<!-- <a class="getPurchasedList" href="#" onclick="newWindow(); return false;">처방내역</a> -->
				</td>
				<td class="c1"><a class="getPurchasedList" href="#"
					onclick="getSaleOffHist(); return false;">결제내역</a></td>
				<td class="c1"><c:choose>
						<c:when test="${!empty listStaffShop}">

							<select id='slctFmly' onChange="fncChgStaff(this);">
								<option value=''>---사용자변경---</option>
								<c:forEach items="${listStaffShop}" var="item"
									varStatus="status">
									<c:choose>
										<c:when test='${staffVo.staffName == item.staffName}'>
											<option selected value="${item.staffId}">${item.staffName}안경사님</option>
										</c:when>
										<c:otherwise>
											<option value="${item.staffId}">
												${item.staffName}안경사님</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</c:when>
						<c:otherwise>
							${staffVo.staffName}안경사님
						</c:otherwise>
					</c:choose></td>
			</tr>
		</table>

		<table width="800" border="0.5">
			<tr>
				<td width="155" height="53"><img class="pnt"
					src="<c:url value="/images/button/Select_${slctBtn}.png" />"
					onclick="goPrdctProcess();return false;"></td>
				<td width="155" height="53"><img class="pnt"
					src="<c:url value="/images/button/Check_${chckBtn}.png" />"
					onclick="goCheckProcess();return false;"></td>
				<td width="155" height="53"><img class="pnt"
					src="<c:url value="/images/button/Assembly_${asblBtn}.png" />"
					onclick="goPrdctAssembly();return false;"></td>
				<td width="155" height="53"><img class="pnt"
					src="<c:url value="/images/button/Payment_${paymBtn}.png" />"
					onclick="goPrdctPayment();return false;"></td>
				<td width="155" height="53"><img class="pnt"
					src="<c:url value="/images/button/Delivery_${dlvrBtn}.png" />"
					onclick="goPrdctDelivery();return false;"></td>
			</tr>
			<tr>
				<td colspan='5' align='center'><input type="image" id='imgMemo'
					onclick="showMemo(); return false;"
					src="<c:url value="/images/button/memo_Button_wh.png" />"
					width="32px" height="32px" /> <span>&nbsp;</span> <input
					type="image" id='imgPrint' onclick="goPrint(); return false;"
					src="<c:url value="/images/button/print_btn_wh.png" />"
					width="32px" height="32px" /> <br> <textarea rows="5"
						cols="60" id="memo_txt" placeholder="메모 작성 후 닫아주셔야 저장됩니다."></textarea>
				</td>
			</tr>
		</table>
	</div>

</div>
<div id="dlgPurchased"></div>
<div id="dlgSaleOffHist"></div>
<div id="cstmrHist"></div>
<div id="dlgSearchResult" hidden></div>


