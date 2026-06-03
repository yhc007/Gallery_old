<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file='/WEB-INF/views/include/staffLib.jsp'%>

<style>
 #dscnt_total_txt_hstry{
 	font-weight: bold;
 }
</style>
<script type="text/javascript">


$("input:checkbox").each(function(index) {
    $("<label>").text("")
                .attr("for", this.id = "checkbox" + index + 1)
                .insertAfter(this);
});

var g_total = 0;
var g_dscntTotal = 0;
var g_pointTotal = 0;
var g_remainedPayment = 0;
var g_penny = 0;
var prePayment = 0;

var etcDscnt = 0;
var partnerDscnt = 0;
var partnerId ;
var partnerCert ;
var partnerMemo ;

var pointValue;
var fmlyCd;

var totalPrice4Point=0;
var prdctsPrice = 0;

var CHANGE=1;
var NO_CHANGE=0;
var ALL_CHECKED=2;
var ALL_UNCHECKED=3;
var USING = 1;
var NOT_USING = 0;

var TY_FRAME=1;
var TY_LENS=2;
var TY_CLENS=3;
var TY_ACC=4;

jQuery(document).ready(function(){
	$("#slct_card_com2").text($("#slct_card_com option:selected").text());
	$("#slctPartner2").text($("#slctPartner option:selected").text());
	if('${saleVoH.partnerDscnt}' !=0)
	{
		partnerDscnt ='${saleVoH.partnerDscnt}'; 
	}else{
		partnerDscnt = 0;
	}
	
	
	if('${saleVoH.etcDscnt}' != 0)
	{
		etcDscnt ='${saleVoH.etcDscnt}'; 
	}else{
		etcDscnt = 0;
	}
	$("#etcDscnt_txt").text(format2(etcDscnt));
	
	
	var initPayCash = '${saleVoH.payCash}';
	var initPayCard = '${saleVoH.payCard}';
	var initPayPoint = '${saleVoH.payPoint}';
	var initCardDate = '${saleVoH.cardDate}';
	var initCardName = '${saleVoH.cardName}';

	//console.log('initPayCash:'+initPayCash);
	//console.log('initPayCard:'+initPayCard);
	//console.log('initPayPoint:'+initPayPoint);
	//console.log('initCardDate:'+initCardDate);
	//console.log('initCardName:'+initCardName);


	//document.getElementById("card_date").value = initCardDate;
 	$("#cash_txt").text(format2(initPayCash));
 	$("#card_txt").text(format2(initPayCard));
 	$("#point_txt").text(format2(initPayPoint));
 	$("#card_name_txt").text(initCardName);
 	$("#card_date_txt").text(initCardDate);
	
	var etcDscntMemo;
	if('${saleVoH.etcDscntMemo}'!== undefined)
	{
		etcDscntMemo = '${saleVoH.etcDscntMemo}';
	}
	
	//fncCardDate_init();
	
	$("#etcDscntMemo_txt2").text(etcDscntMemo);
	$("#earnAll_number").text('${saleVoH.earnPrcnt}');
	//prePayment = '${saleVoH.payCard+saleVoH.payCash+saleVoH.payPoint}';
	prePayment = 0;
	getCstmrPoint();
});
function format2(n) {
	  var reg = /(^[+-]?\d+)(\d{3})/;   
	  n += '';                          

	  while (reg.test(n))
	    n = n.replace(reg, '$1' + ',' + '$2');

	  return n;
	}

function newWindow(){
	var url = "${ctxPath}/cstmrHstry/indexCstmrHstryForm.do";
	
	$.ajax({
		url : url,
		dataType : "html",
		type : "post",
		success : function(data){
			//console.log(data);
			jQuery('#cstmrHist').html('');
			jQuery('#cstmrHist').dialog('destory');

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

					 	  

					  $('#body').append(form); 

					  form.submit();
				}, success:  function(data) {
					
				} 
			});
			}
	});
}
function fncCardDate_init(){
	var date = new Date();

	var day = date.getDate();
	var month = date.getMonth() + 1;
	var year = date.getFullYear();

	if (month < 10) month = "0" + month;
	if (day < 10) day = "0" + day;

	var today = year + "-" + month + "-" + day;       
	$("#card_date").text(today);
}


function fncSum_init(prc) {
	g_total += parseInt(prc);
	g_total = Math.round(g_total);
	//console.log("g_total:"+g_total);
	document.getElementById("total_txt_hstry").innerHTML = format(String(g_total));
}

function fncPointSum_init(prc,cnt,dscnt,earn) {
	var point = prc*cnt*((100-dscnt)/100)*(earn/100);
	g_pointTotal += parseInt(point);
	g_pointTotal = Math.round((g_pointTotal*100)/100.0);
	var tmp_point = g_pointTotal-g_pointTotal%100;
	document.getElementById("point_total_txt").innerHTML = format(String(tmp_point));
	//document.getElementById("point_total_txt").innerHTML = format(String(g_pointTotal));
}

function fncPointSum_init_final() {
	var nPoint = removeComma($("#point_txt").text());
	var etcDscnt = removeComma($("#etcDscnt_txt").text());
	var earnPrcnt = '${saleVoH.earnPrcnt}';
	earnPrctn = Number(earnPrcnt);
	
	if(nPoint=='undefined')
	{ nPoint = 0;}
	if(etcDscnt=='undefined')
	{ etcDscnt = 0;}
	
	//console.log('nPoint:'+nPoint);
	//console.log('etcDscnt:'+etcDscnt);
	//console.log('earnPrcnt:'+earnPrcnt);
	
	g_pointTotal -= etcDscnt*(earnPrcnt/100);
	g_pointTotal -= nPoint*(earnPrcnt/100);
	g_pointTotal = Math.round((g_pointTotal*100)/100.0);
 	
	var tmp_point = g_pointTotal-g_pointTotal%100;
	document.getElementById("point_total_txt").innerHTML = format(String(tmp_point));
}

/* function fncDscntSum_init(prc,cnt,prcnt) {
	var dscnt = prc*cnt*((100-prcnt)/100);
	g_dscntTotal += parseInt(dscnt);
	g_dscntTotal=Math.round(g_dscntTotal);
	document.getElementById("dscnt_total_txt_hstry").innerHTML = format(String(g_dscntTotal));
} */

function fncDscntSum_init(prc,cnt,prcnt) {
	
	var dscnt = prc*cnt*((100-prcnt)/100);
	dscnt=Math.round(dscnt);
	g_dscntTotal += parseInt(dscnt);
	//console.log("dscnt:"+dscnt);
	//console.log("g_dscntTotal:"+g_dscntTotal);
	g_dscntTotal=Math.round(g_dscntTotal);
	//console.log("@g_dscntTotal:"+g_dscntTotal);
	document.getElementById("dscnt_total_txt_hstry").innerHTML = format(String(g_dscntTotal));
}


function fncCalcPointSum(){
	//console.log("Run fncCalcPoitnSum");
	g_pointTotal=0;
	
	var cnt;
	var prc;
	var dscntPrcnt;
	var earnPrcnt;
	var allEarnPrcnt=$("#earnAll_number").text();
	var nPoint = removeComma($("#point_txt").text());
	
	for(var i=0 ; i < arrPrdctId.length ; i++){
		cnt = mapCnt[arrPrdctId[i]];
		prc =  mapPrc[arrPrdctId[i]];
		dscntPrcnt = mapDscntPrcnt[arrPrdctId[i]];
		earnPrcnt = mapEarnPrcnt[arrPrdctId[i]];
		g_pointTotal +=	(((cnt*prc))*((100-dscntPrcnt)/100)*(earnPrcnt/100)); 
	};
	g_pointTotal -= etcDscnt*(earnPrcnt/100);
	g_pointTotal -= nPoint*(earnPrcnt/100);
 	g_pointTotal = Math.round((g_pointTotal*100)/100.0);
 	
	var tmp_point = g_pointTotal-g_pointTotal%100;	
	document.getElementById("point_total_txt").innerHTML = format(String(tmp_point));

 	//document.getElementById("point_total_txt").innerHTML = g_pointTotal;
}
function fncCalcPointSumBeforeUsing(usingPoint){
	g_pointTotal=0;
	
	
	var payment4Point=0;
	for(var i=0 ; i < arrPrdctId.length ; i++){
		var cnt = mapCnt[arrPrdctId[i]];
		var prc =  mapPrc[arrPrdctId[i]];
		var dscntPrcnt = mapDscntPrcnt[arrPrdctId[i]];
		var earnPrcnt = mapEarnPrcnt[arrPrdctId[i]];
		//payment4Point += cnt*prc*((100-dscntPrcnt)/100);
		g_pointTotal +=	((cnt*prc)*((100-dscntPrcnt)/100)*(earnPrcnt/100));
	};
	g_pointTotal -= etcDscnt*(earnPrcnt/100);

 	g_pointTotal = Math.round((g_pointTotal*100)/100.0);
 	console.log("g_pointTotal:" + g_pointTotal);
	var tmp_point = g_pointTotal-g_pointTotal%100;

	document.getElementById("point_total_txt").innerHTML = format(String(tmp_point));

 	//document.getElementById("point_total_txt").innerHTML = (g_pointTotal);
}

