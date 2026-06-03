<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/include/cstmrHstryLib.jsp"%>

<style>
#dscnt_total_txt_hstry {
	font-weight: bold;
}

.payment_number3 {
	height: 20px;
	width: 70px;
	font-weight: bold;
	font-size: 1em;
	text-align: right;
}

/* input[type=checkbox]{ */
.earnChk, .dlvryChk, .asmChk, .chkAll{
	display: none;
}

input[type=checkbox] +label {
	background-image: url("/GalleryStaff/images/checkbox.png");
	background-position:center center;
	height: 20px;
	width: 20px;
	display: inline-block;
	padding: 0 0 0 0px;
}

input[type=checkbox]:checked+label {
	background-image: url("/GalleryStaff/images/checkbox_c.png");
	background-position:center center;
	height: 20px;
	width: 20px;
	display: inline-block;
	padding: 0 0 0 0px;
}

</style>
<script type="text/javascript">


	var g_total = 0;
	var g_dscntTotal = 0;
	var g_pointTotal = 0;
	var g_remainedPayment = 0;
	var g_penny = 0;
	var prePayment = 0;

	var etcDscnt = 0;
	var partnerDscnt = 0;
	var partnerId;
	var partnerCert;
	var partnerMemo;

	var pointValue;
	var fmlyCd;

	var totalPrice4Point = 0;
	var prdctsPrice = 0;

	var CHANGE = 1;
	var NO_CHANGE = 0;
	var ALL_CHECKED = 2;
	var ALL_UNCHECKED = 3;
	var USING = 1;
	var NOT_USING = 0;

	var TY_FRAME = 1;
	var TY_LENS = 2;
	var TY_CLENS = 3;
	var TY_ACC = 4;

	var mCstmrCd;

	var mapCnt = {};
	var mapPrc = {};
	var mapDscntPrcnt = {};
	var mapEarnPrcnt = {};
	var mapPntUsingChk = {};
	var arrPrdctId = new Array();
	var POINT_CHANGE = 1;
	var JUST_SAVE = 0;

	var arrCardComName = new Array();
	var arrCardComId = new Array();

	jQuery(document).ready(function() {

		//init g_var.
		arrCrtPrdct = new Array();
		arrAddPrdct = new Array();
		arrEditPrdct = new Array();
		arrDelPrdct = new Array();

		arrAddPayment = new Array();
		arrRfndPayment = new Array();
		arrEditPayment = new Array();
		arrDelPayment = new Array();

		arrInitInvnId = new Array();
		arrAddInvnId = new Array();
		arrDelInvnId = new Array();

		arrInitNewId = new Array();
		arrAddNewId = new Array();
		arrDelNewId = new Array();
		addNewId = 0;

		mapInvnPrdct = {};
		mapNewPrdct = {};
		mapInvnDtrCnt = {};
		mapInvnAddCnt = {};

		arrInitPay = new Array();
		arrAddPay = new Array();
		arrRfndPay = new Array();
		arrDelPay = new Array();
		payNum = 0;
		mapOrgPay = {};
		//end init.

		if ('${saleVoH.partnerDscnt}' != 0) {
			partnerDscnt = '${saleVoH.partnerDscnt}';
		} else {
			partnerDscnt = 0;
		}

		if ('${saleVoH.etcDscnt}' != 0) {
			etcDscnt = '${saleVoH.etcDscnt}';
		} else {
			etcDscnt = 0;
		}
		$("#etcDscnt_txt").val(addComma(etcDscnt));

		var etcDscntMemo;
		if ('${saleVoH.etcDscntMemo}' !== undefined) {
			etcDscntMemo = '${saleVoH.etcDscntMemo}';
		} else {
			etcDscntMemo = '';
		}
		$("#etcDscntMemo_txt2").val(etcDscntMemo);

		$("#earnAll_number").text('${saleVoH.earnPrcnt}');
		prePayment = 0;
		//getCstmrPoint();
		//getPaymentHist();
		getPaymentList();

		//setPaymentInfo();
		$('.btn').button();
		$("#dlgPartnerInfo").popup();
		$('#btmBtn1').button();
		$('#btmBtn2').button();
		$('#btmBtn3').button();
		$('#btmBtn4').button();
		$('#btmBtn5').button();
		$('#btmBtn5').button();
		$('#btmBtn6').button();
		$('#btmBtn7').button();
		//$('#bottomBtn').controlgruop();
		$('#bottomBtn').controlgroup({
			type : "horizontal"
		});
		
		$('.popup').popup();
		$('#inputTaxName').text();
		$("#popPartnerInfo").popup();
	});

	var listPayment = new Array();
	
	function getPaymentList() {
		//console.log('run getPaymentList');
		var param = "saleId=" + saleId;
		var url = "${ctxPath}/sale/getPaymentList.do";

		$.ajax({
			url : url,
			data : param,
			dataType : "json",
			type : "post",
			success : function(data) {
				/* console.log('success getPaymentList');
				console.log('data:'+data);
				console.log('data.listPayment:'+data.listPayment);
				console.log('json_data:'+JSON.stringify(data)); */
				var item = data.listPayment;

				var strJson = JSON.stringify(data);
				var jsonData = JSON.parse(strJson);
	
				/* console.log('data.listPayment.length:'+data.listPayment.length);
				console.log('jsonData.listPayment.length:'+jsonData.listPayment.length); */
				for ( var i = 0; i < jsonData.listPayment.length; i++) {
					listPayment.push(data.listPayment[i]);
				}
				setPaymentList();
				setTotalPrc();
				setPaymentInfo();
				changePointPrcnt();
				jsonSale.point = removeComma($('#point_total_txt')
						.text())
						+ '';
			}
		});
	}

	function setPaymentList() {
		console.log('run setPaymentList');
		for ( var i = 0; i < listPayment.length; i++) {
			//console.log(JSON.stringify(listPayment[i]));

			//console.log('listPayment.jobId:'+listPayment[i].jobId);
			var jobId = listPayment[i].jobId;
			var tmpHtml = "\
			<tr id='trPay"+jobId+"'style='color: black' bgcolor='white'>\
			<td > \
				<input class ='inputPrdct' id='payDate"
					+ jobId
					+ "' type='date'  data-role='none'/> \
			</td>\
			<td> \
				<input class='payment_number3' type='text' pattern='[0-9]*'\
					id='payCash"
					+ jobId
					+ "'\
					name='payCash'\
					onclick ='resetInputEye(this);'\
					placeholder='숫자만 입력 가능.' size='15' value=0 \
					onkeyup='calcPayment(this,"
					+ jobId
					+ ",0);'\
					onkeypress='if (event.keyCode<48|| event.keyCode>57) event.returnValue=false;'>\
				</input>\
			</td>\
			<td>\
			<input class='payment_number3' type='text'pattern='[0-9]*'\
					id='payCard"
					+ jobId
					+ "'\
					name='payCard'\
					onclick ='resetInputEye(this);'\
					placeholder='숫자만 입력 가능.' size='15' value=0\
					onkeyup='calcPayment(this,"
					+ jobId
					+ ",0);'\
					onkeypress='if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;'>\
			</input>\
			</td>\
			<td>\
				<input class='payment_number3' type='text' pattern='[0-9]*'\
					id='payPoint"
					+ jobId
					+ "'\
					name='payPoint'\
					onclick ='resetInputEye(this);'\
					placeholder='숫자만 입력 가능.' size='15' value=0\
					onkeyup='pointLimit(this);calcPayment(this,"
					+ jobId
					+ ",0);'\
					onkeypress='if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;'>\
					</input>\
				</td>\
			<td colspan='1'>\
				<select class='inputPrdctList' style='width:90px' id='paySlctCardCom"+jobId+"' >\
			</td>\
			<td  style='text-align: right'>\
				<p class='payment_number3' type='text' pattern='[0-9]*'\
					id='paySum"
					+ jobId
					+ "'\
					name='paySum'\
					placeholder='숫자만 입력 가능.' size='15' value=0\
					onkeypress='if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;'>\
				</p>\
			</td>\
			<td>\
				<center>\
				<a href='javascript:setDelPayId("
					+ jobId
					+ ");'>\
					<img src='<c:url value='/images/button/Select_c.png' />' width='15px;'>\
				</a>\
				</center>\
			</td> \
			<td>\
				<center>\
				<a id='btnRfnd"
					+ jobId
					+ "' href='javascript:rfndPayment("
					+ jobId
					+ ");' data-rel='popup'>\
					<img src='<c:url value='/images/button/Select_c.png' />' width='15px;'>\
				</a>\
				</center>\
				<input id='cancel"+jobId+"' valud='0'/>\
			</td> \
		</tr>";

			if (i == 0) {
				$('#payStart').after(tmpHtml);
			} else {
				$('#trPay' + listPayment[i - 1].jobId).after(tmpHtml);
			}
			//카드사 입력. select.
			for ( var j = 0; j < arrCardComId.length; j++) {
				$('#paySlctCardCom' + jobId).append(
						new Option(arrCardComName[j], arrCardComId[j], false,
								true));
			}

			var tmpDate = listPayment[i].datetime.replace('.', '-').replace(
					'.', '-');
			//console.log('tmpDate:'+tmpDate);
			$('#payDate' + jobId).val(tmpDate);
			var tmpPayCash = listPayment[i].payCash;
			$('#payCash' + jobId).val(addComma(tmpPayCash));
			var tmpPayCard = listPayment[i].payCard;
			$('#payCard' + jobId).val(addComma(listPayment[i].payCard));
			var tmpPayPoint = listPayment[i].payPoint;
			$('#payPoint' + jobId).val(addComma(listPayment[i].payPoint));
			$('#paySum' + jobId).text(
					addComma(listPayment[i].payCash + listPayment[i].payCard
							+ listPayment[i].payPoint));
			var tmpCardTy = listPayment[i].cardTy + '';
			$('#paySlctCardCom' + jobId).val(listPayment[i].cardTy);
			document.getElementById("cancel" + jobId).style.display = 'none';
			var tmpCancel = (listPayment[i].cancel) ? (listPayment[i].cancel)
					: '0';
			$('#cancel' + jobId).val(tmpCancel);
			if (listPayment[i].cancel == 2) {
				$('#trPay' + jobId).css('background-color', '#B45F04');
				document.getElementById("btnRfnd" + jobId).style.display = 'none';
				$('#payCash' + jobId).attr('disabled', true);
				$('#payCard' + jobId).attr('disabled', true);
				$('#payPoint' + jobId).attr('disabled', true);

				tmpCancel = $('#cancel' + jobId).val();
				//console.log('tmpCancel:' + tmpCancel);
			}

			arrInitPay.push(jobId);
			mapOrgPay[jobId] = new Payment(jobId, tmpPayCash, tmpPayCard,
					tmpPayPoint, tmpDate, tmpCardTy, tmpDate, tmpCancel);

		}
		//console.log('arrInitPay:' + arrInitPay);
		return;
	}

	function addPayment() {
		//start 1.
		payNum++;
		arrAddPay.push('Add' + payNum);
		var tmpHtml = "\
		<tr id='trPayAdd"+payNum+"'style='color: black' bgcolor='white'>\
		<td > \
			<input class='inputPrdct' id='payDateAdd"
				+ payNum
				+ "' type='date'  data-role='none'/> \
		</td>\
		<td> \
		<input class='payment_number3' type='text' pattern='[0-9]*'\
			id='payCashAdd"
				+ payNum
				+ "'\
			name='payCash'\
			onclick ='resetInputEye(this);'\
			placeholder='숫자만 입력 가능.' size='15' value=0 \
			onkeyup='calcPayment(this,"
				+ payNum
				+ ",1)'\
			onkeypress='if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;'>\
		</input>\
		</td>\
		<td>\
		<input class='payment_number3' type='text'pattern='[0-9]*'\
				id='payCardAdd"
				+ payNum
				+ "'\
				name='payCard'\
				onclick ='resetInputEye(this);'\
				placeholder='숫자만 입력 가능.' size='15' value=0\
				onkeyup='calcPayment(this,"
				+ payNum
				+ ",1)'\
				onkeypress='if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;'>\
		</input>\
		</td>\
		<td>\
			<input class='payment_number3' type='text' pattern='[0-9]*'\
				id='payPointAdd"
				+ payNum
				+ "'\
				name='payPoint'\
				onclick ='resetInputEye(this);'\
				placeholder='숫자만 입력 가능.' size='15' value=0\
				onkeyup='pointLimit(this); calcPayment(this,"
				+ payNum
				+ ",1);'\
				onkeypress='if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;'>\
				</input>\
			</td>\
		<td colspan='1'>\
			<select class='inputPrdctList' style='width:90px' id='paySlctCardComAdd"+payNum+"' >\
		</td>\
		<td  style='text-align: right'>\
			<p class='payment_number3' type='text' pattern='[0-9]*'\
				id='paySumAdd"
				+ payNum
				+ "'\
				name='paySum'\
				placeholder='숫자만 입력 가능.' size='15'\
				onkeypress='if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;'>\
			</p>\
		</td>\
		<td>\
			<center>\
			<a href='javascript:setDelAddPayId("
				+ payNum
				+ ");'>\
				<img src='<c:url value='/images/button/Select_c.png' />' width='15px;'>\
			</a>\
			</center>\
		</td> \
		<td>&nbsp;\
		</td> \
	</tr>";

		// 	console.log('arrInitPay.length:'+arrInitPay.length);
		// 	console.log('arrInitPay[arrInitPay.length].jobId:'+arrInitPay[arrInitPay.length - 1]);
		// 	console.log('arrAddPay[arrAddPay.length-1]):'+arrAddPay[arrAddPay.length-1]);
		// 	console.log('#trPayAdd'+arrAddPay[arrAddPay.length-1]);

		//첫 추가일 경우.
		/* f(arrAddPay.length == 1){
			//초기 결제가 하나도 없을경우.
			if(arrInitPay.length == 0){
				console.log('add Case1');
				$('#payStart').after(tmpHtml);
			//초기 결제가 하나 이상 있을 경우.
			}else{
				if(arrRfndPay.length>0){
					console.log('add Case2');
					$('#trPay'+arrRfndPay[arrRfndPay.length-1]).after(tmpHtml);
				}else{
					console.log('add Case3');
					$('#trPay'+arrInitPay[arrInitPay.length-1]).after(tmpHtml);
				}
			}
		//첫 추가가 아닐경우.
		}else{
			console.log('add Case4');
			$('#trPayAdd'+arrAddPay[arrAddPay.length-2]).after(tmpHtml);	
		} */
		$('#payEnd').before(tmpHtml);

		//카드사 입력. select.
		for ( var j = 0; j < arrCardComId.length; j++) {
			$('#paySlctCardComAdd' + payNum)
					.append(
							new Option(arrCardComName[j], arrCardComId[j],
									false, true));
		}
		var tmpDate = getToday();

		//	console.log('tmpDate:'+tmpDate);
		$('#paySumAdd' + payNum).text(0);
		$('#payDateAdd' + payNum).val(tmpDate);
		$('#paySlctCardComAdd' + payNum).val('0');
	}

	function rfndPayment(refundId) {
		console.log('run rfndPayment:' + refundId);

		payNum++;
		arrRfndPay.push('Rfnd' + payNum);
		var tmpHtml = "\
		<tr id='trPayRfnd"+payNum+"'style='color: black' bgcolor='#B45F04'>\
		<td> \
			<input class='inputPrdct' id='payDateRfnd"
				+ payNum
				+ "' type='date'  data-role='none'/> \
		</td>\
		<td> \
		<input class='payment_number3' type='text' pattern='[0-9]*'\
			id='payCashRfnd"
				+ payNum
				+ "'\
			name='payCash'\
			placeholder='숫자만 입력 가능.' size='15' value=0 \
			onkeyup='calcPayment(this,"
				+ payNum
				+ ",1)'\
			disabled='disabled'\
			onkeypress='if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;'>\
		</input>\
		</td>\
		<td>\
		<input class='payment_number3' type='text'pattern='[0-9]*'\
				id='payCardRfnd"
				+ payNum
				+ "'\
				name='payCard'\
				placeholder='숫자만 입력 가능.' size='15' value=0\
				onkeyup='calcPayment(this,"
				+ payNum
				+ ",1)'\
				disabled='disabled'\
				onkeypress='if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;'>\
		</input>\
		</td>\
		<td>\
			<input class='payment_number3' type='text' pattern='[0-9]*'\
				id='payPointRfnd"
				+ payNum
				+ "'\
				name='payPoint'\
				placeholder='숫자만 입력 가능.' size='15' value=0\
				onkeyup='pointLimit(this); calcPayment(this,"
				+ payNum
				+ ",1);'\
				disabled='disabled'\
				onkeypress='if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;'>\
				</input>\
			</td>\
		<td colspan='1'>\
			<select class='inputPrdctList' style='width:90px' id='paySlctCardComRfnd"+payNum+"' >\
		</td>\
		<td  style='text-align: right'>\
			<p class='payment_number3' type='text' pattern='[0-9]*'\
				id='paySumRfnd"
				+ payNum
				+ "'\
				name='paySum'\
				placeholder='숫자만 입력 가능.' size='15' value=0\
				onkeypress='if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;'>\
			</p>\
		</td>\
		<td>\
			<center>\
			<a href='javascript:setDelRfndPayId("
				+ payNum
				+ ");'>\
				<img src='<c:url value='/images/button/Select_c.png' />' width='15px;'>\
			</a>\
			</center>\
		</td> \
		<td>&nbsp;\
		</td> \
	</tr>";

		// 	console.log('arrInitPay.length:'+arrInitPay.length);
		// 	console.log('arrInitPay[arrInitPay.length].jobId:'+arrInitPay[arrInitPay.length - 1]);
		// 	console.log('arrRfndPay[arrRfndPay.length-1]):'+arrRfndPay[arrRfndPay.length-1]);
		// 	console.log('#trPayRfnd'+arrRfndPay[arrRfndPay.length-1]);
		/* if(arrRfndPay.length == 1){
			if(arrInitPay.length == 0){
				$('#payStart').after(tmpHtml);
			}else{
				$('#trPay'+arrInitPay[arrInitPay.length-1]).after(tmpHtml);	
			}
		}else{
			$('#trPayAdd'+arrRfndPay[arrRfndPay.length-2]).after(tmpHtml);	
		} */
		$('#trPay' + refundId).after(tmpHtml);

		//카드사 입력. select.
		for ( var j = 0; j < arrCardComId.length; j++) {
			$('#paySlctCardComRfnd' + payNum)
					.append(
							new Option(arrCardComName[j], arrCardComId[j],
									false, true));
		}
		var tmpDate = getToday();

		$('#payCashRfnd' + payNum).val('-' + $('#payCash' + refundId).val());
		$('#payCardRfnd' + payNum).val('-' + $('#payCard' + refundId).val());
		$('#payPointRfnd' + payNum).val('-' + $('#payPoint' + refundId).val());
		$('#paySumRfnd' + payNum).text('-' + $('#paySum' + refundId).text());

		//	console.log('tmpDate:'+tmpDate);
		$('#payDateRfnd' + payNum).val(tmpDate);
		$('#paySlctCardComRfnd' + payNum).val(
				$('#paySlctCardCom' + refundId).val());

		setPaymentInfo();
	}

	var DelPayId;
	function setDelPayId(payId) {
		//console.log('payId:'+payId);
		DelPayId = payId;
		$("#delPaymentJQM").popup('open');
	}
	function setDelAddPayId(payId) {
		//console.log('payId:'+payId);
		DelPayId = 'Add' + payId;
		//console.log('DelPayId:'+DelPayId);

		var tmpPayCash = removeComma($('#payCash' + DelPayId).val());
		var tmpPayCard = removeComma($('#payCard' + DelPayId).val());
		var tmpPayPoint = removeComma($('#payPoint' + DelPayId).val());
		/* console.log('tmpPayCash:'+tmpPayCash);
		console.log('tmpPayCard:'+tmpPayCard);
		console.log('tmpPayPoint:'+tmpPayPoint);
		console.log('sum:'+tmpPayCash+tmpPayCard+tmpPayPoint); */
		if (0 == tmpPayCash + tmpPayCard + tmpPayPoint) {
			delPayment();
			return;
		}

		$("#delPaymentJQM").popup('open');
	}

	function setDelRfndPayId(payId) {
		//console.log('payId:'+payId);
		DelPayId = 'Rfnd' + payId;
		//console.log('DelPayId:'+DelPayId);

		/* var tmpPayCash = removeComma($('#payCash'+DelPayId).val());
		var tmpPayCard = removeComma($('#payCard'+DelPayId).val());
		var tmpPayPoint = removeComma($('#payPoint'+DelPayId).val()); */
		/* console.log('tmpPayCash:'+tmpPayCash);
		console.log('tmpPayCard:'+tmpPayCard);
		console.log('tmpPayPoint:'+tmpPayPoint);
		console.log('sum:'+tmpPayCash+tmpPayCard+tmpPayPoint); */
		//if(0==tmpPayCash+tmpPayCard+tmpPayPoint){
		delPayment();
		//	return;
		//}

		//$("#delPaymentJQM").popup('open');
	}

	function delPayment() {
		//console.log('DelPayId:' + DelPayId);

		arrDelPay.push(DelPayId);
		//console.log('step1');
		for ( var i = 0; i < arrInitPay.length; i++) {
			if (arrInitPay[i] == DelPayId) {
				arrInitPay.splice(i, 1);
			}
		}

		for ( var i = 0; i < arrAddPay.length; i++) {
			if (arrAddPay[i] == DelPayId) {
				arrAddPay.splice(i, 1);
			}
		}

		for ( var i = 0; i < arrRfndPay.length; i++) {
			//console.log('arrRfndPay[i]:' + arrRfndPay[i]);
			if (arrRfndPay[i] == DelPayId) {
				arrRfndPay.splice(i, 1);
			}
		}

		//console.log('arrDelPay:' + arrDelPay);
		//console.log('arrAddPay:' + arrAddPay);
		//console.log('arrRfndPay:' + arrRfndPay);
		//console.log('arrInitPay:' + arrInitPay);

		$('#delPrdctJQM').popup('close');
		$('#trPay' + DelPayId).html('');
		setPaymentInfo();
	}

	function format2(n) {
		var reg = /(^[+-]?\d+)(\d{3})/;
		n += '';

		while (reg.test(n))
			n = n.replace(reg, '$1' + ',' + '$2');

		return n;
	}

	function pointLimit(inputThis) {
		//console.log('run pointLimit')
		console.log('val:'+inputThis.value);
		//var pointValue = removeComma(inputThis.value);
		var nPoint = removeComma($("#total_point_txt1").text());
		var payPoint = 0;
		var arrPoint = document.getElementsByName("payPoint");
		/* for ( var i = 0, size = arrPoint.length; i < size; i++) {
			//console.log('PointValue'+arrPoint[i].value);
			payPoint += removeComma(arrPoint[i].value);
		} */
		payPoint = removeComma(inputThis.value)
		//console.log('포인트 확인.:'+(nPoint-payPoint).toString());
		if (0 > (nPoint - payPoint)) {
			alert("가용 포인트를 초과하였습니다.");
			$('#' + inputThis.id).val(0);
			changePointPrcnt();
			return;
		}
		changePointPrcnt();
	}

	function setDscnt(sel) {

		var partnerValue = sel.options[sel.selectedIndex].value;
		partner = partnerValue.split('@');
		partnerId = partner[0];
		var dscntPrcnt = partner[1];
		partnerCert = partner[2];
		partnerMemo = partner[3];

		$("#partnerDscnt_txt").val(dscntPrcnt);

		if (dscntPrcnt == '-1') {
			return;
		}
		changeAllDscnt(dscntPrcnt);

		if (partnerId == '2') {
			//console.log('생일쿠폰!!');
			document.getElementById("birthCoupon").style.display = 'inline';
			document.getElementById("btnBirthCoupon").style.display = 'inline';
			document.getElementById("txtBirthCoupon").style.display = 'inline';
			if (g_couponCd == "NOEXIST") {
				$("#birthCoupon").val("-쿠폰없음-");
				$("#txtBirthCoupon").text("-사용불가-");
			} else if (g_couponShop == 0) {
				$("#birthCoupon").val(g_couponCd);
				$("#txtBirthCoupon").text("-사용가능-");
			} else {
				$("#birthCoupon").val(g_couponCd);
				$("#txtBirthCoupon").text("사용됨:" + g_couponDate);
			}
		} else {
			//console.log('생일 아니다!!');
			//$('#birthCoupon').hide('hide');
			document.getElementById("birthCoupon").style.display = 'none';
			document.getElementById("btnBirthCoupon").style.display = 'none';
			document.getElementById("txtBirthCoupon").style.display = 'none';
		}
		return;
	}

	function formatNumber(number) {
		var pattern = /(-?[0-9]+)([0-9]{3})/;

		while (pattern.test(number)) {
			number = number.replace(pattern, "$1,$2");
		}

		return number;
	}
	function showPartnerInfo() {
		if (partnerId == undefined && partnerCert == undefined
				&& partnerMemo == undefined) {
			alert("협력사 선택 후 정보 열람이 가능합니다.");
			return;
		}

		jQuery('#dlgPartnerInfo_').html('');
		jQuery('#dlgPartnerInfo_')
				.html(
						"<html><body><table border='1' width='100%'><tr><td align='center' style='height: 50%; width: 20%; font-size: 15px'>제휴 조건</td><td align='center'><p id='partner_cert' name='partner_cert' style='height: 50%; width: 80%; font-size: 15px'></p></td></tr><tr><td align='center' style='height: 50%; width: 20%; font-size: 15px'>기타사항</td><td align='center'><p id='partner_memo' name='partner_memo' style='height: 50%; width: 80%; font-size: 15px'></p></td></tr></table></body></html>");
		document.getElementById("partner_cert").innerHTML = partnerCert;
		document.getElementById("partner_memo").innerHTML = partnerMemo;
		
		$("#dlgPartnerInfo").popup();
		$("#dlgPartnerInfo").popup("open");
	}

	//결제와 제품 끝에 둘다 붙어야함.
	function changePointPrcnt() {
		//console.log('run ChangePointPrcnt');
		var tmpEarnPay = 0;

		for ( var i = 0, size = arrInitInvnId.length; i < size; i++) {
			// 		console.log('arrInitInvnId:'+arrInitInvnId[i]);
			// 		console.log('isCheck?:'+$('#earn'+arrInitInvnId[i]).prop('checked'));

			// 		console.log('val:'+$('#dscntPrc'+arrInitInvnId[i]).val());
			var tmpBool = $('#earn' + arrInitInvnId[i]).prop('checked');
			if (tmpBool) {
				tmpEarnPay += removeComma($('#dscntPrc' + arrInitInvnId[i]).val());
			}
		}

		for ( var i = 0, size = arrInitNewId.length; i < size; i++) {
			//console.log('arrInitNewId:'+arrInitNewId[i]);
			//console.log('isCheck?:'+$('#earn'+arrInitNewId[i]).prop('checked'));
			var tmpBool = $('#earn' + arrInitNewId[i]).prop('checked');
			if (tmpBool) {
				tmpEarnPay += removeComma($('#dscntPrc' + arrInitNewId[i]).val());
			}
		}

		for ( var i = 0, size = arrAddInvnId.length; i < size; i++) {
			// 		console.log('arrAddInvnId:'+arrAddInvnId[i]);
			// 		console.log('#dscntPrcAdd'+arrAddInvnId[i]);
			//console.log('isCheck?:'+$('#earn'+arrAddInvnId[i]).prop('checked'));
			var tmpBool = $('#earnAdd' + arrAddInvnId[i]).prop('checked');
			if (tmpBool) {
				tmpEarnPay += removeComma($('#dscntPrcAdd' + arrAddInvnId[i]).val());
			}
		}

		for ( var i = 0, size = arrAddNewId.length; i < size; i++) {
			// 		console.log('arrAddNewId:'+arrAddNewId[i]);
			// 		console.log('#dscntPrcAdd:'+arrAddNewId[i]);
			//console.log('isCheck?:'+$('#earn'+arrAddNewId[i]).prop('checked'));
			var tmpBool = $('#earn' + arrAddNewId[i]).prop('checked');
			if (tmpBool) {
				tmpEarnPay += removeComma($('#dscntPrc' + arrAddNewId[i]).val());
			}
		}

		//console.log('tmpEarnPay:'+tmpEarnPay);

		var pointTotal = 0;
		var earnPrcnt = g_earnPrcnt;
		//console.log('earnPrcnt:'+earnPrcnt);
		var etcDscnt = removeComma($('#etcDscnt_txt').val());
		pointTotal += tmpEarnPay * (earnPrcnt / 100);
		pointTotal -= etcDscnt * (earnPrcnt / 100);
		var tmpPoint = 0;
		for ( var i = 0; i < arrInitPay.length; i++) {
			//console.log('arrInitPay[i]:'+arrInitPay[i]);
			tmpPoint += removeComma($('#payPoint' + arrInitPay[i]).val());
		}

		for ( var j = 0; j < arrAddPay.length; j++) {
			//console.log('arrAddPay[j]:'+arrAddPay[j]);
			tmpPoint += removeComma($('#payPoint' + arrAddPay[j]).val());
		}

		//console.log('pointTotal:'+pointTotal);
		//console.log('tmpPoint:'+tmpPoint);

		pointTotal -= tmpPoint * (earnPrcnt / 100);
		pointTotal = pointTotal - pointTotal % 100;

		//console.log('pointTotal:'+pointTotal);
		if (pointTotal < 0) {
			pointTotal = 0;
		}
		pointTotal = addComma(pointTotal);

		$('#point_total_txt').text(pointTotal);

	}

	function changeAllDscnt(prcnt) {

		if (isNaN(prcnt)) {
			//console.log("isNaN True");
			prcnt = prcnt.value;
		} else {
			//console.log("isNaN False");

		}
		prcnt = addComma(prcnt);

		$('#partnerDscnt_txt').val(prcnt);

		prcnt = removeComma($('#partnerDscnt_txt').val());
		//console.log("prcnt:"+prcnt);

		var elsDscnt = document.getElementsByName("dscntPrcnt_number2");

		for ( var i = 0; i < elsDscnt.length; i++) {
			elsDscnt[i].value = prcnt;
			//console.log(':'+elsDscnt[i].id);
			//console.log(':'+elsDscnt[i].id.substr(10,elsDscnt[i].id.length));
			setDscntPrc(elsDscnt[i].id.substr(10, elsDscnt[i].id.length));
		}
		;
		setTotalPrc();
		changePointPrcnt();
		setPaymentInfo();
	}

	function setDscntPrc(inputId) {

		var tmpCnt = removeComma($('#cnt' + inputId).val());
		var tmpPrc = removeComma($('#prc' + inputId).val());
		var tmpDscntPrcnt = removeComma($('#dscntPrcnt' + inputId).val());

		var tmpDscntPrc = tmpCnt * tmpPrc * (100 - tmpDscntPrcnt) / 100;
		/* console.log('tmpCnt:'+tmpCnt);
		console.log('tmpPrc:'+tmpPrc);
		console.log('tmpDscntPrcnt:'+tmpDscntPrcnt);
		console.log('tmpDscntPrc:'+tmpDscntPrc); */

		$('#dscntPrc' + inputId).val(addComma(tmpDscntPrc));
	}

	function calcRemainedPayment() {
		//console.log('calcRemainedPayment');
		g_remainedPayment = g_dscntTotal - prePayment - etcDscnt;
		Math.round(g_remainedPayment);
		//console.log("on calcRemainedPayment - innerHTML");
		document.getElementById("remainedPayment_txt").innerHTML = formatNumber(String((g_remainedPayment)));
		//calcPrice();
	}

	/* function fncSetEarnAll(source)
	 {
	 console.log('run fncSetEarnAll');
	 checkboxes = document.getElementsByName('earnChkBox');
	 for(var i=0, n=checkboxes.length;i<n;i++) {
	 checkboxes[i].checked = source.checked;
	 if(true==source.checked)
	 {changePointPrcnt(checkboxes[i].value, ALL_CHECKED);}
	 else
	 {changePointPrcnt(checkboxes[i].value, ALL_UNCHECKED);}
	 }
	
	 } */

	function fncSetUsingAll(source) {
		checkboxes = document.getElementsByName('usingChkBox');
		for ( var i = 0, n = checkboxes.length; i < n; i++) {
			checkboxes[i].checked = source.checked;
			if (true == source.checked) {
				pntUsingChk(checkboxes[i].value, ALL_CHECKED);
			} else {
				pntUsingChk(checkboxes[i].value, ALL_UNCHECKED);
			}
		}
	}

	function resetInput(inputThis, prdctId) {
		//console.log('run resetInput');
		//console.log('id:'+inputThis);
		//console.log('id:'+inputThis.id);
		//id.value="0";
		$('#' + inputThis.id).val('');

	}

	function fncGetDate() {
		var datetime = $('#1${saleVoH.saleId}').datepicker({
			dateFormat : 'yy.mm.dd'
		}).val();

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

		//console.log('saleVoH.saleId:'+'${saleVoH.saleId}');
		saleId = Number(saleId);
		histId = Number(histId);

		//console.log("saleId:"+saleId);
		//console.log("histId:"+histId);

		//console.log("staffId:"+'${staffVo.staffId}');

		if (datetime == '' && cardDate == '' && cardTy == 0) {
			alert("수정 정보가 없습니다.");
			return;
		}

		var url = '${ctxPath}/sale/editSaleDate.do';

		$.ajax({
			url : url,
			type : "post",
			data : "saleId=" + saleId + "&histId=" + histId + "&datetime="
					+ datetime,
			dataType : "text",
			beforeSend : function() {
			},
			success : function(data) {
				//console.log(data);
				window.sessionStorage.setItem("popup", 1);
				jQuery('#dlgDateSelect').html('');
				jQuery('#dlgDateSelect').dialog('close');
				//jQuery('#dlgDateSelect').dialog('destroy');
				//location.replace(pageUrl);

				var form = document.createElement("form");
				form.name = 'tempPost';
				form.method = 'post';
				//form.action='${ctxPath}/prdct/indexPrdctProcessForm.do'; 
				form.action = '${ctxPath}/sale/indexSaleForm.do';

				var input = document.createElement("input");
				input.type = "hidden";
				input.name = 'cstmrId';
				input.value = '${saleVoH.cstmrId}';
				$(form).append(input);
				$('body').append(form);
				form.submit();
			}
		});
	}

	function modifyCardPayDate() {
		cardDate = $("#datePicker").val();
		var cardTy = $("#cardTy2").val();
		var param = "jobId=" + jobId + "&cardDate=" + cardDate + "&cardTy="
				+ cardTy;

		//console.log(param);
		var url = "${ctxPath}/sale/modifyCardPayDate.do";

		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data) {
				//console.log(data);
				if (data == "success") {
					//cdate102560
					jQuery('#cdate' + jobId).text(cardDate);
					//jQuery('#tdEdit').html(cardDate);
					//console.log('cardTy:' + cardTy);
					if (cardTy == 0) {
						crtCom = '--선택--';
					} else if (cardTy == 1) {
						crtCom = '비씨';
					} else if (cardTy == 2) {
						crtCom = '삼성';
					} else if (cardTy == 3) {
						crtCom = '엘지';
					} else if (cardTy == 4) {
						crtCom = '국민';
					} else if (cardTy == 5) {
						crtCom = '외환';
					} else if (cardTy == 6) {
						crtCom = '현대';
					} else if (cardTy == 7) {
						crtCom = '신한';
					} else if (cardTy == 8) {
						crtCom = '롯데';
					} else if (cardTy == 9) {
						crtCom = 'NH농협';
					} else if (cardTy == 10) {
						crtCom = '하나SK';
					} else if (cardTy == 11) {
						crtCom = '직불카드';
					} else if (cardTy == 12) {
						crtCom = '선택안함';
					} else if (cardTy == 13) {
						crtCom = '현금영수증';
					}
					jQuery('#ccom' + jobId).text(crtCom);

					$("#dlgDateSelect").dialog('close');
				}
			}
		});
	}

	var jobId;
	function modifyCardDate(jobId_) {
		jobId = jobId_;
		var innerDlg = "<html>\
		<body>\
		<table border='0' width='100%'>\
			<tr align='center'bgcolor='white'>\
				<td>&nbsp;</td>\
				<td>카드결제일</td>\
				<td>카드사</td>\
			</tr>\
			<tr align='center'bgcolor='white'>\
				<td>현재</td>\
				<td id='crtCardDate'></td>\
				<td id='crtCardCom'></td>\
			</tr>\
			<tr align='center' bgcolor='white'>\
				<td style='width: 40px;'>변경</td>\
				<td>\
					<input id='datePicker' type='text'\
					style='height: 30px; width: 120px; font-size: 15px' data-role='date' '>\
				</td>\
				<td>\
					<select id='cardTy2' name='edit_card_com_slct'\
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
			<td colspan='4' align='center'><button onclick='modifyCardPayDate();return false;'\
			id='submit' style='height: 40px; width: 120px' bgcolor='white'>확인</button></td>\
			</tr>\
		</table>\
		</body>\
		</html>";
		jQuery('#dlgDateSelect').html('');

		jQuery('#dlgDateSelect').html(innerDlg);
		$('#datePicker').datepicker({
			dateFormat : 'yy.mm.dd'
		});
		//$( ".selector" ).datepicker( "hide" );

		jQuery('#dlgDateSelect').dialog({
			//bgiframe: true
			title : "수정 날짜 선택",
			modal : true,
			width : 420 // 가로 크기
			,
			height : 200,
			background : "#000",
			open : function() {
				//bfInfo = $(obj).text();
				//infoType = $(obj).attr('name');

				var crtDate = $('#cdate' + jobId).text();
				//console.log('crtDate:'+crtDate);
				jQuery('#crtCardDate').text(crtDate);

				var crtCom = $('#ccom' + jobId).text();
				//console.log('crtCom:'+crtCom);
				jQuery('#crtCardCom').text(crtCom);

			},
			close : function(event, ui) {
				//console.log("in close . editDate");
				jQuery('#dlgDateSelect').html('');

			},
			success : function(data) {

				//console.log($("#prdctCnt").val())

			}
		});
	}
	function dlgDateSelect() {

		//console.log("HsaleId:"+'${saleVoH.saleId}');
		//console.log("HshopId:"+'${saleVoH.shopId}');
		//console.log("shopId:"+'${shopVo.shopId}');
		//console.log("staffId:"+'${staffVo.staffId}');

		if ('${saleVoH.shopId}' != '${shopVo.shopId}') {
			alert("타 매장 기록은 수정 할 수 없습니다.");
			return;
		}

		var innerDlg = "<html>\
					<body>\
					<table border='0' width='100%'>\
						<tr align='center'bgcolor='white'>\
							<td>&nbsp;</td>\
							<td>처방일</td>\
						</tr>\
						<tr align='center'bgcolor='white'>\
							<td>현재</td>\
							<td>${saleVoH.datetime}</td>\
						</tr>\
						<tr align='center' bgcolor='white'>\
							<td style='width: 40px;'>변경</td>\
							<td>\
								<input id='1${saleVoH.saleId}' type='text'\
								style='height: 30px; width: 120px; font-size: 15px'>\
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
		$('#1${saleVoH.saleId}').datepicker({
			dateFormat : 'yy.mm.dd'
		});
		$('#2${saleVoH.saleId}').datepicker({
			dateFormat : 'yy.mm.dd'
		});
		//$( ".selector" ).datepicker( "hide" );

		jQuery('#dlgDateSelect').dialog({
			//bgiframe: true
			title : "수정 날짜 선택",
			modal : true,
			width : 420 // 가로 크기
			,
			height : 200,
			background : "#000",
			close : function(event, ui) {
				//console.log("in close . editDate");
				jQuery('#dlgDateSelect').html('');

			},
			success : function(data) {
				//console.log($("#prdctCnt").val())

			}
		});
	}

	function closeSingleFrame() {
		self.opener = self;
		window.close();
	}
	// 다중프레임의 경우
	function closeMultiFrame() {
		top.opener = top;
		top.window.close();
	}

	$(function() {
		var saleId = Number('${saleVoH.saleId}');
		var cash = Number('${saleVoH.payCash}');
		var point = Number('${saleVoH.payPoint}');
		var cardName = '${saleVoH.cardName}';
		if (cash != "0") {
			$("#deposit").append(
					"(현금 : " + formatNumber(String(cash)) + ")<br>");
		}
		if (point != "0") {
			$("#deposit").append(
					"(포인트 : " + formatNumber(String(point)) + ")<br>");
		}
		getPayCardInfo(saleId);
	});

	function getPayCardInfo(saleId) {
		var param = "saleId=" + saleId;
		var url = "${ctxPath}/sale/getPayCardInfo.do";

		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			success : function(data) {
				$("#deposit").append(data);
			}
		});
	}

	function goPrintDlg() {
		
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
//	 	console.log('mapInvnPrdct:'+JSON.stringify(mapInvnPrdct));
//	 	console.log(JSON.stringify(arrCrtPrdct));
		
		var json1 = JSON.stringify(saveJsonSale);
		jsonSale.fmlyCd = $('#fmly_cd_txt1').text();
		var json2 = JSON.stringify(jsonSale);
		if(json1==json2){
	/* 		console.log('equal!');
			console.log("jsonSale:"+JSON.stringify(jsonSale));
			console.log("saveJsonSale:"+JSON.stringify(saveJsonSale)); */
			
			window.open("${ctxPath}/prdct/indexPrdctProcessFormPrint.do");
			return;
		}else{
			alert('저장 후 출력 바랍니다..');
			checkDiff(jsonSale,saveJsonSale);
			return;
		}

		//location.href="${ctxPath}/prdct/indexPrdctProcessFormPrint.do";
		
	}
	function goTaxPrint(){
		//console.log('run goTaxPrint');
		// 1. 결제 완료되었는지 체크.
		if(jsonSale.result.substr(4,1) != '1' ){alert("결제가 완료되지 않았습니다.");return;}
		
		// 2. 같은 매장인지 체크. 
		if(jsonSale.shopId == 1){
			alert('저장되지 않은 처방입니다. 저장 후 이용 바랍니다.');
			return;
		}else if(jsonSale.shopId != '${shopVo.shopId}'){
			alert('타 매장 매출은 출력 하실 수 없습니다.');
			return;
		}
		
		$('#dlgInputTaxName').popup("open");
		$('#txtTaxBigo').text(g_taxBigo);
	}
 
	var earnAllChecked = true;

	function fncSetEarnCheckAll() {
		console.log('go fncSetEarnCheckAll');
		var inputElements = document.getElementsByTagName('input');
		for ( var i = 0; i < inputElements.length; ++i) {
			if (inputElements[i].className == "earnChk") {
				inputElements[i].checked = earnAllChecked;
				console.log('checkId:' + inputElements[i].id);
				//changePointPrcnt(inputElements[i].id.substr(4,inputElements[i].id.length));
				changePointPrcnt();
			}
		}
		if (earnAllChecked == true) {
			earnAllChecked = false;
		} else {
			earnAllChecked = true;
		}
	}
	var asmAllChecked = true;
	function fncSetAsmCheckAll() {
		var inputElements = document.getElementsByTagName('input');
		for ( var i = 0; i < inputElements.length; ++i) {
			if (inputElements[i].className == "asmChk") {
				inputElements[i].checked = asmAllChecked;
			}
		}
		if (asmAllChecked == true) {
			asmAllChecked = false;
		} else {
			asmAllChecked = true;
		}
	}
	var dlvryAllChecked = true;
	function fncSetDlvryCheckAll() {
		var inputElements = document.getElementsByTagName('input');
		for ( var i = 0; i < inputElements.length; ++i) {
			if (inputElements[i].className == "dlvryChk") {
				inputElements[i].checked = dlvryAllChecked;
			}
		}
		if (dlvryAllChecked == true) {
			dlvryAllChecked = false;
		} else {
			dlvryAllChecked = true;
		}
	}
	function fncSetCheckAll() {
		
		var checkAll = $('#chkAll').prop("checked");
		
		dlvryAllChecked = checkAll;
		earnAllChecked = checkAll;
		asmAllChecked = checkAll;

		fncSetEarnCheckAll();
		fncSetAsmCheckAll();
		fncSetDlvryCheckAll();
	}
	
	//init
	function setPriceInfo(inputThis, inputId, ty) {
		inputThis.value = addComma(removeComma(inputThis.value));
		var tmpId = '';
		if (ty == 'default') {

		} else if (ty == 'N') {
			tmpId = 'N';
		} else if (ty == 'Add') {
			tmpId = 'Add';
		} else if (ty == 'AddN') {
			tmpId = 'AddN';
		} else {
			//console.log('@@Error sePriceInfo Type Problem');
		}

		var tmpCnt = removeComma($('#cnt' + tmpId + inputId).val());
		var tmpPrc = removeComma($('#prc' + tmpId + inputId).val());
		var tmpDscntPrcnt = removeComma($('#dscntPrcnt' + tmpId + inputId).val());
		var tmpDscntPrc = tmpCnt * tmpPrc * (100 - tmpDscntPrcnt) / 100;
		
		/* console.log('tmpCnt:' + tmpCnt);
		console.log('tmpPrc:' + tmpPrc);
		console.log('tmpDscntPrcnt:' + tmpDscntPrcnt);
		console.log('tmpDscntPrc:' + tmpDscntPrc); */

		$('#dscntPrc' + tmpId + inputId).val(addComma(tmpDscntPrc));

		setTotalPrc();
		changePointPrcnt();
		setPaymentInfo();
	}

	function setTotalPrc() {
		console.log('run setTotalPrc');

		var tmpTotalPrc = 0;
		var tmpTotalDscntPrc = 0;
		for ( var i = 0, size = arrInitInvnId.length; i < size; i++) {
			//tmpTotalPrc +=
			//  		console.log('arrInitInvnId['+i+']'+arrInitInvnId[i]);
			var tmpCnt = $('#cnt' + arrInitInvnId[i]).val();
			var tmpPrc = $('#prc' + arrInitInvnId[i]).val();
			var tmpDscntPrc = $('#dscntPrc' + arrInitInvnId[i]).val();
			tmpTotalPrc += removeComma(tmpPrc) * removeComma(tmpCnt);
			tmpTotalDscntPrc += removeComma(tmpDscntPrc);
		}
		for ( var i = 0, size = arrInitNewId.length; i < size; i++) {
			//tmpTotalPrc +=
			// 		console.log('arrInitNewId['+i+']'+arrInitNewId[i]);
			var tmpCnt = $('#cnt' + arrInitNewId[i]).val();
			var tmpPrc = $('#prc' + arrInitNewId[i]).val();
			var tmpDscntPrc = $('#dscntPrc' + arrInitNewId[i]).val();

			// 		console.log('tmpCnt:'+tmpCnt);
			// 		console.log('tmpPrc:'+tmpPrc);
			// 		console.log('tmpDscntPrc:'+tmpDscntPrc);
			tmpTotalPrc += removeComma(tmpPrc) * removeComma(tmpCnt);
			tmpTotalDscntPrc += removeComma(tmpDscntPrc);
		}
		for ( var i = 0, size = arrAddInvnId.length; i < size; i++) {
			//tmpTotalPrc +=
			// 		console.log('arrAddInvnId['+i+']'+arrAddInvnId[i]);
			var tmpCnt = $('#cntAdd' + arrAddInvnId[i]).val();
			var tmpPrc = $('#prcAdd' + arrAddInvnId[i]).val();
			var tmpDscntPrc = $('#dscntPrcAdd' + arrAddInvnId[i]).val();
			tmpTotalPrc += removeComma(tmpPrc) * removeComma(tmpCnt);
			tmpTotalDscntPrc += removeComma(tmpDscntPrc);
		}

		for ( var i = 0, size = arrAddNewId.length; i < size; i++) {
			//tmpTotalPrc +=
			// 		console.log('arrAddNewId['+i+']'+arrAddNewId[i]);
			var tmpCnt = $('#cnt' + arrAddNewId[i]).val();
			var tmpPrc = $('#prc' + arrAddNewId[i]).val();
			var tmpDscntPrc = $('#dscntPrc' + arrAddNewId[i]).val();
			// 		console.log('tmpCnt:'+tmpCnt);
			// 		console.log('tmpPrc:'+tmpPrc);
			// 		console.log('tmpDscntPrc:'+tmpDscntPrc);
			tmpTotalPrc += removeComma(tmpPrc) * removeComma(tmpCnt);
			tmpTotalDscntPrc += removeComma(tmpDscntPrc);
		}

		/* 	console.log('tmpTotalPrc:'+tmpTotalPrc);
		 console.log('tmpTotalDscntPrc:'+tmpTotalDscntPrc); */
		/* arrAddInvnId
		arrInitNewId
		arrAddNewId */
		$('#totalPrc').text('');
		$('#totalDscntPrc').text('');
		$('#totalPrc').text(addComma(tmpTotalPrc));
		$('#totalDscntPrc').text(addComma(tmpTotalDscntPrc));
	}

	function setPaymentInfo() {
		//console.log('run setPaymentInfo');
		var inputValue = (removeComma($('#etcDscnt_txt').val())) ? removeComma($(
				'#etcDscnt_txt').val())
				: 0;

		var inputId = 'etcDscnt_txt';
		$('#' + inputId).val(addComma(inputValue));

		var sumTmpVal = 0;
		for ( var i = 0, size = arrInitPay.length; i < size; i++) {
			// 		console.log('arrInitPay.[i]:'+arrInitPay[i]);
			var tmpVal = removeComma($('#paySum' + arrInitPay[i]).text());
			//  		console.log('tmpVal:'+tmpVal);
			sumTmpVal += tmpVal;
		}
		//console.log('sumTmpVal1:' + sumTmpVal);
		for ( var i = 0, size = arrAddPay.length; i < size; i++) {
			//  	console.log('arrAddPay.[i]:'+arrAddPay[i]);
			var tmpVal = removeComma($('#paySum' + arrAddPay[i]).text());
			//  	console.log('tmpVal:'+tmpVal);
			sumTmpVal += tmpVal;
		}
		// 	console.log('sumTmpVal2:'+sumTmpVal);
		// 	console.log('arrRfndPay.length:'+arrRfndPay.length);
		for ( var i = 0, size = arrRfndPay.length; i < size; i++) {
			//  	console.log('arrRfndPay.[i]:'+arrRfndPay[i]);
			var tmpVal = removeComma($('#paySum' + arrRfndPay[i]).text());
			//   	console.log('tmpVal:'+tmpVal);
			sumTmpVal += tmpVal;
		}

		//sumTmpVal += parseInt(inputValue);
		//	console.log('sumTmpVal3:'+sumTmpVal);
		$('#remainedPayment_txt').text(addComma(sumTmpVal));

		var totalDscntPrc = removeComma($('#totalDscntPrc').text());
		// 	console.log('totalDscntPrc:'+totalDscntPrc);
		// 	console.log('totalDscntPrc:'+totalDscntPrc +'sumTmpVal:'+sumTmpVal+'inputValue:'+inputValue);
		$('#penny_txt').text(
				addComma(totalDscntPrc - sumTmpVal - parseInt(inputValue)));
	}

	function calcPayment(inputId, jobId, payTy) {
		//console.log('run calcPayment');
		var tmpValue = inputId.value;
		var tmpId = inputId.id;

		$('#' + tmpId).val(addComma(tmpValue));

		//  	console.log('inputId:'+tmpId);
		//  	console.log('inputValue:'+tmpValue);
		if (payTy == 1) {
			jobId = 'Add' + jobId;
		}

		var payCash = removeComma($('#payCash' + jobId).val());
		var payCard = removeComma($('#payCard' + jobId).val());
		var payPoint = removeComma($('#payPoint' + jobId).val());
		var paySum = payCash + payCard + payPoint;

		// 	console.log('id: #paySum'+jobId);
		// 	console.log('paySum:'+paySum);
		$('#paySum' + jobId).text(addComma(paySum));

		changePointPrcnt();
		setPaymentInfo();
	}

	function delSaleId() {
		if (saleId == 1) {
			alert('아직 저장되지 않은 처방입니다.');
			return;
		}

		if (confirm("삭제하시겠습니까?\n*삭제한 데이터는 복구할 수 없습니다.") == false) {
			return;
		}
		var url = "${ctxPath}/sale/delSaleId.do";

		var param = "saleId=" + saleId;

		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data) {
				if (data == "success") {
					getVisitListForFrame();
					getCstmrPoint();
				} else {
					alert("실패하였습니다.");
				}
			}
		});
	}
	/* <input style='width:80px' id='birthCoupon' placeholder='쿠폰번호입력' type = 'text' />
	 <input id='btnBirthCoupon' onclick='checkBirth' type = 'button' value='체크' />
	 <span style='font-size:9px;' id='txtBirthCoupon' > </span> */
	
	function unSetCoupon() {
		//console.log('Run unSetCoupon');
		var cancelCoupon = $("#birthCoupon").val();
		jsonSale.cancelCoupon = cancelCoupon;
		//console.log('cancelCoupon:' + cancelCoupon);
		$('#slctPartner').attr('disabled', false);
		$('#birthCoupon').attr('disabled', false);
		
		document.getElementById("labelBirthCoupon").style.display = 'none';
		document.getElementById("unSetCoupon").style.display = 'none';
		document.getElementById("birthCoupon").style.display = 'inline';
		document.getElementById("btnBirthCoupon").style.display = 'inline';
		document.getElementById("txtBirthCoupon").style.display = 'inline';
	}

	function addZero(n) {
		if (n.length == "1") {
			n = "0" + n;
		}
		return n;
	}
	
	function openPartnerInfo(){
		//console.log('run openPartnerInfo');
		jQuery.ajax({  
			url: '${ctxPath}/cstmrHstry/listPartnerData.do'
			, type: "POST"			
			, dataType: "html"
			, success:  function(data) {				
				jQuery('#partnerInfo').html(data);
				$('#popPartnerInfo').popup( 'open',{transition: "pop"});
			}	
		});	
	}
	
