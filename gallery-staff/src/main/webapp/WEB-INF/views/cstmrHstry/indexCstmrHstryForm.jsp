

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/cstmrHstryLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>

<%@ page import="com.gallery.common.CommonCode"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<link rel="stylesheet" type="text/css" href="${ctxPath}/css/tableForm.css">

<script>

function removeSign(str){
	str = str.replace(/\+/gi,"");
	return str;
}

function convertEnterToTab(obj,index){
	var value = removeSign(obj.value);
	if (event.keyCode == 13) {
		 if(value.length=="5"){
			 alert("입력 범위를 초과하였습니다.");
			 $("[tabindex=" + index + "]").focus();
			 obj.value = "";
			 return;
		 }
		 $("[tabindex=" + (index+1) + "]").focus();
		 $("[tabindex=" + (index+1) + "]").val("");

	}
	 if(value.length=="5"){
		 alert("입력 범위를 초과하였습니다.");
		 $("[tabindex=" + index + "]").focus();
		 obj.value = "";
	 }
// 	 console.log(obj.value);
}
$(function(){
	$(".btn").button();
	$(".popup").popup();
	$(".navbar").navbar();
	$(".input").textinput();
	$(".text").text();
	$('#oldbtmBtn1').button();

	//$("[data-role=controlgroup]").controlgroup("refresh");
});

function addPrdctJQM(){
	$("[data-role=controlgroup]").controlgroup("refresh");
	$("#addPrdctJQM").popup('open');
}

function ObjectCopy(obj)
{
	/* console.log('run ObjectCopy');
	console.log('obj:'+obj); */

	var strTmp = JSON.stringify(obj);
	//console.log('strTmp:'+strTmp);
	return JSON.parse(strTmp);
}

//Payment(payId,payCash,payCard,payPoint,fmlyCd,datetime,cancel,cardTy,cardDate){
function checkPayValidation(payCash, payCard, payPoint, datetime){
	if(payCash == '0' && payCard =='0' && payPoint =='0'){alert('결제금액이 누락되었습니다.'); return false;}
	if(!datetime){alert('결제일이 누락 되었습니다.'); return false;}

	return true;
}

function checkValidation(name, prdctTy, cnt, prc, dscntPrc){
	if(!name){alert('제품 이름이 누락되었습니다.'); return false;}
	if(!prdctTy || prdctTy=='0'){alert('제품 종류가 누락되었습니다.'); return false;}
	if(!cnt){alert('제품 수량이 누락되었습니다.'); return false;}
	if(!prc && prc != 0){alert('제품 가격이 누락되었습니다.'); return false;}
	//if(!dscntPrc){alert('제품 할인율이 누락되었습니다.'); return false;}
	return true;
}

function getTy(str,isNew){
	str = str.toString();
	if(isNew==0){
		if(Left(str,1)=='N'){
			return 	str.substr(1,2);
		}else{
			return Left(str,1);
		}
	}else if(isNew==1){
		if(Left(str,1)=='N'){
			return 	str.substr(1,1);
		}else{
			return Left(str,1);
		}
		return Left(str,1);
	}else{
// 		console.log('bug! getTy');
	}

}
function getPid(str,isNew){
// 	console.log('str:'+str);
// 	console.log('isNew:'+isNew);
	str = str.toString();
	if(isNew==0){
		if(Left(str,1)=='N'){
			return 	Right(str,str.length-2);
		}else{
			return 	Right(str,str.length-1);
		}
	}else if((isNew==1)){
		if(Left(str,1)=='N'){
			return 	Right(str,str.length-2);
		}else{
			return Right(str,str.length-1);
		}

	}else{
// 		console.log('bug! getPid');
	}

}


function EyeCheck(histId,shopId,
		gsphRight,gcylRight,gaxisRight,addRight,pdRight,npcRight,npaRight,prismRight,baseRight,
		gsphLeft,gcylLeft,gaxisLeft,addLeft,pdLeft,npcLeft,npaLeft,prismLeft,baseLeft,
		lsphRight,lcylRight,laxisRight,bcRight,diaRight,
		lsphLeft,lcylLeft,laxisLeft,bcLeft,diaLeft,domEye){
	this.histId=histId+'';
	this.shopId=shopId+'';
	this.gsphRight=encodeURIComponent(gsphRight);
	this.gcylRight=encodeURIComponent(gcylRight);
	this.gaxisRight=encodeURIComponent(gaxisRight);
	this.addRight=encodeURIComponent(addRight);
	this.pdRight=encodeURIComponent(pdRight);
	this.npcRight=encodeURIComponent(npcRight);
	this.npaRight=encodeURIComponent(npaRight);
	this.prismRight=encodeURIComponent(prismRight);
	this.baseRight=encodeURIComponent(baseRight);
	this.gsphLeft=encodeURIComponent(gsphLeft);
	this.gcylLeft=encodeURIComponent(gcylLeft);
	this.gaxisLeft=encodeURIComponent(gaxisLeft);
	this.addLeft=encodeURIComponent(addLeft);
	this.pdLeft=encodeURIComponent(pdLeft);
	this.npcLeft=encodeURIComponent(npcLeft);
	this.npaLeft=encodeURIComponent(npaLeft);
	this.prismLeft=encodeURIComponent(prismLeft);
	this.baseLeft=encodeURIComponent(baseLeft);
	this.lsphRight=encodeURIComponent(lsphRight);
	this.lcylRight=encodeURIComponent(lcylRight);
	this.laxisRight=encodeURIComponent(laxisRight);
	this.bcRight=encodeURIComponent(bcRight);
	this.diaRight=encodeURIComponent(diaRight);
	this.lsphLeft=encodeURIComponent(lsphLeft);
	this.lcylLeft=encodeURIComponent(lcylLeft);
	this.laxisLeft=encodeURIComponent(laxisLeft);
	this.bcLeft=encodeURIComponent(bcLeft);
	this.diaLeft=encodeURIComponent(diaLeft);
	this.domEye=domEye+'';
}

function PDscnt (pId,prcnt){
	this.pId = pId+'' ;
	this.prcnt = prcnt+'';
}

function ObjPrdct(prdctId, prdctTy, prdctName, prdctCnt, tradePrc, dscntPcnt, isEarn, isAsm, isDlvr, isNew, addCnt, dtrCnt){
	this.prdctId = prdctId+'';
	this.prdctId = prdctId+'';
	this.prdctTy = prdctTy+'';
	this.prdctName = prdctName+'';
	this.prdctCnt = prdctCnt+'';
	this.tradePrc = tradePrc+'';
	this.dscntPcnt = dscntPcnt+'';
	this.isEarn = isEarn+'';
	this.isAsm = isAsm+'';
	this.isDlvr = isDlvr+'';
	this.isNew = isNew+'';
	this.addCnt = addCnt+'';
	this.dtrCnt = dtrCnt+'';
}

function Payment(payId,payCash,payCard,payPoint,datetime,cardTy,cardDate,cancel){
	this.payId = payId+'';
	this.payCash = payCash+'';
	this.payCard = payCard+'';
	this.payPoint = payPoint+'';
	this.datetime = datetime+'';
	this.cardTy = cardTy+'';
	this.cardDate = cardDate+'';
	this.cancel = cancel+'';
}

function EtcDscnt(memo,mount){
	this.memo = encodeURIComponent(memo);

	this.mount = mount+'';
}
/* function Point(mId,minus,pId,plus){
	this.mId = mId;
	this.minus=minus;
	this.pId = pId;
	this.plus=plus;
} */

var arrCrtPrdct = new Array();
var arrAddPrdct = new Array();
var arrEditPrdct = new Array();
var arrDelPrdct = new Array();

var arrAddPayment = new Array();
var arrRfndPayment = new Array();
var arrEditPayment = new Array();
var arrDelPayment = new Array();

function JsonSale (saleId,staffId,datetime,pDscnt,ognPrice, dscntPrice,	payCash, payCard, payPoint,	memo
					,etcDscnt,result, point, eyeCheck, birthCoupon, cancelCoupon, fmlyCd, cstmrId, shopId, earnPrcnt, cstmrCd, today
					,arrCrtPrdct,arrAddPrdct,arrEditPrdct,arrDelPrdct,arrAddPayment,arrRfndPayment,arrEditPayment,arrDelPayment,inputDate){

// 	console.log('new JsonSale!!!');
	this.saleId = saleId+'';
	this.staffId = staffId+'';
	this.datetime = datetime;
	this.pDscnt = pDscnt;

	this.ognPrice = ognPrice+'';
	this.dscntPrice = dscntPrice+'';
	this.payCash = payCash+'';
	this.payCard = payCard+'';
	this.payPoint = payPoint+'';
	this.memo = encodeURIComponent(memo+'');

	this.etcDscnt = etcDscnt;
	this.result = result+'';
	this.point = point+'';
	this.eyeCheck = eyeCheck;

	this.birthCoupon = birthCoupon;
	this.cancelCoupon = cancelCoupon;
	fmlyCd = this.fmlyCd;
	this.cstmrId = cstmrId+'';
	this.shopId = shopId+'';
	this.earnPrcnt  = earnPrcnt+'';
	this.cstmrCd = cstmrCd+'';
	this.today = today+'';

	this.arrCrtPrdct=arrCrtPrdct;
	this.arrAddPrdct=arrAddPrdct;
	this.arrEditPrdct=arrEditPrdct;
	this.arrDelPrdct=arrDelPrdct;

	this.arrAddPayment = arrAddPayment;
	this.arrRfndPayment = arrRfndPayment;
	this.arrEditPayment = arrEditPayment;
	this.arrDelPayment = arrDelPayment;
	this.inputDate = inputDate;

}

var mapInvnPrdct={};
var mapNewPrdct={};
var mapInvnDtrCnt = {};
var mapInvnAddCnt = {};

var mapOrgPay={};
var mapNewPay={};
//var arrNewPrdct = new Array();

var jsonSale;
var arrInitInvnId = new Array();
var arrAddInvnId = new Array();
var arrDelInvnId = new Array();

var arrInitNewId = new Array();
var arrAddNewId = new Array();
var arrDelNewId = new Array();
var addNewId=0;

var g_flagAdd = true;

var g_earnPrcnt=0;
var g_couponCd ='';
var g_couponShop ='';
var g_couponDate ='';
var g_usedCouponCd = '';
var g_taxBigo = '';

var arrInitPay = new Array();
var arrAddPay = new Array();
var arrRfndPay = new Array();
var arrDelPay = new Array();
var payNum = 0;


function saveSale(){
	//console.log('run saveSale');
	//console.log('jsonSale.shopId:'+jsonSale.shopId);
	//console.log('jsonSale'+JSON.stringify(jsonSale));
	//console.log('shopVo.shopId:'+'${shopVo.shopId}');
	if(jsonSale.shopId != 0  && jsonSale.shopId != '${shopVo.shopId}'){
		alert('타 매장 기록은 수정하실 수 없습니다.');
		return;
	}

	if($("#staffNameH option:selected").text() == '선택해주세요'){
		alert('담당자 기록이 누락되었습니다.');
		return;
	}


	//console.log('JSON:'+JSON.stringify(jsonSale));
	var tmpPartner = $('#slctPartner').val();
	var tmpArr = tmpPartner.split('@');
	var partnerId =  tmpArr[0];
	var cancleCoupon = jsonSale.cancelCoupon;
// 	console.log('tmpPartner:'+partnerId);
// 	console.log('partnerId:'+partnerId);
// 	console.log('cancleCoupon:'+cancleCoupon);

	//생일쿠폰으로 되어있고 쿠폰취소에 값이 있을 경우...
	if(partnerId=='2' && cancleCoupon){
// 		console.log('g_couponCd:'+g_couponCd);
// 		console.log('g_couponShop:'+g_couponShop);
// 		console.log('g_couponDate:'+g_couponDate);
// 		console.log('g_usedCouponCd:'+g_usedCouponCd);
		if(g_couponShop!='0'){
			alert('사용할 수 없는 쿠폰입니다.');
			return;
		}
	}

	jsonSale.arrAddPrdct = new Array();
	jsonSale.arrEditPrdct = new Array();
	jsonSale.arrDelPrdct = new Array();
	jsonSale.arrAddPayment = new Array();
	jsonSale.arrRfndPayment = new Array();
	jsonSale.arrEditPayment = new Array();
	jsonSale.arrEditPayment = new Array();
	//end init.

	jsonSale.arrCrtPrdct= ObjectCopy(arrCrtPrdct);

	var saveJsonSale = ObjectCopy(jsonSale);

	saveJsonSale = getSaleInfo(saveJsonSale);

	////제품 속성 변경 체크.
	saveJsonSale = checkEditPrdct(arrInitInvnId, mapInvnPrdct,0, saveJsonSale);
	if(!saveJsonSale){ return;}
	saveJsonSale = checkEditPrdct(arrInitNewId, mapNewPrdct,1, saveJsonSale);
	if(!saveJsonSale){ return;}

	// 제품 추가 체크
	saveJsonSale = checkAddPrdct(arrAddInvnId, 0, saveJsonSale);
	if(!saveJsonSale){ return;}
	saveJsonSale = checkAddPrdct(arrAddNewId, 1, saveJsonSale);
	if(!saveJsonSale){ return;}

	// 제품 삭제 체크
	saveJsonSale = checkDelPrdct(arrDelInvnId, 0, saveJsonSale);
	if(!saveJsonSale){ return;}
	saveJsonSale = checkDelPrdct(arrDelNewId, 1, saveJsonSale);
	if(!saveJsonSale){ return;}


	//결제 변경 체크.
	saveJsonSale = checkEditPayment(arrInitPay,mapOrgPay,saveJsonSale);
	if(!saveJsonSale){ return;}
	//결제 추가 체크.
	saveJsonSale = checkAddPayment(arrAddPay, saveJsonSale);
	if(!saveJsonSale){ return;}
	//환불 추가 체크.
	saveJsonSale = checkRfndPayment(arrRfndPay, saveJsonSale);
	if(!saveJsonSale){ return;}

	//결제 삭제 체크.
	saveJsonSale = checkDelPayment(arrDelPay, saveJsonSale);
	if(!saveJsonSale){ return;}

	//console.log("saveJsonSale:"+JSON.stringify(saveJsonSale));
// 	console.log('mapInvnPrdct:'+JSON.stringify(mapInvnPrdct));
// 	console.log(JSON.stringify(arrCrtPrdct));

	var json1 = JSON.stringify(saveJsonSale);
	jsonSale.fmlyCd = $('#fmly_cd_txt1').text();
	var json2 = JSON.stringify(jsonSale);

	if(json1==json2){
/* 		console.log('equal!');
		console.log("jsonSale:"+JSON.stringify(jsonSale));
		console.log("saveJsonSale:"+JSON.stringify(saveJsonSale)); */
		alert('변경 사항이 없습니다.');
		return;
	}else{
		if(confirm("저장 하시겠습니까?\n 이전 내용은 복구할 수 없습니다.")==false){
			return;
		}
// 		 console.log('no equal! need Edit');
// 		console.log("jsonSale:"+JSON.stringify(jsonSale));
 		//console.log("saveJsonSale:"+JSON.stringify(saveJsonSale));
		checkDiff(jsonSale,saveJsonSale);
	}

// 	console.log('save saleId:'+saleId);

	var url;
	var param;
	var isNew=true;
	$("#saleLoader").css("display","block");

	var tmpSaleId = Number(saleId);
	//console.log('type:' + typeof tmpSaleId);

	if(tmpSaleId===1){
 		//console.log("case 1");
 		//console.log('tmpSaleId:'+tmpSaleId);
 		//return;
		saveJsonSale.saleId = '1';
		url = '${ctxPath}/cstmrHstry/addCstmrHstry.do';
		param = "jsonString="+JSON.stringify(saveJsonSale);
	}else{
		isNew=false;
 		//console.log("case 2");
 		//console.log('tmpSaleId:'+tmpSaleId);
 		//return;
		url = '${ctxPath}/cstmrHstry/modifyCstmrHstry.do';
		param = "jsonString="+JSON.stringify(saveJsonSale);
	}
	 $.ajax({
		url		: url,
		type 	: "post",
		data 	: param,
		dataType	: "text",
		success: function(data){
			$("#saleLoader").css("display","none");
			//console.log('data:'+data);
			var strData = data;
			var arrTmp = strData.split('@');
			if(arrTmp[0]!='success'){
				alert('저장 안됨. 문제발생. 전산실로 연락 바랍니다. ');
			}else{
				window.scrollTo(0, 0);
				alert('저장 완료.');
				getCstmrInfo();
				getVisitListForFrame();
				if(isNew == true){

				}else{
					getCheckInfo(saleId);
				}
			}
		}
	});
}