function fncCalcDscntSum(){
	g_dscntTotal=0;
	
	var cnt;
	var prc;
	var dscntPrcnt;
	
	for(var i=0 ; i < arrPrdctId.length ; i++){
		cnt = mapCnt[arrPrdctId[i]];
		prc =  mapPrc[arrPrdctId[i]];
		dscntPrcnt = mapDscntPrcnt[arrPrdctId[i]];
		g_dscntTotal +=	(cnt*prc*((100-dscntPrcnt)/100));
	};
 	
/*  	for (var j=0 ; j < arrPrdctIdN.length ; j++)
	{
		cnt = mapCntN[arrPrdctIdN[j]];
		prc =  mapPrcN[arrPrdctIdN[j]];
		dscntPrcnt = mapDscntPrcntN[arrPrdctIdN[j]];
		g_dscntTotal +=	(cnt*prc*((100-dscntPrcnt)/100));
	}
 */
 	g_dscntTotal=Math.round(g_dscntTotal);
 	//console.log("on fncCalcDscntSum - innerHTML");
 	document.getElementById("dscnt_total_txt_hstry").innerHTML = format(String(g_dscntTotal));
 	calcRemainedPayment();
} 

function removeComma(str){
	var result = str.replace(/,/gi,"");
	
	return result;
}

function calcPrice() {
	var nCard = removeComma($("#card_txt").text());
	var nCash = removeComma($("#cash_txt").text());
	var nPoint = removeComma($("#point_txt").text());
	
	if(!nCard){nCard = 0;}
	if(!nCash){nCash = 0;}
	
	var g_penny = g_remainedPayment-nCard-nCash-nPoint;
	Math.round(g_penny);
	document.getElementById("penny_txt").innerHTML = format(String(g_penny));
}

function calcLimit(){
	var nPoint = $("#point_txt").text();
	/* if (0 > (pointValue - nPoint))
	{
		alert("가용 포인트를 초과하였습니다.");
		document.getElementById("point_txt").value=0;
		return;
	}
	if(0 > (totalPrice4Point-nPoint))
	{
		alert("포인트 사용 가능한 물품 가격 합인 "+totalPrice4Point+"원 을 초과하였습니다.");
		document.getElementById("point_txt").value=0;
		return;
	} */
	//fncCalcPointSumBeforeUsing(nPoint);
	var nEarnPoint = document.getElementById("point_total_txt").innerHTML;
	//nEarnPoint = removeCommas(nEarnPoint);
	var point_total_final_txt = nEarnPoint;
	Math.round(point_total_final_txt);
	//document.getElementById("point_total_final_txt").innerHTML = format(String(point_total_final_txt));
	calcPrice();
	fncCalcPointSum();
}
function setEtcDscnt(){
	console.info("run setEtcDscnt");
	$("#etcDscnt_txt").text(); 
	calcRemainedPayment();
	fncCalcPointSum();
}

function calcTotalPrice4Point()
{
	//console.log("run calcTotalPrice4Point");
	totalPrice4Point=0;
	
	var cnt;
	var prc;
	var dscntPrcnt;
	var earnPrcnt;
	
	for(var i=0 ; i < arrPrdctId.length ; i++){
		//console.log("mapPntUsingChk[arrPrdctId[i]]:"+mapPntUsingChk[arrPrdctId[i]]);
		if(mapPntUsingChk[arrPrdctId[i]]!=1)
		{continue;}
		cnt = mapCnt[arrPrdctId[i]];
		prc =  mapPrc[arrPrdctId[i]];
		dscntPrcnt = mapDscntPrcnt[arrPrdctId[i]];
		earnPrcnt = mapEarnPrcnt[arrPrdctId[i]];
		totalPrice4Point +=	(((cnt*prc)-etcDscnt)*((100-dscntPrcnt)/100));
	};
	
	document.getElementById("limit_point_txt").innerHTML = format(String(totalPrice4Point));
}