</script>

<style>
 /* input[type=checkbox] {
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
    } */
    
    /* .cstmrHstrStaffList>tbody>tr>td>img{
    	display:none;
    } */ 
    
.date_number{
height: 40px;
width: 200px;
font-weight: bold;
font-size: 15px;
text-align: center;
}

#slct_card_com,#slctPartner{
	/* display: none; */
}


.cstmrHstrStaffList
{
	font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
	width:100%;
	border-collapse:collapse;
}
.cstmrHstrStaffList td, .cstmrHstrStaffList th 
{
font-size:1em;
border:1px solid #98bf21;
padding:3px 7px 2px 7px;
}
.cstmrHstrStaffList th {
font-size:1.1em;
text-align:left;
padding-top:5px;
padding-bottom:4px;
background-color:#A7C942;
color:#ffffff;
}
.cstmrHstrStaffList tr.alt td 
{
color:#000000;
background-color:#EAF2D3;
}
#dlgPartnerInfo{
	padding : 10px;
	border-radius : 10px;
}
</style>

<table class="cstmrHstrStaffList" border='1' style="font-size: 13px;width:100%;">
	<div hiddn id="dscnt_old" value="${saleVoH.partnerDscnt}"></div>
	<div hiddn id="dscnt_type_old" value="${saleVoH.partnerId}"></div>
	<%-- <tr>
		<td height="3" colspan="10"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr> --%>

	<tr>
		<!-- <th class="borderL borderR blueTr" colspan="10" style="background-color: white; color: black;font-size: 16px;">전체 할인 및 적립 설정</th> -->
		<th class="borderL borderR blueTr" colspan="6">전체 할인 및 적립</th>
		<th class="borderL borderR blueTr" colspan="4">
			<center>
				<input id='chkAll' class='chkAll'
	        			type="checkbox"
						onChange="fncSetCheckAll();"/>
				<label for='chkAll'></label>
			</center>	
		</th>
	</tr>
	<%-- <tr>
		<td height="3" colspan="10"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr> --%>
	
	<tr>
		<td colspan="10">
			<img src="${ctxPath	}/images/green_line.jpg" width="100%">					
		</td>
	</tr>
	
	<tr bgcolor="white" style="color: black">
		<td>
			제휴할인
			<input type='button' value='전체보기' onclick='openPartnerInfo();' />
		</td>
		<td colspan="2">
			<select id='slctPartner' name='slctPartner' onChange="setDscnt(this);">
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
			<!-- <span id="slctPartner2"></span> -->
			
		</td>

		<td>
			<input type="button" style="height: 20px" value="할인 정보" id="btnShowPartner" onClick="showPartnerInfo();">
		</td>

