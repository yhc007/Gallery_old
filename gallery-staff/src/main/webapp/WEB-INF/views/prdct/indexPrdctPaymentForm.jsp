<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script type="text/javascript">

	var cstmrId = '${cstmrId}';
	var pageUrl='${ctxPath}/prdct/indexPrdctProcessForm.do';
	var pop = window.sessionStorage.getItem("popup");
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		var pop = window.sessionStorage.getItem("popup");
		if(pop==1){
			//newWindow();
		}else{
			getPaymentedPrdctListData();

		};
	});
	
	// global Varable----------------------
	var mCstmrCd;
	
	var mapCnt = {};
	var mapPrc = {};
	var mapDscntPrcnt = {};
	var mapEarnPrcnt = {};
	var mapPntUsingChk = {};
	var arrPrdctId = new Array();
	var POINT_CHANGE = 1;
	var JUST_SAVE = 0;
	var chkUseCoupon = 0;
	
	//for Lens
/* 	var mapCntL = {};
	var mapPrcL = {};
	var mapDscntPrcntL = {};
	var mapEarnPrcntL = {};
	var arrPrdctIdL = new Array();
	
	//for Clens
	var mapCntC = {};
	var mapPrcC = {};
	var mapDscntPrcntC = {};
	var mapEarnPrcntC = {};
	var arrPrdctIdC = new Array();
	
	//for Acc
	var mapCntA = {};
	var mapPrcA = {};
	var mapDscntPrcntA = {};
	var mapEarnPrcntA = {};
	var arrPrdctIdA = new Array();
	
	//for NewItem
	var mapCntN = {};
	var mapPrcN = {};
	var mapDscntPrcntN = {};
	var mapEarnPrcntN = {};
	var arrPrdctIdN = new Array(); */
	
	function fncSelectCstmr(cstmrCd){
		mCstmrCd=cstmrCd;
	};
	function fncCancel(){
		jQuery('#dialog').dialog( 'close' );
		jQuery('#dialog').html('');
	};
	
	 function getPaymentedPrdctListData(){
		var url = '${ctxPath}/prdct/listPaymentedPrdctData.do';
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: 'cstmrId='+'${cstmrId}'+'&saleId='+'${saleVo.saleId}',
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listPaymentedPrdctDiv').html(data);
			}
		});  
	}


	//init
	function goCstmrListPage(){
		var form=document.createElement("form");
		form.name='tempPost';
		form.method='post';
		form.action='${ctxPath}/cstmr/cstmrListForm.do';

		var param = document.createElement("input");
		param.setAttribute("type", "hidden");
		param.setAttribute("name", "cstmrName");
		param.setAttribute("value", jQuery('#cstmrSearchForm input[name=cstmrName]').val());
		$(form).append(param);
		$('body').append(form);
		form.submit();
	};
	
	
	function fncSelect(prdctId){
		
		var listCheckBox = document.getElementById('listCheckBox');
		var param=jQuery('#checkForm').serialize();
	}
	function fncPaymentSaveTest(){
		var payCard = document.getElementById("card_txt").value;
		var cardTy = document.getElementById("slct_card_com").value;
		var cardDate = document.getElementById("card_date").value;
		console.log('payCard:'+payCard);
		
		if( payCard!='0'){
			
			console.log("cardTy:"+cardTy);
			console.log("cardDate:"+cardDate);
			if((cardTy=="12")||(cardDate==""))
			{
				alert("카드 결제 정보가 누락되었습니다.");
				return;
			}
		}else{
			console.log("payCard is empty");
			console.log("cardTy:"+cardTy);
			console.log("cardDate:"+cardDate);
		}
		
	}

	var paymentIng=false;
	function fncPaymentSave(point){
		
		if(chkUseCoupon==1){
			//useCoupon();
			var txtCouponCd=0;
			
			txtCouponCd = document.getElementById("couponCd").value;
			if (txtCouponCd) {
				//console.log("txtCouponCd1:"+txtCouponCd);
			}else if(txtCouponCd = $('#txtCouponCd').text()){
				//console.log("txtCouponCd2:"+txtCouponCd);
			}
			console.log("CouponCd:"+txtCouponCd);
			if(!txtCouponCd)
			{
				alert("쿠폰번호가 유효하지 않아 사용하실 수 없습니다.");
				return;
			}
		}
		if($("#couponCd").val()!=""){
			//useOthrPrsnCpn();
		}
		if(paymentIng==true)
		{
			alert('중복 입력 방지 중입니다. 아닐 경우 새로고침 해주십시오.');
			return;
		}
		paymentIng=true;
		var url = '${ctxPath}/prdct/updatePayment.do';
		
		var payCard = document.getElementById("card_txt").value;
		var payCash = document.getElementById("cash_txt").value;
		var payPoint = document.getElementById("point_txt").value;
		if(point==POINT_CHANGE && (payCard!=0||payCash!=0||payPoint!=0))
		{
			alert("포인트카드 변경 전에 저장 후 이동합니다. 결제 금액을 제외시켜 주십시오.");
			paymentIng=false;
			return;
		}
		//var fmlyCd = document.getElementById("fmly_cd_txt").lastChild.textContent;
		var fmlyCd = document.getElementById("fmly_cd_txt").lastChild.textContent;

		var cardTy = document.getElementById("slct_card_com").value;
		var cardDate = document.getElementById("card_date").value;
		
		if((payCard=="")||(payCard==null)){
			payCard = 0;
		}
		if(payCard!='0'){
			console.log("cardTy:"+cardTy);
			console.log("cardDate:"+cardDate);

			if((cardTy=="12")||(cardDate==""))
			{
				alert("카드 결제 정보가 누락되었습니다.");
				paymentIng=false;
				return;
			}
		}else{
			cardData="";
		}
		
		
		if((payCash=="")||(payCash==null)){
			payCash = 0;
		}
		if((payPoint=="")||(payPoint==null)){
			payPoint = 0;
		}
		
		var partnerDscnt = document.getElementById("partnerDscnt_txt").value;
		
		var e = document.getElementById("slctPartner");
		var selected = e.options[e.selectedIndex].value;
		partner = selected.split('@');
		partnerId = partner[0];
		
		//var dscntPrice = document.getElementById("dscnt_price_txt").lastChild.textContent;
		var dscntPrice = document.getElementById("dscnt_total_txt").lastChild.textContent;
		
		dscntPrice = removeCommas(dscntPrice);
		
		var etcDscnt = document.getElementById("etcDscnt_txt").value;
		var etcDscntMemo = document.getElementById("etcDscntMemo_txt").value;
		
		var earnPrcnt = document.getElementById("earnAll_number").value;
		console.log("earnPrcnt"+earnPrcnt);
		
		/* if(payCard == "" && payCash == "" && payPoint == ""
			&& '${saleVo.partnerDscnt}'==partnerDscnt && '${saleVo.partnerId}'==partnerId
			&& '${saleVo.etcDscnt}'==etcDscnt && '${saleVo.etcDscntMemo}'==etcDscntMemo)
		{
			alert("변경된 값이 없습니다.");
			return ;
		} */

		var pennyPrice = document.getElementById("penny_txt").lastChild.textContent;
		pennyPrice = removeCommas(pennyPrice);
		console.log("pennyPrice:"+pennyPrice);
		
		if (pennyPrice<0)
		{
			alert("결제 금액이 초과되었습니다.");
			paymentIng=false;
			return ;
		}
		
		var earnPoint;
		earnPoint = document.getElementById("point_total_txt").lastChild.textContent;
		console.log("earnPoint1:"+earnPoint);
		earnPoint = removeCommas(earnPoint);
		console.log("earnPoint2:"+earnPoint);
				
		var strResult = '${saleVo.result}';
		var strPayResult = strResult.substr(3,1);

		if(pennyPrice > 0 || strPayResult=='1') // 포인트는 최종 계산때 한번만 적립.
		{
			earnPoint = 0;
		}

		var strPrdctId = "";
		var strPrdctDscnt = "";
		var strPrdctEarn = "";
		var strPrdctUsing ="";
		
		//var strPrdctIdNew = "";
		//var strPrdctDscntNew = "";
		//var strPrdctEarnNew = "";

		for(var i=0,size=arrPrdctId.length;i<size;i++)
		{
			if("undefined" == typeof arrPrdctId[i])
			{strPrdctId += "0"+",";}
			else
			{strPrdctId += arrPrdctId[i]+",";}
			
			console.log("mapDscntPrcnt[arrPrdctId[i]]"+mapDscntPrcnt[arrPrdctId[i]]);
			if("undefined" == typeof mapDscntPrcnt[arrPrdctId[i]])
			{strPrdctEarn += "0"+",";}
			else
			{strPrdctDscnt += mapDscntPrcnt[arrPrdctId[i]]+",";}
			
			if("undefined" == typeof mapEarnPrcnt[arrPrdctId[i]])
			{strPrdctEarn += "0"+",";}
			else
			{strPrdctEarn += mapEarnPrcnt[arrPrdctId[i]]+",";}
			
			console.log("mapPntUsingChk[arrPrdctId[i]]"+mapPntUsingChk[arrPrdctId[i]]);
			if("undefined" == typeof mapPntUsingChk[arrPrdctId[i]])
			{strPrdctUsing += "0"+",";}
			else
			{strPrdctUsing += mapPntUsingChk[arrPrdctId[i]]+",";}
		}
		console.log("strPrdctUsing:"+strPrdctUsing);
		/* console.log("arrPrdctIdN.length:"+arrPrdctIdN.length);
		console.log("arrPrdctIdN:"+arrPrdctIdN);
		
		for(var i=0,size=arrPrdctIdN.length;i<size;i++)
		{
			strPrdctIdNew += arrPrdctIdN[i]+",";
			strPrdctDscntNew += mapDscntPrcntNew[arrPrdctIdN[i]]+",";
			strPrdctEarnNew += mapEarnPrcntNew[arrPrdctIdN[i]]+",";
		} */

		var dateTile = window.sessionStorage.getItem("dateTile");

		//console.log("dateTile:"+dateTile);
		//param = jQuery('#checkForm').serialize()+"&dateTile=" + dateTile;

		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: "payCard="+payCard+"&payCash="+payCash+"&payPoint="+payPoint+"&pennyPrice="+pennyPrice
						+"&partnerDscnt="+partnerDscnt+"&partnerId="+partnerId+"&dscntPrice="+dscntPrice
						+"&earnPoint="+earnPoint+"&earnPrcnt="+earnPrcnt
						+"&etcDscnt="+etcDscnt+"&etcDscntMemo="+etcDscntMemo+"&fmlyCd="+fmlyCd+"&cstmrId="+'${cstmrId}'
						+"&strPrdctId="+strPrdctId+"&strPrdctDscnt="+strPrdctDscnt
						+"&strPrdctEarn="+strPrdctEarn+"&strPrdctUsing="+strPrdctUsing
						/* +"&strPrdctIdNew="+strPrdctIdNew+"&strPrdctDscntNew="+strPrdctDscntNew+"&strPrdctEarnNew="+strPrdctEarnNew */
						+"&cardTy="+cardTy+"&cardDate="+cardDate+"&chkUseCoupon="+chkUseCoupon+"&couponCd="+txtCouponCd
						+"&dateTile="+dateTile,
			dataType	: "text",
			success: function(data){
				paymentIng=false;
				
				if(data=="success"){
					alert("저장 완료.");
					//writable=false;
					//getVisitList();
					if(point == POINT_CHANGE)
					{location.replace("${ctxPath}/cstmr/searchFmlyCd.do");}
					else
					{location.replace("${ctxPath}/prdct/indexPrdctPaymentForm.do");}
					
				}else if(data=="fail"){
					alert('<spring:message code="fail"/>');
				}				
			}
		});
	}