function fncChckBoxTest(name)
{
	var nameChkbox = name;
	var inputElements = document.getElementsByName(nameChkbox);
	var len;
	if(inputElements.length == undefined){
		len = 1;
	}else{
		len = inputElements.length;
	}
	len = parseInt(len);
	var arrChecked = new Array();
	for ( var i = 0; i < len; ++i) {
		if (inputElements[i].className == "isEarn_chkBox" && inputElements[i].checked) {
			arrChecked.push(inputElements[i].value+',checked');
		}else{
			arrChecked.push(inputElements[i].value+',unChecked');
		}
	}
	return arrChecked;
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function setDscnt(sel){
	var partnerValue = sel.options[sel.selectedIndex].value;
	partner = partnerValue.split('@');
	partnerId = partner[0];
	var dscntPrcnt = partner[1];
	partnerCert = partner[2];
	partnerMemo = partner[3];
	
	$("#partnerDscnt_txt").text(dscntPrcnt);
	
	changeAllDscnt(dscntPrcnt);
	//setEtcDscnt();
	return ;
}
	
function format(number) {
	var pattern = /(-?[0-9]+)([0-9]{3})/;
	 
	while(pattern.test(number)) {
	  number = number.replace(pattern,"$1,$2");
	}

	return number;
}
function showPartnerInfo(){
	if(partnerId == undefined && partnerCert == undefined && partnerMemo == undefined)
	{
		alert("협력사 선택 후 정보 열람이 가능합니다.");
		return;
	}
	
	 jQuery('#dlgPartnerInfo').html('');
	 jQuery('#dlgPartnerInfo').html(
	 "<html><body><table border='1' width='100%'><tr><td align='center' style='height: 50%; width: 20%; font-size: 15px'>제휴 조건</td><td align='center'><p id='partner_cert' name='partner_cert' style='height: 50%; width: 80%; font-size: 15px'></p></td></tr><tr><td align='center' style='height: 50%; width: 20%; font-size: 15px'>기타사항</td><td align='center'><p id='partner_memo' name='partner_memo' style='height: 50%; width: 80%; font-size: 15px'></p></td></tr></table></body></html>"
	 );
	document.getElementById("partner_cert").innerHTML = partnerCert;
	document.getElementById("partner_memo").innerHTML = partnerMemo;
	
	 jQuery('#dlgPartnerInfo').dialog({
	 //bgiframe: true
	 title: "제휴 정보"
	 , modal: true
	 , width: 600 // 가로 크기
	 , height : 150
	 , background: "#000"
	 , success:  function(data) {
	 } 
	 });
}
function fncGetPointHistory()
{
	jQuery.ajax({  
		url: '${ctxPath}/point/listPointHist.do'
		, type: "POST"
		, data 	: "fmlyCd="+'${cstmrVo.fmlyCd}'
		, dataType: "html"
		, success:  function(data) {
			jQuery('#dlgPointHist').html(data);
		}	
	});	// end ajax	
	jQuery('#dlgPointHist').dialog({
		//bgiframe: true
		 title: "포인트 내역"
		 , modal: true
	     , width: 900 // 가로 크기
	     , background: "#000"
	     , position:{my:"center",at:"top" }
		 , close: function(event, ui){
		}, success:  function(data) {
			
		} 
	});	
}
/* function fncSearchFmlyCd()
{
	//location.replace("${ctxPath}/cstmr/searchFmlyCd.do");
	fncPaymentSave(POINT_CHANGE);
	//move after save.
	//location.href="${ctxPath}/cstmr/searchFmlyCd.do";
} */

function getCstmrPoint(){
	var url = '${ctxPath}/point/getCstmrPoint.do';
	
	$.ajax({
		url		: url,
		type 	: "post",
		data : "cstmrCd=" + '${cstmrVo.cstmrCd}'+"&fmlyCd="+'${cstmrVo.fmlyCd}',
		dataType	: "text",
		beforeSend	: function(){
		},
		success: function(data){
			var rtnData = decodeURIComponent(data);
			var pointParser = rtnData.split(',');
			pointValue = pointParser[0];
			fmlyCd = pointParser[1];
			var fmlyName = pointParser[2];
			
			document.getElementById("total_point_txt").innerHTML = format2(pointValue);
			document.getElementById("fmly_name_txt").innerHTML = fmlyName;
			
			document.getElementById("total_point_txt1").innerHTML = format2(pointValue);
			document.getElementById("fmly_name_txt1").innerHTML = fmlyName;
			
			//document.getElementById("total_point_txt2").innerHTML = pointValue;
			//document.getElementById("fmly_name_txt2").innerHTML = fmlyName;
			
			document.getElementById("fmly_cd_txt").innerHTML = fmlyCd;
			return;
		}
	}); 
};

function changeDscntPrcnt(prcnt,prdctId)
{
	//console.log("prdctId:"+prdctId);
	if(isNaN(prcnt))
	{
		//console.log("isNaN True");
		//console.log("prcnt:"+prcnt);
		prcnt = prcnt.value;		
	}else{
		//console.log("isNaN False");
	}

	var cnt=0;
	var prc=0;

	mapDscntPrcnt[prdctId]=prcnt;
	cnt = mapCnt[prdctId];
	prc = mapPrc[prdctId];

	var dscntPrice = prc*cnt*((100-prcnt)/100);
	dscntPrice = Math.round(dscntPrice);
	document.getElementById("dscntPrice"+prdctId).innerHTML = format(String(dscntPrice));
	
	fncCalcDscntSum();

	changePointPrcnt(prdctId, NO_CHANGE);
}

function changePointPrcnt(prdctId,change)
{
	var prcnt=$("#earnAll_number").text();
	//console.log("change:"+change);
	
	if(change==CHANGE && mapEarnPrcnt[prdctId]==prcnt)
	{mapEarnPrcnt[prdctId]=0;}
	else if(change==CHANGE && mapEarnPrcnt[prdctId]!=prcnt)
	{mapEarnPrcnt[prdctId]=prcnt;}
	else if(change==ALL_CHECKED)
	{mapEarnPrcnt[prdctId]=prcnt;}
	else if(change==ALL_UNCHECKED)
	{mapEarnPrcnt[prdctId]=0;}
	
	var cnt = mapCnt[prdctId];
	var prc = mapPrc[prdctId]; 
	
	var dscntPrice = prc*cnt*((100-mapDscntPrcnt[prdctId])/100);
	dscntPrice = Math.round(dscntPrice);
	//console.log("dscntPrice:"+dscntPrice);
	var pointPrice = (dscntPrice)*(mapEarnPrcnt[prdctId]/100);
	//console.log("pointPrice:"+pointPrice);
	pointPrice = Math.round(pointPrice);
	
	//console.log("on changePointPrcnt innerHTML value : "+document.getElementById("pointPrice"+prdctId));
	document.getElementById("pointPrice"+prdctId).innerHTML = format(String(pointPrice));
	
	fncCalcPointSum();
	//calcTotalPrice4Point();
	//calcLimit();
}


function changeAllPoint(prcnt)
{
	var els=document.getElementsByName("point_prcnt_number2");
	
	//console.log("prcnt"+prcnt);

	for (var i=0;i<els.length;i++) { els[i].value = prcnt.value; }
 	for (var j=0 ; j < arrPrdctId.length ; j++)
	{
		//console.log("arrPrdctId["+j+"]:"+arrPrdctId[j]);
		changePointPrcnt(arrPrdctId[j]);
	}
 	/* for (var j=0 ; j < arrPrdctIdN.length ; j++)
	{
		console.log("arrPrdctIdN["+j+"]:"+arrPrdctIdN[j]);
		changePointPrcntNew(arrPrdctIdN[j]);
	}	 */
}
function changeAllDscnt(prcnt)
{
	if(isNaN(prcnt))
	{
		//console.log("isNaN True");
		prcnt = prcnt.value;		
	}else{
		//console.log("isNaN False");
		
	}
	
	//console.log("prcnt:"+prcnt);
	
 	var elsDscnt=document.getElementsByName("dscnt_prcnt_number2");

	for (var i=0 ; i < elsDscnt.length;i++) { elsDscnt[i].value = prcnt; };
 	for (var j=0 ; j < arrPrdctId.length ; j++)
	{
		//console.log("arrPrdctId["+j+"]:"+arrPrdctId[j]);
		changeDscntPrcnt(prcnt,arrPrdctId[j]);
	}
 	for (var j=0 ; j < arrPrdctIdN.length ; j++)
	{
		//console.log("arrPrdctIdN["+j+"]:"+arrPrdctIdN[j]);
		changeDscntPrcntNew(prcnt,arrPrdctIdN[j]);
	}
}
function calcRemainedPayment()
{
	g_remainedPayment = g_dscntTotal-prePayment-etcDscnt;
	Math.round(g_remainedPayment);
	//console.log("on calcRemainedPayment - innerHTML");
	document.getElementById("remainedPayment_txt").innerHTML = format(String((g_remainedPayment)));
	calcPrice();
}

function fncSetEarnAll(source)
{
	checkboxes = document.getElementsByName('earnChkBox');
	for(var i=0, n=checkboxes.length;i<n;i++) {
		checkboxes[i].checked = source.checked;
		if(true==source.checked)
		{changePointPrcnt(checkboxes[i].value, ALL_CHECKED);}
		else
		{changePointPrcnt(checkboxes[i].value, ALL_UNCHECKED);}
	}
}
function fncSetUsingAll(source)
{
	checkboxes = document.getElementsByName('usingChkBox');
	for(var i=0, n=checkboxes.length;i<n;i++) {
		checkboxes[i].checked = source.checked;
		if(true==source.checked)
		{pntUsingChk(checkboxes[i].value, ALL_CHECKED);}
		else
		{pntUsingChk(checkboxes[i].value, ALL_UNCHECKED);}
	}
}

function resetInput(id,prdctId)
{
	id.value="0";
	changeDscntPrcnt(0,prdctId);
}

function pntUsingChk(prdctId,change)
{
	//console.log("run pntUsingChk");
	if(change==CHANGE && USING == mapPntUsingChk[prdctId])
	{mapPntUsingChk[prdctId]=NOT_USING;}
	else if(change==CHANGE && USING != mapPntUsingChk[prdctId])
	{mapPntUsingChk[prdctId]=USING;}
	else if(change==ALL_CHECKED)
	{mapPntUsingChk[prdctId]=USING;}
	else if(change==ALL_UNCHECKED)
	{mapPntUsingChk[prdctId]=NOT_USING;}
	//console.log("mapPntUsingChk[prdctId]:"+mapPntUsingChk[prdctId]);
	calcTotalPrice4Point();
}


function fncGetDate()
{
	var datetime = $('#1${saleVoH.saleId}').datepicker({ dateFormat: 'yy.mm.dd' }).val();
	var cardDate = $('#2${saleVoH.saleId}').datepicker({ dateFormat: 'yy.mm.dd' }).val();
	
	var cardTy = $('#edit_card_com_slct').val();
	
 	//console.log("datetime:"+datetime);
	//console.log("cardDate:"+cardDate);
	//console.log("cardTy:"+cardTy);
	//console.log("cstmrId:"+'${cstmrId}');
/*	console.log("HsaleId:"+'${saleVoH.saleId}');
	console.log("HhistId:"+'${saleVoH.histId}');
	console.log("HshopId:"+'${saleVoH.shopId}');
	console.log("HsaleId:"+'${saleVoH.saleId}');
	console.log("HshopId:"+'${saleVoH.shopId}');
	console.log("shopId:"+'${shopVo.shopId}');
	console.log("staffId:"+'${staffVo.staffId}');
 */	
	var saleId = '${saleVoH.saleId}';
	var histId = '${saleVoH.histId}';
	
	console.log('saleVoH.saleId:'+'${saleVoH.saleId}');
	saleId = Number(saleId);
	histId = Number(histId);
	
	//console.log("saleId:"+saleId);
	//console.log("histId:"+histId);
	
	//console.log("staffId:"+'${staffVo.staffId}');
	
	if(datetime=='' && cardDate=='' && cardTy==0)
	{	alert("수정 정보가 없습니다."); return;		}
	
	var url= '${ctxPath}/sale/editSaleDate.do';

	 $.ajax({
		url		: url
		,type 	: "post"
		,data 	: "saleId="+saleId+"&histId="+histId+"&datetime="+datetime+"&cardDate="+cardDate+"&cardTy="+cardTy
		,dataType	: "text"
		,beforeSend	: function(){
		},
		success: function(data){
			//console.log(data);
			window.sessionStorage.setItem("popup",1);
			jQuery('#dlgDateSelect').html('');
			//jQuery('#dlgDateSelect').dialog('close');
			jQuery('#dlgDateSelect').dialog('destroy');
			//location.replace(pageUrl);
			
			var form=document.createElement("form");
			form.name='tempPost';
			form.method='post';
			//form.action='${ctxPath}/prdct/indexPrdctProcessForm.do'; 
			form.action='${ctxPath}/sale/indexSaleForm.do';
			
			var input=document.createElement("input");
			input.type="hidden";
			input.name='cstmrId';
			input.value= '${saleVoH.cstmrId}';
			$(form).append(input);
			$('#body').append(form); 
			form.submit();
		}
	}); 
}
function dlgDateSelect(){
	
	//console.log("HsaleId:"+'${saleVoH.saleId}');
	//console.log("HshopId:"+'${saleVoH.shopId}');
	//console.log("shopId:"+'${shopVo.shopId}');
	//console.log("staffId:"+'${staffVo.staffId}');
	
	if('${saleVoH.shopId}' != '${shopVo.shopId}')
	{
		alert("타 매장 기록은 수정 할 수 없습니다.");
		return;
	}


	var innerDlg = "<html>\
					<body>\
					<table border='0' width='100%'>\
						<tr align='center'bgcolor='white'>\
							<td>&nbsp;</td>\
							<td>처방일</td>\
							<td>카드결제일</td>\
							<td>카드사</td>\
						</tr>\
						<tr align='center'bgcolor='white'>\
							<td>현재</td>\
							<td>${saleVoH.datetime}</td>\
							<td>${saleVoH.cardDate}</td>\
							<td>${saleVoH.cardName}</td>\
						</tr>\
						<tr align='center' bgcolor='white'>\
							<td style='width: 40px;'>변경</td>\
							<td>\
								<input id='1${saleVoH.saleId}' type='text'\
								style='height: 30px; width: 120px; font-size: 15px'>\
								</td>\
							<td>\
								<input id='2${saleVoH.saleId}' type='text'\
								style='height: 30px; width: 120px; font-size: 15px'>\
							</td>\
							<td>\
								<select id='edit_card_com_slct' name='edit_card_com_slct'\
								style='height: 30px; width: 80px; font-size: 15px'>\
								<option value='0'selected='selected'>--선택--</option>\
								<option value='1'>비씨</option>\
								<option value='2'>삼성</option>\
								<option value='3'>엘지</option>\
								<option value='4'>국민</option>\
								<option value='5'>외환</option>\
								<option value='6'>현대</option>\
								<option value='7'>신한</option>\
								<option value='8'>롯데</option>\
								<option value='9'>NH농협</option>\
								<option value='10'>하나SK</option>\
								<option value='11'>직불카드</option>\
								<option value='12'>선택안함</option>\
								<option value='13'>현금영수증</option>\
								</select>\
							</td>\
						</tr>\
						<tr>\
						<td colspan='4' align='center'><button onclick='fncGetDate();return false;'\
						id='submit' style='height: 40px; width: 120px' bgcolor='white'>확인</button></td>\
						</tr>\
					</table>\
					</body>\
					</html>";
	jQuery('#dlgDateSelect').html('');
	
	jQuery('#dlgDateSelect').html(innerDlg);
	$('#1${saleVoH.saleId}').datepicker({ dateFormat: 'yy.mm.dd' });
	$('#2${saleVoH.saleId}').datepicker({ dateFormat: 'yy.mm.dd' });
	//$( ".selector" ).datepicker( "hide" );

	
	 jQuery('#dlgDateSelect').dialog({
	 //bgiframe: true
	 title: "수정 날짜 선택"
	 , modal: true
	 , width: 420 // 가로 크기
	 , height : 200
	 , background: "#000"
	 , close: function(event, ui){
		console.log("in close . editDate");
		jQuery('#dlgDateSelect').html('');
		//jQuery('#dlgDateSelect').html('');
		//jQuery('#dlgDateSelect').dialog('close');
		//jQuery('#cstmrHist').html('');
		//jQuery('#cstmrHist').dialog('close');
		//newWindow();
		//window.parent.jQuery('#cstmrHist').dialog('close');
		
		//var isOpen = $( ".selector" ).dialog( "isOpen" );
		//console.log('isOpen:'+isOpen);
		//$('#cstmrHist').dialog('close');
		//jQuery('#cstmrHist').dialog('destory');
		//jQuery('#cstmrHist').dialog('close');
		//$('#cstmrHist').dialog('close');
		//ScriptManager.RegisterClientScriptBlock(this,this.GetType(),"closedialog","$(function(){$('#cstmrHist').dialog('close');});",true);
		/* $.proxy(function(data){
			   $(this).dialog('close');
			}, this); */
		//newWindow();
			
			
	 }, success:  function(data) {
	 //console.log($("#prdctCnt").val())
		 
	 } 
	 });
}

function closeSingleFrame()
{
 self.opener = self;
 window.close();
}
// 다중프레임의 경우
function closeMultiFrame()
{
 top.opener = top;
 top.window.close();
}

$(function(){
	var saleId = Number('${saleVoH.saleId}');
	var cash = Number('${saleVoH.payCash}');
	var point = Number('${saleVoH.payPoint}');
	var cardName = '${saleVoH.cardName}';
	if(cash!="0"){
		$("#deposit").append("(현금 : " + format(String(cash)) +")<br>");
	}
	if(point!="0"){
		$("#deposit").append("(포인트 : " + format(String(point)) +")<br>");
	}	
	getPayCardInfo(saleId);			
});

function getPayCardInfo(saleId){
	var param = "saleId=" + saleId;
	var url = "${ctxPath}/sale/getPayCardInfo.do";
	
	$.ajax({
		url : url,
		data : param,
		dataType : "html",
		success :function(data){
			$("#deposit").append(data);
		}
	});
}

function goPrintDlg()
{
	//location.href="${ctxPath}/prdct/indexPrdctProcessFormPrint.do";
	window.open("${ctxPath}/prdct/indexPrdctProcessFormPrint.do");
}

</script>

<style>
 input[type=checkbox] {
    display:none;
  }
 
  input[type=checkbox] + label
   {
       background-image : url("/GalleryStaff/images/checkbox.png");
       height: 32px;
       width: 32px;
       display:inline-block;
       padding: 0 0 0 0px;
   }

   input[type=checkbox]:checked + label
    {
        background-image : url("/GalleryStaff/images/checkbox_c.png");
        height: 32px;
        width: 32px;
        display:inline-block;
        padding: 0 0 0 0px;
    }
    #cstmrHstrStaffList>tbody>tr>td>img{
    	display:none;
    } 
    
