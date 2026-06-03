<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/cstmrHstryLib.jsp"%>

<!-- <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
 -->
<script>
	//----------------------
	//화면 초기 실행 
	
	jQuery(document).ready(function(){
		getPaymentedPrdctListData();
		getCstmrMemo();
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
	
	
	function getPaymentedPrdctListData(){
		var url = '${ctxPath}/cstmrHstry/listPaymentedPrdctData.do';
		
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: 'cstmrId='+'${cstmrId}'+'&saleId='+g_saleId,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listPaymentedPrdctDivH').html(data);
			}
		});  
	}
	
	function fncSelectCstmr(cstmrCd){
		mCstmrCd=cstmrCd;
	};
	function fncCancel(){
		jQuery('#dialog').dialog( 'close' );
		jQuery('#dialog').html('');
	};
	
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

	function fncPaymentSave(point){
		//console.log("Run fncPaymentSave");
		var url = '${ctxPath}/prdct/updatePayment.do';
		
		var payCard = document.getElementById("card_txt").value;
		var payCash = document.getElementById("cash_txt").value;
		var payPoint = document.getElementById("point_txt").value;
		if(point==POINT_CHANGE && (payCard!=0||payCash!=0||payPoint!=0))
		{
			alert("포인트카드 변경 전에 저장 후 이동합니다. 결제 금액을 제외시켜 주십시오.");
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
			//console.log("cardTy:"+cardTy);
			//console.log("cardDate:"+cardDate);
			
			if((cardTy=="-1")||(cardDate==""))
			{
				alert("카드 결제 정보가 누락되었습니다.");
				return;
			}
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
		//console.log("earnPrcnt"+earnPrcnt);
		
		/* if(payCard == "" && payCash == "" && payPoint == ""
			&& '${saleVoH.partnerDscnt}'==partnerDscnt && '${saleVoH.partnerId}'==partnerId
			&& '${saleVoH.etcDscnt}'==etcDscnt && '${saleVoH.etcDscntMemo}'==etcDscntMemo)
		{
			alert("변경된 값이 없습니다.");
			return ;
		} */

		var pennyPrice = document.getElementById("penny_txt").lastChild.textContent;
		pennyPrice = removeCommas(pennyPrice);
		//console.log("pennyPrice:"+pennyPrice);
		
		if (pennyPrice<0){
			alert("결제 금액이 초과되었습니다.");
			return ;
		}
		
		var earnPoint;
		earnPoint = document.getElementById("point_total_txt").lastChild.textContent;
		//console.log("earnPoint1:"+earnPoint);
		earnPoint = removeCommas(earnPoint);
		//console.log("earnPoint2:"+earnPoint);
		
		if(pennyPrice > 0) // 포인트는 최종 계산때만 적립.
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

		for(var i=0,size=arrPrdctId.length;i<size;i++){
			strPrdctId += arrPrdctId[i]+",";
			strPrdctDscnt += mapDscntPrcnt[arrPrdctId[i]]+",";
			strPrdctEarn += mapEarnPrcnt[arrPrdctId[i]]+",";
			//console.log("mapPntUsingChk[arrPrdctId[i]]"+mapPntUsingChk[arrPrdctId[i]]);
			if("undefined" == typeof mapPntUsingChk[arrPrdctId[i]])
			{strPrdctUsing += "0"+",";}	

			else
			{strPrdctUsing += mapPntUsingChk[arrPrdctId[i]]+",";}
		}
		//console.log("strPrdctUsing:"+strPrdctUsing);
		/* console.log("arrPrdctIdN.length:"+arrPrdctIdN.length);
		console.log("arrPrdctIdN:"+arrPrdctIdN);
		
		for(var i=0,size=arrPrdctIdN.length;i<size;i++)
		{
			strPrdctIdNew += arrPrdctIdN[i]+",";
			strPrdctDscntNew += mapDscntPrcntNew[arrPrdctIdN[i]]+",";
			strPrdctEarnNew += mapEarnPrcntNew[arrPrdctIdN[i]]+",";
		} */

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
						+"&cardTy="+cardTy+"&cardDate="+cardDate
						,
			dataType	: "text",
			success: function(data){
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

	var memo = false;
	function showMemo(){
		if(!memo){
			$("#memo_txt").slideDown(500);
			$("#memo").text("접기");
			memo = true;
		}else{
			
			$("#memo").text("메모");
			memo = false;
			cstmrMemoUpdate();	
			$("#memo_txt").slideUp(500);
		}
	}
	
	function getCstmrMemo(){
	var url = '${ctxPath}/cstmr/getCstmrMemo.do';
	 
	//javax
	 $.ajax({
		url		: url,
		type 	: "post",
		data : "cstmrId=" + '${cstmrId}',
		dataType	: "text",
		beforeSend	: function(){
		},
		success: function(data){
			$("#memo_txt").html(decodeURIComponent(data));
		}
	});
}

function removeCommas(str) {
    return(str.replace(/,/g,''));
}
  
function cstmrMemoUpdate(){
	var url = '${ctxPath}/cstmr/cstmrMemoUpdate.do';
	var memo = $("#memo_txt").val();
	//javax
	 $.ajax({
		url		: url,
		type 	: "post",
		data : "memo=" + memo + "&cstmrId=" + '${cstmrId}',
		dataType	: "text",
		beforeSend	: function(){
		},
		success: function(data){
		}
	}); 
}
</script> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<title>Payment Page</title>
<style>
	#btn1	{
		height: 40px;
	}
	#memo{
		height: 50px;
		width: 50px;
	}
	#memo_txt{
		display: none;
	}

</style>
</head>

<body>
	<br>
    <div id='listPaymentedPrdctDivH' style="font-size: 13px;">
    </div>
    <br>
    <br>
</body>
</html>