// saleId,staffId,datetime,pDscnt,ognPrice, dscntPrice,	payCash, payCard, payPoint,	memo
// ,etcDscnt,result, point, eyeCheck, birthCoupon, cancelCoupon, fmlyCd, cstmrId, shopId, earnPrcnt, cstmrCd, today
// ,arrCrtPrdct,arrAddPrdct,arrEditPrdct,arrDelPrdct,arrAddPayment,arrRfndPayment,arrEditPayment,arrDelPayment
function checkDiff(b,a){
	//console.log('run checkDiff');
	if(a.saleId != b.saleId){console.log('diff saleid!');}
	if(a.staffId != b.staffId){console.log('diff staffId!');}
	if(a.datetime != b.datetime){console.log('diff datetime!');}
	if(a.point != b.point){console.log('diff saleid!');}
	if(JSON.stringify(a.pDscnt) != JSON.stringify(b.pDscnt)){console.log('diff pDscnt!');}
	if(a.ognPrice != b.ognPrice){console.log('diff ognPrice!');}
	if(JSON.stringify(a.dscntPrice) != JSON.stringify(b.dscntPrice)){console.log('diff dscntPrice!');}
	if(a.payCash != b.payCash){console.log('diff payCash!');}
	if(a.payCard != b.payCard){console.log('diff payCard!');}
	if(a.payPoint != b.payPoint){console.log('diff payPoint!');}
	if(a.memo != b.memo){console.log('diff memo!');}
	if(JSON.stringify(a.etcDscnt) != JSON.stringify(b.etcDscnt)){console.log('diff etcDscnt!');}
	if(a.point != b.point){console.log('diff point!');}
	if(JSON.stringify(a.eyeCheck) != JSON.stringify(b.eyeCheck)){console.log('diff eyeCheck!');}
	if(a.birthCoupon != b.birthCoupon){console.log('diff birthCoupon!');}
	if(a.cancelCoupon != b.cancelCoupon){console.log('diff cancelCoupon!');}
	if(a.fmlyCd != b.fmlyCd){console.log('diff fmlyCd!');}
	if(a.cstmrId != b.cstmrId){console.log('diff cstmrId!');}
	if(a.shopId != b.shopId){console.log('diff shopId!');}
	if(a.earnPrcnt != b.earnPrcnt){console.log('diff earnPrcnt!');}
	if(a.cstmrCd != b.cstmrCd){console.log('diff cstmrCd!');}
	if(a.today != b.today){console.log('diff today!');}
// 	if(JSON.stringify(a.arrCrtPrdct) != JSON.stringify(b.arrCrtPrdct))	{console.log('diff arrCrtPrdct!');}
	if(JSON.stringify(a.arrAddPrdct) != JSON.stringify(b.arrAddPrdct))	{console.log('diff arrAddPrdct!');}
	if(JSON.stringify(a.arrEditPrdct) != JSON.stringify(b.arrEditPrdct))	{console.log('diff arrEditPrdct!');
// 	console.log('a:'+JSON.stringify(a.arrEditPrdct));
//  	console.log('b:'+JSON.stringify(b.arrEditPrdct));
	}
	if(JSON.stringify(a.arrDelPrdct) != JSON.stringify(b.arrDelPrdct))	{console.log('diff arrDelPrdct!');}
	if(JSON.stringify(a.arrAddPayment) != JSON.stringify(b.arrAddPayment))	{console.log('diff arrAddPayment!');}
	if(JSON.stringify(a.arrRfndPayment) != JSON.stringify(b.arrRfndPayment))	{console.log('diff arrRfndPayment!');}
	if(JSON.stringify(a.arrEditPayment) != JSON.stringify(b.arrEditPayment))	{console.log('diff arrEditPayment!');
// 	console.log('a:'+JSON.stringify(a.arrEditPayment));
// 	console.log('b:'+JSON.stringify(b.arrEditPayment));
	}
	if(JSON.stringify(a.arrDelPayment) != JSON.stringify(b.arrDelPayment))	{console.log('diff arrDelPayment!');}
// 	console.log('End of diff!');
}

function getSaleInfo(jsonSale)
{
	//console.log('run getSaleInfo');
// 	console.log("run saveSale in cstmrHist");
	var getPoint = removeComma($('#point_total_txt').text())+'';
	jsonSale.point = getPoint;


	var staffId = ($('#staffNameH').val()=='0') ? $('#staffIdH').text() : $('#staffNameH').val();
	//console.log('staffId:'+staffId);
	jsonSale.staffId = staffId;

	var dateTime = $('#visitDateH').val();
	//console.log('datetime:'+dateTime);
	dateTime = dateTime.replace('-','.');
	dateTime = dateTime.replace('-','.');
	jsonSale.datetime = dateTime;

	var tmpPartner = $('#slctPartner').val();
	var tmpArr = tmpPartner.split('@');
	var partnerId =  tmpArr[0];
	if(partnerId=='2'){
		if(!$('#birthCoupon').val()){
			jsonSale.birthCoupon = '';
		}else{
			jsonSale.birthCoupon = $('#birthCoupon').val();
		}
	}else{
		jsonSale.birthCoupon = '';
	}


// 	console.log('partnerId:'+partnerId);
	var partnerValue = removeComma($('#partnerDscnt_txt').val());
// 	console.log('partnerValue:'+partnerValue);
	var pDscnt = new PDscnt(partnerId,partnerValue);
	jsonSale.pDscnt = pDscnt;

	var ognPrice = removeComma($('#totalPrc').text())+'';
// 	console.log('ognPrice:'+ognPrice);
	var dscntPrice = removeComma($('#totalDscntPrc').text())+'';
// 	console.log('dscntPrc:'+dscntPrc);
	jsonSale.ognPrice = ognPrice;
	jsonSale.dscntPrice = dscntPrice;

	var arrCash = document.getElementsByName("payCash");
	var payCash=0;
	for(var i=0,size=arrCash.length;i<size;i++){
		//console.log('cashValue'+arrCash[i].value);
		payCash += removeComma(arrCash[i].value);
	}
// 	console.log('payCash:'+payCash);
	jsonSale.payCash = payCash+'';

	var payCard = 0;
	var arrCard = document.getElementsByName("payCard");
	for(var i=0,size=arrCard.length;i<size;i++){
		//console.log('CardValue'+arrCard[i].value);
		payCard += removeComma(arrCard[i].value);
	}
	//console.log('payCard:'+payCard);
	jsonSale.payCard = payCard+'';

	var payPoint = 0;
	var arrPoint = document.getElementsByName("payPoint");
	for(var i=0,size=arrPoint.length;i<size;i++){
		//console.log('PointValue'+arrPoint[i].value);
		payPoint += removeComma(arrPoint[i].value);
	}
// 	console.log('payPoint:'+payPoint);
	jsonSale.payPoint = payPoint+'';
	var tmpMemo = encodeURIComponent($('#memo_txtH').val());
	//console.log('tmpMemo:'+tmpMemo);
	jsonSale.memo = tmpMemo;



	var etcDscntPrcnt = removeComma($('#etcDscnt_txt').val());
// 	console.log('etcDscntPrcnt:'+etcDscntPrcnt);
	var etcDscntMemo = $('#etcDscntMemo_txt2').val();
// 	console.log('etcDscntMemo:'+etcDscntMemo);
	var tmpEtcDscnt = new EtcDscnt(etcDscntMemo, etcDscntPrcnt);
	jsonSale.etcDscnt = tmpEtcDscnt;

	// 선택 조건 - init 제품이나, add 제품이 하나 이상.
	// 검안 조건 - 그냥 무조건 pass
	// 조립 조건 - 체크박스 확인후 전부 체크되있으면 ok
	// 전달 조건 - 위와 동문
	// 결제 조건 - 잔액이 0원.
	// 제품 추가 체크
	var prdctCnt = arrInitInvnId.length+arrInitNewId.length+arrAddInvnId.length+arrAddNewId.length;
	var statSelect = (prdctCnt>0)? '1' : '0' ;

	var statEye ='1';

	var statAsmbly = '1';
	var inputElements = document.getElementsByTagName('input');
	for ( var i = 0; i < inputElements.length; ++i) {
		if(inputElements[i].className == "asmChk"){
			if(!inputElements[i].checked)
			{statAsmbly='0';}
		}
	}
	var statDlvry = '1';
	var inputElements = document.getElementsByTagName('input');
	for ( var i = 0; i < inputElements.length; ++i) {
		if(inputElements[i].className == "dlvryChk"){
			if(!inputElements[i].checked)
			{statDlvry='0';}
		}
	}
	var statPayment = '0';
	var penny = removeComma($('#penny_txt').text());
	if(penny==0){
		statPayment='1';
	}

	var result = statSelect+statEye+statAsmbly+statPayment+statDlvry;
	/* console.log('statSelect:'+statSelect);
	console.log('statEye:'+statEye);
	console.log('statAsmbly:'+statAsmbly);
	console.log('statDlvry:'+statDlvry);
	console.log('statPayment:'+statPayment);
	console.log('result:'+result);*/
	jsonSale.result = result;

	//eyeCheck info.
	var histId = $("#histId").text();
	var shopId = $("#shopId").text();
	var gsphRight = $("#gsphRight").val();
	var gcylRight = $("#gcylRight").val();
	var gaxisRight = $("#gaxisRight").val();
	var addRight = $("#addRight").val();
	var pdRight = $("#pdRight").val();
	var npcRight= $("#npcRight").val();
	var npaRight = $("#npaRight").val();
	var prismRight = $("#prismRight").val();
	var baseRight= $("#baseRight").val();

	var gsphLeft = $("#gsphLeft").val();
	var gcylLeft = $("#gcylLeft").val();
	var gaxisLeft= $("#gaxisLeft").val();
	var addLeft = $("#addLeft").val();
	var pdLeft= $("#pdLeft").val();
	var npcLeft =  $("#npcLeft").val();
	var npaLeft = $("#npaLeft").val();
	var prismLeft = $("#prismLeft").val();
	var baseLeft = $("#baseLeft").val();

	var lsphRight = $("#lsphRight").val();
	var lcylRight = $("#lcylRight").val();
	var laxisRight = $("#laxisRight").val();
	var bcRight = $("#bcRight").val();
	var diaRight = $("#diaRight").val();
	var lsphLeft = $("#lsphLeft").val();
	var lcylLeft = $("#lcylLeft").val();
	var laxisLeft = $("#laxisLeft").val();
	var bcLeft= $("#bcLeft").val();
	var diaLeft = $("#diaLeft").val();

	var domEye='0';

	if($("#domR").prop('checked')){
		domEye = $("#domR").val();
	}else if($("#domL").prop('checked')){
		domEye = $("#domL").val();
	}else{
		domEye = $("#domN").val();
	}
	//console.log('domEye:'+domEye);
	//console.log(	histId	,shopId,gsphRight,gcylRight,gaxisRight,addRight,pdRight,npcRight,npaRight,prismRight,baseRight,gsphLeft,gcylLeft,gaxisLeft,addLeft,pdLeft,npcLeft,npaLeft,prismLeft,baseLeft,lsphRight,lcylRight,laxisRight,bcRight,diaRight,lsphLeft,lcylLeft,laxisLeft,bcLeft,diaLeft');
	var eyeCheck = new EyeCheck(histId,shopId,gsphRight,gcylRight,gaxisRight,addRight,pdRight,npcRight,npaRight,prismRight,baseRight,gsphLeft,gcylLeft,gaxisLeft,addLeft,pdLeft,npcLeft,npaLeft,prismLeft,baseLeft,lsphRight,lcylRight,laxisRight,bcRight,diaRight,lsphLeft,lcylLeft,laxisLeft,bcLeft,diaLeft,domEye);
	//console.log('eyeCheck_JSON:'+JSON.stringify(eyeCheck));
	jsonSale.eyeCheck = eyeCheck;

	jsonSale.fmlyCd = $('#fmly_cd_txt1').text();

	jsonSale.inputDate = getToday();

	return jsonSale;
}

function checkAddPrdct(arrAddId, tyNew, saveJsonSale){
	//console.log('run checkAddPrdct');
	for(var i = 0;i<arrAddId.length;i++){
		//console.log('arrAddId['+i+']:'+arrAddId[i]);
		var tmpAddId  = arrAddId[i];
		//console.log('left3:'+Left(arrAddId[i],3));
		if(Left(arrAddId[i],3)!='Add'){
			tmpAddId = 'Add' + arrAddId[i];
		}
		var tmpPid='';
		//console.log('nomal name:'+$('#name'+tmpAddId).val());
		//console.log('uri name:'+ encodeURIComponent($('#name'+tmpAddId).val()));
		var addNewName = encodeURIComponent($('#name'+tmpAddId).val());
		var addNewPrdctTy = $('#slctTy'+tmpAddId).val();
		var addNewCnt = removeComma($('#cnt'+tmpAddId).val());
		var addNewPrc = removeComma($('#prc'+tmpAddId).val());
		var addNewDscntPrcnt = removeComma($('#dscntPrcnt'+tmpAddId).val());
		var addNewDcsntPrc = removeComma($('#dscntPrc'+tmpAddId).val());
		var addNewEarn = ($('#earn'+tmpAddId).attr('checked')) ? '5' : '0' ;
		var addNewAsm = ($('#asm'+tmpAddId).attr('checked')) ? '1':'0';
		var addNewDlvry = ($('#dlvry'+tmpAddId).attr('checked')) ? '1':'0';

		/* console.log('['+i+']addNewName :'+addNewName);
		console.log('['+i+']addNewPrdctTy :'+addNewPrdctTy);
		console.log('['+i+']addNewCnt :'+addNewCnt);
		console.log('['+i+']addNewPrc :'+addNewPrc);
		console.log('['+i+']addNewDscntPrcnt :'+addNewDscntPrcnt);
		console.log('['+i+']addNewDcsntPrc :'+addNewDcsntPrc);
		console.log('['+i+']addNewEarn :'+addNewEarn);
		console.log('['+i+']addNewAsm :'+addNewAsm);
		console.log('['+i+']addNewDlvry :'+addNewDlvry); */
		var addCnt = '0';
		var dtrCnt = '0';
		if(tyNew == 1){
			tmpNewTy='1';
			tmpPid = '0';
		}else{
			dtrCnt = addNewCnt;
			tmpNewTy='0';
			tmpPid = getPid(arrAddId[i],1);
		}

		if(!checkValidation(addNewName, addNewPrdctTy, addNewCnt, addNewPrc, addNewDscntPrcnt)){
			return false;
		}


		var newTy = (tyNew==1)?'1':'0';
		var addPrdct = new ObjPrdct(tmpPid,addNewPrdctTy,addNewName,addNewCnt,addNewPrc,addNewDscntPrcnt
									,addNewEarn,addNewAsm,addNewDlvry,newTy,addCnt,dtrCnt);
		saveJsonSale.arrAddPrdct.push(addPrdct);

	}
	return saveJsonSale;
}

function checkDelPrdct(arrDelId, tyNew, saveJsonSale){
	//console.log('run checkDelPrdct tyNew:'+tyNew);

	for(var i = 0;i<arrDelId.length;i++){
		//console.log('arrDelId['+i+']:'+arrDelId[i]);

		if(Left(arrDelId[i],3)=='Add'){
			continue;
		}
		var delPid = (tyNew==1)?getPid(arrDelId[i],1):getPid(arrDelId[i],0);
		var delPty = (tyNew==1)?getTy(arrDelId[i],1):getTy(arrDelId[i],0);
		//console.log('delPid:'+delPid);
		//console.log('delPty:'+delPty);

		if(!delPid){
			console.log('Error! delPid in checkDelPrdct ');
			return;
		}
		if(!delPty){
			console.log('Error! delPty in checkDelPrdct');
			return;
		}
		var addCnt='0';
		var dtrCnt='0';

// 		console.log('arrDelId[i]:'+arrDelId[i]);
		addCnt = mapInvnAddCnt[arrDelId[i]];
		dtrCnt = mapInvnDtrCnt[arrDelId[i]];
		addCnt = (addCnt)?addCnt:'0';
		dtrCnt = (dtrCnt)?dtrCnt:'0';
// 		console.log('addCnt:'+addCnt);
// 		console.log('dtrCnt:'+dtrCnt);

		var newTy = (tyNew==1)?'1':'0';
		var delPrdct = new ObjPrdct(delPid,delPty,'0'
									,'0','0','0'
									,'0','0','0',newTy,addCnt,dtrCnt);

		saveJsonSale.arrDelPrdct.push(delPrdct);
	}

	return saveJsonSale;
}

//arrInitInvnId, mapInvnPrdct
function checkEditPrdct(arrInitId, mapPrdct,tyNew, saveJsonSale){
	//console.log('run checkEditPrdct');
	for(var i = 0 ; i<arrInitId.length;i++){
		var tmpId = arrInitId[i];
		var tmpVal = mapPrdct[tmpId];
// 		console.log('tmpId['+i+']:'+tmpId);
// 		console.log('mapPrdct['+tmpId+']:'+tmpVal);
// 		console.log('mapPrdct['+tmpId+'] JSON:'+JSON.stringify(tmpVal));
		var tmpArr = tmpId.split('_');

		var tmpNewTy;//not need.
		var tmpPid;
		if(tyNew == 1){
			tmpNewTy='1';
			tmpPid = getPid(tmpId,1);
		}else{
			tmpNewTy='0';
			tmpPid = getPid(tmpId,0);
		}
		//console.log('tmpNewTy:'+tmpNewTy);
		//console.log('nomal name:'+$('#name'+tmpId).val());
		//console.log('uri name:'+ encodeURIComponent($('#name'+tmpId).val()));
		var tmpName = encodeURIComponent($('#name'+tmpId).val());

		var tmpPrdctTy = $('#slctTy'+tmpId).val();
		var tmpCnt = removeComma($('#cnt'+tmpId).val())+'';
		var tmpPrc = removeComma($('#prc'+tmpId).val())+'';
		var tmpDscntPrcnt = removeComma($('#dscntPrcnt'+tmpId).val())+'';
		var tmpDcsntPrc = removeComma($('#dscntPrc'+tmpId).val());

		var tmpEarn = ($('#earn'+tmpId).attr('checked')) ? '5' : '0' ;
		var tmpAsm = ($('#asm'+tmpId).attr('checked')) ? '1':'0';
		var tmpDlvry = ($('#dlvry'+tmpId).attr('checked')) ? '1':'0';

		//var tmpEarn = $('#earn'+tmpId).val();
		//var tmpAsm = $('#asm'+tmpId).val();
		//var tmpDlvry = $('#dlvry'+tmpId).val();

		console.log('tmpDscntPrcnt:'+tmpDscntPrcnt);

		if(!checkValidation(tmpName, tmpPrdctTy, tmpCnt, tmpPrc, tmpDscntPrcnt)){
			return false;
		}
		var addCnt='0';
		var dtrCnt='0';
		var editPrdct = new ObjPrdct(tmpPid,tmpPrdctTy,tmpName,tmpCnt,tmpPrc,tmpDscntPrcnt,
									tmpEarn,tmpAsm,tmpDlvry,tmpVal.isNew,addCnt,dtrCnt);

		if(JSON.stringify(tmpVal) == JSON.stringify(editPrdct)){
// 			console.log('['+i+']똑같다!');
// 			console.log('['+i+']bf'+JSON.stringify(tmpVal));
// 			console.log('['+i+']af'+JSON.stringify(editPrdct));
		}else{
// 			console.log('['+i+']다르다!');
// 			console.log('['+i+']bf'+JSON.stringify(tmpVal));
// 			console.log('['+i+']af'+JSON.stringify(editPrdct));
			saveJsonSale.arrEditPrdct.push(editPrdct);
		}
	}
	return saveJsonSale;
}