<!-- 				 -->
		<td width='50px'>
			<input id="partnerDscnt_txt"
				class ='prcnt_number2'
				type='text'
				name="partnerDscnt_txt"
				placeholder="숫자만 입력 가능." size="3"
				value="${ saleVoH.partnerDscnt}"
				onclick ="resetInputEye(this);"
				onkeyup="changeAllDscnt(this);"
				onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;">
			</input>
		</td>
		<td colspan='5'>
			<label id='labelBirthCoupon' for='birthCoupon' >적용쿠폰:</label>
			<!-- onclick ="resetInputEye(this);" -->
			<input style='width:80px' id='birthCoupon'
					onclick ="setCouponCdJQM();"
					placeholder='쿠폰번호입력' type = 'text' />
			<input id='unSetCoupon' onclick='unSetCoupon(); return false;' type = 'button' value='해제' />
			
			<input id='btnBirthCoupon' onclick='checkBirth(); return false;' type = 'button' value='체크' />
			<span style='font-size:9px;' id='txtBirthCoupon' > </span>
			<script>
			
			var tmpPartner = $('#slctPartner').val();
			var tmpArr = tmpPartner.split('@');
			var partnerId =  tmpArr[0];
			//console.log('g_usedCouponCd:'+g_usedCouponCd);
			//console.log('g_couponCd:'+g_couponCd);
			if(g_usedCouponCd){
				
				document.getElementById("labelBirthCoupon").style.display='inline';
				document.getElementById("birthCoupon").style.display='inline';
				document.getElementById("unSetCoupon").style.display='inline';
				
				$('#birthCoupon').val(g_usedCouponCd);
				$('#birthCoupon').attr('disabled', true);
				$('#slctPartner').attr('disabled', true);
				
				document.getElementById("btnBirthCoupon").style.display='none';
				document.getElementById("txtBirthCoupon").style.display='none';	
			}else if(partnerId=='2'){
				//console.log('생일쿠폰!!');
				
				document.getElementById("labelBirthCoupon").style.display='none';
				document.getElementById("unSetCoupon").style.display='none';
				
				document.getElementById("birthCoupon").style.display='inline';
				document.getElementById("btnBirthCoupon").style.display='inline';
				document.getElementById("txtBirthCoupon").style.display='inline';
				
				$('#birthCoupon').attr('disabled', false);
				
				if(g_couponCd == "NOEXIST"){
					$("#birthCoupon").val("-쿠폰없음-");
					$("#txtBirthCoupon").text("-사용불가-");
				}else if(g_couponShop==0){
					$("#birthCoupon").val(g_couponCd);
					$("#txtBirthCoupon").text("-사용가능-");
				}else{
					$("#birthCoupon").val(g_couponCd);
					$("#txtBirthCoupon").text("사용됨:"+g_couponDate);
				}
				//$('#birthCoupon').hide('show');
			}else{
				//console.log('생일 아니다!!');
				//$('#birthCoupon').hide('hide');
				document.getElementById("labelBirthCoupon").style.display='none';
				document.getElementById("unSetCoupon").style.display='none';
				
				document.getElementById("birthCoupon").style.display='none';
				document.getElementById("btnBirthCoupon").style.display='none';
				document.getElementById("txtBirthCoupon").style.display='none';
			}

			</script>
		</td>
	</tr>
	
	<tr>
		<td colspan="10">
			<img src="${ctxPath	}/images/green_line.jpg" width="100%">					
		</td>
	</tr>
	
	<tr class="tb" style="color: black" bgcolor="white">
		<td style='width:150px'>제품명</br>
		<input type=button onclick='addNewPrdct(); return false;' value='신규'/>
		<input type=button onclick='addInvnPrdct(); return false;' value='재고'/>
		<%-- <a href="javascript:addPrdctJQM();">
			<img src="<c:url value="/images/button/Select_p.png" />" width="15px;">
		</a> --%>
		</td>
		<td  style="text-align: center;">종류</td>
		<td  style="text-align: center;">수량</td>
		<td  style="text-align: center;">가격</td>
		<td  style="text-align: center;">할인%</td>
		<td  style="text-align: center;">할인후가격</td>
		<td onclick='fncSetEarnCheckAll(); return false;' style="text-align: center;">적립</td>
		<td onclick='fncSetAsmCheckAll(); return false;'  style="text-align: center;">조립</td>
		<td onclick='fncSetDlvryCheckAll(); return false;'  style="text-align: center;">전달</td>
		<td  style="text-align: center;">제거</td>
		<!-- <td width="80px">적립예정</td>
		<td width="40px">사용</td> -->
	</tr>
	<c:choose>
		<c:when test="${ !empty listPrdctH || !empty newPrdctH}">
			<form id="listCheckBox" name="listCheckBox" method="post" action="">
			<!-- @@Frame. -->
				<c:forEach var="prdct" items="${listPrdctH}" varStatus="status" >
					<tr id='tr${prdct.itemTy}${prdct.prdctId}' class="listData trListPrdct" style="color: black" bgcolor="white">
						<td width="140px">
							<input type='text' id='name${prdct.itemTy}${prdct.prdctId}'
									class='inputPrdct'
									style='width:100%; text-align: center;'
									value='${prdct.prdctName}' disabled='disabled'>
							<%-- <a onclick="editInvnPrdct('${prdct.itemTy}${prdct.prdctId}');return false;" href="#invnPrdctJQM" data-rel="popup" data-role="button" data-mini="true" data-inline="true"><img src="<c:url value="/images/content/edit.png" />" width="15px;"></a> --%>
						</td>
						<%-- <td>${prdct.colorName}</td> --%>
						<td>
							<select class='inputPrdctList' id='slctTy${prdct.itemTy}${prdct.prdctId}' disabled="disabled">
								<option value='0'>종류선택</option>
								<option value='1'>프레임</option>
								<option value='2'>렌즈</option>
								<option value='3'>콘텍트렌즈</option>
								<option value='4'>기타</option>
								<option value='5'>선글라스</option>
								<option value='6'>일회용렌즈</option>
							</select>
						</td>
						<td >
							<input type='text' style='width:30px;'
									class='inputPrdct'	
									id='cnt${prdct.itemTy}${prdct.prdctId}'
									value='${prdct.prdctCnt}'
									disabled="disabled"
									onclick ='resetInputEye(this);'
									onkeyup="setPriceInfo(this,'${prdct.itemTy}${prdct.prdctId}', 'default');"
									/>
						</td>
						<td>
							<input id='prc${prdct.itemTy}${prdct.prdctId}'
									class='inputPrdct'
									onkeyup="setPriceInfo(this,'${prdct.itemTy}${prdct.prdctId}', 'default');"	
									style="width:70px; text-align: right;" disabled="disabled"/>
						</td>
						<td style="text-align: right;">
						<input id="dscntPrcnt${prdct.itemTy}${prdct.prdctId}"
								class="prcnt_number2 inputPrdct" type="text" value='${prdct.dscntPrcnt}' size="3" name="dscntPrcnt_number2"
								<%-- onClick="resetInput(this,'${prdct.itemTy}${prdct.prdctId}');" --%>
								onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;"
								onkeyup="setPriceInfo(this,'${prdct.itemTy}${prdct.prdctId}', 'default');"
								value ='${prdct.dscntPrcnt}'>
						</input>
						</td>
						
						<td style="text-align: right;">
							<input type='text'
									class="inputPrdct"
									id="dscntPrc${prdct.itemTy}${prdct.prdctId}" style="width:70px; text-align: right;" disabled="disabled"/>
							
								<%-- <fmt:formatNumber value= "${prdct.prc*prdct.prdctCnt*((100-prdct.dscntPrcnt)/100)}" pattern="#,###" /> --%>
						</td>
						<td style="text-align: center;">
							
				        	<input id='earn${prdct.itemTy}${prdct.prdctId}'
				        			class="earnChk"
				        			type="checkbox"
				        			name="earnChkBox" value="${prdct.itemTy}${prdct.prdctId}"
									onChange="changePointPrcnt();"/>
							<label for='earn${prdct.itemTy}${prdct.prdctId}'></label>
						</td>
						
						<td style="text-align: center;">

				        	<input id='asm${prdct.itemTy}${prdct.prdctId}'
				        			class="asmChk"
				        			type="checkbox"
				        			name="earnChkBox" value="${prdct.itemTy}${prdct.prdctId}"
									onChange="changePointPrcnt();"/>
							<label for='asm${prdct.itemTy}${prdct.prdctId}'></label>							
						</td>
						
						<td style="text-align: center;">
							
				        	<input id='dlvry${prdct.itemTy}${prdct.prdctId}'
				        			class="dlvryChk"
				        			type="checkbox"
				        			name="earnChkBox" value="${prdct.itemTy}${prdct.prdctId}"
									onChange="changePointPrcnt();"/>
							<label for='dlvry${prdct.itemTy}${prdct.prdctId}'></label>
						</td>
						<td>
							<a href="#" onclick="setDelInvnPrdct('${prdct.itemTy}${prdct.prdctId}','delInvnPrdctJQM','${prdct.prdctCnt}');return false;" data-rel="popup" data-role="button" data-mini="true" data-inline="true">
								<img src="<c:url value="/images/button/Select_c.png" />" width="15px;">
							</a>
						</td>
						<td hidden><p id="pointPrice${prdct.itemTy}${prdct.prdctId}">
								<fmt:formatNumber value= "${prdct.prc*prdct.prdctCnt*((100-prdct.dscntPrcnt)/100)*(prdct.earnPrcnt/100)}" pattern="#,###" />
							</p>
						</td>
						<td hidden>
						<c:choose>
					        <c:when test="${prdct.usingPoint =='1'}">
					        	<%-- <input class="usingCheckbox" type="checkbox" name="usingChkBox" checked
								value="${prdct.itemTy}${prdct.prdctId}" onChange="pntUsingChk('${prdct.itemTy}${prdct.prdctId}', CHANGE);"></input> --%>
					        </c:when>
					        <c:otherwise>
					        	<%-- <input class="usingCheckbox" type="checkbox" name="usingChkBox"
								value="${prdct.itemTy}${prdct.prdctId}" onChange="pntUsingChk('${prdct.itemTy}${prdct.prdctId}', CHANGE);"></input> --%>
					        </c:otherwise>
				    	</c:choose>
						</td>

						<script>
							$('#dscntPrc${prdct.itemTy}${prdct.prdctId}').val(addComma('${prdct.prc*prdct.prdctCnt*(100-prdct.dscntPrcnt)/100}'));
							$("#slctTy${prdct.itemTy}${prdct.prdctId}").val('${prdct.itemTy}');
							$('#prc${prdct.itemTy}${prdct.prdctId}').val(addComma('${prdct.prc}'));
							
							if('${prdct.earnPrcnt}'==5){
								$('#earn${prdct.itemTy}${prdct.prdctId}').prop('checked', true);	
							}else{
								$('#earn${prdct.itemTy}${prdct.prdctId}').prop('checked', false);
							}
							$('#earn${prdct.itemTy}${prdct.prdctId}').val('${prdct.earnPrcnt}');
							
							if('${prdct.asmbly}'==1){
								$('#asm${prdct.itemTy}${prdct.prdctId}').prop('checked', true);	
							}else{
								$('#asm${prdct.itemTy}${prdct.prdctId}').prop('checked', false);
							}
							$('#asm${prdct.itemTy}${prdct.prdctId}').val('${prdct.asmbly}');
							
							if('${prdct.dlvry}'==1){
								$('#dlvry${prdct.itemTy}${prdct.prdctId}').prop('checked', true);	
							}else{
								$('#dlvry${prdct.itemTy}${prdct.prdctId}').prop('checked', false);
							}
							$('#dlvry${prdct.itemTy}${prdct.prdctId}').val('${prdct.dlvry}');
							
				 			arrPrdctId.push('${prdct.itemTy}${prdct.prdctId}');
					 		mapCnt['${prdct.itemTy}${prdct.prdctId}'] = '${prdct.prdctCnt}';
					 		mapPrc['${prdct.itemTy}${prdct.prdctId}'] = '${prdct.prc}';
					 		mapDscntPrcnt['${prdct.itemTy}${prdct.prdctId}'] = ['${prdct.dscntPrcnt}'];
					 		mapEarnPrcnt['${prdct.itemTy}${prdct.prdctId}'] = ['${prdct.earnPrcnt}'];
					 		mapPntUsingChk['${prdct.itemTy}${prdct.prdctId}'] = ['${prdct.usingPoint}'];
					 		
