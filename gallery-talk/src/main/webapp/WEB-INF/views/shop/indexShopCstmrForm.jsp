<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

 
<link rel="stylesheet" type="text/css"
	href="${ctxPath}/css/SpryAssets/SpryValidationTextarea.css" />
<script src="${ctxPath}/css/SpryAssets/SpryValidationTextarea.css"
	type="text/javascript">
</script>

<script>

function newWindow(){
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
			     , width: 1000 // 가로 크기
			     ,height : 800
			     , background: "#000"
			     , position:{my:"center",at:"bottom",of:"#tile" }
				 , close: function(event, ui){
					//location.replace("${ctxPath}/check/indexCheckEyesForm.do");

					//alert('cstmrId:'+'${cstmrId}');
					var form=document.createElement("form");
					  form.name='tempPost';
					  form.method='post';
					  form.action='${ctxPath}/sale/indexSaleForm.do';  

					  var input=document.createElement("input");
					  input.type="hidden";
					  input.name='cstmrId';
					  input.value= '${cstmrId}';
					  $(form).append(input);

					  $('#body').append(form); 

					  form.submit();
				}, success:  function(data) {
					
				} 
			});
			}
	});
}

	//----------------------
	//화면 초기 실행

	jQuery(document).ready(function() {
		getVisitingCstmrListData();
		fncDateTile_init();
		checkCookie();
	});
	//----------------------
	var saleResult = '${saleVo.result}';
	var mCstmrCd;
	function fncSelectCstmr(cstmrCd) {
		mCstmrCd = cstmrCd;
	};
	function fncCancel() {
		jQuery('#dialog').dialog('close');
		jQuery('#dialog').html('');
		/*
		jQuery('#dialog').dialog( 'close' );
		jQuery('#dialog').html('');
		 */
	};
	
	
	function checkCookie()
	{
	 //쿠키값이 있으면 element를 가려준다
	 console.log('staffId:'+'${staffVo.staffId}');
	 var strCookie = 'galleryNotice1'+'${staffVo.staffId}';
	    	console.log('strCookie:'+strCookie);

	 	var val = getCookie(strCookie);
	 	console.log('cookie is :'+val);
	    if(val == "done"){
	    	console.log('cookie is done.');
	    }else{
	    	console.log("cookie isn't done.");
	    	runNotice();
	    }
	}
	
	function getCookie( name ) 
	{ 
	    var nameOfCookie = name + "="; 
	    var x = 0; 
	    while ( x <= document.cookie.length ) 
	    { 
	        var y = (x+nameOfCookie.length); 
	        if ( document.cookie.substring( x, y ) == nameOfCookie ) 
	        { 
	            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
	                endOfCookie = document.cookie.length;
	            return unescape( document.cookie.substring( y, endOfCookie ) ); 
	        } 
	        x = document.cookie.indexOf( " ", x ) + 1; 
	        if ( x == 0 ) 
	            break; 
	    } 
	    return ""; 
	}
	
	function runNotice()
	{
		console.log('runNotice()');
		var url = "${ctxPath}/notice/notice1.do";
	
		$.ajax({
		url : url,
		dataType : "html",
		type : "post",
		success : function(data){
			//console.log(data);
			jQuery('#popupNotice').html(data);
			jQuery('#popupNotice').dialog({
				//bgiframe: true
				 title: "공지사항"
				 , modal: true
			     , width: 450 // 가로 크기
			     , height : 'auto'
			     , background: "#000"
			     , position:{my:"center",at:"center",of:window }
				 , close: function(event, ui){
					//window.sessionStorage.setItem("popup",0);
					/* var form=document.createElement("form");
					  form.name='tempPost';
					  form.method='post';
					  form.action='${ctxPath}/sale/indexSaleForm.do';  
					  var input=document.createElement("input");
					  input.type="hidden";
					  input.name='cstmrId';
					  input.value= '${cstmrId}';
					  $(form).append(input);
					  $('#body').append(form); 
					  form.submit(); */
				}, success:  function(data) {
				} 
			});
			}
	});			
	}
	
	function getVisitingCstmrListData(){
		var url = '${ctxPath}/saleJob/listVisitingCstmrData.do';
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: "cstmrId="+'${cstmrId}',
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listVisitingCstmrDiv').html(data);
			}
		});  
	}

	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncCheckValidation() {
		if (cstmrName.value == "") {
			alert('<spring:message code="validation.put" arguments="고객명을"/>');
			return false;
		}

		return true;
	}

	function goCstmrListPage() {
		if (!fncCheckValidation()) {
			return;
		}

		var form = document.createElement("form");
		form.name = 'tempPost';
		form.method = 'post';
		form.action = '${ctxPath}/cstmr/cstmrListForm.do';

		var param = document.createElement("input");
		param.setAttribute("type", "hidden");
		param.setAttribute("name", "cstmrName");
		param.setAttribute("value", jQuery(
				'#cstmrSearchForm input[name=cstmrName]').val());
		$(form).append(param);
		$('#body').append(form);
		form.submit();
	};
	
	function fncGoCstmrSearchPage(){
		location.href = '${ctxPath}/cstmr/indexCstmrForm2.do';
		
	};
	
	function fncGoStaffPage(shopId){
		
		var form=document.createElement("form");
		  form.name='tempPost';
		  form.method='post';
		  form.action='${ctxPath}/staff/indexStaffForm.do';  
		  
		  var input=document.createElement("input");
		  input.type="hidden";
		  input.name='shopId';
		  input.value= shopId;
		  $(form).append(input);
		  $('#body').append(form); 
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
		  $('#body').append(form); 
		  form.submit();
	};

	
	function fncDateTile_init(){
		var date = new Date();

		var day = date.getDate();
		var month = date.getMonth() + 1;
		var year = date.getFullYear();

		if (month < 10) month = "0" + month;
		if (day < 10) day = "0" + day;

		var today = year + "." + month + "." + day;       
		window.sessionStorage.setItem("dateTile",today);
	}	
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>회원 찾기</title>
<!-- <style type="text/css">

