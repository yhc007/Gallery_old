<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>

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
		
	if('${saleVo.partnerDscnt}' !=0)
	{
		partnerDscnt ='${saleVo.partnerDscnt}'; 
	}else{
		partnerDscnt = 0;
	}
	
	
	if('${saleVo.etcDscnt}' != 0)
	{
		etcDscnt ='${saleVo.etcDscnt}'; 
	}else{
		etcDscnt = 0;
	}
	document.getElementById("etcDscnt_txt").value = etcDscnt;
	var etcDscntMemo;
	if('${saleVo.etcDscntMemo}'!== undefined)
	{
		etcDscntMemo = '${saleVo.etcDscntMemo}';
	}
	
	fncCardDate_init();
	
	document.getElementById("etcDscntMemo_txt").value = etcDscntMemo;
	document.getElementById("earnAll_number").value = '${saleVo.earnPrcnt}';
	prePayment = '${saleVo.payCard+saleVo.payCash+saleVo.payPoint}';
	getCstmrPoint();
	getBirthCoupon();
	fncSum_init(0);
	fncDscntSum_init(0,0,0);
	fncPointSum_init(0,0,0,0);
});

function fncCardDate_init(){
	var date= window.sessionStorage.getItem("dateTile");
	console.log('dateTile:'+date);
	document.getElementById("card_date").value = date;
}

function getBirthCoupon() {
	var url = '${ctxPath}/coupon/getBirthCoupon.do';
	//var url = 'getCheckData.do';

	//javax
	$.ajax({
		url : url,
		type : "post",
		data : "cstmrCd=" + '${cstmrVo.cstmrCd}',
		dataType : "json",
		beforeSend : function() {
		},
		success : function(data) {
			/* console.log("Run getCheckInfo Success!!");
			console.log("data.couponCd:"+data.couponCd);
			console.log("data.cstmrCd:"+data.cstmrCd);
			console.log("data.cstmrMail:"+data.cstmrMail);
			console.log("data.shopNum:"+data.shopNum);
			console.log("data.couponCd:"+data.shopName);
			console.log("data.usingDate:"+data.usingDate);
			console.log("data.wMemo:"+data);
			console.log("data.wMemo:"+decodeURIComponent(data.wMemo)); */
			
			var shopNum = data.shopNum;

			if(data.couponCd == "NOEXIST")
			{
				console.log("NO exist");
				document.getElementById("txtHasCoupon").innerHTML = "-쿠폰없음-";
			}else if(shopNum==0){
				document.getElementById("txtCouponCd").innerHTML = data.couponCd;
				document.getElementById("txtHasCoupon").innerHTML = data.couponCd;
			}else{
				document.getElementById("txtHasCoupon").innerHTML = "-사용된쿠폰-</br>"+data.couponCd+":"+data.usingDate;
			} 
		}
	});
	
	}


function fncSum_init(prc) {
	g_total += parseInt(prc);
	g_total = Math.round(g_total);
	document.getElementById("total_txt").innerHTML = format(String(g_total));
}


function fncPointSum_init(prc,cnt,dscnt,earn) {
	var point = ((prc*cnt))*((100-dscnt)/100)*(earn/100);
	g_pointTotal += parseInt(point);
	g_pointTotal = Math.round((g_pointTotal*100)/100.0);
	var tmp_point = g_pointTotal-g_pointTotal%100;
	console.log("g_pointTotal:"+g_pointTotal);
	console.log("g_pointTotal%100:"+g_pointTotal%100);
	console.log("tmp_point:"+tmp_point);
	document.getElementById("point_total_txt").innerHTML = format(String(tmp_point));
	//document.getElementById("point_total_txt").innerHTML = format(String(g_pointTotal));
}

function fncPointSum_init_final() {
	var nPoint = $("#point_txt").text();
	var etcDscnt = $("#etcDscnt_txt").text();
	var earnPrcnt = '${saleVoH.earnPrcnt}';
	
	if(earnPrcnt !='undefined'){
		earnPrcnt=Number(earnPrcnt);
	}else{
		earnPrcnt=5;
	}
	if(nPoint=='undefined')
	{ nPoint = 0;}
	if(etcDscnt=='undefined')
	{ etcDscnt = 0;}

	//g_pointTotal -= etcDscnt*(earnPrcnt/100);
	//g_pointTotal -= nPoint*(earnPrcnt/100);
	
	g_pointTotal -= etcDscnt*(earnPrcnt/100);
	g_pointTotal -= nPoint*(earnPrcnt/100);
	g_pointTotal = Math.round((g_pointTotal*100)/100.0);
 	
	var tmp_point = g_pointTotal-g_pointTotal%100;
	
	document.getElementById("point_total_txt").innerHTML = format(String(tmp_point));
}




function fncDscntSum_init(prc,cnt,prcnt) {
	var dscnt = prc*cnt*((100-prcnt)/100);
	g_dscntTotal += parseInt(dscnt);
	console.log("dscnt:"+dscnt);
	console.log("g_dscntTotal:"+g_dscntTotal);
	g_dscntTotal=Math.round(g_dscntTotal);
	console.log("@g_dscntTotal:"+g_dscntTotal);
	document.getElementById("dscnt_total_txt").innerHTML = format(String(g_dscntTotal));
}