.date_number{
height: 40px;
width: 200px;
font-weight: bold;
font-size: 15px;
text-align: center;
}

#slct_card_com,#slctPartner{
	display: none;
}


#cstmrHstrStaffList
{
	font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
	width:100%;
	border-collapse:collapse;
}
#cstmrHstrStaffList td, #cstmrHstrStaffList th 
{
font-size:1em;
border:1px solid #98bf21;
padding:3px 7px 2px 7px;
}
#cstmrHstrStaffList th 
{
font-size:1.1em;
text-align:left;
padding-top:5px;
padding-bottom:4px;
background-color:#A7C942;
color:#ffffff;
}
#cstmrHstrStaffList tr.alt td 
{
color:#000000;
background-color:#EAF2D3;
}
</style>

<table id="cstmrHstrStaffList" border='1' width="90%" style="font-size: 13px;" ">
	<div hiddn id="dscnt_old" value="${saleVoH.partnerDscnt}"></div>
	<div hiddn id="dscnt_type_old" value="${saleVoH.partnerId}"></div>
	<%-- <tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr> --%>

	<tr>
		<!-- <th class="borderL borderR blueTr" colspan="9" style="background-color: white; color: black;font-size: 16px;">전체 할인 및 적립 설정</th> -->
		<th class="borderL borderR blueTr" colspan="7">전체 할인 및 적립 설정</th>
	</tr>
	<%-- <tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr> --%>
	
	<tr>
		<td colspan="7">
			<img src="${ctxPath	}/images/black_line.jpg" width="100%">					
		</td>
	</tr>
	
	<tr bgcolor="white" style="color: black">
		<td>제휴할인</td>
		<td colspan="3">
			<select id='slctPartner' name='slctPartner' onChange="setDscnt(this);">
				<option value="-1">할인 종류</option>
				<c:forEach items="${listPartner}" var="item" varStatus="status">
					<c:choose>
						<c:when test="${saleVoH.partnerId == item.partnerId}">
							<option selected="selected" value="${item.partnerId}@${item.dscntPrcnt}@${item.partnerCert}@${item.partnerMemo}">${item.partnerName}</option>
							<script>
								partnerCert = '${item.partnerCert}';
								partnerMemo = '${item.partnerMemo}';
							</script>
						</c:when>
						<c:otherwise>
							<option value="${item.partnerId}@${item.dscntPrcnt}@${item.partnerCert}@${item.partnerMemo}">${item.partnerName}</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
			<span id="slctPartner2"></span>
		</td>

		<td>
			<!-- <input type="button" style="height: 20px" value="할인 정보" id="btnShowPartner" onClick="showPartnerInfo();"> -->
		</td>

		<td>
				<c:choose>
					<c:when test="${!empty saleVoH.partnerDscnt}">
						<span class="prcnt_number2"  id="partnerDscnt_txt" name="partnerDscnt_txt"
							
							onChange=changeAllDscnt(this); return false;"
							placeholder="숫자만 입력 가능." size="3"
							onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;">
							${saleVoH.partnerDscnt}
						</span>
					</c:when>
					<c:otherwise>
						<span class="prcnt_number2"  id="partnerDscnt_txt" name="partnerDscnt_txt"
							onChange="changeAllDscnt(this); return false;"
							placeholder="숫자만 입력 가능." size="3"
							onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;">
						</span>
					</c:otherwise>
				</c:choose>
			%
		</td>
		<td>&nbsp;</td>
	</tr>
	
	<tr>
		<td colspan="7">
			<img src="${ctxPath	}/images/black_line.jpg" width="100%">					
		</td>
	</tr>
	
	<%-- <tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" width="800px"
			height="1" /></td>
	</tr > --%>
	<tr class="tb" style="color: black" bgcolor="white">
		<td width="150px">제품명</td>