function checkEditPayment(arrInitPay, mapPayment, saveJsonSale){
	console.log('@run checkEditPayment:');
	//mapOrgPay
	//Payment(payId,payCash,payCard,payPoint,fmlyCd,datetime,cancel,cardTy,cardDate){
	for(var i = 0 ; i<arrInitPay.length;i++){
		var tmpId = arrInitPay[i];
		var tmpVal = mapPayment[tmpId];
  		//console.log('tmpId['+i+']:'+tmpId);
// 		console.log('mapPrdct['+tmpId+'] JSON:'+JSON.stringify(tmpVal));
		var tmpArr = tmpId.split('_');

		var tmpNewTy;

// 		console.log('tmpNewTy:'+tmpNewTy);
		var tmpPayCash = removeComma($('#payCash'+tmpId).val());
		var tmpPayCard = removeComma($('#payCard'+tmpId).val());
		var tmpPayPoint = removeComma($('#payPoint'+tmpId).val());
		var tmpDatetime = $('#payDate'+tmpId).val();
		var tmpCardTy = $('#paySlctCardCom'+tmpId).val();
		var tmpCardDate = $('#payDate'+tmpId).val();
		var tmpCancel = $('#cancel'+tmpId).val();

// 		console.log('tmpPayCash:'+tmpPayCash);
// 		console.log('tmpPayCard:'+tmpPayCard);
// 		console.log('tmpPayPoint:'+tmpPayPoint);
// 		console.log('tmpDatetime:'+tmpDatetime);
// 		console.log('tmpCardTy:'+tmpCardTy);

		if(!checkPayValidation(tmpPayCash, tmpPayCard, tmpPayPoint, tmpDatetime)){
			return false;
		}
		var editPayment = new Payment(tmpId,tmpPayCash,tmpPayCard
									,tmpPayPoint,tmpDatetime
									,tmpCardTy,tmpCardDate,tmpCancel);

		if(JSON.stringify(tmpVal) == JSON.stringify(editPayment)){
			/* console.log('['+i+']결제 정보 일치.!');
			console.log('['+i+']bf'+JSON.stringify(tmpVal));
			console.log('['+i+']af'+JSON.stringify(editPayment)); */
		}else{
			/* console.log('['+i+']결제 정보 다름!');
			console.log('['+i+']bf'+JSON.stringify(tmpVal));
			console.log('['+i+']af'+JSON.stringify(editPayment)); */
 			saveJsonSale.arrEditPayment.push(editPayment);
		}
	}
	return saveJsonSale;
}

function checkAddPayment(arrAddPay, saveJsonSale){
	//console.log('run checkAddPayment');
	for(var i = 0;i<arrAddPay.length;i++){
		var tmpId = arrAddPay[i];
		//console.log('arrAddPay['+i+'];'+tmpId);
		var tmpPayCash = removeComma($('#payCash'+tmpId).val());
		var tmpPayCard = removeComma($('#payCard'+tmpId).val());
		var tmpPayPoint = removeComma($('#payPoint'+tmpId).val());
		var tmpDatetime = $('#payDate'+tmpId).val();
		var tmpCardTy = $('#paySlctCardCom'+tmpId).val();
		var tmpCardDate = $('#payDate'+tmpId).val();
		//var tmpCancel = $('#cancel'+tmpId).val();
		var tmpCancel = '0';
		/* console.log('tmpPayCash:'+tmpPayCash);
		console.log('tmpPayCard:'+tmpPayCard);
		console.log('tmpPayPoint:'+tmpPayPoint);
		console.log('tmpDatetime:'+tmpDatetime);
		console.log('tmpCardTy:'+tmpCardTy); */

		if(!checkPayValidation(tmpPayCash, tmpPayCard, tmpPayPoint, tmpDatetime)){
			return false;
		}
		/* console.log('tmpPayCash:'+tmpPayCash);
		console.log('tmpPayCard:'+tmpPayCard);
		console.log('tmpPayPoint:'+tmpPayPoint);
		console.log('tmpDatetime:'+tmpDatetime);
		console.log('tmpCardTy:'+tmpCardTy); */
		tmpId = tmpId.replace('Add','');
		var addPayment = new Payment(tmpId,tmpPayCash,tmpPayCard
									,tmpPayPoint,tmpDatetime
									,tmpCardTy,tmpCardDate,tmpCancel);
		saveJsonSale.arrAddPayment.push(addPayment);
	}
	//console.log('JSON:'+JSON.stringify(saveJsonSale.arrAddPayment));
	return saveJsonSale;
}

function checkRfndPayment(arrRfndPay, saveJsonSale){
	//console.log('run checkRfndPayment');

	for(var i = 0;i<arrRfndPay.length;i++){
		var tmpId = arrRfndPay[i];
 		//console.log('arrRfndPay['+i+'];'+tmpId);
		var tmpPayCash = removeComma($('#payCash'+tmpId).val());
		var tmpPayCard = removeComma($('#payCard'+tmpId).val());
		var tmpPayPoint = removeComma($('#payPoint'+tmpId).val());
		var tmpDatetime = $('#payDate'+tmpId).val();
		var tmpCardTy = $('#paySlctCardCom'+tmpId).val();
		var tmpCardDate = $('#payDate'+tmpId).val();

		if(!checkPayValidation(tmpPayCash, tmpPayCard, tmpPayPoint, tmpDatetime)){
			return false;
		}
// 		console.log('tmpPayCash:'+tmpPayCash);
// 		console.log('tmpPayCard:'+tmpPayCard);
// 		console.log('tmpPayPoint:'+tmpPayPoint);
// 		console.log('tmpDatetime:'+tmpDatetime);
// 		console.log('tmpCardTy:'+tmpCardTy);
// 		var rfndPayment = new Payment(tmpId,tmpPayCash*-1,tmpPayCard*-1
// 									,tmpPayPoint*-1,tmpDatetime
// 									,tmpCardTy,tmpCardDate);
		tmpId = tmpId.replace('Rfnd','');
		var rfndPayment = new Payment(tmpId,tmpPayCash,tmpPayCard
									,tmpPayPoint,tmpDatetime
									,tmpCardTy,tmpCardDate,'2');
		saveJsonSale.arrRfndPayment.push(rfndPayment);
	}
	console.log('JSON:'+JSON.stringify(saveJsonSale.arrRfndPayment));
	return saveJsonSale;
}