/* .header {
	font-family: "Arial Black", Gadget, sans-serif;
	font-size: 30px;
	text-align: center;
}
 */
.box1 {
	-webkit-border-radius: 7px;
	padding: 10px 45px;
	border-radius: 12px/20px;
	font-family: "맑은 고딕 Bold";
	background-color: #D0D0D0;
	color: #FFFFFF;
	font-weight: bold;
	font-size: 18px;
	border: 0px solid #004B23;
	text-align: center;
}

.box2 {
	-webkit-border-radius: 2px;
	padding: 10px 45px;
	border-radius: 12px/20px;
	font-family: "맑은 고딕 Bold";
	background-color: #333;
	color: #FFFFFF;
	font-weight: bold;
	font-size: 18px;
	border: 0px solid #004B23;
	text-align: center;
}

/* body {
	background-color: #39F;
	margin-left: 3px;
	margin-top: 10px;
	margin-right: 3px;
	margin-bottom: 10px;
} */

/* body,td,th {
	color: #FFF;
	font-family: "맑은 고딕 Bold";
	font-weight: bold;
	font-size: 18px;
	text-align: center;
} */

.title {
	font-size: 36px;
}

.title2 {
	font-size: 30px;
}
</style> -->
</head>

<body>
	<center>
		<div calss="transBoxTable">
		<table class="listCstmr" width="800" border="0.5">
			<tr>
				<td class="btnTop" width="160" height="26"
					onclick="staffLogin(${staffVo.staffId}); return false;">매장고객</td>
				<td width="160" height="26">&nbsp;</td>
				<td width="160" height="26">&nbsp;</td>
				<td width="160" height="26">&nbsp;</td>
				<td class="btnTop" width="160" height="26"
					onclick="fncGoStaffPage(${shopVo.shopId});return false;">Log-out</td>
			</tr>
			<tr>
				<td height="44" colspan="5">
					<div class="head_title">
						Gallery Eyewear</br>
						Cloud System
					</div>
				</td>
			</tr>
			<tr>
				<td height="24" colspan="5">&nbsp;</td>
				</td>
			</tr>
			
			<tr>
			
			<td colspan="5">
			<input type="button" href="#" onclick="fncGoCstmrSearchPage();return false;" class="btnFindCstrm" value="회 원 찾 기">
				<!-- <td height="63" onclick="fncGoCstmrSearchPage();return false;"
					colspan="5" bgcolor="#0000CF" class="title2">회원 찾기</td> -->
			</td>
			</tr>
			
		</table>
		</div>
		
		<div class="transBoxTable">
		<div id="listVisitingCstmrDiv"></div>
		</div>

	</center>
	<div id='popupNotice'></div>	
</body>
</html>