<!-- 		<td width="40px">특성</td> -->
		<td width="40px" style="text-align: right;">수량</td>
		<td width="90px" style="text-align: right;">가격</td>
		<td width="135px" style="text-align: right;">합계</td>
		<td width="130px" style="text-align: right;">할인율</td>
		<td width="100px" style="text-align: right;">할인후가격</td>
		<td width="40px" style="text-align: center;">적립</td>
		<!-- <td width="80px">적립예정</td>
		<td width="40px">사용</td> -->
	</tr>
	<%-- <tr>
		<td height="3" colspan="9">
			<img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" />
		</td>
	</tr> --%>

	<c:choose>
		<c:when test="${ !empty listPrdctH || !empty newPrdctH || !empty listLensH || !empty listClensH || !empty listAccH}">
			<form id="listCheckBox" name="listCheckBox" method="post" action="">
			
			<!-- @@Frame. -->
				<c:forEach var="prdct" items="${listPrdctH}" varStatus="status" >
					<tr class="listData" style="color: black" bgcolor="white">
						<td>${prdct.prdctName}</td>
						<%-- <td>${prdct.colorName}</td> --%>
						<td>${prdct.prdctCnt}</td> 
						<td style="text-align: right;"><fmt:formatNumber value="${prdct.prc}" pattern="#,###" /></td>
						<td style="text-align: right;"><fmt:formatNumber
								value="${prdct.prc*prdct.prdctCnt}" pattern="#,###" /></td>
						<td style="text-align: right;">
							<span class="prcnt_number2" type="number" value='${prdct.dscntPrcnt}' size="3" name="dscnt_prcnt_number2"
								id="dscnt_input_numberF${prdct.prdctId}"
								onClick="resetInput(dscnt_input_numberF${prdct.prdctId},'F${prdct.prdctId}');"
								onChange="changeDscntPrcnt(this,'F${prdct.prdctId}'); return false;"
								onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;">${prdct.dscntPrcnt}%</span>
						</td>
						<!-- <input onclick ="resetInput(gcylLeft);" type="text" size="3" style="font-size: 17px"  id="gcylLeft"
						name="gcylLeft" onchange="format(gcylLeft)"></input> -->
						<td style="text-align: right;">
							<p id="dscntPriceF${prdct.prdctId}">
								<fmt:formatNumber value= "${prdct.prc*prdct.prdctCnt*((100-prdct.dscntPrcnt)/100)}" pattern="#,###" />
							</p>
						</td>
						<td style="text-align: center;">
						<c:choose>
				        <c:when test="${prdct.earnPrcnt =='5'}">
				        	<%-- <input class="earnCheckbox" type="checkbox" name="earnChkBox" value="F${prdct.prdctId}" checked
								onChange="changePointPrcnt('F${prdct.prdctId}', CHANGE);" ></input> --%>
								<span>O</span>
				        </c:when>
				        <c:otherwise>
				        	<%-- <input class="earnCheckbox" type="checkbox" name="earnChkBox" value="F${prdct.prdctId}"
								onChange="changePointPrcnt('F${prdct.prdctId}', CHANGE);" ></input> --%>
								<span>X</span>
				        </c:otherwise>
				    	</c:choose>
						</td>
						<td hidden><p id="pointPriceF${prdct.prdctId}">
								<fmt:formatNumber value= "${prdct.prc*prdct.prdctCnt*((100-prdct.dscntPrcnt)/100)*(prdct.earnPrcnt/100)}" pattern="#,###" />
							</p>
						</td>
						<td hidden>
						<c:choose>
					        <c:when test="${prdct.usingPoint =='1'}">
					        	<%-- <input class="usingCheckbox" type="checkbox" name="usingChkBox" checked
								value="F${prdct.prdctId}" onChange="pntUsingChk('F${prdct.prdctId}', CHANGE);"></input> --%>
					        </c:when>
					        <c:otherwise>
					        	<%-- <input class="usingCheckbox" type="checkbox" name="usingChkBox"
								value="F${prdct.prdctId}" onChange="pntUsingChk('F${prdct.prdctId}', CHANGE);"></input> --%>
					        </c:otherwise>
				    	</c:choose>
						</td>

						<script>
				 			arrPrdctId.push('F${prdct.prdctId}');
					 		mapCnt['F${prdct.prdctId}'] = '${prdct.prdctCnt}';
					 		mapPrc['F${prdct.prdctId}'] = '${prdct.prc}';
					 		mapDscntPrcnt['F${prdct.prdctId}'] = ['${prdct.dscntPrcnt}'];
					 		mapEarnPrcnt['F${prdct.prdctId}'] = ['${prdct.earnPrcnt}'];
					 		mapPntUsingChk['F${prdct.prdctId}'] = ['${prdct.usingPoint}'];
						</script>
						
					</tr>
					<tr>
						<td colspan="7">
							<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">					
						</td>
					</tr>
					<script>
			    		fncSum_init('${prdct.prc*prdct.prdctCnt}');
			    		//fncDscntSum_init('${prdct.prc*prdct.prdctCnt*((100-prdct.dscntPrcnt)/100)}');
			    		fncDscntSum_init('${prdct.prc}','${prdct.prdctCnt}','${prdct.dscntPrcnt}');
			    		//fncPointSum_init('${prdct.prc*prdct.prdctCnt*((100-prdct.dscntPrcnt)/100)*(prdct.earnPrcnt/100)}');
			    		fncPointSum_init('${prdct.prc}','${prdct.prdctCnt}','${prdct.dscntPrcnt}','${prdct.earnPrcnt}');
			    	</script>
				</c:forEach>
				<!-- END Frame -->

				<!-- @@ Lens. -->
				<c:forEach var="prdctLens" items="${listLensH}" varStatus="status" >
					<tr class="listData" style="color: black" bgcolor="white">
						<td>${prdctLens.prdctName}</td>
						<%-- <td>${prdctLens.colorName}</td> --%>
						<td>${prdctLens.prdctCnt}</td>
						<td style="text-align: right;"><fmt:formatNumber value="${prdctLens.prc}" pattern="#,###" /></td>
						<td style="text-align: right;"><fmt:formatNumber
								value="${prdctLens.prc*prdctLens.prdctCnt}" pattern="#,###" /></td>
								
						<td style="text-align: right;"><span class="prcnt_number2" type="number" value='${prdctLens.dscntPrcnt}' size="3" name="dscnt_prcnt_number2"
								id="dscnt_input_numberL${prdctLens.prdctId}"
								onClick="resetInput(dscnt_input_numberL${prdctLens.prdctId},'L${prdctLens.prdctId}');"
								onChange="changeDscntPrcnt(this,'L${prdctLens.prdctId}','${prdctLens.prc}','${prdctLens.prdctCnt}',TY_LENS); return false;"
								onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;">${prdctLens.dscntPrcnt}%</span>
						</td>
						
						<td style="text-align: right;">
							<p id="dscntPriceL${prdctLens.prdctId}">
								<fmt:formatNumber value= "${prdctLens.prc*prdctLens.prdctCnt*((100-prdctLens.dscntPrcnt)/100)}" pattern="#,###" />
							</p>
						</td>
						<td style="text-align: center;">
						<c:choose>
					        <c:when test="${prdctLens.earnPrcnt =='5'}">
								<%-- <input class="earnCheckbox" type="checkbox" name="earnChkBox" value="L${prdctLens.prdctId}" checked
									onChange="changePointPrcnt('L${prdctLens.prdctId}', CHANGE);" ></input> --%>
									<span>O</span>
					        </c:when>
					        <c:otherwise>