function checkDelPayment(arrDelPay, saveJsonSale){
	console.log('run checkDelPayment');
	for(var i = 0;i<arrDelPay.length;i++){
		var tmpId = arrDelPay[i];
// 		console.log('del id:'+arrDelPay[i]);
// 		console.log('Left(arrDelPay[i],3)'+Left(arrDelPay[i],3));
		if(! ((Left(arrDelPay[i],3)=='Add' || (Left(arrDelPay[i],3)=='Rfn'))) ){
			var delPayment = new Payment(tmpId,'0','0'
										,'0','0'
										,'0','0','0');
			saveJsonSale.arrDelPayment.push(delPayment);
		}
	}
	console.log('JSON:'+JSON.stringify(saveJsonSale.arrDelPayment));
	return saveJsonSale;
}

	var writable = true;

	/* function toggle(){
		if(!writable){
			fncCheckWrite();
		}else{
			fncSave();
			writable = false;
		}
	} */

	function removeComma(str){
		if(!str){str='0';}
		//console.log('removeComma:'+str);
		str = str.toString();
		var result = str.replace(/,/gi,"");
		result = parseInt(result,10);
		return result;
	}

	function addComma(x) {
		if(!x){x=0;}
		//console.log('addComma:'+x);
		x = removeComma(x);
		x = parseInt(x,10);
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	var saleId;
	function changeClr(id){
		saleId = id;
		$(".redTr").css("color","red");
		$(".blackTr").css("color","black");
		$(".dateSpan").css("background-color","white");
		$("#" + id).css("background-color", "#81BEF7");
		//$("#" + id).css("color", "white");

		getCheckInfo(id);
		selectedId = id;
	}

	var selectedId;

	function visitDateMouseOver(id){
		if(selectedId!=id){
			$("#" + id).css("background-color", "#CEE3F6");
		}
	}

	function visitDateMouseOut(id){
		if(selectedId!=id){
			$("#" + id).css("background-color", "white");
		}
	}
	var g_shopName = '${shopVo.shopName}';
	var g_shopId = '${shopVo.shopId}';

	jQuery(document).ready(function() {
		console.log("SALE ID " + '${saleId}')

		$('#fixDate').val(getToday());
		var width = window.innerWidth;
		var height = window.innerHeight;
		$("#saleLoader").css("left",width/2-165);
		$("#saleLoader").css("top",height/2-60);
		getCstmrInfo();
		getVisitListForFrame();
		jQuery('#cstmrId').val('${cstmrId}');

		/* $("input:radio").each(function(index) {
		    $("<label>").text("")
		                .attr("for", this.id = "radio" + index + 1)
		                .insertAfter(this);
		}); */

		setCstmrHist();
		slctNavItem('frame');
		getNoticeInfo();
	});
	function getToday()
	{
		var fixedDate = window.sessionStorage.getItem("fixedDate");
		console.log('fixedDate:'+fixedDate);
		var returnDate;
		if(fixedDate){
			returnDate = fixedDate;
		}else{
			var date = new Date();

			var day = date.getDate();
			var month = date.getMonth() + 1;
			var year = date.getFullYear();
			if (month < 10) month = "0" + month;
			if (day < 10) day = "0" + day;
			var today = year + "-" + month + "-" + day;
			returnDate= today;
		}
		console.log('returnDate:'+returnDate);
		return returnDate;
	}

	function goPayment(){
		var url = '${ctxPath}/sale/modifygoPayment.do';
		var param = "saleId=" + saleId
									//+"&staffId="+"${staffVo.staffId}"+
									//"&payCard="+jsonSale.payCard+
									//"&payCash="+jsonSale.payCash+
									//"&payPoint="+jsonSale.payPoint+
									//"&datetime="+jsonSale.datetime
									;
		//alert(param);
		$.ajax({
		url		: url,
		type 	: "post",
		data 	: param,
		dataType	: "text",
	/* 	beforesend:function(){
			alert(param);
		}, */
		success: function(data){
	           if(data == 'success'){
								 alert('강제완료  성공');
								 //saveSale("payment")
	           }else{
	        	   alert('강제완료 실패');
	           					}
	           }
	 });

	}

	function setCstmrHist(){
		//console.log("set cstmrHist");
		var url = '${ctxPath}/shop/setShopCstmrHstry.do';
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: "cstmrId="+'${cstmrId}',
			dataType	: "text",
			success: function(data){
			}
		});
	}
	//----------------------
	var mCstmrCd;
	function fncSelectCstmr(cstmrCd) {
		mCstmrCd = cstmrCd;
	};
	function resetInputEye(param)
	{
		document.getElementById(param.id).value = '';
	}

	function getSaleMemoH(saleId){
		//var saleId = '${saleVo.saleId}';
		//console.log('run getSaleMemoH saleId:'+saleId);
		if(saleId==''||saleId==0){
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
				//$("#memo_txtH").html(decodeURIComponent(data));
				document.getElementById("memo_txtH").value = decodeURIComponent(data);
			}
		});
	}


	function getCheckInfo(saleId) {
		console.log('run getCheckInfo:'+saleId);
		//console.log(saleId);
		getPaymentedPrdctListData();

		if (saleId < 0) {
			return;
		}

		var url;
		if(saleId=="1"){
			$("#ctmrVisitTitle").html("처방생성");
			url = '${ctxPath}/cstmrHstry/getCheckDataInit.do';
		}else{
			$("#ctmrVisitTitle").html("진행상태");
			url = '${ctxPath}/cstmrHstry/getCheckData.do';
		}


		//var url = 'getCheckData.do';

		//javax
		$.ajax({
			url : url,
			type : "post",
			data : "saleId=" + saleId,
			dataType : "json",
			beforeSend : function() {
			},
			success : function(data) {
 				console.log('data:'+data);
 				console.log('data.isOld:'+data.isOld);

				if(data.isOld==0){
					$(".hiddenOld").css("display","none");
					$(".hiddenNew").css("display","inline");
				}else if(data.isOld==1){
					$(".hiddenNew").css("display","none");
					$(".hiddenOld").css("display","inline");
				}

				if(0==g_earnPrcnt){
					g_earnPrcnt =  data.earnPrcnt;
				}


 				//console.log('data.couponBirth:'+data.couponBirth);
 				console.log('@@@saleId@@@:'+data.saleId);
//  				console.log('g_earnPrcnt:'+g_earnPrcnt);
 				console.log('data.shopId:'+data.shopId);
 				console.log('data.cstmrId:'+data.cstmrId);
 				g_usedCouponCd = data.couponBirth;

 				if(!data.taxBigo){
 					g_taxBigo='발급된 적 없음';
 				}else{
 					g_taxBigo = '발급됨:'+data.taxBigo;
 				}


				var chk1;
				var chk2;
				var chk3;
				var chk4;
				var chk5;

				$("#chk1").removeClass("whiteTr");
				$("#chk2").removeClass("whiteTr");
				$("#chk3").removeClass("whiteTr");
				$("#chk4").removeClass("whiteTr");
				$("#chk5").removeClass("whiteTr");

				$("#chk1").removeClass("blueTr");
				$("#chk2").removeClass("blueTr");
				$("#chk3").removeClass("blueTr");
				$("#chk4").removeClass("blueTr");
				$("#chk5").removeClass("blueTr");

				if(data.result.substr(0,1)=="0"){
					$("#chk1").addClass("whiteTr");
				}else{
					$("#chk1").addClass("blueTr");
				}

				if(data.result.substr(1,1)=="0"){
					$("#chk2").addClass("whiteTr");
				}else{
					$("#chk2").addClass("blueTr");
				}

				if(data.result.substr(2,1)=="0"){
					$("#chk3").addClass("whiteTr");
				}else{
					$("#chk3").addClass("blueTr");
				}

				if(data.result.substr(3,1)=="0"){
					$("#chk4").addClass("whiteTr");
				}else{
					$("#chk4").addClass("blueTr");
				}

				if(data.result.substr(4,1)=="0"){
					$("#chk5").addClass("whiteTr");
				}else{
					$("#chk5").addClass("blueTr");
				}

				if(data.result=='11111'){
					//console.log('11111');
					//console.log('data.saleId:'+data.saleId);
					$('#'+data.saleId).removeClass('redTr');
					$('#'+data.saleId).addClass('blackTr');
					$('#'+data.saleId).css('color', 'black');
				}else{
					$('#'+data.saleId).removeClass('blackTr');
					$('#'+data.saleId).addClass('redTr');
					$('#'+data.saleId).css('color', 'red');
				}

				jQuery("#histId").text(data.histId);
				if(data.shopId){
					jQuery("#shopId").text(data.shopId);
				}else{
					jQuery("#shopId").text(g_shopId);
				}

				jQuery("#gsphRight").val(data.gsphRight);
				jQuery("#gcylRight").val(data.gcylRight);
				jQuery("#gaxisRight").val(data.gaxisRight);
				jQuery("#addRight").val(data.addRight);
				jQuery("#pdRight").val(data.pdRight);
				jQuery("#npcRight").val(data.npcRight);
				jQuery("#npaRight").val(data.npaRight);
				jQuery("#prismRight").val(data.prismRight);
				jQuery("#baseRight").val(data.baseRight);

				jQuery("#gsphLeft").val(data.gsphLeft);
				jQuery("#gcylLeft").val(data.gcylLeft);
				jQuery("#gaxisLeft").val(data.gaxisLeft);
				jQuery("#addLeft").val(data.addLeft);
				jQuery("#pdLeft").val(data.pdLeft);
				jQuery("#npcLeft").val(data.npcLeft);
				jQuery("#npaLeft").val(data.npaLeft);
				jQuery("#prismLeft").val(data.prismLeft);
				jQuery("#baseLeft").val(data.baseLeft);

				jQuery("#lsphRight").val(data.lsphRight);
				jQuery("#lcylRight").val(data.lcylRight);
				jQuery("#laxisRight").val(data.laxisRight);
				jQuery("#bcRight").val(data.bcRight);
				jQuery("#diaRight").val(data.diaRight);
				jQuery("#lsphLeft").val(data.lsphLeft);
				jQuery("#lcylLeft").val(data.lcylLeft);
				jQuery("#laxisLeft").val(data.laxisLeft);
				jQuery("#bcLeft").val(data.bcLeft);
				jQuery("#diaLeft").val(data.diaLeft);
				if(data.domEye=="1"){
					$('input:radio[name="domEye"]').filter('[value="1"]').attr('checked', true);
				}else if(data.domEye=="2"){
					$('input:radio[name="domEye"]').filter('[value="2"]').attr('checked', true);
				}else{// if(data.domEye=="0"){
					$('input:radio[name="domEye"]').filter('[value="0"]').attr('checked', true);
					$('input:radio[name="domEye"]').filter('[value="1"]').attr('checked', false);
					$('input:radio[name="domEye"]').filter('[value="2"]').attr('checked', false);
				}

				var eyeCheck = new EyeCheck(data.histId,data.shopId,data.
						gsphRight,data.gcylRight,data.gaxisRight,data.addRight,data.pdRight,data.npcRight,data.npaRight,data.prismRight,data.baseRight,data.
						gsphLeft,data.gcylLeft,data.gaxisLeft,data.addLeft,data.pdLeft,data.npcLeft,data.npaLeft,data.prismLeft,data.baseLeft,data.
						lsphRight,data.lcylRight,data.laxisRight,data.bcRight,data.diaRight,data.
						lsphLeft,data.lcylLeft,data.laxisLeft,data.bcLeft,data.diaLeft,data.domEye);

// 				console.log('@@saleId:'+data.saleId);
// 				console.log('@@staffid:'+data.staffId);
// 				console.log('@@memo:'+data.memo);
// 				console.log('@@datetime:'+data.datetime);
// 				console.log('@@partnerId:'+data.partnerId);
// 				console.log('@@partnerDscnt:'+data.partnerDscnt);
// 				console.log('@@etcDscnt:'+data.etcDscnt);
// 				console.log('@@etc_dscnt_memo:'+data.etcDscntMemo);
// 				console.log('@@ognPrice:'+data.ognPrice);
// 				console.log('@@dscntPrice:'+data.dscntPrice);
// 				console.log('@@payCash:'+data.payCash);
// 				console.log('@@payCard:'+data.payCard);
// 				console.log('@@payPoint:'+data.payPoint);
// 				console.log('@@result:'+data.result);

				var pDscnt =new PDscnt(data.partnerId,data.partnerDscnt);

				var etcDscnt = new EtcDscnt(data.etcDscntMemo,data.etcDscnt);
				var tmpMemo = (data.memo)? data.memo:'';

				var point=0;
				var birthCoupon;
				if(!g_usedCouponCd){
					birthCoupon = '';
				}else{
					birthCoupon = g_usedCouponCd;
				}
				var cstmrId ='${cstmrId}';
				var cstmrCd ='${cstmr.cstmrCd}';
// 				console.log('fmlyCd:'+fmlyCd);
// 				console.log('cstmrCd:'+cstmrCd);
				var cancelCoupon = '';
				var fmlyCd = $('#fmly_cd_txt1').text();

// 				(saleId,staffId,datetime,pDscnt,ognPrice, dscntPrice,payCash, payCard, payPoint,	memo
// 				,etcDscnt,result, point, eyeCheck, birthCoupon, cancelCoupon, fmlyCd, cstmrId, shopId, earnPrcnt, cstmrCd, today
// 				,arrCrtPrdct,arrAddPrdct,arrEditPrdct,arrDelPrdct,arrAddPayment,arrRfndPayment,arrEditPayment,arrDelPayment)

				var setShopId;
				if(0 != data.shopId){
					setShopId = data.shopId;
				}else{
					setShopId = g_shopId;
				}
			jsonSale = new JsonSale (data.saleId, data.staffId,data.datetime,pDscnt
					,data.ognPrice,data.dscntPrice,data.payCash,data.payCard,data.payPoint,tmpMemo
					,etcDscnt,data.result, point, eyeCheck, birthCoupon ,cancelCoupon
					,fmlyCd, cstmrId, setShopId , data.earnPrcnt, cstmrCd, getToday()
					,arrCrtPrdct,arrAddPrdct,arrEditPrdct,arrDelPrdct, arrAddPayment,arrRfndPayment,arrEditPayment,arrDelPayment,getToday());
				//console.log("JSON test:"+JSON.stringify(jsonSale));
				//shop and staff


				if(data.shopName){
					jQuery("#shopNameH").text(data.shopName);
				}else{
					jQuery("#shopNameH").text(g_shopName);
				}



				var stime;
				if(data.datetime){
					stime =data.datetime;
					stime = stime.replace('.','-');
					stime = stime.replace('.','-');
				}else{
					stime = getToday()
				}
				jQuery("#visitDateH").val(stime);

				/* jQuery("#staffNameH").text(data.staffName);
				console.log('staffName:'+data.staffName);
				jQuery("#staffIdH").text(data.staffId); */
// 				console.log('staffName:'+data.staffName);
// 				console.log('staffId:'+data.staffId);

				$('#staffIdH').text(data.staffId);
// 				console.log('hstShopId:'+data.shopId);

				if(data.shopId != '${shopVo.shopId}'){
					$('#staffNameH').prop('disabled', 'disabled');
					$("#staffNameH option[value='0']").text(data.staffName);

					$("#staffNameH option[value='0']").attr("selected", "selected");
				}else{
					$("#staffNameH option[value='0']").text(data.staffName);
					/* $("#staffNameH").val('0'); */
					$("#staffNameH option[value='0']").attr("selected", "selected");
				}

				if( (!data.staffName || data.shopId==0)){
					$('#staffNameH').prop('disabled', false);
					$("#staffNameH option[value='0']").text('선택해주세요');
					//$("#staffNameH option[value='0']").attr('선택해주세요');
					//$("#staffNameH option[value='0']").attr("selected", "selected");
					$("#staffNameH").val('${staffVo.staffId}');
				}
				/* $("#staffNameH").val("data.staffId"); */
				jQuery("#saleIdH").text(saleId);
				getSaleMemoH(saleId);
				jQuery('#gframe1').text(data.gframe1);
				jQuery('#gframe2').text(data.gframe2);
				jQuery('#gframe3').text(data.gframe3);
				jQuery('#glens1').text(data.glens1);
				jQuery('#glens2').text(data.glens2);
				jQuery('#glens3').text(data.glens3);
				jQuery('#clensL').text(data.clensL);
				jQuery('#clensR').text(data.clensR);
				jQuery('#gpayment').text(format2(String(data.gpayment * data.oldDigit)));
				jQuery('#clpayment').text(format2(String(data.clpayment * data.oldDigit)));
				jQuery('#ognPrice').text(format2(String(data.ognPrice * data.oldDigit)));
				jQuery('#payCash').text(format2(String(data.payCash * data.oldDigit)));
				jQuery('#payCard').text(format2(String(data.payCard * data.oldDigit)));
				jQuery('#payPoint').text(format2(String(data.payPoint * data.oldDigit)));

				$('#old_partner').text(data.partnerName);
				$('#old_partnerDscnt').text(data.partnerDscnt);

				if(data.cname==null){
// 					console.log('cname is null');
					jQuery('#cname').text('');
				}else{
// 					console.log('cname is not null');
					jQuery('#cname').text(data.cname);
				}

				jQuery('#cardDate').text(data.cardDate);

				jQuery('#payPoint_txt').text(format2(String(data.payPoint * data.oldDigit)));

				//console.log("card_date:"+data.cardDate);
				//console.log("cname:"+data.cname);
				//jQuery('#card_date_txt').text(data.cardDate);
				//jQuery('#cname_txt').text(data.cname);

			}
		});
	}


	function format2(n) {
		  var reg = /(^[+-]?\d+)(\d{3})/;
		  n += '';

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');

		  return n;
		}


	function getVisitListForFrame() {
		//location.replace("${ctxPath}/cstmrHstry/indexCstmrHstryForm.do");
		var url = '${ctxPath}/cstmrHstry/listVisitDataForFrame.do';

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

	function getCstmrInfo() {
		var url = '${ctxPath}/cstmrHstry/listCstmrInfo.do';

		//console.log("run getCstmrInfo cstmrId is :"+'${cstmrId}');
		//javax
		$.ajax({
			url : url,
			type : "post",
			data : "cstmrId="+'${cstmrId}',
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				getFmlyCd('${cstmr.fmlyCd}');
// 				console.log("success CstmrInfo");
// 				console.log("cstmr : "+'${cstmr}');
// 				console.log("cstmr.fmlyCd : "+'${cstmr.fmlyCd}');
				jQuery('#cstmrInfo').html(data);
			}
		});
	};

	function getFmlyCd(fmlyCd){
		var url = "${ctxPath}/cstmr/getFmlyList.do";
		console.log('@@getFmlyCd@@ fmlyCd:'+fmlyCd);
		console.log('@@getFmlyCd@@ cstmrCd:'+'${cstmr.cstmrCd}');
		var param = "fmlyCd=" + fmlyCd+"&cstmrCd="+'${cstmr.cstmrCd}';

		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#fmlyList").html(data);
			}
		});
	};

	function getPaymentedPrdctListData(){
		var url = '${ctxPath}/cstmrHstry/listPaymentedPrdctData.do';

		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: 'cstmrId='+'${cstmrId}'+'&saleId='+saleId,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listPaymentedPrdctDivH').html(data);
			}
		});
	}


	/*
	 * 고객 데이타 리스트 보드 페이징
	 */

	function fncCheckWrite() {
		gsphRight.readOnly = false;
		gcylRight.readOnly = false;
		gaxisRight.readOnly = false;
		addRight.readOnly = false;
		pdRight.readOnly = false;
		npcRight.readOnly = false;
		npaRight.readOnly = false;
		prismRight.readOnly = false;
		baseRight.readOnly = false;

		gsphLeft.readOnly = false;
		gcylLeft.readOnly = false;
		gaxisLeft.readOnly = false;
		addLeft.readOnly = false;
		pdLeft.readOnly = false;
		npcLeft.readOnly = false;
		npaLeft.readOnly = false;
		prismLeft.readOnly = false;
		baseLeft.readOnly = false;

		lsphRight.readOnly = false;
		lcylRight.readOnly = false;
		laxisRight.readOnly = false;
		bcRight.readOnly = false;
		diaRight.readOnly = false;

		lsphLeft.readOnly = false;
		lcylLeft.readOnly = false;
		laxisLeft.readOnly = false;
		bcLeft.readOnly = false;
		diaLeft.readOnly = false;

	/* 	btnEdit.disabled = false;
		btnSave.disabled = false; */

		writable = true;

	}

	function fncSaveCheck() {
		if (writable == false) {
			alert('<spring:message code="warn.check.writable"/>');
			return;
		}
		var url = '${ctxPath}/check/insertVisitAction.do';
		/* var url = 'insertVisitAction.do'; */

		param = jQuery('#checkForm').serialize();

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
					location.replace("${ctxPath}/check/indexCheckEyesForm.do");

				} else if (data == "fail") {
					alert('<spring:message code="fail"/>');
				}
			}
		});

	}

	function formatVal(obj){
		var type = $('#crtHstName').text();
		var value = $('#editHstVal').val();;

// 		console.log('type:'+type);
// 		console.log('value:'+value);

		var n = value;
 		var number = '';
 		if(value.length==0){
 			$('#editHstVal').val('0');
 			return;
 		}

//  		console.log('substr:'+type.substr(1, 3));
 		if( 'sp' == type.substr(1, 2)
 			|| 'cy' == type.substr(1, 2)
 			|| 'npa' == type.substr(0, 3)){
 			//console.log('case1');
	 		if(n.charAt(0)=="+"){
	 			if(n.length==2){
	 				number = n + ".0";
	 			}else if(n.length==3){
	 				var n1 = n.substr(1,1);
	 				var n2 = n.substr(2,1);
	 				number = "+" + n1 + "." + n2;
	 			}else if(n.length==4){
	 				var n1 = n.substr(1,1);
	 				var n2 = n.substr(2,1);
	 				var n3 = n.substr(3,1);
	 				number ="+" + n1 + "." + n2 + n3;
	 			}else if(n.length==5){
	 				var n1 = n.substr(1,1);
	 				var n2 = n.substr(2,1);
	 				var n3 = n.substr(3,1);
	 				var n4 = n.substr(4,1);
	 				number = "+" + n1 +  n2 + "." + n3 + n4;
	 			}else if(n.length>5){
	 				alert('너무 깁니다.');
	 				return;
	 			}
	 			$('#editHstVal').val(number);
	 		}else{
	 			if(n.length==1){
	 				number = n + ".0";
	 			}else if(n.length==2){
	 				var n1 = n.substr(0,1);
	 				var n2 = n.substr(1,1);
	 				number = n1 + "." + n2;
	 			}else if(n.length==3){
	 				var n1 = n.substr(0,1);
	 				var n2 = n.substr(1,1);
	 				var n3 = n.substr(2,1);
	 				number = n1 + "." + n2 + n3;
	 			}else if(n.length==4){
	 				var n1 = n.substr(0,1);
	 				var n2 = n.substr(1,1);
	 				var n3 = n.substr(2,1);
	 				var n4 = n.substr(3,1);
	 				number = n1 +  n2 + "." + n3 + n4;
	 			}else if(n.length>4){
	 				alert('너무 깁니다.');
	 				return;
	 			}
	 			$('#editHstVal').val("-" + number);
	 	 	}
 		}else if('ad' == type.substr(0, 2)
 				|| 'np' == type.substr(0, 3)
				|| 'pr' == type.substr(0, 2)
				|| 'bc' == type.substr(0, 2)
				|| 'di' == type.substr(0, 2)){
 			//console.log('case2');
 			if(n.length==1){
 				number = n + ".0";
 			}else if(n.length==2){
 				var n1 = n.substr(0,1);
 				var n2 = n.substr(1,1);
 				number = n1 + "." + n2;
 			}else if(n.length==3){
 				var n1 = n.substr(0,1);
 				var n2 = n.substr(1,1);
 				var n3 = n.substr(2,1);
 				number = n1 + "." + n2 + n3;
 			}else if(n.length==4){
 				var n1 = n.substr(0,1);
 				var n2 = n.substr(1,1);
 				var n3 = n.substr(2,1);
 				var n4 = n.substr(3,1);
 				number = n1 +  n2 + "." + n3 + n4;
 			}else if(n.length>4){
 				alert('너무 깁니다.');
 					return;
 	 	 	}
 	 		$('#editHstVal').val(number);
 		}else{
 			//console.log('case3');
 			$('#editHstVal').val(value);
 		}

 		return;
	}


 	function format(id){
 		//console.log('@run format');
 		var n = id.value;
 		n = n.toString();
 		var number;

 		if(n.charAt(0)=="+"){
 			if(n.length==2){
 				number = n + ".0";
 			}else if(n.length==3){
 				var n1 = n.substr(1,1);
 				var n2 = n.substr(2,1);
 				number = "+" + n1 + "." + n2;
 			}else if(n.length==4){
 				var n1 = n.substr(1,1);
 				var n2 = n.substr(2,1);
 				var n3 = n.substr(3,1);
 				number ="+" + n1 + "." + n2 + n3;
 			}else if(n.length==5){
 				var n1 = n.substr(1,1);
 				var n2 = n.substr(2,1);
 				var n3 = n.substr(3,1);
 				var n4 = n.substr(4,1);
 				number = "+" + n1 +  n2 + "." + n3 + n4;
 			}
 	 		document.getElementById(id.id).value = number;
 		}else{
 			if(n.length==1){
 				number = n + ".0";
 			}else if(n.length==2){
 				var n1 = n.substr(0,1);
 				var n2 = n.substr(1,1);
 				number = n1 + "." + n2;
 			}else if(n.length==3){
 				var n1 = n.substr(0,1);
 				var n2 = n.substr(1,1);
 				var n3 = n.substr(2,1);
 				number = n1 + "." + n2 + n3;
 			}else if(n.length==4){
 				var n1 = n.substr(0,1);
 				var n2 = n.substr(1,1);
 				var n3 = n.substr(2,1);
 				var n4 = n.substr(3,1);
 				number = n1 +  n2 + "." + n3 + n4;
 			}
 	 		document.getElementById(id.id).value = "-" + number;
 	 	}
 	}

 	 	function formatAdd(id){
 	 		var n = id.value;
 	 		var number;
 			if(n.length==1){
 				number = n + ".0";
 			}else if(n.length==2){
 				var n1 = n.substr(0,1);
 				var n2 = n.substr(1,1);
 				number = n1 + "." + n2;
 			}else if(n.length==3){
 				var n1 = n.substr(0,1);
 				var n2 = n.substr(1,1);
 				var n3 = n.substr(2,1);
 				number = n1 + "." + n2 + n3;
 			}else if(n.length==4){
 				var n1 = n.substr(0,1);
 				var n2 = n.substr(1,1);
 				var n3 = n.substr(2,1);
 				var n4 = n.substr(3,1);
 				number = n1 +  n2 + "." + n3 + n4;
 			}

 			document.getElementById(id.id).value = + number;

 		}

 	function formatNoSign(id){
 		var n = id.value;
 		var number;
		if(n.length==1){
			number = n + ".0";
		}else if(n.length==2){
			var n1 = n.substr(0,1);
			var n2 = n.substr(1,1);
			number = n1 + "." + n2;
		}else if(n.length==3){
			var n1 = n.substr(0,1);
			var n2 = n.substr(1,1);
			var n3 = n.substr(2,1);
			number = n1 + "." + n2 + n3;
		}else if(n.length==4){
			var n1 = n.substr(0,1);
			var n2 = n.substr(1,1);
			var n3 = n.substr(2,1);
			var n4 = n.substr(3,1);
			number = n1 +  n2 + "." + n3 + n4;
		}

			document.getElementById(id.id).value = number;
 	}

 	var show = false;
 	function showOther(){
 			$(".notUse").toggle();
 			if(!show){
 				document.getElementById("btn1").src ="<c:url value="/images/button/Select_m.png" />";
 				show = true;
 			}else{
 				document.getElementById("btn1").src ="<c:url value="/images/button/Select_p.png" />";
 				show = false;
 			}
 	}

 	/* var visible_memo = false;
	function showCstmrMemoDlg(){
		if(!visible_memo){
			getCstmrMemoDlg();
			$("#cstmr_memo_dlg_txt").slideDown(500);
			$("#cstmr_memo_dlg").text("저장");
			visible_memo = true;
		}else{
			$("#cstmr_memo_dlg").text("메모 열기");
			visible_memo = false;
			cstmrMemoUpdateDlg();
			$("#cstmr_memo_dlg_txt").slideUp(500);
		}
	} */


 	/* function getCstmrMemoDlg(){
 		console.log("run getCstmrHstryMemo @@@");
		//var url = '${ctxPath}/cstmr/getCstmrMemo.do';
		var saleId = '${saleVo.saleId}';
		var url = '${ctxPath}/sale/getSaleMemo.do';

		console.log("saleId:"+saleId);
		$("#cstmr_memo_dlg_txt").html("");
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data : "saleId=" + saleId,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				console.log("getSaleMemo:"+decodeURIComponent(data));
				$("#cstmr_memo_dlg_txt").html(decodeURIComponent(data));
			}
		});
	};


	function cstmrMemoUpdateDlg(){
		var saleId = '${saleVo.saleId}';
		var url = '${ctxPath}/sale/saleMemoUpdate.do';
		var memo = $("#cstmr_memo_dlg_txt").val();
		console.log("run MemoUpdateDlg");
		console.log("update memo:"+memo);
		console.log("saleId:"+saleId);
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data : "memo=" + memo + "&saleIdbackground-=" + saleId,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				if(data!='success'){
					alert('메모 저장 실패');
				}else{
					alert('저장 완료.');
				}
			}
		});
	} */

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
	function goBackward(){
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

		$('body').append(form);
		form.submit();
	};
	function fncEditSaleDate()
	{
		alert("Edit Test");

		$(".hiddenEdit").css("display","inline");
		$(".hiddenNoEdit").css("display","none");
	}
	function fncSaveEdit()
	{
		$(".hiddenEdit").css("display","none");
		$(".hiddenNoEdit").css("display","inline");
	}

	function setReturnPayId(){
		$("#delPaymentJQM").popup('open');
	}
	var InvnEditTy='';
	var InvnEditId='';
	var InvnDelId='';
	function addInvnPrdct(){
		console.log('@run addInvnPrdct');
		$("#invnPrdctTitle").text("제품추가");
		InvnEditTy='add';
		$('#invnPrdctJQM').popup();
		$('#invnPrdctJQM').popup('open');
	}
	/* function editInvnPrdct(id){
		console.log('@run editInvnPrdct id:'+id);
		InvnEditId=id;
		$("#invnPrdctTitle").text("제품수정");
		InvnEditTy='edit';
	} */

	var delInvn = true;
	var delNew = true;
	var prdctCnt;
	function setDelInvnPrdct(ty_id,popupDiv, cnt){
		prdctCnt = cnt;
		$("[data-role=controlgroup]").controlgroup("refresh");
		console.log('@run setDelInvnPrdct id:'+ty_id);
		InvnDelId=ty_id+'';
		//$("#invnPrdctTitle").text("제품수정");
		delInvn = true;
		delNew = false;
		$("#addInvnPrdctCnt").val(prdctCnt);
		$("#destroyPrdctCnt").val(0);
		$("#" + popupDiv).popup('open');
	}
	function setDelAddNewPrdct(ty_id){
		$("[data-role=controlgroup]").controlgroup("refresh");
		//console.log('@run setDelAddNewPrdct id:'+ty_id);
		NewDelId='AddN'+ty_id;
		//$("#invnPrdctTitle").text("제품수정");
		delInvn = false;
		delNew = true;

		var tmpName = $('#name'+NewDelId).val();
		var tmpTy = $('#slctTy'+NewDelId).val();
		var tmpPrc = $('#prc'+NewDelId).val();
		var tmpDscntPrcnt = $('#dscntPrcnt'+NewDelId).val();

 		/* console.log('tmpName:'+tmpName);
 		console.log('tmpTy:'+tmpTy);
 		console.log('tmpPrc:'+tmpPrc);
 		console.log('tmpDscntPrcnt:'+tmpDscntPrcnt); */

		if(!tmpName){
			if(tmpTy==0){
				if(!tmpPrc){
					//console.log('delete New Prdct');
					delInvnPrdct();
					return;
				}
			}
		}
		$('#delPrdctJQM').popup('open');
	}


	function setDelNewPrdct(ty_id){
		//console.log('@run setDelNewPrdct id:'+ty_id);
		NewDelId='N'+ty_id;
		//$("#invnPrdctTitle").text("제품수정");
		delInvn = false;
		delNew = true;

		var tmpName = $('#name'+ty_id).val();
		var tmpTy = $('#slctTy'+ty_id).val();
		var tmpPrc = $('#prc'+ty_id).val();
		var tmpDscntPrcnt = $('#dscntPrcnt'+ty_id).val();

// 		console.log('tmpName:'+tmpName);
// 		console.log('tmpTy:'+tmpTy);
// 		console.log('tmpPrc:'+tmpPrc);
// 		console.log('tmpDscntPrcnt:'+tmpDscntPrcnt);

		$('#delPrdctJQM').popup('open');
	}

	var DelPayId;

	function delInvnPrdct(){
		//console.log('run delInvnPrdct:'+InvnDelId);
		var delId;
		if(delInvn==true){
			delId = InvnDelId;
			var addInvnPrdctCnt = $("#addInvnPrdctCnt").val();
			var destroyPrdctCnt = $("#destroyPrdctCnt").val();

			if(Number(addInvnPrdctCnt) + Number(destroyPrdctCnt) > prdctCnt){
				alert("수량을 초과하였습니다.");
				return;
			}
			//console.log("재고 추가 : " + addInvnPrdctCnt + "\n폐기 : " + destroyPrdctCnt);


			//폐기, 반품여부 구분해서 정보와야함.
			arrDelInvnId.push(InvnDelId+'');
			mapInvnDtrCnt[InvnDelId]=destroyPrdctCnt;
			mapInvnAddCnt[InvnDelId]=addInvnPrdctCnt;
			for(var i=0 ; i < arrAddInvnId.length ; i++){
				//console.log('arrAddInvnId[i]:'+arrAddInvnId[i]);
				//console.log('InvnDelId:'+InvnDelId);
				if(arrAddInvnId[i]==InvnDelId){arrAddInvnId.splice(i,1);}
			}

			for(var i=0 ; i < arrInitInvnId.length ; i++){
				//console.log('arrInitInvnId[i]:'+arrInitInvnId[i]);
				//console.log('InvnDelId:'+InvnDelId);
				if(arrInitInvnId[i]==InvnDelId){arrInitInvnId.splice(i,1);}
			}


		}else{
			delId = NewDelId;
			arrDelNewId.push(NewDelId);
			for(var i=0 ; i < arrAddNewId.length ; i++){
				//console.log('arrAddNewId[i]:'+arrAddNewId[i]);
				//console.log('NewDelId:'+NewDelId);
				if(arrAddNewId[i]==NewDelId){arrAddNewId.splice(i,1);}
			}
			for(var i=0 ; i < arrInitNewId.length ; i++){
				//console.log('arrInitNewId[i]:'+arrInitNewId[i]);
				//console.log('NewDelId:'+NewDelId);
				if(arrInitNewId[i]==NewDelId){arrInitNewId.splice(i,1);}
			}

		}

		/* console.log('arrInitInvnId:'+JSON.stringify(arrInitInvnId));
		console.log('arrAddInvnId:'+JSON.stringify(arrAddInvnId));
		console.log('arrDelInvnId:'+JSON.stringify(arrDelInvnId));

		console.log('arrInitNewId:'+JSON.stringify(arrInitNewId));
		console.log('arrAddNewId:'+JSON.stringify(arrAddNewId));
		console.log('arrDelNewId:'+JSON.stringify(arrDelNewId)); */

		$("#tr"+delId).html('');

		$("#delPrdctJQM").popup("close");

		setTotalPrc();
		changePointPrcnt();
		setPaymentInfo();

		return;
	}

	function fncCancel(){
		$("#invnPrdctJQM").popup("close");
	}
	function addPrdct(){
		//console.log('run addPrdct');
		if(mCnt<1){
			alert('<spring:message code="warn.cnt.prdct" />');
			return;
		}

		if(mPrdctId==null){
			alert('<spring:message code="warn.choice.item" arguments="상품"/>');
			return;
		}
		/* console.log('렌즈 추가');
		console.log('id:'+mPrdctId);
		console.log('mTrdePrc:'+mTrdePrc);
		console.log('mCnt:'+mCnt); */

		var InvnAddId = mPrdctTy+mPrdctId;

		//초기 제품군과 중복체크.
		for(var i=0;i<arrInitInvnId.length;i++){
			/* console.log('diff1:'+arrInitInvnId[i]);
			console.log('diff2:'+InvnAddId); */
			if(arrInitInvnId[i]==InvnAddId){
				alert('동일 제품이 처방에 있습니다.');
				return;
			}
		}

		//삭제 제품품군과 중복 체크.
		for(var i=0;i<arrDelInvnId.length;i++){
			/* console.log('diff1:'+arrDelInvnId[i]);
			console.log('diff2:'+InvnAddId); */
			if(arrDelInvnId[i]==InvnAddId){
				arrDelInvnId.splice(i,1);
			}
		}

		//console.log('InvnAddId:'+InvnAddId);
		//lens Default cnt is 2.
		mCnt=2;

		if(mPrdctTy==3 || mPrdctTy==2){
			mCnt=2;
		}else{
			mCnt=1;
		}

		/* if(mPrdctTy==4){
			$('#chk'+InvnEditId).prop('checked', false);
		} */

		/* console.log('mPrdctName:'+mPrdctName);
		console.log('mPrdctTy:'+mPrdctTy); */

		//InvnEditTy is 'add' or 'edit'
		/* console.log('InvnEditTy:'+InvnEditTy);
		console.log('InvnEditId:'+InvnEditId); */

		var dscntPrcnt=$('#partnerDscnt_txt').val();

		if(InvnEditTy=='edit'){
			/* arrDelInvnId.push(InvnEditId);
			var newInvnId = mPrdctTy+'_'+mPrdctId;
			console.log('newInvnId:'+newInvnId);
			console.log('InvnEditId:'+InvnEditId);
			$('#name'+InvnEditId).val(mPrdctName);
			$('#name'+InvnEditId).attr('id','name'+newInvnId);
			console.log('#name'+'#name'+InvnEditId);
			$('#slctTy'+InvnEditId).val(mPrdctTy);
			$('#slctTy'+InvnEditId).attr('id','slctTy'+newInvnId);
			$('#cnt'+InvnEditId).val(mCnt);
			$('#cnt'+InvnEditId).attr('id','cnt'+newInvnId);
			$('#prc'+InvnEditId).val(mTrdePrc);
			$('#prc'+InvnEditId).attr('id','prc'+newInvnId);

			$('#dscntPrcnt'+InvnEditId).val(dscntPrcnt);
			$('#dscntPrcnt'+InvnEditId).attr('id','dscntPrcnt'+newInvnId);

			$('#dscntPrc'+InvnEditId).val(addComma(mTrdePrc*mCnt*((100-dscntPrcnt)/100)));
			$('#dscntPrc'+InvnEditId).attr('id','dscntPrc'+newInvnId);

			$('#earn'+InvnEditId).prop('checked', false);
			$('#earn'+InvnEditId).attr('id','earn'+newInvnId);
			$('#asm'+InvnEditId).prop('checked', false);
			$('#asm'+InvnEditId).attr('id','asm'+newInvnId);
			$('#dlvry'+InvnEditId).prop('checked', false);
			$('#dlvry'+InvnEditId).attr('id','dlvry'+newInvnId); */
		}else{
			arrAddInvnId.push(InvnAddId);
// 			console.log(JSON.stringify('arrInitInvnId:'+arrInitInvnId));
// 			console.log(JSON.stringify('arrAddInvnId:'+arrAddInvnId));
// 			console.log(JSON.stringify('arrDelInvnId:'+arrDelInvnId));

// 			console.log(JSON.stringify('arrInitNewId:'+arrInitNewId));
// 			console.log(JSON.stringify('arrAddNewId:'+arrAddNewId));
// 			console.log(JSON.stringify('arrDelNewId:'+arrDelNewId));

			var Add = "'Add'";
			var delPrdctJQM ="'delPrdctJQM'";
			var inputHtml='\
			<tr id="tr'+InvnAddId+'" class="listData trListPrdct" style="color: black" bgcolor="white">\
				<td width="140px">\
					<input id="nameAdd'+InvnAddId+'" value="'+mPrdctName+'"\
					class="inputPrdct"\
					style="width:100%" type="text" placeholder="제품명" disabled="disabled">\
				</td>\
				<td width="112px">\
					<select class="inputPrdctList" id="slctTyAdd'+InvnAddId+'" name="slctBmonth" disabled="disalbed">\
						<option value="0">종류선택</option>\
						<option value="1">프레임</option>\
						<option value="2">렌즈</option>\
						<option value="3">콘텍트렌즈</option>\
						<option value="4">기타</option>\
						<option value="5">선글라스</option>\
						<option value="6">일회용렌즈</option>\
					</select>\
				</td>\
				<td width="38px">\
					<input id="cntAdd'+InvnAddId+'" style="width:30px" type="text" placeholder="수량" value="'+mCnt+'"\
							class="inputPrdct"\
							onclick ="resetInputEye(this);"\
							onkeyup="setPriceInfo(this,'+InvnAddId+','+Add+');">\
				</td>\
				<td width="90px">\
					<input id="prcAdd'+InvnAddId+'" \
							class="inputPrdct"\
							onkeyup="setPriceInfo(this,'+InvnAddId+','+Add+');"\
							value="'+addComma(mTrdePrc)+'" style="width:70px; text-align:right;" type="text" placeholder="가격" disabled="disabled">\
				</td>\
				<td width="50px">\
					<input id="dscntPrcntAdd'+InvnAddId+'" \
							class="inputPrdct"\
							name="dscntPrcnt_number2"\
							onkeyup="setPriceInfo(this,'+InvnAddId+','+Add+');"\
							value="'+dscntPrcnt+'" style="width:100%;" type="text" placeholder="할인" value="0">\
				</td>\
				<td width="88px" align="right">\
					<input id="dscntPrcAdd'+InvnAddId+'" \
							class="inputPrdct"\
							value="'+addComma((mCnt*mTrdePrc*((100-dscntPrcnt)/100)))+'"style="width:70px;text-align:right;" type="text" placeholder="할인가격" disabled="disabled">\
				</td>\
				<td width="32px" align="center">\
					<input class="earnChk" id="earnAdd'+InvnAddId+'" type="checkbox"\
							onChange="changePointPrcnt();">\
					<label for="earnAdd'+InvnAddId+'"></label>\
				</td>\
				<td width="33px"align="center">\
					<input class="asmChk" id="asmAdd'+InvnAddId+'" type="checkbox" >\
					<label for="asmAdd'+InvnAddId+'"></label>\
				</td>\
				<td width="33px"align="center">\
					<input class="dlvryChk" id="dlvryAdd'+InvnAddId+'" type="checkbox" >\
					<label for="dlvryAdd'+InvnAddId+'"></label>\
				</td>\
				<td>\
					<a onclick="setDelInvnPrdct('+InvnAddId+','+delPrdctJQM+',' + mCnt + ');return false;" href="#delPrdctJQM" data-rel="popup">\
						<img src="<c:url value="/images/button/Select_c.png" />" width="15px;">\
					</a>\
				</td>\
			</tr>';

			$("#listAddPrdct").append(inputHtml);

			$("#slctTyAdd"+InvnAddId).val(mPrdctTy);
			setTotalPrc();
			changePointPrcnt();
			setPaymentInfo();
		}
		$("#invnPrdctJQM").popup("close");


		return;
	}

	function addNewPrdct(){
		$("#addPrdctJQM").popup("close");
		addNewId++;
		arrAddNewId.push('AddN'+addNewId);

		var AddN = "'AddN'";

		/* console.log(JSON.stringify('arrInitInvnId:'+arrInitInvnId));
		console.log(JSON.stringify('arrAddInvnId:'+arrAddInvnId));
		console.log(JSON.stringify('arrDelInvnId:'+arrDelInvnId));

		console.log(JSON.stringify('arrInitNewId:'+arrInitNewId));
		console.log(JSON.stringify('arrAddNewId:'+arrAddNewId));
		console.log(JSON.stringify('arrDelNewId:'+arrDelNewId)); */

		var inputHtml='\
		<tr id="trAddN'+addNewId+'" class="listData trListPrdct" style="color: black" bgcolor="white">\
			<td width="140px">\
				<input id="nameAddN'+addNewId+'"style="width:100%"\
						class="inputPrdct"\
						data-role="none"\
						autocomplete="on"\
						onkeyup="prdctNameChecker(this);"\
						type="text" placeholder="제품명">\
			</td>\
			<td width="112px">\
				<select class="inputPrdctList" id="slctTyAddN'+addNewId+'" name="slctBmonth">\
					<option value="0">종류선택</option>\
					<option value="1">프레임</option>\
					<option value="2">렌즈</option>\
					<option value="3">콘텍트렌즈</option>\
					<option value="4">기타</option>\
					<option value="5">선글라스</option>\
					<option value="6">일회용렌즈</option>\
				</select>\
			</td >\
			<td width="38px">\
				<input id="cntAddN'+addNewId+'"\
						class="inputPrdct"\
						style="width:30px" type="text" placeholder="수량" value="1"\
						onclick ="resetInputEye(this);"\
						onkeyup="setPriceInfo(this,'+addNewId+','+AddN+');">\
			</td>\
			<td width="90px">\
				<input id="prcAddN'+addNewId+'"\
						class="inputPrdct"\
						onclick ="resetInputEye(this);"\
						onkeyup="setPriceInfo(this,'+addNewId+','+AddN+');"\
						style="text-align:right; width:70px" type="text" placeholder="가격">\
			</td>\
			<td width="50px">\
				<input id="dscntPrcntAddN'+addNewId+'" value="0"\
						class="inputPrdct"\
						name="dscntPrcnt_number2"\
						onclick ="resetInputEye(this);"\
						onkeyup="setPriceInfo(this,'+addNewId+','+AddN+');"\
						style="width:100%" type="text" placeholder="할인">\
			</td>\
			<td  width="88px" align="right">\
				<input class="inputPrdct"\ id="dscntPrcAddN'+addNewId+'" style="text-align:right; width:70px" type="text" placeholder="할인가격" disabled="disabled">\
			</td>\
			<td width="32px" align="center">\
				<input class="earnChk" id="earnAddN'+addNewId+'" type="checkbox" value="check"\
						onChange="changePointPrcnt();">\
				<label for="earnAddN'+addNewId+'"></label>\
			</td>\
			<td width="33px" align="center">\
				<input class="asmChk" id="asmAddN'+addNewId+'" type="checkbox" value="check">\
				<label for="asmAddN'+addNewId+'"></label>\
			</td>\
			<td width="33px" align="center">\
				<input class="dlvryChk" id="dlvryAddN'+addNewId+'" type="checkbox" value="check">\
				<label for="dlvryAddN'+addNewId+'"></label>\
			</td>\
			<td>\
			<a href="javascript:setDelAddNewPrdct('+addNewId+');" data-rel="popup">\
				<img src="<c:url value="/images/button/Select_c.png" />" width="15px;">\
			</a>\
		</td>\
		</tr>';

		$("#listAddPrdct").append(inputHtml);

		var dscntPrcnt=$('#partnerDscnt_txt').val();
		$('#dscntPrcntAddN'+addNewId).val(dscntPrcnt);
	}

	var SearchItemTy='frame';
	function slctNavItem(item){
		//console.log('item:'+item);
		$('.hideTable').css("display","none");
		if(item=='frame'){
			$("#selectTitle").text("프레임 검색");
			$('#listItemFrameDiv').css("display","inline");
		}else if(item=='lens'){
			$("#selectTitle").text("렌즈 검색");
			$('#listItemLensDiv').css("display","inline");
		}else if(item=='clens'){
			$("#selectTitle").text("콘택트렌즈 검색");
			$('#listItemClensDiv').css("display","inline");
		}else if(item=='acc'){
			$("#selectTitle").text("기타 검색");
			$('#listItemAccDiv').css("display","inline");
		}else{
			$("#selectTitle").text("프레임 검색");
			$('#listItemFrameDiv').css("display","inline");
			item='frame';
		}
		SearchItemTy = item;
	}



	function mnSearch(){
		//console.log('SearchItemTy:'+SearchItemTy);
		var itemTy='1';

		if(SearchItemTy=='frame'){
			itemTy='1';
		}else if(SearchItemTy=='lens'){
			itemTy='2';
		}else if(SearchItemTy=='clens'){
			itemTy='3';
		}else if(SearchItemTy=='acc'){
			itemTy='4';
		}else{
			itemTy='1';
		}

		var url;

		if(itemTy=="2"){
			//console.log("lens is selected")
			url = '${ctxPath}/cstmrHstry/listLensData.do';
		}else{
			url = '${ctxPath}/cstmrHstry/listPrdctData.do';
		}

		var mn = jQuery('#mn').val();
		/* console.log('mn:'+mn);
		console.log('itemTy:'+itemTy); */
/* 		if(mn.length<2){
			alert("검색어는 2글자 이상 입력 바랍니다.");
			return;
		}
 */

		var param = "prdctName="+mn+"&itemTy="+itemTy;
		//javax
		$.ajax({
			url : url,
			type : "post",
			data : param,
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				//console.log("data:"+data);
				if(itemTy=='1'){
					jQuery('#listItemFrameDiv').html(data);
				}else if(itemTy=='2'){
					jQuery('#listItemLensDiv').html(data);
				}else if(itemTy=='3'){
					jQuery('#listItemClensDiv').html(data);
				}else if(itemTy=='4'){
					jQuery('#listItemAccDiv').html(data);
				}else{
					jQuery('#listItemFrameDiv').html(data);
				}

			}
		});
	}

	function goToShopPage(){
		//원래 소스. 캐논이 임시방편으로 잠시 막음.
		//$.mobile.changePage("#shopPage",{transition:"slide",reverse:"true"});

		location.href="${ctxPath}/shop/indexShopCstrmForm.do";

		$('#txtSearch1').val('');
		$('#txtSearch2').val('');
		$('#txtSearch3').val('');
		$('#txtSearch4').val('');
		$('#txtSearch5').val('');
		$('#txtSearch6').val('');
	}
	function setFixDate(){
		var fixedDate = document.getElementById("fixDate").value;
		window.sessionStorage.setItem("fixedDate",fixedDate);
	}

	function newCstmrVisit(){
		//console.log('run newCstmrVisit');
		//saleId for newCstmrInit.
		saleId = 1;
		g_usedCouponCd='';

		getCheckInfo(saleId);


		$("#visitDateH").val(getToday());

		var staffId = "${staffVo.staffId}";

		$("#staffNameH").val(''+staffId);

		//console.log('staffId:'+staffId);

		$("#shopNameH").html("${shopVo.shopName}");


		jQuery('#gsphRight').val("");
		jQuery('#gcylRight').val("");
		jQuery('#gaxisRight').val("");
		jQuery('#addRight').val("");
		jQuery('#pdRight').val("");
		jQuery('#npcRight').val("");
		jQuery('#npaRight').val("");
		jQuery('#prismRight').val("");
		jQuery('#baseRight').val("");

		jQuery('#gsphLeft').val("");
		jQuery('#gcylLeft').val("");
		jQuery('#gaxisLeft').val("");
		jQuery('#addLeft').val("");
		jQuery('#pdLeft').val("");
		jQuery('#npcLeft').val("");
		jQuery('#npaLeft').val("");
		jQuery('#prismLeft').val("");
		jQuery('#baseLeft').val("");

		jQuery('#lsphRight').val("");
		jQuery('#lcylRight').val("");
		jQuery('#laxisRight').val("");
		jQuery('#bcRight').val("");
		jQuery('#diaRight').val("");

		//pointer
		jQuery('#lsphLeft').val("");
		jQuery('#lcylLeft').val("");
		jQuery('#laxisLeft').val("");
		jQuery('#bcLeft').val("");
		jQuery('#diaLeft').val("");

		$('input:radio[name="domEye"]').filter('[value="0"]').attr('checked', true);
		$('input:radio[name="domEye"]').filter('[value="1"]').attr('checked', false);
		$('input:radio[name="domEye"]').filter('[value="2"]').attr('checked', false);


		$("#memo_txtH").val("");

		$("#chk1").addClass("whiteTr");
		$("#chk2").addClass("whiteTr");
		$("#chk3").addClass("whiteTr");
		$("#chk4").addClass("whiteTr");
		$("#chk5").addClass("whiteTr");

	}

	function getLastEyeCheck(){
		var url = '${ctxPath}/check/getEyeCheckByCstmrId.do';
		var cstmrId = '${cstmrId}';
		var param = "csmtrId=" + cstmrId;

		//javax
		$.ajax({
			url : url,
			type : "post",
			data : "cstmrId=" + cstmrId,
			dataType : "json",
			success : function(data) {
				//console.log("data:"+data);
				jQuery("#gsphRight").val(data.gsphRight);
				jQuery("#gcylRight").val(data.gcylRight);
				jQuery("#gaxisRight").val(data.gaxisRight);
				jQuery("#addRight").val(data.addRight);
				jQuery("#pdRight").val(data.pdRight);
				jQuery("#npcRight").val(data.npcRight);
				jQuery("#npaRight").val(data.npaRight);
				jQuery("#prismRight").val(data.prismRight);
				jQuery("#baseRight").val(data.baseRight);

				jQuery("#gsphLeft").val(data.gsphLeft);
				jQuery("#gcylLeft").val(data.gcylLeft);
				jQuery("#gaxisLeft").val(data.gaxisLeft);
				jQuery("#addLeft").val(data.addLeft);
				jQuery("#pdLeft").val(data.pdLeft);
				jQuery("#npcLeft").val(data.npcLeft);
				jQuery("#npaLeft").val(data.npaLeft);
				jQuery("#prismLeft").val(data.prismLeft);
				jQuery("#baseLeft").val(data.baseLeft);

				jQuery("#lsphRight").val(data.lsphRight);
				jQuery("#lcylRight").val(data.lcylRight);
				jQuery("#laxisRight").val(data.laxisRight);
				jQuery("#bcRight").val(data.bcRight);
				jQuery("#diaRight").val(data.diaRight);
				jQuery("#lsphLeft").val(data.lsphLeft);
				jQuery("#lcylLeft").val(data.lcylLeft);
				jQuery("#laxisLeft").val(data.laxisLeft);
				jQuery("#bcLeft").val(data.bcLeft);
				jQuery("#diaLeft").val(data.diaLeft);
				if(data.domEye=="1"){
					$('input:radio[name="domEye"]').filter('[value="1"]').attr('checked', true);
				}else if(data.domEye=="2"){
					$('input:radio[name="domEye"]').filter('[value="2"]').attr('checked', true);
				}else{// if(data.domEye=="0"){
					$('input:radio[name="domEye"]').filter('[value="0"]').attr('checked', true);
					$('input:radio[name="domEye"]').filter('[value="1"]').attr('checked', false);
					$('input:radio[name="domEye"]').filter('[value="2"]').attr('checked', false);
				}
			}
		});

	}
	function prdctNameChecker(input){
		//console.log('prdctNameChecker:'+input.value);
		var tmp = input.value;
		if(tmp.indexOf("\"") > -1){
			alert('(")는 사용하실 수 없습니다.');
			input.value=tmp.split('"').join('');
			return;
		}
	}
	function resetAllvisit(){
		//console.log('run resetAllVisit');
		$('.eyeChk').val('0');
		$('input:radio[name="domEye"]').filter('[value="0"]').attr('checked', true);
		$('input:radio[name="domEye"]').filter('[value="1"]').attr('checked', false);
		$('input:radio[name="domEye"]').filter('[value="2"]').attr('checked', false);
	}

	function printTax(){
		//console.log('run printTax');
		var printName = $('#inputTaxName').val();
		//console.log('printName:'+printName);
		//var printSSN = $('#printSSN').val();
		var printSSN = '';
		if(!printName){alert('발급자 정보가 누락되었습니다.');return;}

		if(printSSN){
			if(printSSN.length != 13){
				alert('주민등록번호는 13자리 숫자만 입력 바랍니다.');
				return;
			}
			printSSN = printSSN.replace('-','');
			printSSN = printSSN.replace(/(^\s*)|(\s*$)/gi, "");
			var printSSN1 = printSSN.substr(0,6);
			var printSSN2 = printSSN.substr(6,7);
			printSSN = printSSN1 +'-'+ printSSN2;
		}

// 		console.log('printSSN:'+printSSN);
// 		console.log('printName:'+printName);
// 		console.log('printSSN:'+printSSN);

		var url = '${ctxPath}/shop/getShopInfo.do';
		var param = 'shopId='+jsonSale.shopId;

		var shopId;
		var cName;
		var cNum;
		var shopName;
		var telephone;
		var addr;
		var headHtml='';
		var tailHtml='';
		var urlStr='';
		var stampImgPath='';

		jQuery.ajax({
			url: url,
			type : "post",
			data : param,
			dataType : "json",
			error:function(request,status,error){
				alert('실패. 재로그인 바랍니다.');
			},
			success : function(data){
				 shopId = data.shopId;
				 cName = data.taxName;
				 cNum = data.taxNum;
				 shopName = data.shopName;
				 telephone = data.telephone;
				 addr = data.addr;
				 stampImgPath=data.urlStr+data.stampImgPath;

				 headHtml = makeHead(printName,printSSN,cName,cNum,telephone,addr);
				 tailHtml = makeTail(cName,stampImgPath);
				 makeBody(headHtml,tailHtml);

				 //로딩 안됨.
				 var tmpHtml = $('#printable').html();
				 goTaxPrintPage(tmpHtml);

				 //$("#imgStamp")
				 //   .load(function() {
				 //   	console.log("image loaded correctly");
				    	//window.print();

				    	//var myWindow = window.open("", "myWindow", "width=200, height=100");    // Opens a new window
						//myWindow.document.write($('#printable').html());                  // Text in the new window
				 //   	updatePrintTax(printName);
				 //   })
				 //.error(function() { alert("실패. 재시도 바랍니다."); })
				 updatePrintTax(printName);
			}
		});
	}