/* function fncChckBoxTest()
{
	var inputElements = document.getElementsByName("isEarn_chkBox");
	var len;
	if(inputElements.length == undefined){
		len = 1;
	}else{
		len = inputElements.length;
	}
	console.log("fncChckBoxTest:"+len);
	len = parseInt(len);
	for ( var i = 0; i < len; ++i) {
		if (inputElements[i].className == "isEarn_chkBox"
				&& inputElements[i].checked) {
			return "checked";
		}else{
			return "unchecked";
		}
	}
} */

function removeCommas(str) {
    return(str.replace(/,/g,''));
}
  

function changeHashOnLoad() {
	window.location.href += "#";
	setTimeout("changeHashAgain()", "50"); 
	}

function changeHashAgain() {
window.location.href += "1";
}

var storedHash = window.location.hash;

window.setInterval(function () {
	if (window.location.hash != storedHash) {
		window.location.hash = storedHash;
	}
	}, 50);
	
</script> 



	

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<title>Payment Page</title>
<style>
	
</style>
</head>

<body onload="changeHashOnLoad(); ">
<center>

	<div class="transBoxTable">
	    <div id='listPaymentedPrdctDiv' >
	    </div>
	    <img id='imgSave' onclick="fncPaymentSave(JUST_SAVE);" src="<c:url value="/images/content/save.png" />"
		onmousedown="this.src='<c:url value="/images/content/savepush.png" />'"
		onmouseup="this.src='<c:url value="/images/content/save.png" />'" width="72" height="72" />
    </div>
    
    
  
  <br><br>
 
</center>
</body>
</html>