<%-- 					        	<input class="earnCheckbox" type="checkbox" name="earnChkBox" value="L${prdctLens.prdctId}"
									onChange="changePointPrcnt('L${prdctLens.prdctId}', CHANGE);" ></input> --%>
									<span>X</span>
					        </c:otherwise>
				    	</c:choose>
						</td>
						<td hidden><p id="pointPriceL${prdctLens.prdctId}">
								<fmt:formatNumber value= "${prdctLens.prc*prdctLens.prdctCnt*((100-prdctLens.dscntPrcnt)/100)*(prdctLens.earnPrcnt/100)}" pattern="#,###" />
							</p>
						</td>
						<td hidden>
							<c:choose>
						        <c:when test="${prdctLens.usingPoint =='1'}">
						        <%-- 	<input class="usingCheckbox" type="checkbox" name="usingChkBox" checked
							value="L${prdctLens.prdctId}" onChange="pntUsingChk('L${prdctLens.prdctId}', CHANGE);"></input> --%>
						        </c:when>
						        <c:otherwise>
						        	<%-- <input class="usingCheckbox" type="checkbox" name="usingChkBox"
							value="L${prdctLens.prdctId}" onChange="pntUsingChk('L${prdctLens.prdctId}', CHANGE);"></input> --%>
						        </c:otherwise>
					    	</c:choose>
							
						</td>

						<script>
				 			arrPrdctId.push('L${prdctLens.prdctId}');
					 		mapCnt['L${prdctLens.prdctId}'] = '${prdctLens.prdctCnt}';
					 		mapPrc['L${prdctLens.prdctId}'] = '${prdctLens.prc}';
					 		mapDscntPrcnt['L${prdctLens.prdctId}'] = ['${prdctLens.dscntPrcnt}'];
					 		mapEarnPrcnt['L${prdctLens.prdctId}'] = ['${prdctLens.earnPrcnt}'];
					 		mapPntUsingChk['L${prdctLens.prdctId}'] = ['${prdctLens.usingPoint}'];
						</script>
						
					</tr>
					<tr>
						<td colspan="7">
							<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">					
						</td>
					</tr>
					
					<script>
			    		fncSum_init('${prdctLens.prc*prdctLens.prdctCnt}');
			    		//fncDscntSum_init('${prdctLens.prc*prdctLens.prdctCnt*((100-prdctLens.dscntPrcnt)/100)}');
			    		fncDscntSum_init('${prdctLens.prc}','${prdctLens.prdctCnt}','${prdctLens.dscntPrcnt}');
			    		//fncPointSum_init('${prdctLens.prc*prdctLens.prdctCnt*((100-prdctLens.dscntPrcnt)/100)*(prdctLens.earnPrcnt/100)}');
			    		fncPointSum_init('${prdctLens.prc}','${prdctLens.prdctCnt}','${prdctLens.dscntPrcnt}','${prdctLens.earnPrcnt}');
			    	</script>
				</c:forEach>
				<!-- END Lens -->
				
				<!-- @@ Clens. -->
				<c:forEach var="prdctClens" items="${listClensH}" varStatus="status" >
					<tr class="listData" style="color: black" bgcolor="white">
						<td>${prdctClens.prdctName}</td>
						<%-- <td>${prdctClens.colorName}</td> --%>
						<td>${prdctClens.prdctCnt}</td>
						<td style="text-align: right;"><fmt:formatNumber value="${prdctClens.prc}" pattern="#,###" /></td>
						<td style="text-align: right;"><fmt:formatNumber
								value="${prdctClens.prc*prdctClens.prdctCnt}" pattern="#,###" /></td>
								
						<td style="text-align: right;"><span class="prcnt_number2" type="number" value='${prdctClens.dscntPrcnt}' size="3" name="dscnt_prcnt_number2"
								id="dscnt_input_numberC${prdctClens.prdctId}"
								onClick="resetInput(dscnt_input_numberC${prdctClens.prdctId},'C${prdctClens.prdctId}');"
								onChange="changeDscntPrcnt(this,'C${prdctClens.prdctId}','${prdctClens.prc}','${prdctClens.prdctCnt}',TY_LENS); return false;"
								onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;">${prdctClens.dscntPrcnt}%</span>
						</td>
						
						<td style="text-align: right;">
							<p id="dscntPriceC${prdctClens.prdctId}">
								<fmt:formatNumber value= "${prdctClens.prc*prdctClens.prdctCnt*((100-prdctClens.dscntPrcnt)/100)}" pattern="#,###" />
							</p>
						</td>
						<td style="text-align: center;">
						<c:choose>
					        <c:when test="${prdctClens.earnPrcnt =='5'}">
					        	<%-- <input class="earnCheckbox" type="checkbox" name="earnChkBox"
					        	 value="C${prdctClens.prdctId}" checked
								onChange="changePointPrcnt('C${prdctClens.prdctId}', CHANGE);" ></input> --%>
								<span>O</span>
					        </c:when>
					        <c:otherwise>
					        	<%-- <input class="earnCheckbox" type="checkbox" name="earnChkBox" value="C${prdctClens.prdctId}"
								onChange="changePointPrcnt('C${prdctClens.prdctId}', CHANGE);" ></input> --%>
								<span>X</span>
					        </c:otherwise>
				    	</c:choose>
						</td>
						<!-- <td>&nbsp;</td> -->
						<td hidden>
							<p id="pointPriceC${prdctClens.prdctId}">
								<fmt:formatNumber value= "${prdctClens.prc*prdctClens.prdctCnt*((100-prdctClens.dscntPrcnt)/100)*(prdctClens.earnPrcnt/100)}" pattern="#,###" />
							</p>
						</td>
						<!-- <td>&nbsp;</td> -->
						<td hidden>
							<c:choose>
						        <c:when test="${prdctClens.usingPoint =='1'}">
						        	<%-- <input class="usingCheckbox" type="checkbox" name="usingChkBox" checked
							value="C${prdctClens.prdctId}" onChange="pntUsingChk('C${prdctClens.prdctId}', CHANGE);"></input> --%>
						        </c:when>
						        <c:otherwise>
						        	<%-- <input class="usingCheckbox" type="checkbox" name="usingChkBox"
							value="C${prdctClens.prdctId}" onChange="pntUsingChk('C${prdctClens.prdctId}', CHANGE);"></input> --%>
						        </c:otherwise>
					    	</c:choose>
							
						</td>

						<script>
				 			arrPrdctId.push('C${prdctClens.prdctId}');
					 		mapCnt['C${prdctClens.prdctId}'] = '${prdctClens.prdctCnt}';
					 		mapPrc['C${prdctClens.prdctId}'] = '${prdctClens.prc}';
					 		mapDscntPrcnt['C${prdctClens.prdctId}'] = ['${prdctClens.dscntPrcnt}'];
					 		mapEarnPrcnt['C${prdctClens.prdctId}'] = ['${prdctClens.earnPrcnt}'];
					 		mapPntUsingChk['C${prdctClens.prdctId}'] = ['${prdctClens.usingPoint}'];
						</script>
						
					</tr>
					
					<tr>
						<td colspan="7">
							<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">					
						</td>
					</tr>
					<script>
			    		fncSum_init('${prdctClens.prc*prdctClens.prdctCnt}');
			    		//fncDscntSum_init('${prdctClens.prc*prdctClens.prdctCnt*((100-prdctClens.dscntPrcnt)/100)}');
			    		fncDscntSum_init('${prdctClens.prc}','${prdctClens.prdctCnt}','${prdctClens.dscntPrcnt}');
			    		//fncPointSum_init('${prdctClens.prc*prdctClens.prdctCnt*((100-prdctClens.dscntPrcnt)/100)*(prdctClens.earnPrcnt/100)}');
			    		fncPointSum_init('${prdctClens.prc}','${prdctClens.prdctCnt}','${prdctClens.dscntPrcnt}','${prdctClens.earnPrcnt}');
			    	</script>
				</c:forEach>
				<!-- END Clens -->
				
				<!-- @@ Accs. -->
				<c:forEach var="prdctAcc" items="${listAccH}" varStatus="status" >
					<tr class="listData" style="color: black" bgcolor="white">
						<td>${prdctAcc.prdctName}</td>
						<%-- <td>${prdctAcc.colorName}</td> --%>
						<td>${prdctAcc.prdctCnt}</td>
						<td style="text-align: right;"><fmt:formatNumber value="${prdctAcc.prc}" pattern="#,###" /></td>
						<td style="text-align: right;"><fmt:formatNumber
								value="${prdctAcc.prc*prdctAcc.prdctCnt}" pattern="#,###" /></td>
								
						<td style="text-align: right;"><span class="prcnt_number2" type="number" value='${prdctAcc.dscntPrcnt}' size="3" name="dscnt_prcnt_number2"
								id="dscnt_input_numberA${prdctAcc.prdctId}"
								onClick="resetInput(dscnt_input_numberA${prdctAcc.prdctId},'A${prdctAcc.prdctId}');"
								onChange="changeDscntPrcnt(this,'A${prdctAcc.prdctId}','${prdctAcc.prc}','${prdctAcc.prdctCnt}',TY_LENS); return false;"
								onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;">${prdctAcc.dscntPrcnt}%</span>
						</td>
						
						<td style="text-align: right;">
							<p id="dscntPriceA${prdctAcc.prdctId}">
								<fmt:formatNumber value= "${prdctAcc.prc*prdctAcc.prdctCnt*((100-prdctAcc.dscntPrcnt)/100)}" pattern="#,###" />
							</p>
						</td>
						<td style="text-align: center;">						
						<c:choose>
					        <c:when test="${prdctAcc.earnPrcnt =='5'}">
					        	<%-- <input class="earnCheckbox" type="checkbox" name="earnChkBox" value="A${prdctAcc.prdctId}" checked
								onChange="changePointPrcnt('A${prdctAcc.prdctId}', CHANGE);" ></input> --%>
								<span>O</span>
					        </c:when>
					        <c:otherwise>
					        	<%-- <input class="earnCheckbox" type="checkbox" name="earnChkBox" value="A${prdctAcc.prdctId}"
								onChange="changePointPrcnt('A${prdctAcc.prdctId}', CHANGE);" ></input> --%>
								<span>X</span>
					        </c:otherwise>
				    	</c:choose>
						</td>
						<!-- <td>&nbsp;</td> -->
						<td hidden>
							<p id="pointPriceA${prdctAcc.prdctId}">
								<fmt:formatNumber value= "${prdctAcc.prc*prdctAcc.prdctCnt*((100-prdctAcc.dscntPrcnt)/100)*(prdctAcc.earnPrcnt/100)}" pattern="#,###" />
							</p>
						</td>
						<!-- <td>&nbsp;</td> -->
						<td hidden>
							<c:choose>
						        <c:when test="${prdctAcc.usingPoint =='1'}">
						        	<%-- <input class="usingCheckbox" type="checkbox" name="usingChkBox" checked
							value="A${prdctAcc.prdctId}" onChange="pntUsingChk('A${prdctAcc.prdctId}', CHANGE);"></input> --%>
						        </c:when>
						        <c:otherwise>
						        	<%-- <input class="usingCheckbox" type="checkbox" name="usingChkBox"
							value="A${prdctAcc.prdctId}" onChange="pntUsingChk('A${prdctAcc.prdctId}', CHANGE);"></input> --%>
						        </c:otherwise>
					    	</c:choose>
							
						</td>

						<script>
				 			arrPrdctId.push('A${prdctAcc.prdctId}');
					 		mapCnt['A${prdctAcc.prdctId}'] = '${prdctAcc.prdctCnt}';
					 		mapPrc['A${prdctAcc.prdctId}'] = '${prdctAcc.prc}';
					 		mapDscntPrcnt['A${prdctAcc.prdctId}'] = ['${prdctAcc.dscntPrcnt}'];
					 		mapEarnPrcnt['A${prdctAcc.prdctId}'] = ['${prdctAcc.earnPrcnt}'];
					 		mapPntUsingChk['A${prdctAcc.prdctId}'] = ['${prdctAcc.usingPoint}'];
						</script>
						
					</tr>
					<tr>
						<td colspan="7">
							<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">					
						</td>
					</tr>
					<script>
			    		fncSum_init('${prdctAcc.prc*prdctAcc.prdctCnt}');
			    		fncDscntSum_init('${prdctAcc.prc}','${prdctAcc.prdctCnt}','${prdctAcc.dscntPrcnt}');
			    		//fncPointSum_init('${prdctAcc.prc*prdctAcc.prdctCnt*((100-prdctAcc.dscntPrcnt)/100)*(prdctAcc.earnPrcnt/100)}');
			    		fncPointSum_init('${prdctAcc.prc}','${prdctAcc.prdctCnt}','${prdctAcc.dscntPrcnt}','${prdctAcc.earnPrcnt}');
			    	</script>
				</c:forEach>
				<!-- End Accs. -->
				
				<!-- @@ newPrdct. -->
				<c:forEach var="newPrdct" items="${newPrdctH}" varStatus="status" >
					<tr class="listData" style="color: black" bgcolor="white">
						<td>${newPrdct.prdctName}</td>
						<%-- <td>${newPrdct.colorName}</td> --%>
						<td>${newPrdct.prdctCnt}</td>
						<td style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc}" pattern="#,###" /></td>
						<td style="text-align: right;"><fmt:formatNumber
								value="${newPrdct.prc*newPrdct.prdctCnt}" pattern="#,###" /></td>
								
						<td style="text-align: right;"><span class="prcnt_number2" type="number" value='${newPrdct.dscntPrcnt}' size="3" name="dscnt_prcnt_number2"
								id="dscnt_input_numberN${newPrdct.prdctId}"
								onClick="resetInput(dscnt_input_numberN${newPrdct.prdctId},'N${newPrdct.prdctId}');"
								onChange="changeDscntPrcnt(this,'N${newPrdct.prdctId}','${newPrdct.prc}','${newPrdct.prdctCnt}',TY_LENS); return false;"
								onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;">${newPrdct.dscntPrcnt}%</span>
						</td>
						
						<td style="text-align: right;">
							<p id="dscntPriceN${newPrdct.prdctId}">
								<fmt:formatNumber value= "${newPrdct.prc*newPrdct.prdctCnt*((100-newPrdct.dscntPrcnt)/100)}" pattern="#,###" />
							</p>
						</td>
						<td style="text-align: center;">
						<c:choose>
					        <c:when test="${newPrdct.earnPrcnt =='5'}">
					        	<%-- <input class="earnCheckbox" type="checkbox" name="earnChkBox" value="N${newPrdct.prdctId}" checked
								onChange="changePointPrcnt('N${newPrdct.prdctId}', CHANGE);" ></input> --%>
								<span>O</span>
					        </c:when>
					        <c:otherwise>
					        	<%-- <input class="earnCheckbox" type="checkbox" name="earnChkBox" value="N${newPrdct.prdctId}"
								onChange="changePointPrcnt('N${newPrdct.prdctId}', CHANGE);" ></input> --%>
								<span>X</span>
					        </c:otherwise>
				    	</c:choose>
						</td>
						<!-- <td>&nbsp;</td> -->
						<td hidden>
							<p id="pointPriceN${newPrdct.prdctId}">
								<fmt:formatNumber value= "${newPrdct.prc*newPrdct.prdctCnt*((100-newPrdct.dscntPrcnt)/100)*(newPrdct.earnPrcnt/100)}" pattern="#,###" />
							</p>
						</td>
						<!-- <td>&nbsp;</td> -->
						<td hidden>
							<c:choose>
						        <c:when test="${newPrdct.usingPoint =='1'}">
						        	<%-- <input class="usingCheckbox" type="checkbox" name="usingChkBox" checked
										value="N${newPrdct.prdctId}" onChange="pntUsingChk('N${newPrdct.prdctId}', CHANGE);"></input> --%>
						        </c:when>
						        <c:otherwise>
						        	<%-- <input class="usingCheckbox" type="checkbox" name="usingChkBox"
										value="N${newPrdct.prdctId}" onChange="pntUsingChk('N${newPrdct.prdctId}', CHANGE);"></input> --%>
						        </c:otherwise>
					    	</c:choose>
							
						</td>

						<script>
				 			arrPrdctId.push('N${newPrdct.prdctId}');
					 		mapCnt['N${newPrdct.prdctId}'] = '${newPrdct.prdctCnt}';
					 		mapPrc['N${newPrdct.prdctId}'] = '${newPrdct.prc}';
					 		mapDscntPrcnt['N${newPrdct.prdctId}'] = ['${newPrdct.dscntPrcnt}'];
					 		mapEarnPrcnt['N${newPrdct.prdctId}'] = ['${newPrdct.earnPrcnt}'];
					 		mapPntUsingChk['N${newPrdct.prdctId}'] = ['${newPrdct.usingPoint}'];
						</script>
						
					</tr>
					<tr>
						<td colspan="7">
							<img src="${ctxPath	}/images/black_dot_line.jpg " width="100%">					
						</td>
					</tr>
					<script>
			    		fncSum_init('${newPrdct.prc*newPrdct.prdctCnt}');
			    		//fncDscntSum_init('${newPrdct.prc*newPrdct.prdctCnt*((100-newPrdct.dscntPrcnt)/100)}');
			    		fncDscntSum_init('${newPrdct.prc}','${newPrdct.prdctCnt}','${newPrdct.dscntPrcnt}');
			    		//fncPointSum_init('${newPrdct.prc*newPrdct.prdctCnt*((100-newPrdct.dscntPrcnt)/100)*(newPrdct.earnPrcnt/100)}');
			    		fncPointSum_init('${newPrdct.prc}','${newPrdct.prdctCnt}','${newPrdct.dscntPrcnt}','${newPrdct.earnPrcnt}');
			    	</script>
				</c:forEach>
				<!-- End newPrdct -->			
			</form>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="7" align="center">상품 데이터가 없습니다.</td>
			</tr>
		</c:otherwise>

	</c:choose>
	<%-- <tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr> --%>
	<tr bgcolor="white" >
		<td style="color : black">가격합계</td>
		<td>&nbsp;</td>
		<td style="color : black; text-align: right;" >할인 전:</td>
		<td style="color : black;"><p id="total_txt_hstry" style="text-align: right;" ></p></td>
		<td style="color : black;  text-align: right;">할인 후:</td>
		<td style="color : black"><p id="dscnt_total_txt_hstry" style="text-align: right; background-color: white; color: black" ></p></td>
		<td>&nbsp;</td>
	</tr>
	<%-- <tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr> --%>

	<tr>
		<td colspan="7">
			<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">					
		</td>
	</tr>
	<tr style="color: black" bgcolor="white">
		<td >기타할인</td>
		<td>&nbsp;</td>
		
		
		<td colspan="3">
			<span type="text" id="etcDscntMemo_txt2"
			name="etcDscntMemo_txt" value="" placeholder="1000원 이하 할인 등."
			size="255"></span>
		</td>
		<td style="text-align: right">
			<span class="payment_number2" type="number" pattern="[0-9]*" id="etcDscnt_txt"
					name="etcDscnt_txt" onChange="setEtcDscnt();"
					placeholder="숫자만 입력 가능." size="15">
			</spant>
		</td>
		<td>&nbsp;</td>
		
	</tr>
	<tr>
		<td colspan="7">
			<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">					
		</td>
	</tr>
	<%-- <tr>
		<td height="3" colspan="9">
			<img src="<c:url value="/images/content/Whiteline.jpg" />"
				alt="line" width="800" height="1" />
		</td>
	</tr> --%>

	<tr style="color: black" bgcolor="white">
		<td >현금</td>
		<td colspan="4">&nbsp;</td>
		<td  style="text-align: right"><span class="payment_number2" type="number" pattern="[0-9]*" id="cash_txt"
			name="cash_txt" onChange="calcPrice();"
			placeholder="숫자만 입력 가능." size="15" value=0
			onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;"></span></td>
			
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">					
		</td>
	</tr>
	<tr style="color: black" bgcolor="white">
		<td>카드</td>
		
		
		<%-- <td >
			<select id='slct_card_com' name='slctCardCom' >
				<c:forEach items="${listCardCom}" var="card" varStatus="status">
					<option value="${card.cardComId}">${card.cardComName}</option>
				</c:forEach>
			</select>
		</td> --%>
		<td colspan="2">
			<p id="card_name_txt">
			</p>
		</td>
		
		<td>결제일:</td>
		<td>
			<p id="card_date_txt" ></p>
		</td>
		<td  style="text-align: right"><span class="payment_number2" type="number" id="card_txt" pattern="[0-9]*"
			name="card_txt" onChange="calcPrice();" placeholder="숫자만 입력 가능." size="15" value=0
			onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;">
			</span>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">					
		</td>
	</tr>
	<tr style="color: black" bgcolor="white">
		<td>포인트</td>
		
		<td colspan='4'>&nbsp;</td>
		<td hidden>
			<input type="button" value="검색" id="btnSearchFmlyCd">
		</td>
		
		<td hidden onclick= "fncGetPointHistory(); return false;">
			<span id=fmly_name_txt hidden></span><span id=fmly_cd_txt hidden></span>
		</td>
		
		<td hidden onclick= "fncGetPointHistory(); return false;">
			<span id=total_point_txt hidden>
				<fmt:formatNumber value="" pattern="#,###" />
			</span>
		</td>

		<td hidden>사용한도:</td>
	
		<td hidden>
		<span id=limit_point_txt></span>
		<fmt:formatNumber value="" pattern="#,###" />
		</td>
		
		<td style="text-align: right">
			<span class="payment_number2"  id="point_txt" name="point_txt" >
			</span>
		</td>
	   <td>&nbsp;</td>
		<script>
			calcTotalPrice4Point();
			calcLimit();
		</script>
	</tr>

	<%-- <tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" />
		</td>
	</tr> --%>

	<tr  hidden style="color: black">
		<td>선금</td>
		<td colspan="5">&nbsp;</td>
		<td style="text-align: right;" >
			<fmt:formatNumber value="${saleVoH.payCard+saleVoH.payCash+saleVoH.payPoint}" 
							  pattern="#,###" />
		</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="${ctxPath	}/images/black2_line.jpg" width="100%">					
		</td>
	</tr>
	<tr style="color: black" bgcolor="white">
		<td >결제금액</td>
		<td colspan='4'>&nbsp;</td>
		<td style="text-align: right;background-color: white; color: black" ><span id="remainedPayment_txt"></span></td>
		<script>
			g_remainedPayment = g_dscntTotal-prePayment-etcDscnt;
			document.getElementById("remainedPayment_txt").innerHTML = format(String((g_remainedPayment)));
		</script>
		<td>&nbsp;</td>
		
	</tr>
	<tr style="color: black" bgcolor="white" >
		<td colspan='5'>&nbsp;</td>
		<td style="text-align: right" ><span id="deposit" style="font-size: 11px;"></td>
		<td>&nbsp;</td>
	</tr>
	<%-- <tr>
		<td height="3" colspan="9">
			<img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" />
		</td>
	</tr> --%>
	<tr>
		<td colspan="7">
			<img src="${ctxPath	}/images/black_line.jpg" width="100%">					
		</td>
	</tr>
	<tr style="color: black" bgcolor="white">
		<td>잔액</td>
		<td colspan='4'>&nbsp;</td>
		
		<td style="text-align: right;" ><span id="penny_txt"></span></td>
		<script>
		calcPrice();
		</script>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="${ctxPath	}/images/black_line.jpg" width="100%">					
		</td>
	</tr>
	<tr style="color: black" bgcolor="white">
		<td>적립금</td>
		<td colspan="4" text-align = 'center'>100 단위까지 적립</td>
		<td style="text-align: right;  color: black" >
			<span id="point_total_txt">
				<fmt:formatNumber value="" pattern="#,###" />
			</span>
		</td>
		<td>&nbsp;</td>
	</tr>
	<%-- <tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr> --%>
	<tr>
	<tr>
	<td colspan="7">
			<img src="${ctxPath	}/images/black_line.jpg" width="100%">					
		</td>
	</tr>	
		<td height="44" colspan="9">
		<center>
			<img src="<c:url value="/images/content/edit.png" />"
			onclick="dlgDateSelect();"  width="35px" height="35px" ></button>
			<input type="image" id='imgPrint' onclick="goPrintDlg(); return false;" src="<c:url value="/images/button/print_btn.png" />"width="32px" height="32px" />
		</center>
		</td>
	</tr>
	<script>
		fncPointSum_init_final();
	</script>
</table>

<div id="dlgPartnerInfo" title="할인정보"></div>
<div id="dlgPointHist" title="포인트 내역"></div>
<div id="dlgDateSelect" title="포인트 내역"></div>
<br>