function goTaxPrintPage(taxHtml){
	console.log('run goTaxPrintPage');
	console.log('taxHtml:'+taxHtml);
	var url = '${ctxPath}/tax/printTax.do';
	//var param = 'taxHtml=' + taxHtml;
	//window.open("${ctxPath}/tax/printTax.do?taxHtml"+taxHtml);

	var texForm = document.createElement("form");
	texForm.name = 'tempPost';
	texForm.method = 'post';
	texForm.action = url;
	texForm.setAttribute("target", "_blank");

	var param = document.createElement("input");
	param.setAttribute("type", "hidden");
	param.setAttribute("name", "taxHtml");
	param.setAttribute("value", taxHtml);
	$(texForm).append(param);
	$('body').append(texForm);
	texForm.submit();

}

function updatePrintTax(printName){
	function SaleObj(jobId,saleId, cnt, date, name, payCash, payCard, cardTy, bigo, shopId, shopName){
		this.jobId = jobId;
		this.saleId = saleId;
		this.cnt = cnt;
		this.date = date;
		this.name = name;
		this.payCash = payCash;
		this.payCard = payCard;
		this.cardTy = cardTy;
		this.bigo = bigo;
		this.shopId = shopId;
		this.shopName = shopName;
	}

		var url = '${ctxPath}/tax/renewalTax.do';
		var arrTax = new Array();
//		var keys = mapAddTax.keys();
// 		console.log('keys:'+keys);
// 		console.log('mapAddTax:'+mapAddTax);
		var date = new Date();
		var day = date.getDate();
		var month = date.getMonth() + 1;
		var year = date.getFullYear();
		if (month < 10) month = "0" + month;
		if (day < 10) day = "0" + day;
		var today = year + "-" + month + "-" + day;
		function JsonAddTax(arrTax, today,printName){
			this.arrTax = arrTax;
			this.today = today;
			this.printName = printName;
		}

		tmpSaleObj = new SaleObj('',jsonSale.saleId,'','',$('#cstmrName').val(),'','','','','',g_shopName);
		arrTax.push(tmpSaleObj);

		var jsonAddTax =new JsonAddTax(arrTax , today.replace('-','.').replace('-','.') , printName);
		var email = $('#taxEmail').val();
		var cstmrId =$('#taxCstmrId').val();
		//var param = 'jsonTax='+JSON.stringify(jsonAddTax)+'&email='+email+'&cstmrId='+cstmrId;
		var param = 'jsonTax='+JSON.stringify(jsonAddTax);

		jQuery.ajax({
			url: url,
			type : "post",
			data : param,
			dataType	: "text",
			error:function(request,status,error){
				console.log('실패. 출력내용사항 업데이트안됨.');
			},
			success		: function(data){
				 //console.log(data);
			}
			});
	}

		function makeHead(printName,printSSN,cName,cNum,telephone,addr){

			var date = new Date();
			var day = date.getDate();
			var month = date.getMonth() + 1;
			var year = date.getFullYear();
			if (month < 10) month = "0" + month;
			if (day < 10) day = "0" + day;
			var today = year + "-" + month + "-" + day;

			var headHtml="\
				<table class='tbPrint' style='border:0.5; border-collapse:collapse;'>\
				<tr>\
					<td colspan='6'>\
						<center>\
							<h2>의료비납입증명서(연말정산용)</h2>\
						</center>\
					</td>\
				</tr>\
				<tr>\
					<td style='width:16%'></td>\
					<td style='width:16%'></td>\
					<td style='width:16%'></td>\
					<td style='width:16%'></td>\
					<td style='width:16%;text-align:right;'>발급일자</td>\
					<td class ='thickTd' style='width:16%;'>"+today+"</td>\
				</tr>\
				<tr>\
					<td colspan='6'>&nbsp;</td>\
				</tr>\
				<tr>\
					<td>[고객정보]</td>\
					<td colspan='5'></td>\
				</tr>\
				<tr>\
					<td class='thinTd'>성명</td>\
					<td class='thickTd'>"+printName+"</td>\
					<td class='thinTd'>주민등록번호</td>\
					<td colspan ='3' class='thickTd'>"+printSSN+"</td>\
				</tr>\
				<tr>\
					<td colspan='6'>&nbsp;</td>\
				</tr>\
				<tr>\
					<td>[공급자]</td>\
					<td colspan='5'></td>\
				</tr>\
				<tr>\
					<td class='thinTd'>사업자 등록</br>번호</td>\
					<td class='thickTd'>"+cNum+"</td>\
					<td class='thinTd'>상호</td>\
					<td class='thickTd'>갤러리안경</td>\
					<td class='thinTd'>대표자</td>\
					<td class='thickTd'>"+cName+"</td>\
				</tr>\
				<tr>\
					<td class='thinTd'>업태</td>\
					<td class='thickTd'>소매</td>\
					<td class='thinTd'>종목</td>\
					<td class='thickTd'>안경</td>\
					<td class='thinTd'>전화번호</td>\
					<td class='thickTd'>"+telephone+"</td>\
				</tr>\
				<tr>\
					<td class='thinTd'>소재지</td>\
					<td class='thickTd' colspan='5'>"+addr+"</td>\
				</tr>\
				<tr>\
					<td colspan='6'>&nbsp;</td>\
				</tr>\
				<tr>\
					<td>[구매내역]</td>\
					<td colspan='5'></td>\
				</tr>\
				<tr>\
					<td colspan='6'>&nbsp;</td>\
				</tr>\
				<tr><td colspan='6'>\
				<table class='tbList' style='border:0.5; border-collapse:collapse;'>\
				<tr>\
					<td width='25%' class='thinTd'>년 월</td>\
					<td width='20%' class='thinTd'>신용카드</td>\
					<td width='20%' class='thinTd'>현 금</td>\
					<td width='20%' class='thinTd'>합계</td>\
					<td width='15%' class='thinTd'>비고</td>\
				</tr>";

			return headHtml;
		}

		//size of printOut table.

	function makeBody(headHtml,tailHtml){
		//console.log('listPayment.length:'+listPayment.length);
		//var tmpMapSize = mapAddTax.size();
		var tmpMapSize = listPayment.length;
		var limit = Math.ceil(tmpMapSize/9);
		var k=0;
		$('#printable').html('');
		for(var j =0 ;j<limit;j++){
			var tmpSize=7;
			//var tmpKeys = mapAddTax.keys();
			var tmpTr='';
			var tmpHtml;
			var tmpSum=0;
			var tmpCashSum=0;
			var tmpCardSum=0;
			for(var i=0;i<tmpSize;i++,k++){
				if(k<tmpMapSize){
					//var tmpSaleObj =  mapAddTax.get(tmpKeys[k]);
					//SaleObj(jobId,saleId, cnt, date, name, payCash, payCard, cardTy, bigo){
					//tmpSum = Number(removeComma(tmpSaleObj.payCard)) + Number(removeComma(tmpSaleObj.payCash));
					var payCash=0;
					var payCard=0;

					if(listPayment[k].cardTy==13){
						payCash = Number(removeComma(listPayment[k].payCash))+Number(removeComma(listPayment[k].payCard));
					}else{
						payCash = Number(removeComma(listPayment[k].payCash));
						payCard = Number(removeComma(listPayment[k].payCard));
					}

					tmpSum = payCard + payCash;
					tmpCashSum += payCash;
					tmpCardSum += payCard;
					tmpTr += "\
						<tr>\
							<td class='thickTd'>"+listPayment[k].datetime+"</td>\
							<td class='rightTd'>"+addComma(payCard)+"</td>\
							<td class='rightTd'>"+addComma(payCash)+"</td>\
							<td class='rightTd'>"+addComma(tmpSum)+"</td>\
							<td class='thickTd'>&nbsp;</td>\
						</tr>";
				}else{
					tmpTr+="\
						<tr>\
							<td class='thickTd'>&nbsp;</td>\
							<td class='thickTd'>&nbsp;</td>\
							<td class='thickTd'>&nbsp;</td>\
							<td class='thickTd'>&nbsp;</td>\
							<td class='thickTd'>&nbsp;</td>\
						</tr>";
				}
			}
			tmpTr+="<tr>\
				<td class='thickTd'>총구입비용</td>\
				<td class='rightTd'>"+addComma(tmpCardSum)+"</td>\
				<td class='rightTd'>"+addComma(tmpCashSum)+"</td>\
				<td class='rightTd'>"+addComma(tmpCardSum+tmpCashSum)+"</td>\
				<td class='thickTd'>&nbsp;</td>\
			</tr>";
			var breaker = "<p class='break'>&nbsp;</p>";
//				console.log("j:"+j);
//				console.log("limit:"+limit);
			if(j == limit-1){
				tmpHtml = headHtml+tmpTr+tailHtml;
			}else{
				tmpHtml = headHtml+tmpTr+tailHtml+breaker;
			}
			//tmpHtml = headHtml+tmpTr+tailHtml+breaker;

			$('#printable').append(tmpHtml);
			//console.log("print html:"+$('#printable').html());
		}

	}


	function makeTail(cName,stampImgPath){
		var tmpName = cName;
		var tailHtml = "\
			</table></td></tr>\
			<tr>\
				<td colspan='2' style='text-align:center'>[구입용도] : 시력교정용</td>\
				<td colspan='4'></td>\
			</tr>\
			<tr>\
			<td colspan='6'>&nbsp;</td>\
			</tr>\
			<tr>\
				<td colspan='6'>&nbsp;</td>\
			</tr>\
			<tr>\
				<td colspan='3'></td>\
				<td colspan='2' >위 사실을 확인합니다.</td>\
				<td rowspan='3'class='bgTd'>\
					<div class='imgWrap'>\
					  <center><img id='imgStamp' src='"+stampImgPath+"' width='45px'/></center>\
					  <span class='imgDescription'>"+tmpName+"&nbsp;(인)</span>\
					</div>\
				</td>\
			</td>\
			</tr>\
			<tr>\
				<td colspan='4'></td>\
				<td style='text-align:right'>확인자:\</td>\
			</tr>\
			<tr>\
				<td colspan='5'>&nbsp;</td>\
			</tr>\
			<tr>\
				<td colspan='6'><center>이 계산서는 소득세법상 의료비공제 신청에 필요합니다.</center></td>\
			</tr>\
		</table>\
		";

		return tailHtml;
	}

	/* get latest notice title to show */
	function getNoticeInfo(){
		var url = "${ctxPath}/board/getTitle.do";
		var contents = '<b style="color:black"><공지>';
		$.ajax({
			url : url,
			dataType : "json",
			type : "GET",
			success : function(title){
				for(var i=0; i<title.length; i++){
					contents += (i+1) + ". " + title[i] +"&nbsp;&nbsp;&nbsp;&nbsp;";
				}
				contents += "</b>"
				$('#noticeInfo').html(contents);

	}
		});
		}