// 					 		console.log();
// 					 		console.log('prdctId:'+'${prdct.prdctId}');
// 					 		console.log('itemTy:'+'${prdct.itemTy}');
// 					 		console.log('name:'+'${prdct.prdctName}');
// 					 		console.log('cnt:'+'${prdct.prdctCnt}');
// 					 		console.log('prc:'+'${prdct.prc}');
// 					 		console.log('dscntPrcnt:'+'${prdct.dscntPrcnt}');
// 					 		console.log('earnPrcnt:'+'${prdct.earnPrcnt}');
// 					 		console.log('asmbly:'+'${prdct.asmbly}');
// 					 		console.log('dlvry:'+'${prdct.dlvry}');
					 		
					 		arrCrtPrdct.push(new ObjPrdct('${prdct.prdctId}', '${prdct.itemTy}', encodeURIComponent('${prdct.prdctName}'), '${prdct.prdctCnt}'
					 									, '${prdct.prc}', '${prdct.dscntPrcnt}', '${prdct.earnPrcnt}', '${prdct.asmbly}','${prdct.dlvry}', '0','0','0'));
					 		//console.log('arrCrtPrdct Size:'+arrCrtPrdct.length);
					 		//console.log('push id :'+'${prdct.itemTy}${prdct.prdctId}');
					 		arrInitInvnId.push('${prdct.itemTy}${prdct.prdctId}');
					 		mapInvnPrdct['${prdct.itemTy}${prdct.prdctId}'] = new ObjPrdct('${prdct.prdctId}', '${prdct.itemTy}', encodeURIComponent('${prdct.prdctName}'), '${prdct.prdctCnt}'
 																				,'${prdct.prc}', '${prdct.dscntPrcnt}', '${prdct.earnPrcnt}', '${prdct.asmbly}','${prdct.dlvry}', '0','0','0');
					 		//console.log('check Map:'+JSON.stringify(mapPrdct['${prdct.itemTy}${prdct.prdctId}']));
					 		//var arrNewPrdct = Array();
					 		//function CrtPrdct(prdctId, prdctTy, prdctName, prdctCnt, tradePrc, dscntPcnt, dscntPrc, isEarn, isAsm,isDlvr)
						</script>
						
					</tr>
					<%-- <tr>
						<td colspan="10">
							<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">					
						</td>
					</tr> --%>
					<script>
			    		//fncSum_init('${prdct.prc*prdct.prdctCnt}');
			    		//fncDscntSum_init('${prdct.prc*prdct.prdctCnt*((100-prdct.dscntPrcnt)/100)}');
			    		//fncDscntSum_init('${prdct.prc}','${prdct.prdctCnt}','${prdct.dscntPrcnt}');
			    		//fncPointSum_init('${prdct.prc*prdct.prdctCnt*((100-prdct.dscntPrcnt)/100)*(prdct.earnPrcnt/100)}');
			    		//fncPointSum_init('${prdct.prc}','${prdct.prdctCnt}','${prdct.dscntPrcnt}','${prdct.earnPrcnt}');
			    	</script>
				</c:forEach>

				<!-- @@ newPrdct. -->
				<c:forEach var="newPrdct" items="${newPrdctH}" varStatus="status" >
					<tr id='trN${newPrdct.itemTy}${newPrdct.prdctId}' class="listData trListPrdct" style="color: black" bgcolor="white">
						<td width="140px">
							<input style='text-align:center;width:100%;'
								class='inputPrdct'
								id='nameN${newPrdct.itemTy}${newPrdct.prdctId}' type='text'
								data-role="none"
								autocomplete="on"
								onkeyup="prdctNameChecker(this);"	
								value='${newPrdct.prdctName}' placeholder='제품명'/>
								<!-- onclick ="resetInputEye(this);" -->
						</td>

						<td>
							<select class = 'inputPrdctList' id='slctTyN${newPrdct.itemTy}${newPrdct.prdctId}'>
								<option value='0'>종류선택</option>
								<option value='1'>프레임</option>
								<option value='2'>렌즈</option>
								<option value='3'>콘텍트렌즈</option>
								<option value='4'>기타</option>
								<option value='5'>선글라스</option>
								<option value='6'>일회용렌즈</option>
							</select>
						</td>
						<td>
							<input style='width:30px;' id='cntN${newPrdct.itemTy}${newPrdct.prdctId}'
									class='inputPrdct'
									onclick ='resetInputEye(this);'
									onkeyup="setPriceInfo(this,'${newPrdct.itemTy}${newPrdct.prdctId}','N');"
									value='${newPrdct.prdctCnt}' />
						</td>
						<td>
							<input id='prcN${newPrdct.itemTy}${newPrdct.prdctId}'
									class='inputPrdct'
									onclick ="resetInputEye(this);"
									onkeyup="setPriceInfo(this,'${newPrdct.itemTy}${newPrdct.prdctId}','N');"
									style="width:70px; text-align: right;" />
						</td>
								
						<td style="text-align: center;">
							<input id="dscntPrcntN${newPrdct.itemTy}${newPrdct.prdctId}"
									onclick ="resetInputEye(this);"
									onkeyup="setPriceInfo(this,'${newPrdct.itemTy}${newPrdct.prdctId}','N');"
									class="prcnt_number2 inputPrdct" type="text" value='${newPrdct.dscntPrcnt}' size="100%" name="dscntPrcnt_number2"
									style='text-align : center;'
									onkeypress="if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;">
							</input>
						</td>
						
						<td style="text-align: right;">
							<input type='text'
									id="dscntPrcN${newPrdct.itemTy}${newPrdct.prdctId}"
									class='inputPrdct'
									onclick ="resetInputEye(this);"
									onkeyup="setPriceInfo(this,'${newPrdct.itemTy}${newPrdct.prdctId}','N');"
									style="width:70px; text-align: right;" disabled="disabled"/>
						</td>
						
						<td style="text-align: center;">
				        	<input id='earnN${newPrdct.itemTy}${newPrdct.prdctId}'
				        			class="earnChk"
				        			type="checkbox"
				        			name="earnChkBox" value="${newPrdct.itemTy}${newPrdct.prdctId}"
									onChange="changePointPrcnt();"/>
							<label for='earnN${newPrdct.itemTy}${newPrdct.prdctId}'></label>
						</td>
						<td style="text-align: center;">
				        	<input id='asmN${newPrdct.itemTy}${newPrdct.prdctId}'
				        			class="asmChk"
				        			type="checkbox"
				        			name="earnChkBox" value="${newPrdct.itemTy}${newPrdct.prdctId}"
									onChange="changePointPrcnt();"/>
							<label for='asmN${newPrdct.itemTy}${newPrdct.prdctId}'></label>
						</td>
						<td style="text-align: center;">
				        	<input id='dlvryN${newPrdct.itemTy}${newPrdct.prdctId}'
				        			class="dlvryChk"
				        			type="checkbox"
				        			name="earnChkBox" value="${newPrdct.itemTy}${newPrdct.prdctId}"
									onChange="changePointPrcnt();"/>
							<label for='dlvryN${newPrdct.itemTy}${newPrdct.prdctId}'></label>
						</td>
						<td>
							<a onclick="setDelNewPrdct('${newPrdct.itemTy}${newPrdct.prdctId}');return false;" href="#delPrdctJQM" data-rel="popup">
								<img src="<c:url value="/images/button/Select_c.png" />" width="15px;">
							</a>
						</td>
						<script>
							$("#slctTyN${newPrdct.itemTy}${newPrdct.prdctId}").val('${newPrdct.itemTy}');
							$('#dscntPrcN${newPrdct.itemTy}${newPrdct.prdctId}').val(addComma('${newPrdct.prc*newPrdct.prdctCnt*(100-newPrdct.dscntPrcnt)/100}'));
							$('#prcN${newPrdct.itemTy}${newPrdct.prdctId}').val(addComma('${newPrdct.prc}'));
							if('${newPrdct.earnPrcnt}'!=0){
								$('#earnN${newPrdct.itemTy}${newPrdct.prdctId}').prop('checked', true);	
							}else{
								$('#earnN${newPrdct.itemTy}${newPrdct.prdctId}').prop('checked', false);
							}
							$('#earnN${newPrdct.itemTy}${newPrdct.prdctId}').val('${newPrdct.earnPrcnt}');
							
							if('${newPrdct.asmbly}'!=0){
								$('#asmN${newPrdct.itemTy}${newPrdct.prdctId}').prop('checked', true);	
							}else{
								$('#asmN${newPrdct.itemTy}${newPrdct.prdctId}').prop('checked', false);
							}
							$('#asmN${newPrdct.itemTy}${newPrdct.prdctId}').val('${newPrdct.asmbly}');
							
							if('${newPrdct.dlvry}'!=0){
								$('#dlvryN${newPrdct.itemTy}${newPrdct.prdctId}').prop('checked', true);	
							}else{
								$('#dlvryN${newPrdct.itemTy}${newPrdct.prdctId}').prop('checked', false);
							}
							$('#dlvryN${newPrdct.itemTy}${newPrdct.prdctId}').val('${newPrdct.dlvry}');
							
				 			arrPrdctId.push('N${newPrdct.prdctId}');
					 		mapCnt['N${newPrdct.prdctId}'] = '${newPrdct.prdctCnt}';
					 		mapPrc['N${newPrdct.prdctId}'] = '${newPrdct.prc}';
					 		mapDscntPrcnt['N${newPrdct.prdctId}'] = ['${newPrdct.dscntPrcnt}'];
					 		mapEarnPrcnt['N${newPrdct.prdctId}'] = ['${newPrdct.earnPrcnt}'];
					 		mapPntUsingChk['N${newPrdct.prdctId}'] = ['${newPrdct.usingPoint}'];
							
					 		arrCrtPrdct.push(new ObjPrdct('${newPrdct.prdctId}', '${newPrdct.itemTy}', encodeURIComponent('${newPrdct.prdctName}'), '${newPrdct.prdctCnt}'
 									, '${newPrdct.prc}', '${newPrdct.dscntPrcnt}', '${newPrdct.earnPrcnt}', '${newPrdct.asmbly}','${newPrdct.dlvry}', '1','0','0'));
 							//console.log('arrCrtPrdct Size:'+arrCrtPrdct.length);
					 		//function CrtPrdct(prdctId, prdctTy, prdctName, prdctCnt, tradePrc, dscntPcnt, dscntPrc, isEarn, isAsm,isDlvr){
					 			
					 		arrInitNewId.push('N${newPrdct.itemTy}${newPrdct.prdctId}');
					 		/* arrInitInvnId.push('N${newPrdct.itemTy}${newPrdct.prdctId}'); */
					 		/* mapInvnPrdct['N${newPrdct.itemTy}${newPrdct.prdctId}'] = new ObjPrdct('${newPrdct.prdctId}', '${newPrdct.itemTy}', '${newPrdct.prdctName}', '${newPrdct.prdctCnt}' */
					 		mapNewPrdct['N${newPrdct.itemTy}${newPrdct.prdctId}'] = new ObjPrdct('${newPrdct.prdctId}', '${newPrdct.itemTy}', encodeURIComponent('${newPrdct.prdctName}'), '${newPrdct.prdctCnt}'
 																				,'${newPrdct.prc}', '${newPrdct.dscntPrcnt}', '${newPrdct.earnPrcnt}', '${newPrdct.asmbly}','${newPrdct.dlvry}', '1','0','0');
						</script>
					</tr>
					<%-- <tr>
						<td colspan="10">
							<img src="${ctxPath	}/images/black_dot_line.jpg " width="100%">					
						</td>
					</tr> --%>
					<script>
						setTotalPrc();
			    		//fncSum_init('${newPrdct.prc*newPrdct.prdctCnt}');
			    		//fncDscntSum_init('${newPrdct.prc*newPrdct.prdctCnt*((100-newPrdct.dscntPrcnt)/100)}');
			    		//fncDscntSum_init('${newPrdct.prc}','${newPrdct.prdctCnt}','${newPrdct.dscntPrcnt}');
			    		//fncPointSum_init('${newPrdct.prc*newPrdct.prdctCnt*((100-newPrdct.dscntPrcnt)/100)*(newPrdct.earnPrcnt/100)}');
			    		//fncPointSum_init('${newPrdct.prc}','${newPrdct.prdctCnt}','${newPrdct.dscntPrcnt}','${newPrdct.earnPrcnt}');
			    	</script>
				</c:forEach>
				<!-- End newPrdct -->			
			</form>
		</c:when>
		<c:otherwise>
			<tr>
				<!-- <td colspan="10" align="center">상품 데이터가 없습니다.</td> -->
			</tr>
		</c:otherwise>

	</c:choose>
	<%-- <tr>
		<td height="3" colspan="10"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr> --%>
	</table>

	<table id="listAddPrdct" class="cstmrHstrStaffList" border='1' width="100%" style="font-size: 13px;" >
		
	</table>
	<!-- <table class="cstmrHstrStaffList" border='1' width="100%" style="font-size: 13px;" > -->
	<table class="cstmrHstrStaffList" border='1' width="600px" style="font-size: 13px;" >
	<tr height='3'>
		<td height='3' width='20%'></td>
		<td height='3' width='10%'></td>
		<td height='3' width='10%'></td>
		<td height='3' width='10%'></td>
		<td height='3' width='10%'></td>
		<td height='3' width='10%'></td>
		<td height='3' width='5%'></td>
		<td height='3' width='5%'></td>
	</tr>
	<tr bgcolor="white" >
		
		<td  style="color : black;">가격합계</td>
		<td colspan ='2' >&nbsp;</td>
		<td style="color : black; text-align: right;" >할인 전:</td>
		<td style="color : black;"><p id="totalPrc" style="text-align: right;" ></p></td>
		<td style="color : black;  text-align: right;">할인 후:</td>
		<td colspan='2' style="color : black"><p id="totalDscntPrc" style="text-align: right;font-size:18px;font-weight:bolder; background-color: white; color: black" ></p></td>
		<!-- <td colspan='4'>&nbsp;</td> -->
	</tr>
	<%--
	<tr>
		<td height="3" colspan="8"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr>
	--%>

	<%-- <tr>
		<td colspan="8">
			<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">					
		</td>
	</tr> --%>
	<tr style="color: black" bgcolor="white">
		<td >기타할인</td>
		<td colspan='5'>
			<input type="text" id="etcDscntMemo_txt2"
			onclick ="resetInputEye(this);"
			name="etcDscntMemo_txt" value="" placeholder="1000원 이하 할인 등."
			size="255"/>
		</td>
		<td colspan='2' style="text-align: right">
			<input class="payment_number3" type="text" pattern="[0-9]*" id="etcDscnt_txt"
					onclick ="resetInputEye(this);"
					name="etcDscnt_txt"
					onkeypress="if (event.keyCode < 48|| event.keyCode>57)  event.returnValue=false;"
					onkeyup="setPaymentInfo();"
					placeholder="숫자만입력" size="15"/>
		</td>
	</tr>
	<%-- <tr>
		<td colspan="8">
			<img src="${ctxPath	}/images/black_dot_line.jpg" width="100%">					
		</td>
	</tr> --%>
	<%-- <tr>
		<td height="3" colspan="8">
			<img src="<c:url value="/images/content/Whiteline.jpg" />"
				alt="line" width="800" height="1" />
		</td>
	</tr> --%>

	<tr style="color: black" bgcolor="white">
		<td >결제
			<input type='button' onclick='addPayment(); return false;' value='추가'/>
			<%-- <a href='#' onclick='addPayment(); return false;'>
				<img src="<c:url value="/images/button/Select_p.png" />" width="15px;">
			</a> --%>
		</td>
		<td colspan='1'>현금</td>
		<td colspan='1'>카드</td>
		<td colspan='1'>포인트</td>
		<td colspan='1'>카드사</td>
		<td hidden >
			<select id='slct_card_com' name='slctCardCom' data-role='none'>
				<c:forEach items="${listCardCom}" var="card" varStatus="status">
					<option value="${card.cardComId}">${card.cardComName}</option>
					<script>
						arrCardComId.push('${card.cardComId}');
						arrCardComName.push('${card.cardComName}');
					</script>
				</c:forEach>
			</select>
		</td>
		<td  colspan='1' style="text-align: center">합계</td>
		<td  colspan='1' style="text-align: center">삭제</td>
		<td  colspan='1' style="text-align: center">환불</td>
	</tr>
	
 	<tr id='payStart'></tr>
	<tr>
		<td height="3" colspan="8"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="100%" height="1" />
		</td>
	</tr>

	<tr id='payEnd'></tr>
	<tr style="color: black" bgcolor="white">
		<td >결제금액</td>
		<td colspan='5'>&nbsp;</td>
		<td colspan='2' style="text-align: right;background-color: white; color: black" ><span id="remainedPayment_txt"></span></td>
		<script>
			g_remainedPayment = g_dscntTotal-prePayment-etcDscnt;
			document.getElementById("remainedPayment_txt").innerHTML = formatNumber(String((g_remainedPayment)));
		</script>
		
	</tr>
	<!-- <tr style="color: black" bgcolor="white" >
		<td colspan='8'>&nbsp;</td>
		<td style="text-align: right" ><span id="deposit" style="font-size: 11px;"></td>
	</tr> -->
	<%-- <tr>
		<td height="3" colspan="8">
			<img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" />
		</td>
	</tr> --%>
	<tr>
		<td colspan="8">
			<img src="${ctxPath	}/images/green_line.jpg" width="100%">					
		</td>
	</tr>
	<tr style="color: black" bgcolor="white">
		<td >잔액</td>
		<td colspan='5'>&nbsp;</td>
		<td colspan='2' style="text-align: right;" ><span id="penny_txt" style="font-size:18px; font-weight:bolder"></span></td>

		<script>
			//calcPrice();
		</script>
	</tr>
	<tr>
		<td colspan="8">
			<img src="${ctxPath	}/images/green_line.jpg" width="100%">					
		</td>
	</tr>
	<tr style="color: black" bgcolor="white">
		<td  >적립예정금</td>
		<td colspan="5" text-align = 'center'>구매 완료시 100 단위까지 일괄 적립</td>
		<td colspan='2' style="text-align: right;  color: black" >
			<span id="point_total_txt">
				<fmt:formatNumber value="" pattern="#,###" />
			</span>
		</td>
	</tr>
	<%-- <tr>
		<td height="3" colspan="8"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
			width="800" height="1" /></td>
	</tr> --%>
	<tr>
		<td colspan="8"> <img src="${ctxPath	}/images/green_line.jpg" width="100%"></td>
	</tr>	
		<td height="44" colspan="8">
		<center>
			<%-- <img src="<c:url value="/images/content/edit.png" />" onclick="dlgDateSelect();"  width="35px" height="35px" > --%>
			<div id='bottomBtn' data-role="controlgroup" data-type="horizontal">
				<a id='btmBtn1' href="javascript:newCstmrVisit();" data-mini="true" data-role="button">새로운처방</a>
				<a id='btmBtn2' href="javascript:saveSale();" data-mini="true" data-role="button">처방 저장</a>
				<a id='btmBtn3' href="javascript:if(confirm('저장되지 않은 내용은 사라집니다.')){getCheckInfo(saleId);}" data-mini="true" data-role="button">처방 복구</a>
				<a id='btmBtn4' href="javascript:delSaleId();" data-mini="true" data-role="button">삭제</a>	
				<a id='btmBtn5' href="javascript:goPrintDlg();" data-mini="true" data-role="button">프린트</a>
				<a id='btmBtn6' href="javascript:goTaxPrint();" data-mini="true" data-role="button">의료비납입증명서</a>
				<a id='btmBtn7' href="javascript:goPayment();" data-mini="true" data-role="button">강제 완료</a>
			</div>
		</center>
		</td>
	</tr>
	<script>
		//fncPointSum_init_final();
		//setPaymentInfo();
	</script>