function fncCalcPointSum(){
	console.log("Run fncCalcPoitnSum");
	g_pointTotal=0;
	
	var cnt;
	var prc;
	var dscntPrcnt;
	var earnPrcnt;
	var allEarnPrcnt=document.getElementById("earnAll_number").value;
	var nPoint = document.getElementById("point_txt").value;
	var etcDscnt = document.getElementById("etcDscnt_txt").value;	
	var totalPrice;
	for(var i=0 ; i < arrPrdctId.length ; i++){
		cnt = mapCnt[arrPrdctId[i]];
		prc =  mapPrc[arrPrdctId[i]];
		dscntPrcnt = mapDscntPrcnt[arrPrdctId[i]];
		earnPrcnt = mapEarnPrcnt[arrPrdctId[i]];
		//g_pointTotal +=	(((cnt*prc)-etcDscnt)*((100-dscntPrcnt)/100)*(earnPrcnt/100)-(nPoint*(earnPrcnt/100)));
		g_pointTotal +=	(((cnt*prc))*((100-dscntPrcnt)/100)*(earnPrcnt/100)); 
	};
	g_pointTotal -= etcDscnt*(earnPrcnt/100);
	g_pointTotal -= nPoint*(earnPrcnt/100);
 	g_pointTotal = Math.round((g_pointTotal*100)/100.0);
 	
 	console.log("g_pointTotal:" + g_pointTotal);
	var tmp_point = g_pointTotal-g_pointTotal%100;
	console.log("g_pointTotal:"+g_pointTotal);
	console.log("g_pointTotal%100:"+g_pointTotal%100);
	console.log("tmp_point:"+tmp_point);
	document.getElementById("point_total_txt").innerHTML = format(String(tmp_point));

 	//document.getElementById("point_total_txt").innerHTML = format(String(g_pointTotal));
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
		g_pointTotal +=	(cnt*prc*((100-dscntPrcnt)/100)*(earnPrcnt/100));
	}
	
	
  	g_pointTotal = g_pointTotal-usingPoint;
 	g_pointTotal = Math.round((g_pointTotal*100)/100.0);
	var tmp_point = g_pointTotal-g_pointTotal%100;
	console.log("g_pointTotal:"+g_pointTotal);
	console.log("g_pointTotal%100:"+g_pointTotal%100);
	console.log("tmp_point:"+tmp_point);
	document.getElementById("point_total_txt").innerHTML = format(String(tmp_point));

 	//document.getElementById("point_total_txt").innerHTML = format(String(g_pointTotal));
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
 	console.log("on fncCalcDscntSum - innerHTML");
 	document.getElementById("dscnt_total_txt").innerHTML = format(String(g_dscntTotal));
 	calcRemainedPayment();
} 


function calcPrice() {
	var nCard = document.getElementById("card_txt").value;
	var nCash = document.getElementById("cash_txt").value;
	var nPoint = document.getElementById("point_txt").value;
	
	if(!nCard){nCard = 0;}
	if(!nCash){nCash = 0;}
	
	var g_penny = g_remainedPayment-nCard-nCash-nPoint;
	g_penny=Math.round(g_penny);
	document.getElementById("penny_txt").innerHTML = format(String(g_penny));
}

function calcLimit(){
	var nPoint = document.getElementById("point_txt").value;
	if (0 > (pointValue - nPoint))
	{
		alert("가용 포인트를 초과하였습니다.");
		document.getElementById("point_txt").value=0;
		return;
	}
	/* if(0 > (totalPrice4Point-nPoint))
	{
		alert("포인트 사용 가능한 물품 가격 합인 "+totalPrice4Point+"원 을 초과하였습니다.");
		document.getElementById("point_txt").value=0;
		return;
	} */
	//fncCalcPointSumBeforeUsing(nPoint);
	var nEarnPoint = document.getElementById("point_total_txt").innerHTML;
	//nEarnPoint = removeCommas(nEarnPoint);
	var point_total_final_txt = nEarnPoint;
	point_total_final_txt = Math.round(point_total_final_txt);
	//document.getElementById("point_total_final_txt").innerHTML = format(String(point_total_final_txt));
	calcPrice();
	fncCalcPointSum();
}
function setEtcDscnt(){
	console.info("run setEtcDscnt");
	etcDscnt = document.getElementById("etcDscnt_txt").value; 
	calcRemainedPayment();
	fncCalcPointSum();
}

function calcTotalPrice4Point()
{
	console.log("run calcTotalPrice4Point");
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
		totalPrice4Point +=	(cnt*prc*((100-dscntPrcnt)/100));
	};
 	
 	/* for (var j=0 ; j < arrPrdctIdN.length ; j++)
	{
		cnt = mapCntN[arrPrdctIdN[j]];
		prc =  mapPrcN[arrPrdctIdN[j]];
		dscntPrcnt = mapDscntPrcntN[arrPrdctIdN[j]];
		earnPrcnt = mapEarnPrcntN[arrPrdctIdN[j]];
		if(earnPrcnt==0)
		{continue;}
		totalPrice4Point +=	(cnt*prc*((100-dscntPrcnt)/100));
	} */
	console.log("totalPrice4Point:"+totalPrice4Point);
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

function addComma(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function setDscnt(sel){
	var partnerValue = sel.options[sel.selectedIndex].value;
	partner = partnerValue.split('@');
	partnerId = partner[0];
	var dscntPrcnt = partner[1];
	partnerCert = partner[2];
	partnerMemo = partner[3];
	document.getElementById("partnerDscnt_txt").value = dscntPrcnt;
	
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
	     , position:{my:"center",at:"bottom",of:"#tile" }
		 , success:  function(data) {
		} 
	});	
}



function getCstmrPoint(){
	var url = '${ctxPath}/point/getCstmrPoint.do';
	
	$.ajax({
		url		: url,
		type 	: "post",
		data : "cstmrCd=" + '${cstmrVo.cstmrCd}'+"&fmlyCd="+'${cstmrVo.fmlyCd}',
		dataType	: "text",
		success: function(data){
			var rtnData = decodeURIComponent(data);
			var pointParser = rtnData.split(',');
			pointValue = pointParser[0];
			fmlyCd = pointParser[1];
			var fmlyName = pointParser[2];
			
			document.getElementById("total_point_txt").innerHTML = pointValue;
			document.getElementById("fmly_name_txt").innerHTML = fmlyName;
			document.getElementById("total_point_txt1").innerHTML = pointValue;
			document.getElementById("fmly_name_txt1").innerHTML = fmlyName;
			document.getElementById("fmly_cd_txt").innerHTML = fmlyCd;
			return;
		}
	}); 
};