</script>

<style>
    #printable {
		 display: none;
	}
    #dateFrame{
    	width: 100px;
    	height: 700px;
    	overflow: auto;
    }
   	a{
   		text-decoration: none;
   	}
   	a:LINK{
   		color : blue;
   	}
   	a:VISITED{
		color : blue;
   	}
   	a:HOVER{
   		color: #ff0000;
   	}
   	a:ACTIVE{
		color: #3399ff;
   	}

   	.dateSpan{
   		font-weight: bold;
   		cursor : pointer;
   		border-bottom : 1px solid black;
   		height : 35px;
   		font-size:1.2em;
   	}
   	.blackTr{
   		color: black;
   	}
   	.redTr{
   		color: red;
   	}
   	#dateSelect{
   		display: none;
   	}
   	.blueTr{
   		background-color: #99ccff;
   	}
   	.whiteTr{
		background-color: white;
   	}
   	.greenTr{
   		background-color: #deb887;
   	}
   	.borderL{
   		border-top-left-radius:0.5em;
   	}
   	.borderR{
   		border-top-right-radius:0.5em;
   	}
   	.eyeChk{
   		width:100%;
		font-size:14px;
   	}
   	#saleLoader{
		position : absolute;
		left :100px;
		display : none;
		height : 25px;
		z-index:9;
	}

	.inputPrdct{
		font-size:1em;
		font-weight: bold;
	}
	.inputPrdctList{
		font-size:1em;
		font-weight: bold;
	}
	.trListPrdct{
		background-color: #39F;
	}
	* {
		text-shadow: none;
	}
}
</style>