</table>

<div id="dlgPartnerInfo" data-role="popup" class='noPrint'>
	<a href="#" data-rel="back" data-role="button" data-theme="a"
			data-icon="delete" data-iconpos="notext" class="ui-btn-right btn" class="btn"></a>
	<div id='dlgPartnerInfo_'>
	</div>
</div>
<!-- <div id="dlgPointHist" title="포인트 내역"></div> -->
<div id="dlgDateSelect" title="날짜 선택" class='noPrint'></div>

<div id="dlgInputTaxName" data-role="popup" class="popup noPrint">
	<a href="#" data-rel="back" data-role="button" data-theme="a"
			data-icon="delete" data-iconpos="notext" class="ui-btn-right btn" class="btn"></a>
	<div data-role="header" data-theme="a" class="ui-corner-top header">
				<h3>연말정산용 의료비 납입 증명서 발급</h3>
				<p id='txtTaxBigo'></p>
	</div>
	<table border='0.5'>
	<tr>
		<td>
			<label for='inputTaxName'>발급자명</label>
		</td>
		<td>
			<input id='inputTaxName' type='text' placeholder='발급자이름' data-mini="true" />
		</td>
	</tr>
	<tr>
		<td colspan='2'>
			<input type='button' onclick='printTax(); $("#dlgInputTaxName").popup("close");return false;' value='확인' data-mini="true" class="btn"/>
		</td>
		<!-- <td>
			<input type='button' onclick='$("#dlgInputTaxName").popup("close"); return false;'value='취소' data-mini="true" class="btn"/>
		</td> -->
	</tr>
	</table>
	
</div>

<div data-role="popup" id="popPartnerInfo" class="ui-content" data-theme="e" data-overlay-theme="a" style="overflow:scroll; height:400px; padding:10px;">
    <div id="partnerInfo"> </div>
</div>
<br>