function changeDscntPrcnt(prcnt,prdctId)
{
	console.log("prdctId:"+prdctId);
	if(isNaN(prcnt))
	{
		console.log("isNaN True");
		console.log("prcnt:"+prcnt);
		prcnt = prcnt.value;		
	}else{
		console.log("isNaN False");
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
	var prcnt=document.getElementById("earnAll_number").value;
	console.log("change:"+change);
	
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
	console.log("dscntPrice:"+dscntPrice);
	var pointPrice = (dscntPrice)*(mapEarnPrcnt[prdctId]/100);
	console.log("pointPrice:"+pointPrice);
	pointPrice = Math.round(pointPrice);
	
	console.log("on changePointPrcnt innerHTML value : "+document.getElementById("pointPrice"+prdctId));
	document.getElementById("pointPrice"+prdctId).innerHTML = format(String(pointPrice));
	
	fncCalcPointSum();
	//calcTotalPrice4Point();
	//calcLimit();
}

/* function changeDscntPrcntNew(prcnt,prdctId)
{
	if(isNaN(prcnt))
	{
		console.log("isNaN True");
		prcnt = prcnt.value;		
	}else{
		console.log("isNaN False");
	}
	
	mapDscntPrcntN[prdctId]=prcnt;

	var cnt = mapCntN[prdctId];
	var prc = mapPrcN[prdctId];
	
	var dscntPrice = prc*cnt*((100-prcnt)/100);
	dscntPrice = Math.round(dscntPrice);
	console.log("dscntPrice:"+dscntPrice);
	document.getElementById("newDscntPrice"+prdctId).innerHTML = format(String(dscntPrice));
	
	fncCalcDscntSum();
	
	changePointPrcntNew(mapEarnPrcntN[prdctId],prdctId);
}
function changePointPrcntNew(prcnt,prdctId)
{
	var prcnt = document.getElementById("earnAll_number").value;
 	console.log("prcnt:"+prcnt);
	console.log("prdctId:"+prdctId);
	console.log("mapCntN["+prdctId+"]"+mapCntN[prdctId]);
	console.log("mapPrcN["+prdctId+"]"+mapPrcN[prdctId]);
 
	mapEarnPrcntN[prdctId]=prcnt;
	
	var cnt = mapCntN[prdctId];
	var prc = mapPrcN[prdctId]; 

	var dscntPrice = prc*cnt*((100-mapDscntPrcntN[prdctId])/100);
	dscntPrice = Math.round(dscntPrice);
	console.log("dscntPrice:"+dscntPrice);
	var pointPrice = (dscntPrice)*(prcnt/100);
	pointPrice = Math.round(pointPrice);
	console.log("pointPrice:"+pointPrice);
	document.getElementById("newPointPrice"+prdctId).innerHTML = format(String(pointPrice));
	
	fncCalcPointSum();
	calcTotalPrice4Point();
	calcLimit();
} */

function changeAllPoint(prcnt)
{
	var els=document.getElementsByName("point_prcnt_number");
	
	console.log("prcnt"+prcnt);

	for (var i=0;i<els.length;i++) { els[i].value = prcnt.value; }
 	for (var j=0 ; j < arrPrdctId.length ; j++)
	{
		console.log("arrPrdctId["+j+"]:"+arrPrdctId[j]);
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
		console.log("isNaN True");
		prcnt = prcnt.value;		
	}else{
		console.log("isNaN False");
		
	}
	
	console.log("prcnt:"+prcnt);
	
 	var elsDscnt=document.getElementsByName("dscnt_prcnt_number");

	for (var i=0 ; i < elsDscnt.length;i++) { elsDscnt[i].value = prcnt; };
 	for (var j=0 ; j < arrPrdctId.length ; j++)
	{
		console.log("arrPrdctId["+j+"]:"+arrPrdctId[j]);
		changeDscntPrcnt(prcnt,arrPrdctId[j]);
	}
  	/* for (var j=0 ; j < arrPrdctIdN.length ; j++){
		console.log("arrPrdctIdN["+j+"]:"+arrPrdctIdN[j]);
		changeDscntPrcntNew(prcnt,arrPrdctIdN[j]);
	} */
 
 }
function calcRemainedPayment()
{
	g_remainedPayment = g_dscntTotal-prePayment-etcDscnt;
	g_remainedPayment = Math.round(g_remainedPayment);
	console.log("on calcRemainedPayment - innerHTML");
	document.getElementById("remainedPayment_txt").innerHTML = format(String((g_remainedPayment)));
	calcPrice();
}

function fncSearchFmlyCdNoSave()
{
	location.href="${ctxPath}/cstmr/searchFmlyCd.do";
}
function fncSearchFmlyCd()
{
	fncPaymentSave(POINT_CHANGE);
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
	console.log("run pntUsingChk");
	if(change==CHANGE && USING == mapPntUsingChk[prdctId])
	{mapPntUsingChk[prdctId]=NOT_USING;}
	else if(change==CHANGE && USING != mapPntUsingChk[prdctId])
	{mapPntUsingChk[prdctId]=USING;}
	else if(change==ALL_CHECKED)
	{mapPntUsingChk[prdctId]=USING;}
	else if(change==ALL_UNCHECKED)
	{mapPntUsingChk[prdctId]=NOT_USING;}
	console.log("mapPntUsingChk[prdctId]:"+mapPntUsingChk[prdctId]);
	calcTotalPrice4Point();
}
function checkUse()
{
		
	if(chkUseCoupon==0)
	{chkUseCoupon=1;}
	else
	{chkUseCoupon=0;}
	
	console.log(chkUseCoupon)
	console.log('${saleVo.shopId}')
	console.log('${cstmrVo.cstmrCd}')
	
}

function chkCoupon(){
	var couponCd = $("#couponCd").val();
	var param = "couponCd=" + couponCd;
	var url = "${ctxPath}/coupon/chkCoupon.do";
	
	$.ajax({
		url : url,
		dataType : "text",
		data : param,
		type : "post",
		success : function(data){
			if(data.trim()=="exist"){
				alert("쿠폰이 있습니다.");
			}else{
				alert("쿠폰이 존재하지 않습니다.");
			}
		}
	});
}

function showCouponDiv(){
	$("#couponDiv").dialog({
		title : "쿠폰 검색",
		width : 'auto',
		height :'auto'
	})	;
}

function inputCoupon(){
	$("#srch_").attr("disabled",true);
	$("#input_").attr("disabled",true);
	
	var couponCd = $("#couponDiv input[id='inputCd']").val();
	
	$("#srch_").attr("disabled",false);
	$("#input_").attr("disabled",true);
	$("#couponDiv").dialog("close");
	$("#couponCd").val(couponCd);

}
function srchCoupon(){
	$("#srch_").attr("disabled",true);
	var cstmrName = $("#couponDiv input[id='cstmrName']").val();
	var cellphone = $("#couponDiv input[id='cellphone']").val();
	var telephone = $("#couponDiv input[id='telephone']").val();
	
	var url = "${ctxPath}/coupon/chkCoupon.do";
	var param = "cstmrName=" + cstmrName + 
					"&cellphone=" + cellphone +
					"&telephone=" + telephone;
	
	$.ajax({
		url : url,
		dataType : "text",
		data : param,
		type : "post",
		success : function(data){
			$("#srch_").attr("disabled",false);
			console.log(data);
			var result = data.split("|");
			if(result[0]=="noCoupon"){
				alert("쿠폰이 없습니다.");
			}else if(result[0]=="noCstmr"){
				alert("존재하지 않는 회원입니다.");
			}else if(result[0]=="exist"){
				$("#couponDiv").dialog("close");
				$("#couponCd").val(result[1]);
			}
		}
	});
}
$(function(){
	var saleId = Number('${saleVo.saleId}');
	var cash = Number('${saleVo.payCash}');
	var point = Number('${saleVo.payPoint}');
	var cardName = '${saleVo.cardName}';
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


function clearValue(id){
	console.log("id : " + id);
	$("#"+ id).val("");
}
</script>

<style>
	#couponDiv{
		display: none;
	}
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
</style>


<table class="staffList" width="800px" border="0.5">
	<div hiddn id="dscnt_old" value="${saleVo.partnerDscnt}"></div>
	<div hiddn id="dscnt_type_old" value="${saleVo.partnerId}"></div>
	<tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr>
	<tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr>
	<tr>
		<td colspan="9">전체 할인 및 적립 설정</td>
	</tr>
	<tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr>
	<tr height="45">
		<td>포인트</td>
		<td colspan="2">
			<input type="button" value="저장 없이 검색" id="btnSearchFmlyCdNoSave"
				style="height:50px; width:100px" onClick="fncSearchFmlyCdNoSave();">
		</td>

		<td onclick= "fncGetPointHistory(); return false;">
			<span id=fmly_name_txt1></span><span id=fmly_cd_txt1 hidden></span>
		</td>
		
		<td>포인트</td>
		<td onclick= "fncGetPointHistory(); return false;" >
			<span id=total_point_txt1>
				<fmt:formatNumber value="" pattern="#,###" />
			</span>
		</td>
		
		<td hidden><input class="prcnt_number" type="number" size="3"
				hidden
				id="earnAll_number"
				onChange="changeAllPoint(this); return false;"
				readonly="readonly"
				onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;" onclick="clearValue(id)"></input>%
		</td>
		
		<td hidden>
			<input hidden class="earnCheckbox" type="checkbox" onClick="fncSetEarnAll(this);"></input>
 		</td>
		<td hidden>
			<input hidden class="usingCheckbox" type="checkbox" onClick="fncSetUsingAll(this);"></input>
 		</td>
 		
 		<td>&nbsp;</td>
 		<td>&nbsp;</td>
 		<td>&nbsp;</td>
 		<td>&nbsp;</td>
 		<td>&nbsp;</td>
 	</tr>
 	
 	<tr height="45">
		<td>생일쿠폰</td>
		
		<td>&nbsp;</td>
		<td colspan='3'>
			<span id=txtHasCoupon></span>
			<span id=txtCouponCd hidden></span>
		</td>
		
		<td >
			사용하기</br><input class="earnCheckbox" type="checkbox" id="chkUseCoupon" onclick="checkUse();"></input>
 		</td>
 		
 		
 		<td><input type="tel" id="couponCd" placeholder="타인 쿠폰검색" style="height: 40px" onclick="showCouponDiv();"> </td>
 		
 		<td>&nbsp;</td>
 		<td>&nbsp;</td>
 	</tr>
	
	<tr height="45">
		<td>제휴할인</td>
		<td colspan="3">
			<select id='slctPartner' name='slctPartner' onChange="setDscnt(this);">
				<option value="-1">할인 종류</option>
				<c:forEach items="${listPartner}" var="item" varStatus="status">
					<c:choose>
						<c:when test="${saleVo.partnerId == item.partnerId}">
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
		</td>

		<td>
			<input type="button" value="할인 정보" id="btnShowPartner" onClick="showPartnerInfo();">
		</td>

		<td>
				<c:choose>
					<c:when test="${!empty saleVo.partnerDscnt}">
						<input class="prcnt_number" type="number" id="partnerDscnt_txt" name="partnerDscnt_txt"
							value="${saleVo.partnerDscnt}"
							onChange=changeAllDscnt(this); return false;"
							placeholder="숫자만 입력 가능." size="3"
							onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;">
						</input>
					</c:when>
					<c:otherwise>
						<input class="prcnt_number" type="number" id="partnerDscnt_txt" name="partnerDscnt_txt"
							onChange="changeAllDscnt(this); return false;"
							placeholder="숫자만 입력 가능." size="3"
							onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;">
						</input>
					</c:otherwise>
				</c:choose>
			%
		</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" width="800px"
			height="1" /></td>
	</tr>
	<tr class="tb" height="46">
		<td width="120px">제품명</td>
<!-- 		<td width="40px">특성</td> -->
		<td width="40px">수량</td>
		<td width="90px">가격</td>
		<td width="95px">합계</td>
		<td width="80px">할인율</td>
		<td width="100px">할인후가격</td>
		<td width="40px">적립</td>
		<td>
			<input hidden class="earnCheckbox" type="checkbox" onClick="fncSetEarnAll(this);"></input>
 		</td>
		<td>&nbsp;</td>
		<!-- <td width="80px">적립예정</td>
		<td width="40px">사용</td> -->
	</tr>
	<tr>
		<td height="3" colspan="9">
			<img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" />
		</td>
	</tr>

	<c:choose>
		<c:when test="${ !empty listPrdct || !empty newPrdct || !empty listLens || !empty listClens || !empty listAcc}">
			<form id="listCheckBox" name="listCheckBox" method="post" action="">
			
			<!-- @@Frame. -->
				<c:forEach var="prdct" items="${listPrdct}" varStatus="status" >
					<tr class="listData" height="66">
						<td>${prdct.prdctName}</td>
						<%-- <td>${prdct.colorName}</td> --%>
						<td>${prdct.prdctCnt}</td>
						<td><fmt:formatNumber value="${prdct.prc}" pattern="#,###" /></td>
						<td style="text-align: right;"><fmt:formatNumber
								value="${prdct.prc*prdct.prdctCnt}" pattern="#,###" /></td>
						<td><input class="prcnt_number" type="number" value='${prdct.dscntPrcnt}' size="3" name="dscnt_prcnt_number"
								id="dscnt_input_numberF${prdct.prdctId}"
								onClick="resetInput(dscnt_input_numberF${prdct.prdctId},'F${prdct.prdctId}');"
								onChange="changeDscntPrcnt(this,'F${prdct.prdctId}'); return false;"
								onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;" onclick="clearValue(id)">%
						</td>
						<!-- <input onclick ="resetInput(gcylLeft);" type="text" size="3" style="font-size: 17px"  id="gcylLeft"
						name="gcylLeft" onchange="format(gcylLeft)"></input> -->
						<td>
							<p id="dscntPriceF${prdct.prdctId}">
								<fmt:formatNumber value= "${prdct.prc*prdct.prdctCnt*((100-prdct.dscntPrcnt)/100)}" pattern="#,###" />
							</p>
						</td>
						<td>
						<c:choose>
				        <c:when test="${prdct.earnPrcnt =='5'}">
				        	<input class="earnCheckbox" type="checkbox" name="earnChkBox" value="F${prdct.prdctId}" checked
								onChange="changePointPrcnt('F${prdct.prdctId}', CHANGE);" ></input>
						
				        </c:when>
				        <c:otherwise>
				        	<input class="earnCheckbox" type="checkbox" name="earnChkBox" value="F${prdct.prdctId}"
								onChange="changePointPrcnt('F${prdct.prdctId}', CHANGE);" ></input>
						
				        </c:otherwise>
				    	</c:choose>
						</td>
						<td>&nbsp;</td>
						<td hidden><p id="pointPriceF${prdct.prdctId}">
								<fmt:formatNumber value= "${prdct.prc*prdct.prdctCnt*((100-prdct.dscntPrcnt)/100)*(prdct.earnPrcnt/100)}" pattern="#,###" />
							</p>
						</td>
						<td>&nbsp;</td>
						<td hidden>
						<c:choose>
					        <c:when test="${prdct.usingPoint =='1'}">
					        	<input class="usingCheckbox" type="checkbox" name="usingChkBox" checked
								value="F${prdct.prdctId}" onChange="pntUsingChk('F${prdct.prdctId}', CHANGE);"></input>
					        </c:when>
					        <c:otherwise>
					        	<input class="usingCheckbox" type="checkbox" name="usingChkBox"
								value="F${prdct.prdctId}" onChange="pntUsingChk('F${prdct.prdctId}', CHANGE);"></input>
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
				<c:forEach var="prdctLens" items="${listLens}" varStatus="status" >
					<tr class="listData" height="66">
						<td>${prdctLens.prdctName} - ${prdctLens.curve}</td></td>
						<%-- <td>${prdctLens.colorName}</td> --%>
						<td>${prdctLens.prdctCnt}</td>
						<td><fmt:formatNumber value="${prdctLens.prc}" pattern="#,###" /></td>
						<td style="text-align: right;"><fmt:formatNumber
								value="${prdctLens.prc*prdctLens.prdctCnt}" pattern="#,###" /></td>
								
						<td><input class="prcnt_number" type="number" value='${prdctLens.dscntPrcnt}' size="3" name="dscnt_prcnt_number"
								id="dscnt_input_numberL${prdctLens.prdctId}"
								onClick="resetInput(dscnt_input_numberL${prdctLens.prdctId},'L${prdctLens.prdctId}');"
								onChange="changeDscntPrcnt(this,'L${prdctLens.prdctId}','${prdctLens.prc}','${prdctLens.prdctCnt}',TY_LENS); return false;"
								onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;" onclick="clearValue(id)">%
						</td>
						
						<td>
							<p id="dscntPriceL${prdctLens.prdctId}">
								<fmt:formatNumber value= "${prdctLens.prc*prdctLens.prdctCnt*((100-prdctLens.dscntPrcnt)/100)}" pattern="#,###" />
							</p>
						</td>
						<td>
						
						<c:choose>
					        <c:when test="${prdctLens.earnPrcnt =='5'}">
								<input class="earnCheckbox" type="checkbox" name="earnChkBox" value="L${prdctLens.prdctId}" checked
									onChange="changePointPrcnt('L${prdctLens.prdctId}', CHANGE);" ></input>
					        </c:when>
					        <c:otherwise>
					        	<input class="earnCheckbox" type="checkbox" name="earnChkBox" value="L${prdctLens.prdctId}"
									onChange="changePointPrcnt('L${prdctLens.prdctId}', CHANGE);" ></input>
					        </c:otherwise>
				    	</c:choose>
						</td>
						<td>&nbsp;</td>
						<td hidden><p id="pointPriceL${prdctLens.prdctId}">
								<fmt:formatNumber value= "${prdctLens.prc*prdctLens.prdctCnt*((100-prdctLens.dscntPrcnt)/100)*(prdctLens.earnPrcnt/100)}" pattern="#,###" />
							</p>
						</td>
						<td>&nbsp;</td>
						<td hidden>
							<c:choose>
						        <c:when test="${prdctLens.usingPoint =='1'}">
						        	<input class="usingCheckbox" type="checkbox" name="usingChkBox" checked
							value="L${prdctLens.prdctId}" onChange="pntUsingChk('L${prdctLens.prdctId}', CHANGE);"></input>
						        </c:when>
						        <c:otherwise>
						        	<input class="usingCheckbox" type="checkbox" name="usingChkBox"
							value="L${prdctLens.prdctId}" onChange="pntUsingChk('L${prdctLens.prdctId}', CHANGE);"></input>
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
				<c:forEach var="prdctClens" items="${listClens}" varStatus="status" >
					<tr class="listData" height="66">
						<td>${prdctClens.prdctName}</td>
						<%-- <td>${prdctClens.colorName}</td> --%>
						<td>${prdctClens.prdctCnt}</td>
						<td><fmt:formatNumber value="${prdctClens.prc}" pattern="#,###" /></td>
						<td style="text-align: right;"><fmt:formatNumber
								value="${prdctClens.prc*prdctClens.prdctCnt}" pattern="#,###" /></td>
								
						<td><input class="prcnt_number" type="number" value='${prdctClens.dscntPrcnt}' size="3" name="dscnt_prcnt_number"
								id="dscnt_input_numberC${prdctClens.prdctId}"
								onClick="resetInput(dscnt_input_numberC${prdctClens.prdctId},'C${prdctClens.prdctId}');"
								onChange="changeDscntPrcnt(this,'C${prdctClens.prdctId}','${prdctClens.prc}','${prdctClens.prdctCnt}',TY_LENS); return false;"
								onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;" onclick="clearValue(id)">%
						</td>
						
						<td>
							<p id="dscntPriceC${prdctClens.prdctId}">
								<fmt:formatNumber value= "${prdctClens.prc*prdctClens.prdctCnt*((100-prdctClens.dscntPrcnt)/100)}" pattern="#,###" />
							</p>
						</td>
						<td>
						<c:choose>
					        <c:when test="${prdctClens.earnPrcnt =='5'}">
					        	<input class="earnCheckbox" type="checkbox" name="earnChkBox"
					        	 value="C${prdctClens.prdctId}" checked
								onChange="changePointPrcnt('C${prdctClens.prdctId}', CHANGE);" ></input>
					        </c:when>
					        <c:otherwise>
					        	<input class="earnCheckbox" type="checkbox" name="earnChkBox" value="C${prdctClens.prdctId}"
								onChange="changePointPrcnt('C${prdctClens.prdctId}', CHANGE);" ></input>
					        </c:otherwise>
				    	</c:choose>
						</td>
						<td>&nbsp;</td>
						<td hidden>
							<p id="pointPriceC${prdctClens.prdctId}">
								<fmt:formatNumber value= "${prdctClens.prc*prdctClens.prdctCnt*((100-prdctClens.dscntPrcnt)/100)*(prdctClens.earnPrcnt/100)}" pattern="#,###" />
							</p>
						</td>
						<td>&nbsp;</td>
						<td hidden>
							<c:choose>
						        <c:when test="${prdctClens.usingPoint =='1'}">
						        	<input class="usingCheckbox" type="checkbox" name="usingChkBox" checked
							value="C${prdctClens.prdctId}" onChange="pntUsingChk('C${prdctClens.prdctId}', CHANGE);"></input>
						        </c:when>
						        <c:otherwise>
						        	<input class="usingCheckbox" type="checkbox" name="usingChkBox"
							value="C${prdctClens.prdctId}" onChange="pntUsingChk('C${prdctClens.prdctId}', CHANGE);"></input>
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
				<c:forEach var="prdctAcc" items="${listAcc}" varStatus="status" >
					<tr class="listData" height="66">
						<td>${prdctAcc.prdctName}</td>
						<%-- <td>${prdctAcc.colorName}</td> --%>
						<td>${prdctAcc.prdctCnt}</td>
						<td><fmt:formatNumber value="${prdctAcc.prc}" pattern="#,###" /></td>
						<td style="text-align: right;"><fmt:formatNumber
								value="${prdctAcc.prc*prdctAcc.prdctCnt}" pattern="#,###" /></td>
								
						<td><input class="prcnt_number" type="number" value='${prdctAcc.dscntPrcnt}' size="3" name="dscnt_prcnt_number"
								id="dscnt_input_numberA${prdctAcc.prdctId}"
								onClick="resetInput(dscnt_input_numberA${prdctAcc.prdctId},'A${prdctAcc.prdctId}');"
								onChange="changeDscntPrcnt(this,'A${prdctAcc.prdctId}','${prdctAcc.prc}','${prdctAcc.prdctCnt}',TY_LENS); return false;"
								onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;" onclick="clearValue(id)">%
						</td>
						
						<td>
							<p id="dscntPriceA${prdctAcc.prdctId}">
								<fmt:formatNumber value= "${prdctAcc.prc*prdctAcc.prdctCnt*((100-prdctAcc.dscntPrcnt)/100)}" pattern="#,###" />
							</p>
						</td>
						<td>
						
						<c:choose>
					        <c:when test="${prdctAcc.earnPrcnt =='5'}">
					        	<input class="earnCheckbox" type="checkbox" name="earnChkBox" value="A${prdctAcc.prdctId}" checked
								onChange="changePointPrcnt('A${prdctAcc.prdctId}', CHANGE);" ></input>
					        </c:when>
					        <c:otherwise>
					        	<input class="earnCheckbox" type="checkbox" name="earnChkBox" value="A${prdctAcc.prdctId}"
								onChange="changePointPrcnt('A${prdctAcc.prdctId}', CHANGE);" ></input>
					        </c:otherwise>
				    	</c:choose>
						</td>
						<td>&nbsp;</td>
						<td hidden>
							<p id="pointPriceA${prdctAcc.prdctId}">
								<fmt:formatNumber value= "${prdctAcc.prc*prdctAcc.prdctCnt*((100-prdctAcc.dscntPrcnt)/100)*(prdctAcc.earnPrcnt/100)}" pattern="#,###" />
							</p>
						</td>
						<td>&nbsp;</td>
						<td hidden>
							<c:choose>
						        <c:when test="${prdctAcc.usingPoint =='1'}">
						        	<input class="usingCheckbox" type="checkbox" name="usingChkBox" checked
							value="A${prdctAcc.prdctId}" onChange="pntUsingChk('A${prdctAcc.prdctId}', CHANGE);"></input>
						        </c:when>
						        <c:otherwise>
						        	<input class="usingCheckbox" type="checkbox" name="usingChkBox"
							value="A${prdctAcc.prdctId}" onChange="pntUsingChk('A${prdctAcc.prdctId}', CHANGE);"></input>
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
					<script>
			    		fncSum_init('${prdctAcc.prc*prdctAcc.prdctCnt}');
			    		fncDscntSum_init('${prdctAcc.prc}','${prdctAcc.prdctCnt}','${prdctAcc.dscntPrcnt}');
			    		//fncPointSum_init('${prdctAcc.prc*prdctAcc.prdctCnt*((100-prdctAcc.dscntPrcnt)/100)*(prdctAcc.earnPrcnt/100)}');
			    		fncPointSum_init('${prdctAcc.prc}','${prdctAcc.prdctCnt}','${prdctAcc.dscntPrcnt}','${prdctAcc.earnPrcnt}');
			    		
			    	</script>
				</c:forEach>
				<!-- End Accs. -->
				
				<!-- @@ newPrdct. -->
				<c:forEach var="newPrdct" items="${newPrdct}" varStatus="status" >
					<tr class="listData" height="66">
						<td>${newPrdct.prdctName}</td>
						<%-- <td>${newPrdct.colorName}</td> --%>
						<td>${newPrdct.prdctCnt}</td>
						<td><fmt:formatNumber value="${newPrdct.prc}" pattern="#,###" /></td>
						<td style="text-align: right;"><fmt:formatNumber
								value="${newPrdct.prc*newPrdct.prdctCnt}" pattern="#,###" /></td>
								
						<td><input class="prcnt_number" type="number" value='${newPrdct.dscntPrcnt}' size="3" name="dscnt_prcnt_number"
								id="dscnt_input_numberN${newPrdct.prdctId}"
								onClick="resetInput(dscnt_input_numberN${newPrdct.prdctId},'N${newPrdct.prdctId}');"
								onChange="changeDscntPrcnt(this,'N${newPrdct.prdctId}','${newPrdct.prc}','${newPrdct.prdctCnt}',TY_LENS); return false;"
								onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;" onclick="clearValue(id)">%
						</td>
						
						<td>
							<p id="dscntPriceN${newPrdct.prdctId}">
								<fmt:formatNumber value= "${newPrdct.prc*newPrdct.prdctCnt*((100-newPrdct.dscntPrcnt)/100)}" pattern="#,###" />
							</p>
						</td>
						<td>
						
						<c:choose>
					        <c:when test="${newPrdct.earnPrcnt =='5'}">
					        	<input class="earnCheckbox" type="checkbox" name="earnChkBox" value="N${newPrdct.prdctId}" checked
								onChange="changePointPrcnt('N${newPrdct.prdctId}', CHANGE);" ></input>
					        </c:when>
					        <c:otherwise>
					        	<input class="earnCheckbox" type="checkbox" name="earnChkBox" value="N${newPrdct.prdctId}"
								onChange="changePointPrcnt('N${newPrdct.prdctId}', CHANGE);" ></input>
					        </c:otherwise>
				    	</c:choose>
						</td>
						<td>&nbsp;</td>
						<td hidden>
							<p id="pointPriceN${newPrdct.prdctId}">
								<fmt:formatNumber value= "${newPrdct.prc*newPrdct.prdctCnt*((100-newPrdct.dscntPrcnt)/100)*(newPrdct.earnPrcnt/100)}" pattern="#,###" />
							</p>
						</td>
						<td>&nbsp;</td>
						<td hidden>
							<c:choose>
						        <c:when test="${newPrdct.usingPoint =='1'}">
						        	<input class="usingCheckbox" type="checkbox" name="usingChkBox" checked
										value="N${newPrdct.prdctId}" onChange="pntUsingChk('N${newPrdct.prdctId}', CHANGE);"></input>
						        </c:when>
						        <c:otherwise>
						        	<input class="usingCheckbox" type="checkbox" name="usingChkBox"
										value="N${newPrdct.prdctId}" onChange="pntUsingChk('N${newPrdct.prdctId}', CHANGE);"></input>
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
				<td colspan="9" align="center">상품 데이터가 없습니다.</td>
			</tr>
		</c:otherwise>

	</c:choose>
	
	<tr height="46">
		<td>가격합계</td>
		<td>&nbsp;</td>
		<td>할인 전:</td>
		<td><p id="total_txt" style="text-align: right;"></p></td>
		<td>할인 후:</td>
		<td><p id="dscnt_total_txt" style="text-align: center;"  ></p></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	<tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr>


	<tr>
		<td height="42">기타할인</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		
		<td colspan="3">
			<input type="text" id="etcDscntMemo_txt"
			name="etcDscntMemo_txt" value="" placeholder="1000원 이하 할인 등."
			size="255" onclick="clearValue(id);"></input>
		</td>
		<td>
			<input class="payment_number" type="number" pattern="[0-9]*" id="etcDscnt_txt"
					name="etcDscnt_txt" onChange="setEtcDscnt();"
					placeholder="숫자만 입력 가능." size="15" onclick="clearValue(id);">
		
		</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	
	<tr>
		<td height="3" colspan="9">
			<img src="<c:url value="/images/content/Whiteline.jpg" />"
				alt="line" width="800" height="1" />
		</td>
	</tr>

	<tr>
		<td height="48" >현금</td>
		<td colspan="5">&nbsp;</td>
		<td><input class="payment_number" type="number" pattern="[0-9]*" id="cash_txt"
			name="cash_txt" onChange="calcPrice();"
			placeholder="숫자만 입력 가능." size="15" value=0
			onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;" onclick="clearValue(id);"></input></td>
			
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>

	<tr height="45">
		<td>카드</td>
		
		
		<td colspan="2">
			<select id='slct_card_com' name='slctCardCom' ">
				<c:forEach items="${listCardCom}" var="card" varStatus="status">
					<c:choose>
				        <c:when test="${card.cardComId == '12'}">
				        	<option value="${card.cardComId}" selected="selected">${card.cardComName}</option>
				        </c:when>
				        <c:otherwise>
				        	<option value="${card.cardComId}">${card.cardComName}</option>
				        </c:otherwise>
				        </c:choose>
					
				</c:forEach>
			</select>
		</td>
		<td>결제일</td>
		<td colspan="2">
			<!-- <input type="date" id="card_date" > -->
			<input type="text" id="card_date" >
			<script>
				$('#card_date').datepicker({ dateFormat: 'yy.mm.dd',defaultDate: new Date() });
				//$('#card_date').datepicker( 'setDate', new Date());
			</script>
		</td>
		<td>
			<input class="payment_number" type="number" id="card_txt" pattern="[0-9]*"
			name="card_txt" onChange="calcPrice();" placeholder="숫자만 입력 가능." size="15" value=0
			onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;" onclick="clearValue(id)">
			</input>
		</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>

	<tr height="45">
		<td>포인트</td>
		
		
		<td colspan="2">
			<input type="button" value="저장 후 검색" id="btnSearchFmlyCd"
				style="height:50px; width:100px" onClick="fncSearchFmlyCd();">
		</td>
		
		<td onclick= "fncGetPointHistory(); return false;">
			<span id=fmly_name_txt></span><span id=fmly_cd_txt hidden></span>
		</td>
		<td>포인트</td>
		<td onclick= "fncGetPointHistory(); return false;">
			<span id=total_point_txt>
				<fmt:formatNumber value="" pattern="#,###" />
			</span>
		</td>
		<td hidden>사용한도:</td>
		<td hidden>
		<span id=limit_point_txt></span>
		<fmt:formatNumber value="" pattern="#,###" />
		</td>
		<td>
			<input class="payment_number" type="number" pattern="[0-9]*" id="point_txt"
				name="point_txt" onChange="calcLimit();"
				placeholder="숫자만 입력 가능." size="15" value=0
				onkeypress="if (event.keyCode<48|| event.keyCode>57) event.returnValue=false;" onclick="clearValue(id)">
			</input>
		</td>
	
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<script>
			calcTotalPrice4Point();
			calcLimit();
		</script>
	</tr>

	<tr>
		<td height="3" colspan="9"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" />
		</td>
	</tr>
	
	<tr height="42">
		<td>선금</td>
		<td colspan="5">&nbsp;</td>
		<td style="text-align: right;" ></span>
			<fmt:formatNumber value="${saleVo.payCard+saleVo.payCash+saleVo.payPoint}" 
							  pattern="#,###" />
		</td>
		
	</tr>
	<tr style="text-align: right">
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td><span id="deposit" style="font-size: 15px;"></td>
	</tr>
	<tr>
		<td height="42">결제금액</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td style="text-align: right;" >
			<span id="remainedPayment_txt">
				<fmt:formatNumber value="" pattern="#,###" />
			</span>
		</td>
		<script>
			g_remainedPayment = g_dscntTotal-prePayment-etcDscnt;
			document.getElementById("remainedPayment_txt").innerHTML = format(String((g_remainedPayment)));
		</script>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="3" colspan="9">
			<img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" />
		</td>
	</tr>
	
	<tr height="42">
		<td>잔액</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td style="text-align: right;" ><span id="penny_txt"></span></td>
		<script>
		calcPrice();
		</script>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr height="42">
		<td>적립예정</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>		
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>100 단위 적립</td>
		<td style="text-align: right;" >
			<span id="point_total_txt">
				<fmt:formatNumber value="" pattern="#,###" />
			</span>
		</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>

	<script>
		fncPointSum_init_final();
	</script>
</table>
<div id="dlgPartnerInfo" title="할인정보"></div>
<div id="dlgPointHist" title="포인트 내역"></div>

<br>
<div id="couponDiv">
<center>
	<form action="" id="couponForm">
		<table width="90%" style="text-align: center">
			<tr>
				<td><input type="text" id="cstmrName" style="height: 40px; width: 120px; font-size: 25px;" placeholder="이름" > </td>
			</tr>
			<tr>
				<td>
					<input type="tel" id="cellphone"style="height: 40px; width: 200px; font-size: 25px;" placeholder="휴대전화(4자리)" ><br>OR<br>
					<input type="tel" id="telephone"style="height: 40px; width: 200px; font-size: 25px;" placeholder="유선전화(4자리)" >
				</td>
			</tr>
			<tr style="text-align: center">
				<td> <button onclick="srchCoupon(); return false;" style="height: 30px" id="srch_">검색</button></td>
			</tr>
			<tr>
				<td>
					<img src="${ctxPath	}/images/black2_line.jpg" width="200px">
					 <br>OR<br>					
					 <img src="${ctxPath}/images/black2_line.jpg" width="200px">
				</td>
			</tr>
			<tr>
				<td><input type="tel" id="inputCd" style="height: 40px; width: 200px; font-size: 25px;" placeholder="쿠폰코드" ></td>
			</tr>
			<tr style="text-align: center">
				<td> <button onclick="inputCoupon(); return false;" style="height: 30px" id="input_">바로입력</button></td>
			</tr>
			
			
			
			
		</table>
	</form>
</center>
</div>