<style type="text/css" media="print">
	.noPrint{
		display : none;
	}

	@page{
		size:8.27in 11.69in;
		margin:.5in .5in .5in .5in;
		mso-header-margin:.5in;
		mso-footer-margin:.5in;
		mso-paper-source:0;
	}


	#printable {
		display : block;
		/* display:none; */
		border-style: solid;
    	border-width: 5px;
	}

	/* .break { page-break-before: always; } */


	.tbPrint{
		border-width: 1px;
		border-spacing: 0px;
		border-style: outset;
		border-color: white;
		border-collapse: collapse;
		width:15cm;
		height:23cm;
		font-size:0.7em;
	}
	.tbList{
		border-width: 1px;
		border-spacing: 0px;
		border-style: outset;
		border-color: white;
		border-collapse: collapse;
		width:15cm;
		font-size:0.7em;
	}

	.thickTd{
		border-left: 1px solid;
	 	border-bottom: 1px solid;
	 	border-top: 1px solid;
	 	border-right: 1px solid;
		padding: 10px;
		border-style: outset;
		border-color: black;
		text-align:center;
		height:20px;
	}
	.rightTd{
		border-left: 1px solid;
	 	border-bottom: 1px solid;
	 	border-top: 1px solid;
	 	border-right: 1px solid;
		padding: 10px;
		border-style: outset;
		border-color: black;
		background-color: white;
		text-align:right;
		height:20px;
	}
	.thinTd{
		border-left: 1px solid;
	 	border-bottom: 1px solid;
	 	border-top: 1px solid;
	 	border-right: 1px solid;
		padding: 0px;
		border-style: outset;
		border-color: black;
		background-color: white;
		text-align:center;
		height:20px;
	}

	.bgTd{
		border-width: 0px;
		padding: 0px;
		border-style: outset;
		border-color: black;
		height:20px;
	}

	.noLineTd{
	 	border-left: 0;
	 	border-bottom: 0;
	 	border-top: 0;
	 	border-right: 0;
		padding: 0px;
		border-style: outset;
		border-color: black;
		background-color: white;

		height:25px;
	}

	.thinTr{
		border-width: thin;
		padding: 0px;
		border-style: inset;
		border-color: black;
		background-color: white;
	}

	.graph-img img{display:none;}

	.imgWrap {
		position: relative;
		left:30%;
		width: 100%;
	}

	.imgDescription {
	  position: absolute;
	  top: 33%;
	  left: -20%;
	  color: #000;
	  width:100%;
	  visibility: visible;
	  opacity: 1;
	}

</style>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
	<title>고객처방</title>
	<link rel="stylesheet" href="../css/toggle-switch.css">
</head>

<body >
	<table class="listShop noPrint" width="800px" border="0.5">
		<tr>
			<td width="14%" height="26" onclick="goToShopPage(); return false;" style="color: black; font-weight: bold;">매장고객</td>
			<td width="14%" height="26" onclick="galleryCummunity()" id='cmnt' style="color: black; font-weight: bold;">커뮤니티</td>
			<!-- <td width="114" height="26" onclick="dlgSearchCstmr()" id='srch' style="color: black; font-weight: bold;">최근검색</td> -->
			<td width="30%" colspan='2' ><label for='fixDate' style="color: black; font-weight: bold;" >날짜고정:</label> <input id='fixDate' data-role="none" onchange='setFixDate(); return false;' type='date' /></td>
			<td width="14%" height="26" onclick="galleryManager()" id="mng" style="color: black; font-weight: bold;"> 매장관리</td>
			<td width="14%" height="26" onclick="getAsBoard()" id="as" style="color: black; font-weight: bold;"> A/S 관리</td>
			<td width="14%" height="26" onclick="fncGoStaffPage(${shopVo.shopId});return false;" style="color: black; font-weight: bold;">Log-out</td>
		</tr>
		<tr>
		<td colspan="7">
			<marquee id='noticeInfo' width="800px"  style="cursor: pointer;" behavior="scroll" direction="left" scrollamount="6" onmouseover="this.stop()" onmouseout="this.start()" onclick="galleryCummunity()"></marquee>
		</td>
		</tr>
	</table>
    <!-- <div calss="transBoxTable" style="font-size: 13px;"> -->
		<table class="noPrint" style="font-size: 13px;width:800px;border : 5px solid #D8D8D8; padding : 10px; border-radius :15px; background-color:white" >
			<tr>
				<td colspan="2">
					<div id="cstmrInfo"></div>
				</td>
			</tr>
			<tr>
				<td valign="top" width='10%'>
					<div id="dateFrame" style="font-size: 11px;">
					</div>
				</td>
				<td align="left" width='80%' style="border:2px solid #A4A4A4; padding : 15px; border-radius : 10px">

				<table width='100%' style="border-collapse:collapse;" border="1">
					<Tr>
						<td colspan="10" align="center" style="font-weight:bolder" id="ctmrVisitTitle">
							진행상태
						</td>
					</Tr>
					<tr>
						<Td width='20%' colspan="2" id="chk1" style="font-weight : bolder;" align="center">선택</Td>
						<Td width='20%' colspan="2" id="chk2" style="font-weight : bolder;" align="center">검안</Td>
						<Td width='20%' colspan="2" id="chk3" style="font-weight : bolder;" align="center">조립</Td>
						<Td width='20%' colspan="2" id="chk4" style="font-weight : bolder;" align="center">결제</T1d>
						<Td width='20%' colspan="2" id="chk5" style="font-weight : bolder;" align="center">전달</Td>
					</tr>
				</table>
				<hr>
				<table width='100%' style="border-collapse:collapse;" border="1">
				<tr>
					<td class="blueTd" style='width:15%;'>
						매장
					</td>
					<td style='width:15%;' class="formWhiteTd">
						<!-- <input id='shopNameH' type='text' data-mini="true"/ disabled='disabled'> -->
						<p style='text-align:center;' id='shopNameH'></p>
					</td>
					<td class="blueTd" style='width:15%;'>
						처방일
					</td>
					<td class="formWhiteTd" style='width:15%;'>
						<input id='visitDateH' type='date'  data-role='none' data-mini="true" />
					</td>
					<td class="blueTd" style='width:15%;'>
						담당
						<input type='hidden' id='staffIdH' />
					</td>
					<td class="formWhiteTd" style='width:15%;'>
						<c:choose>
							<c:when test="${!empty listStaff}">
								<select style='width:100%' id="staffNameH" data-role="none">
									<option value='0'>---사용자변경---</option>
									<c:forEach items="${listStaff}" var="item" varStatus="status">
										<option value="${item.staffId}" > ${item.staffName}</option>
									</c:forEach>
								</select>
							</c:when>
							<c:otherwise>
								<option value='0'>---사용자변경---</option>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<Td class="blueTd">메모
					</Td>
					<td colspan="5" class="formWhiteTd">
						<textarea style='height:100%;'data-role="none" rows="4" cols="100" id="memo_txtH" placeholder="메모 작성 후 저장 하지 않은 정보는 소실됩니다.">
						</textarea>
					</td>
				</tr>
			</table>

			<!-- <form name="checkForm" id="checkForm" method="post" action=""> -->
			<input type="hidden" id="histId" name="histId"></input>
			<input type="hidden" id="shopId" name="shopId"></input>
			<input type="hidden" id="cstmrId" name="cstmrId"></input>
			<table width="100%"  style="font-size: 13px; text-align: center" id="staffList"  >
			<form id="cstmrHist">
				<tr bgcolor="white" style="color: black" class="greenTr">
					<td width="78px" class="borderL">Glasses</td>
					<td width="78px">SPH</td>
					<td width="78px">CYL</td>
					<td width="78px">AXIS</td>
					<td width="78px">PD</td>
					<td width="78px">ADD</td>
					<td width="78px">PRISM</td>
					<td width="78px">BASE</td>
					<td width="78px">NPC</td>
					<td width="78px">NPA</td>
				</tr>

				<tr>
					<td colspan="10">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">
					</td>
				</tr>

				<tr style="color: black" bgcolor="white">
					<td >Right</td>
					<td >
						<input type="edit"	size="3" id="gsphRight" class="eyeChk"
						onkeydown="convertEnterToTab(this,1)"
						tabindex="1"
							name="gsphRight"  onclick ="resetInputEye(this);" onchange="format(gsphRight);">
						</td>
					<td >
						<input type="edit" size="3"   id="gcylRight" class="eyeChk"
						onkeydown="convertEnterToTab(this,2)"
						tabindex="2"
						name="gcylRight"  onclick ="resetInputEye(this);" onchange="format(gcylRight)">
						</td>
					<td >
						<input type="edit" size="3"   class="eyeChk"
						onkeydown="convertEnterToTab(this,3)"
						tabindex="3"
							id="gaxisRight" name="gaxisRight"  onclick ="resetInputEye(this);">
					</td>
					<td >
						<input type="edit" size="3" class="eyeChk"   onclick = "resetInputEye(this);"
							onkeydown="convertEnterToTab(this,4)"
								tabindex="4"
							id="pdRight" name="pdRight" >
					</td>
					<td >
						<input type="edit" size="3" class="eyeChk"  id="addRight" name="addRight"
						onkeydown="convertEnterToTab(this,5)"
						tabindex="5"
						onchange="formatNoSign(addRight)" onclick ="resetInputEye(this);">
					</td>

					<td >
						<input type="edit" size="3" class="eyeChk"    class="notUse"
						onkeydown="convertEnterToTab(this,11)"
						tabindex="11"
						id="prismRight" name="prismRight" onchange="formatNoSign(prismRight)" onclick ="resetInputEye(this);">
					</td>
					<td >
						<input type="edit" class="eyeChk" size="3"   class="notUse"
						onkeydown="convertEnterToTab(this,12)"
						tabindex="12"
							id="baseRight" name="baseRight" onchange="formatNoSign(baseRight)" onclick ="resetInputEye(this);">
						</td>
					<td >
						<input type="edit" size="3" class="eyeChk"  class="notUse"
						onkeydown="convertEnterToTab(this,13)"
						tabindex="13"
							id="npcRight" name="npcRight" onchange="formatNoSign(npcRight)" onclick ="resetInputEye(this);">
						</td>
					<td >
						<input type="edit" size="3"class="eyeChk"   class="notUse"
						onkeydown="convertEnterToTab(this,14)"
						tabindex="14"
							id="npaRight" name="npaRight" onchange="format(npaRight)" onclick ="resetInputEye(this);">
					</td>

				</tr >
				<tr>
					<td colspan="10">
						<%-- <img src="${ctxPath	}/images/black_line.jpg" width="100%"> --%>
					</td>
				</tr>

				<tr style="color: black" bgcolor="white">
					<td >Left</td>
					<td><input onclick ="resetInputEye(this);" class="eyeChk" type="edit" size="3"   id="gsphLeft"
					onkeydown="convertEnterToTab(this,6)"
						tabindex="6"
						name="gsphLeft" onchange="format(gsphLeft)" ></td>
					<td><input onclick ="resetInputEye(this);" class="eyeChk" type="edit" size="3"   id="gcylLeft"
					onkeydown="convertEnterToTab(this,7)"
						tabindex="7"
						name="gcylLeft" onchange="format(gcylLeft)"></td>
					<td><input onclick ="resetInputEye(this);" class="eyeChk" type="edit" size="3"   id="gaxisLeft"
					onkeydown="convertEnterToTab(this,8)"
						tabindex="8"
						name="gaxisLeft"></td>
					<td><input onclick ="resetInputEye(this);" class="eyeChk" type="edit" size="3"   id="pdLeft"
					onkeydown="convertEnterToTab(this,9)"
						tabindex="9"
						name="pdLeft" ></td>
					<td><input onclick ="resetInputEye(this);" class="eyeChk"type="edit" size="3"   id="addLeft"
					onkeydown="convertEnterToTab(this,10)"
						tabindex="10"
						name="addLeft" onchange="formatNoSign(addLeft)"></td>
					<td ><input onclick ="resetInputEye(this);" class="eyeChk"type="edit" size="3"   class="notUse"
					onkeydown="convertEnterToTab(this,15)"
						tabindex="15"
						id="prismLeft" name="prismLeft" onchange="formatNoSign(prismLeft)"></td>
					<td ><input onclick ="resetInputEye(this);" class="eyeChk"type="edit" size="3"   class="notUse"
					onkeydown="convertEnterToTab(this,16)"
						tabindex="16"
						id="baseLeft" name="baseLeft" onchange="formatNoSign(baseLeft)"></td>
					<td ><input onclick ="resetInputEye(this);" class="eyeChk"type="edit" size="3"   class="notUse"
					onkeydown="convertEnterToTab(this,17)"
						tabindex="17"
						id="npcLeft" name="npcLeft" onchange="formatNoSign(npcLeft)"></td>
					<td ><input onclick ="resetInputEye(this);" class="eyeChk"type="edit" size="3"   class="notUse"
					onkeydown="convertEnterToTab(this,18)"
						tabindex="18"
						id="npaLeft" name="npaLeft" onchange="format(npaLeft)"></td>

				</tr>
				<%-- <tr style="color: black">
				<td height="3" colspan="10"><img
					src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
						width="800" height="1" /></td>
				</tr> --%>
				<tr>
					<td colspan="10">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">
					</td>
				</tr>

				<tr class="greenTr" style="color: black">
					<td class="borderL">C/L</td>
					<td>SPH</td>
					<td>CYL</td>
					<td>AXIS</td>
					<td>B.C</td>
					<td>DIA</td>
					<td bgcolor="white">&nbsp;</td>
					<td colspan='2'>우위안</td>
					<td bgcolor="white">&nbsp;</td>

				</tr>
				<tr>
					<td colspan="10">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">
					</td>
				</tr>
				<tr style="color: black" bgcolor="white">
					<td>Right</td>
					<td>
						<input onclick="resetInputEye(this);" class="eyeChk"
						onkeydown="convertEnterToTab(this,19)"
						tabindex="19"
						type="edit" size="3"  id="lsphRight"
						name="lsphRight" onchange="format(lsphRight)">
						</td>
					<td>
						<input onclick="resetInputEye(this);" class="eyeChk"
						onkeydown="convertEnterToTab(this,20)"
						tabindex="20"
						type="edit" size="3"  id="lcylRight"
						name="lcylRight" onchange="format(lcylRight)">
						</td>
					<td>
						<input onclick="resetInputEye(this);" class="eyeChk"
						type="edit" size="3"  id="laxisRight"
						onkeydown="convertEnterToTab(this,21)"
						tabindex="21"
						name="laxisRight">
						</td>
					<td>
						<input onclick="resetInputEye(this);" class="eyeChk"
						onkeydown="convertEnterToTab(this,22)"
						tabindex="22"
						type="edit" size="3"  id="bcRight"
						name="bcRight" onchange="formatNoSign(bcRight)">
					</td>
					<td>
						<input onclick="resetInputEye(this);" class="eyeChk"
						onkeydown="convertEnterToTab(this,23)"
						tabindex="23"
						type="edit" size="3"  id="diaRight"
						name="diaRight" onchange="formatNoSign(diaRight)">
					</td>

					<td rowspan='3' colspan="4" width="20" style="color: black" bgcolor="white">
						<center>
							<table>
								<tr>
									<td width='40px'>우</td>
									<td width='40px'>좌</td>
									<td width='40px'>없음</td>
								</tr>
								<tr>
						 			<td>
						 				<input tabindex="29" class="dom_eye"type="radio"  data-role='none' value='1' name="domEye" id="domR">
						 			</td>
						 			<td>
						 				<input tabindex="30" class="dom_eye"  type="radio"  data-role='none' value='2' name="domEye" id="domL">
						 			</td>
						 			<td>
						 				<input tabindex="31" class="dom_eye" type="radio"  data-role='none' value='0' name="domEye" id="domN">
						 			</td>
						 		</tr>
						 	</table>

						 	<input type="button" onclick='getLastEyeCheck();' id='resetAll' value="최근방문시력" data-role='none'>
						 	<input type="button" onclick='resetAllvisit();' id='resetAll' value="시력전체삭제" data-role='none'>
					 	</center>
					</td>

				</tr>

				<tr>
					<td colspan="6">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">
					</td>
				</tr>

				<tr style="color: black" bgcolor="white">
					<td >Left</td>
						<td>
							<input onclick="resetInputEye(this);" class="eyeChk"
							type="edit" size="3"  id="lsphLeft"
							onkeydown="convertEnterToTab(this,24)"
						tabindex="24"
							name="lsphLeft" onchange="format(lsphLeft)"></td>
						<td>

							<input onclick="resetInputEye(this);" class="eyeChk"
							onkeydown="convertEnterToTab(this,25)"
						tabindex="25"
							type="edit" size="3"  id="lcylLeft"
							name="lcylLeft" onchange="format(lcylLeft)">
							</td>
						<td>
							<input onclick="resetInputEye(this);" class="eyeChk"
							onkeydown="convertEnterToTab(this,26)"
						tabindex="26"
							type="edit" size="3"  id="laxisLeft"
							name="laxisLeft">
						</td>
						<td>
							<input onclick="resetInputEye(this);" class="eyeChk"
							onkeydown="convertEnterToTab(this,27)"
						tabindex="27"
							type="edit" size="3"  id="bcLeft"
							name="bcLeft" onchange="formatNoSign(bcLeft)">
						</td>
						<td>
							<input onclick="resetInputEye(this);" class="eyeChk"
							type="edit" size="3"  id="diaLeft"
							onkeydown="convertEnterToTab(this,28)"
						tabindex="28"
							name="diaLeft" onchange="formatNoSign(diaLeft)">
						</td>
				</tr>
				<tr>
					<td colspan="10">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">
					</td>
				</tr>
		</form>
			</table>
				<table class="hiddenOld " width="800px" style="font-size: 13px; text-align: center;">
				<tr style="color: black" class="blueTr">
					<td colspan='5' style="background-color: white;font-size:14px; color: black">과거 (-2013/12/31) 시스템 구매 내역</td>

				</tr>
				<tr>
					<td colspan="5">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">
					</td>
				</tr>
				<%-- <tr>
				<td height="3" colspan="5"><img
					src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
					width="800" height="1" /></td>
				</tr> --%>
				<tr bgcolor="white" style="color: black">
					<td width="20%">할인내역</td>
					<td ><span id=old_partner></span></td>
					<td ><span id=old_partnerDscnt></span>%</td>
					<td >&nbsp;</td>
					<td >&nbsp;</td>
				</tr>

				<tr bgcolor="white" style="color: black">
					<td width="20%">FRAME</td>
					<td ><span id=gframe1></span></td>
					<td ><span id=gframe2></span></td>
					<td ><span id=gframe3></span></td>
					<td >&nbsp;</td>
				</tr>
				<%-- <tr style="color: black" >
				<td height="3" colspan="5"><img
					src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
					width="800" height="1" /></td>
				</tr> --%>
				<tr>
					<td colspan="5">
						<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">
					</td>
				</tr>
				<tr bgcolor="white" style="color: black">
					<td>LENS</td>
					<td colspan='1'><span id=glens1></span></td>
					<td colspan='1'><span id=glens2></span></td>
					<td colspan='1'><span id=glens3></span></td>
					<td colspan='1'>&nbsp;</span></td>
				</tr>
				<%-- <tr style="color: black">
				<td height="3" colspan="5"><img
					src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
					width="800" height="1" /></td>
				</tr> --%>
				<tr>
					<td colspan="5">
						<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">
					</td>
				</tr>
				<tr bgcolor="white" style="color: black">
					<td width="20%">CLENS</td>
					<td width="20%">LEFT</td>
					<td  width="20%"><span id=clensL></span></td>
					<td width="20%">RIGHT</td>
					<td  width="20%"><span id=clensR></span></td>
				</tr>
				<%-- <tr style="color: black">
					<td height="3" colspan="5"><img
						src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
						width="800" height="1" /></td>
				</tr> --%>
				<tr>
					<td colspan="5">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">
					</td>
				</tr>
				<tr bgcolor="white" style="color: black">
					<td>구매금액</td>
					<td>Frame + Lens</td>
					<td><span style="text-align: right;" id=gpayment></span></td>
					<td>Clens</td>
					<td ><span style="text-align: right;" id=clpayment></span></td>
				</tr>
				<tr>
					<td colspan="5">
					<img src="${ctxPath	}/images/black2_line.jpg" width="100%" height="2px">
					</td>
				</tr>
				<tr bgcolor="white" style="color: black">
					<td>구매합계</td>
					<td></td>
					<td style="text-align: right; background-color: white; color: black"><span id=ognPrice></span></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="5">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">
					</td>
				</tr>
				<%-- <tr style="color: black">
					<td height="3" colspan="5"><img
						src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
						width="800" height="1" /></td>
				</tr> --%>

				<tr bgcolor="white" style="color: black">
					<td>현금</td>
					<td></td>
					<td style="text-align: right"><span id=payCash></span></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="5">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">
					</td>
				</tr>
				<tr bgcolor="white" style="color: black">
					<td>카드</td>
					<td><span id=cname></span><br/>(<span id=cardDate></span>)</td>
					<td style="text-align: right"><span id=payCard></span></td>
					<td> </td>
					<td> </td>
				</tr>
				<tr>
					<td colspan="5">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">
					</td>
				</tr>
				<tr bgcolor="white" style="color: black">
					<td>포인트</td>
					<td></td>
					<td style="text-align: right"><span id=payPoint></span></td>
					<td></td>
					<td></td>
				</tr>
				<%-- <tr style="color: black">
					<td height="3" colspan="5"><img
						src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
						width="800" height="1" /></td>
				</tr> --%>
				<tr>
					<td colspan="5">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">
					</td>
				</tr>
				<tr>
					<td colspan="2"></td>
					<td >
						<a id='oldBtmBtn1' href="javascript:newCstmrVisit();" data-role="button">새로운처방</a>
					</td>
					<td colspan="2"></td>
				</tr>

				</table>
			<!-- </div> -->
		<!-- </form> -->
			<div id="paymentList" class="hiddenNew">
				<div id='listPaymentedPrdctDivH' style="font-size: 13px;">
  					</div>
			</div>
		</table>
<!-- <div id="PopDiv"> -->

<!-- <div data-role="popup" class='popup' id="addPrdctJQM" class="ui-content">
	<div data-role="controlgroup" data-type="horizontal" >
		<a onclick="addNewPrdct(); return false;" data-role="button" class='btn' data-icon="plus">신규제품</a>
		<a onclick="addInvnPrdct(); return false;" data-role="button" data-icon="plus" >재고관리제품</a>
		<a onclick="addInvnPrdct();return false;" href="#invnPrdctJQM" data-rel="popup" data-position-to="window" data-role="button" class='btn' data-icon="plus" >재고관리제품</a>
		<a data-role="button" data-rel="back" data-icon="delete" class='btn'>취소</a>
	</div>
</div> -->

<div data-role="popup" id="delInvnPrdctJQM" class="ui-content popup noPrint" style="padding : 10px">
	<div data-role="controlgroup" data-type="horizontal" >
		매장 재고 <input type="number" id="addInvnPrdctCnt" style="width:50px;height:30px;font-size:18px">
		폐기 <input type="number" id="destroyPrdctCnt" style="width:50px;height:30px;font-size:18px">
	</div>

	<center>
	<div data-role="controlgroup" data-type="horizontal" >
		<a onclick="delInvnPrdct(); return false;" data-role="button" data-icon="plus" class='btn' >확인</a>
		<a data-role="button" data-rel="back" data-icon="delete" class='btn' >취소</a>
	</div>
	</center>
</div>


<div data-role="popup" id="delPrdctJQM" class="ui-content popup noPrint">
	<div data-role="controlgroup" data-type="horizontal" >
		<a onclick="delInvnPrdct(); return false;" data-role="button" data-icon="plus" class='btn'>제품 삭제</a>
		<a data-role="button" data-rel="back" data-icon="delete" class='btn'>취소</a>
	</div>
</div>
<div data-role="popup" id="delPaymentJQM" class="ui-content popup noPrint">
	<div data-role="controlgroup" data-type="horizontal" >
		<a onclick="delPayment(); return false;" data-role="button" data-icon="plus" class='btn'>결제 삭제</a>
		<a data-role="button" data-rel="back" data-icon="delete" class='btn'>취소</a>
	</div>
</div>


<div data-role="popup" class='popup ui-corner-all ui-content noPrint'  id="invnPrdctJQM" style="min-width:300px;">
	<a href="#" data-rel="back" data-role="button"class='btn'  data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
	<div data-role="header">
		<center>
		<h1 id ='invnPrdctTitle' class='text'>제품수정</h1>
		</center>
		<div data-role="navbar" class='navbar'>
			<ul>
				<li><a href="#" onclick="slctNavItem('frame');">Frame</a></li>
				<li><a href="#" onclick="slctNavItem('lens');">Lens</a></li>
				<li><a href="#" onclick="slctNavItem('clens');">Clens</a></li>
				<li><a href="#" onclick="slctNavItem('acc');">Acc</a></li>
			</ul>
		</div>
	</div>

	<div style="padding:10px 20px;" class='noPrint'>
		<center>
		  <h3 id='selectTitle'>프레임 검색</h3>
		 </center>
          <label for="mn" class="ui-hidden-accessible">모델명:</label>
          <input type="text" id="mn" placeholder="모델명" data-theme="a"
          		onKeyPress="javascript:if(event.keyCode == 13) mnSearch();" class='input'/>
    	  <button type="button" data-theme="b"class='btn'  onclick="mnSearch();" >검색</button>
		</div>
	<div id = 'listItemFrameDiv' class='hideTable noPrint'>
	</div>
	<div id = 'listItemLensDiv' class='hideTable noPrint'>
	</div>
	<div id = 'listItemClensDiv' class='hideTable noPrint'>
	</div>
	<div id = 'listItemAccDiv' class='hideTable noPrint'>
	</div>
</div>
<img src="${ctxPath }/images/loader2.gif" id="saleLoader" class='noPrint'>

<div id="printable"></div>
<!-- </div> -->
</body>

</html>
