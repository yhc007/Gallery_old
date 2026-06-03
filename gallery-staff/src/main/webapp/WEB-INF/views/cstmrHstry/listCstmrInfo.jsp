<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/cstmrHstryLib.jsp"%>
<%@ page import="com.gallery.common.CommonCode"%>

<style>
	.c1{

	}

	#saveBigo{
		-webkit-appearance: none;
		width:48px;
		height:28px;
	}
	.blueTd{
   		background-color: #99ccff;
   		text-align:center;
   		font-weight : bolder;
   		font-size : 12px;
   	}
	.formWhiteTd{
		background-color :white;
	}
</style>
<script>
	var mPrdctId;
	var mTrdePrc;
	var g_fmlyCd='';
	var fmlyName='';
	var bfFmlyCd;

	//limit 20
	var g_bfCstmrName = '' ;
	//limit 80
	var g_bfCstmrAddr = '' ;
	//limit 15 (4/4/4)
	var g_bfCstmrTel = '' ;
	//limit 15 (4/4/4)
	var g_bfCstmrMobile = '' ;

	//no check.
	var g_bfCstmrBirthDay = '' ;
	//no check.
	var g_bfCstmrBirthTy = '' ;
	//255
	var g_bfCstmrBigo = '' ;
	var g_bfCstmrEmail = '' ;


	jQuery(document).ready(function() {
		//console.log("run listCstmrInfo");
		getBirthCoupon();
		getCstmrPoint();
		initCstmrInfo();

		$("#dlgEditFmly").popup();
		$("#popPointHstry").popup();
		$("#noCouponInfo").popup();
		$('#cstmrSearchJQM').popup();
		$('#cstmrCouponSearchJQM').popup();

		$(".navbar").navbar();
		$(".btn").button();

		$( "#dlgEditFmly" ).bind({
			   popupbeforeposition: function(event, ui) {
				   //console.log("open Popup!");
				   //jQuery('#crtFmlyName').text(fmlyName+":"+g_fmlyCd);
				   jQuery('#crtFmlyName').val(fmlyName+":"+g_fmlyCd);
			   }
		});

		getCstmrBigo();
	});

	function initCstmrInfo()
	{
		if("${cstmr.sexCd}"=="00400001"){
			$("#male").attr("checked",true);
		}else{
			$("#female").attr("checked",true);
		}
		var noInfo='정보가 없습니다.';
		jQuery('#cstmrCd').text('${cstmr.cstmrCd}');
		var oldCstmrCd = '${cstmr.oldCstmrCd}';
		if(oldCstmrCd){
			$('#oldCstmrCd').text('(${cstmr.oldCstmrCd})');
		}else{
			$("#oldCstmrCd").css("display", "none");
		}
		$('#cstmrRegShop').text('${cstmr.strRegShop}');
		//console.log('cstmrName:'+'${cstmr.cstmrName}');
		if('${cstmr.cstmrName}'==''){
			//console.log('step1');
			//jQuery('#cstmrName').text(noInfo);
			jQuery('#cstmrName').val(noInfo);
		}else{
			//console.log('step2');
			//jQuery('#cstmrName').text('${cstmr.cstmrName}');
			g_bfCstmrName = '${cstmrVo.cstmrName}' ;
			jQuery("#cstmrForm input[id='cstmrName']").val('${cstmrVo.cstmrName}');
		}
		if('${cstmr.addr}'==''){
			//jQuery('#cstmrAddr').text(noInfo);
			//jQuery('#cstmrAddr').val(noInfo);
		}else{
			g_bfCstmrAddr = '${cstmr.addr}' ;
			//jQuery('#cstmrAddr').text('${cstmr.addr}');
			jQuery('#cstmrAddr').val('${cstmr.addr}');
		}
		if('${cstmr.telephone}'==''){
			//jQuery('#cstmrPhone').text(noInfo);
			//jQuery('#cstmrPhone').val(noInfo);
		}else{
			g_bfCstmrTel = '${cstmr.telephone}' ;
			var cstmrTel = '${cstmr.telephone}';
			setTelnum(cstmrTel,"tels","tel[]");
		}

		if('${cstmr.cellphone}'==''){
			//jQuery('#cstmrCell').text(noInfo);
			//jQuery('#cstmrCell').val(noInfo);
		}else{
			var cstmrCell = '${cstmr.cellphone}';
			g_bfCstmrMobile = '${cstmr.cellphone}' ;
			//jQuery('#cstmrCell').text('${cstmr.cellphone}');
			jQuery('#cstmrCell').val('${cstmr.cellphone}');
			setTelnum(cstmrCell,"mobiles","mobile[]");
		}
		if('${cstmr.birthDay}'==''){
			//jQuery('#cstmrBirth').text(noInfo);
			//jQuery('#cstmrBirth').val(noInfo);
		}else{
			g_bfCstmrBirthDay = '${cstmr.birthDay}' ;
			g_bfCstmrBirthTy = '${cstmr.birthDayTyCd}' ;
			var birthType = '${cstmr.birthDayTyCd}';
			var birthDay = '${cstmr.birthDay}';

			if(birthDay.indexOf('.') > -1){
				var tmp = birthDay.split('.');
				var year = tmp[0];
				var month = tmp[1];
				var date = tmp[2];
				$( "#slctBirthDayTyCd" ).find( 'option[value="' + birthType + '"]' ).prop( "selected", true );
				$( "#slctByear" ).find( 'option[value="' + year + '"]' ).prop( "selected", true );
				$( "#slctBmonth" ).find( 'option[value="' + month + '"]' ).prop( "selected", true );
				$( "#slctBday" ).find( 'option[value="' + date + '"]' ).prop( "selected", true );
			}else{
				var tmpVal = getNumberOnly(birthDay);
				console.log('tmpVal.length:'+tmpVal.length);
				tmpSize = tmpVal.length;

				var tmpArrVal = new Array();

				tmpArrVal[0] = tmpVal.substring(tmpSize-4,tmpSize-8);
				tmpArrVal[1] = tmpVal.substring(tmpSize-2,tmpSize-4);
				tmpArrVal[2] = tmpVal.substring(tmpSize,tmpSize-2);

// 				console.log('tmpArrVal[0]:'+tmpArrVal[0]);
// 				console.log('tmpArrVal[1]:'+tmpArrVal[1]);
// 				console.log('tmpArrVal[2]:'+tmpArrVal[2]);

				$( "#slctBirthDayTyCd" ).find( 'option[value="' + birthType + '"]' ).prop( "selected", true );
				$( "#slctByear" ).find( 'option[value="' + tmpArrVal[0] + '"]' ).prop( "selected", true );
				$( "#slctBmonth" ).find( 'option[value="' + tmpArrVal[1] + '"]' ).prop( "selected", true );
				$( "#slctBday" ).find( 'option[value="' + tmpArrVal[2] + '"]' ).prop( "selected", true );
			}

		}

		if('${cstmr.email}'==''){
			//jQuery('#cstmrEmail').text(noInfo);
			//jQuery('#cstmrEmail').val(noInfo);
		}else{
			//jQuery('#cstmrEmail').text('${cstmr.email}');
			g_bfCstmrEmail = '${cstmr.email}' ;
			jQuery('#cstmrEmail').val('${cstmr.email}');
		}
		if('${cstmr.getSmsYn}'=='Y'){
			jQuery('#getSms').prop('checked', true);
		}else{
			jQuery('#getSms').prop('checked', false);
		}
		if('${cstmr.getEmailYn}'=='Y'){
			jQuery('#getEmail').prop('checked', true);
		}else{
			jQuery('#getEmail').prop('checked', false);
		}
		if('${cstmr.getDmYn}'=='Y'){
			jQuery('#getDm').prop('checked', true);
		}else{
			jQuery('#getDm').prop('checked', false);
		}

// 		if('${cstmr.bigo}'==''){

// 		}else{
// 			//g_bfCstmrBigo = '${cstmr.bigo}';
// 			//jQuery('#cstmrBigo').val(decodeURIComponent('${cstmr.bigo}'));
// 			//console.log('bigo:'+decodeURIComponent(g_bfCstmrBigo));
// 			//jQuery('#cstmrBigo').val(decodeURIComponent(g_bfCstmrBigo));
// 			//document.getElementById("cstmrBigo").value = decodeURIComponent('${cstmr.bigo}');
// 		}
	}

	function fncSaveEdit() {
		var checkStaffId = document.getElementById('staffId').innerHTML;
		if (checkStaffId != '${staffVoH.staffId}') {
			alert("다른 스태프의 작업을 수정할 수 없습니다.");
			return;
		}

		if (writable == false) {
			alert('<spring:message code="warn.check.writable"/>');
			return;
		}
		var url = 'updateVisitAction.do';

		param = jQuery('#checkForm').serialize();

		//alert(param);

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
					writable = false;
				} else if (data == "fail") {
					alert('<spring:message code="fail"/>');
				}
			}
		});
	}



	function cstmrInfoUpdate(){
		var isChange = false;
		var name = $("#cstmrName").val();
		var addr = $("#cstmrAddr").val();
		var tel1 = $("#tel1").val();
		var tel2 = $("#tel2").val();
		var tel3 = $("#tel3").val();
		var email = $("#cstmrEmail").val();
		var mobile1 = $("#mobile1").val();
		var mobile2 = $("#mobile2").val();
		var mobile3 = $("#mobile3").val();
		var birthTy  = $('select[name="slctBirthDayTyCd"]').val();
		var birthYear = $('select[name="slctByear"]').val();
		var birthMonth = $('select[name="slctBmonth"]').val();
		var birthDay = $('select[name="slctBday"]').val();
		//console.log("bigo: 217Line");
		var bigo = encodeURIComponent($("#cstmrBigo").val());

		//limit 20
		if(name != g_bfCstmrName){
			isChange = true;
			if(name.length > 20){
				alert('이름은 20자 내로 가능합니다.');
				return;
			}
		}
		//limit 80
		if(addr != g_bfCstmrAddr){
			isChange = true;
			if(name.length > 80){
				alert('주소는 20자 내로 가능합니다.');
				return;
			}
		}


		//limit 15 (4/4/4)
		var telephone = tel1+'-'+tel2+'-'+tel3
		if(telephone != g_bfCstmrTel){
			isChange = true;
			if(tel1.length>4){
				alert('전화번호 각 칸당 4글자 이내로 가능합니다.');
				return;
			}
			if(tel2.length>4){
				alert('전화번호 각 칸당 4글자 이내로 가능합니다.');
				return;
			}
			if(tel3.length>4){
				alert('전화번호 각 칸당 4글자 이내로 가능합니다.');
				return;
			}
			if(telephone=='--')
			{
				telephone='';
			}
		}
		//limit 15 (4/4/4)
		var cellphone = mobile1+'-'+mobile2+'-'+mobile3;
		if(cellphone != g_bfCstmrMobile){

			isChange = true;
			if(mobile1.length>4){
				alert('휴대폰 각 칸당 4글자 이내로 가능합니다.');
				return;
			}
			if(mobile2.length>4){
				alert('휴대폰 각 칸당 4글자 이내로 가능합니다.');
				return;
			}
			if(mobile3.length>4){
				alert('휴대폰 각 칸당 4글자 이내로 가능합니다.');
				return;
			}
			if(cellphone=='--')
			{
				cellphone='';
			}
		}

		//limit 80
		if(email != g_bfCstmrEmail){
			isChange = true;
			if(email.length > 80){
				alert('이메일은 80글자 이내로 가능합니다. 현재 '+email.length+'글자');
				return;
			}
		}
		var cstmrBirth = birthYear+'.'+birthMonth+'.'+birthDay;
		if( cstmrBirth != g_bfCstmrBirthDay){
			isChange = true;
		}
		if( birthTy != g_bfCstmrBirthTy){
			isChange = true;
		}

		//255
		//console.log("bigo: 299Line");
		if( bigo != g_bfCstmrBigo){
			isChange = true;
			if(bigo.length > 255){
				alert('비고는 255자 이내로 가능합니다. 현재 '+bigo.length+'글자');
				return;
			}
		}

		//console.log('isChange:'+isChange);
		if(!isChange){
			alert('변경사항이 없습니다.');
			return;
		}

		var url = '${ctxPath}/cstmr/editCstmrInfo.do';

		//bigo = encodeURIComponent(bigo);
		//javax
		//console.log("bigo: 318Line");
		 $.ajax({
			url		: url,
			type 	: "post",
			data : "bigo=" + bigo + "&cstmrName=" + name + "&addr=" + addr + "&email=" + email
					+ "&telephone=" + telephone+ "&cellphone=" + cellphone
					+ "&birthDay=" + cstmrBirth + "&birthDayTyCd=" + birthTy
					+"&cstmrId=" + '${cstmrVo.cstmrId}',
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				alert('저장 완료');
			}
		});
	}

	var infoType;
	function fncSetData()
	{
		//console.log('run fncSetData');
		var editVal = $("#editVal").val();
		//var editVal2='';

		//console.log("editVal : "+editVal);
		//console.log('infoType:'+infoType);
		//console.log('common.name:'+"<%=CommonCode.CSTMR_NAME%>");

		var validationLength=250;
		if(infoType == 'cstmrName' || infoType==0){
			//console.log('case cstmrName');
			validationLength = 20;
			infoType=<%=CommonCode.CSTMR_NAME%>;
		}else if(infoType =='cstmrAddr' || infoType==1 ){
			//console.log('case cstmrAddr');
			validationLength = 80;
			infoType=<%=CommonCode.CSTMR_ADDR%>;
		}else if(infoType=='telephone' || infoType==2 ){
			//console.log('case telephone');
			validationLength = 15;
			var editVal1=$("#editVal1").val();
			var editVal2=$("#editVal2").val();
			var editVal3=$("#editVal3").val();
			//console.log('length1:'+editVal1.length);
			//console.log('length3:'+editVal2.length);
			//console.log('length3:'+editVal3.length);
			if( editVal1.length<1 || editVal2.length<1 || editVal3.length<1){
				alert('빈칸이 있습니다.');
				return
			}else if( editVal1.length>4 || editVal2.length>4 || editVal3.length>4){
				alert('칸 마다 5자 이하로 입력 가능합니다.');
				return;
			}

			editVal = editVal1+'-'+editVal2+'-'+editVal3;

			infoType=<%=CommonCode.CSTMR_TELEPHONE%>;
		}else if(infoType=='cellphone' || infoType==3){
			//console.log('case cellphone');
			validationLength = 15;
			var editVal1=$("#editVal1").val();
			var editVal2=$("#editVal2").val();
			var editVal3=$("#editVal3").val();
			//console.log('length1:'+editVal1.length);
			//console.log('length3:'+editVal2.length);
			//console.log('length3:'+editVal3.length);
			if( editVal1.length<1 || editVal2.length<1 || editVal3.length<1){
				alert('빈칸이 있습니다.');
				return
			}else if( editVal1.length>4 || editVal2.length>4 || editVal3.length>4){
				alert('칸 마다 5자 이하로 입력 가능합니다.');
				return;
			}

			editVal = editVal1+'-'+editVal2+'-'+editVal3;

			infoType=<%=CommonCode.CSTMR_CELLPHONE%>;
		}else if(infoType=='email' || infoType==4 ){
			//console.log('case email');
			validationLength = 80;
			infoType=<%=CommonCode.CSTMR_EMAIL%>;
		}else if(infoType=='birth' || infoType==5 ){
			//console.log('in birth case.');
			validationLength = 15;
			infoType=<%=CommonCode.CSTMR_BIRTH%>;
			var slctBirthDayThCd = $('select[name="slctBirthDayTyCd"]').val();
			var slctByear = $('select[name="slctByear"]').val();
			var slctBmonth = $('select[name="slctBmonth"]').val();
			var slctBday = $('select[name="slctBday"]').val();
			editVal=slctByear+'.'+slctBmonth+'.'+slctBday;
			editVal2=slctBirthDayThCd;
			//console.log('editVal:'+editVal);
			//console.log('editVal2:'+editVal2);

		}else{
			alert('unknown case error!');
		}

		if(editVal.length>validationLength){
			alert(validationLength+'자 내로 저장 가능합니다.');
			return;
		}else if(editVal == bfInfo){
			alert('수정할 내용이 없습니다.');
			return;
		}

		//return;

		var url = '${ctxPath}/cstmr/editCstmrInfo.do';
		editVal = encodeURIComponent(editVal);
		//console.log('infoType:'+infoType);
		//console.log('edidtVal:'+editVal);

		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data : "infoType=" + infoType + "&editVal=" + editVal+"&cstmrId=" + '${cstmrVo.cstmrId}'+'&editVal2='+editVal2,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				if(data=='success'){
					alert('저장완료');

					editVal = decodeURIComponent(editVal);
					//console.log('editVal1:'+editVal);
					if(editVal==''){
						editVal='정보가 없습니다.';
					}
					//console.log('editVal2:'+editVal);
					switch(infoType){
					case <%=CommonCode.CSTMR_NAME%>:
						jQuery('#cstmrName').text(editVal);
						jQuery('#dlgEditCstmrInfo').dialog( 'destroy' );
						break;
					case <%=CommonCode.CSTMR_ADDR%>:
						jQuery('#cstmrAddr').text(editVal);
						jQuery('#dlgEditCstmrInfo').dialog( 'destroy' );
						break;
					case <%=CommonCode.CSTMR_TELEPHONE%>:
						jQuery('#cstmrPhone').text(editVal);
						jQuery('#dlgEditCstmrPhoneInfo').dialog( 'destroy' );
						break;
					case <%=CommonCode.CSTMR_CELLPHONE%>:
						jQuery('#cstmrCell').text(editVal);
						jQuery('#dlgEditCstmrPhoneInfo').dialog( 'destroy' );
						break;
					case <%=CommonCode.CSTMR_EMAIL%>:
						jQuery('#cstmrEmail').text(editVal);
						jQuery('#dlgEditCstmrInfo').dialog( 'destroy' );
						break;
					case <%=CommonCode.CSTMR_BIRTH%>:
						jQuery('#cstmrBirth').text(editVal);
						if(editVal2=='00600002'){
							jQuery('#cstmrBirthTy').text('(-)');
						}else {
							jQuery('#cstmrBirthTy').text('(+)');
						}
						jQuery('#dlgEditCstmrBirthInfo').dialog( 'destroy' );

						break;

					}

				}else{
					alert('저장 실패. 반복될 경우 관리자에게 연락 바랍니다.');
				}
			}
		});
	}

	function dlgEditCstmrInfo(obj){
		jQuery('#cstmrCd').text('${cstmr.cstmrCd}');

		jQuery('#dlgEditCstmrInfo').dialog({
		title: "고객 정보 수정"
		 , modal: false
		 , width: 'auto' // 가로 크기
		 , height : 'auto'
		 , background: "#000"

		 , close: function(event, ui){
			//console.log("in close . editCstmrInfo");

			var txtPhone="\
				<input id='editVal' type='text' \
				style='height: 30px; width: 100%; font-size: 15px' >";
			jQuery('#tdEdit').html(txtPhone);

		 }
		 , open: function(){
			bfInfo = $(obj).text();
			infoType = $(obj).attr('name');
			jQuery('#crtVal').text( bfInfo );
			//console.log('infoType:'+infoType);
		}
		, success:  function(data) {
		//console.log($("#prdctCnt").val())

		}

		});
	}
	function dlgEditCstmrBirthInfo(obj){
		//jQuery('#cstmrCd').text('${cstmr.cstmrCd}');
		jQuery('#dlgEditCstmrBirthInfo').dialog({
		title: "고객 정보 수정"
		 , modal: true
		 , width: 'auto' // 가로 크기
		 , height : 'auto'
		 , background: "#000"

		 , close: function(event, ui){
			//console.log("in close . editCstmrInfo");
		 }
		 , open: function(){
			bfInfo = $(obj).text();
			infoType = $(obj).attr('name');
			jQuery('#crtBirth').text( bfInfo );
			//console.log('infoType:'+infoType);
			}
		});
	}
	function dlgEditCstmrPhoneInfo(obj){
		//jQuery('#cstmrCd').text('${cstmr.cstmrCd}');
		jQuery('#dlgEditCstmrPhoneInfo').dialog({
		title: "고객 정보 수정"
		 , modal: true
		 , width: 'auto' // 가로 크기
		 , height : 'auto'
		 , background: "#000"

		 , close: function(event, ui){
		 }
		 , open: function(){
			bfInfo = $(obj).text();
			infoType = $(obj).attr('name');
			jQuery('#crtPhone').text( bfInfo );
			//console.log('infoType:'+infoType);
			}
		});
	}


	function getBirthCoupon() {
		var url = '${ctxPath}/coupon/getBirthCoupon.do';
		//var url = 'getCheckData.do';
		//console.log('run getBirthCoupon');
		//console.log('cstmrCd:'+'${cstmrVo.cstmrCd}');

		//javax
		$.ajax({
			url : url,
			type : "post",
			data : "cstmrCd=" + '${cstmrVo.cstmrCd}',
			dataType : "json",
			beforeSend : function() {
			},
			success : function(data) {
				var shopNum = data.shopNum;
				g_couponCd = data.couponCd;
				g_couponShop = shopNum;
				g_couponDate = data.usingDate;
				if(data.couponCd == "NOEXIST"){
					document.getElementById("cstmrBirthCoupon").innerHTML = "-쿠폰없음-";
				}else if(shopNum==0){
					document.getElementById("cstmrBirthCoupon").innerHTML = "-사용가능-"+data.couponCd;
				}else{
					document.getElementById("cstmrBirthCoupon").innerHTML = "-사용된쿠폰-</br>"+data.couponCd+":"+data.usingDate;
				}
			}
		});

	}

	function dlgEditFmly(){
		//console.log('run dlgEditFmly()');

		/* $("#dlgEditFmly").popup( "open", {transition: "slide"}); */

		/* jQuery('#dlgEditFmly').dialog({
		title: "가족코드 변경"
		 , modal: true
		 , width: 'auto' // 가로 크기
		 , height : 'auto'
		 , background: "#000"
		 , close: function(event, ui){
		 }
		 , open: function(){
			bfFmlyCd = g_fmlyCd;
			jQuery('#crtFmlyName').text(fmlyName+":"+g_fmlyCd);
			//console.log('infoType:'+infoType);
			}
		}); */

	}
	function fncCloseFmlyCd()
	{
		$("#dlgEditFmly").popup( "close");
	}

	function fncSetFmlyCd(inputCd){

		if(confirm("고객 포인트가 있을경우 가족으로 통합되며 한번 합쳐진 포인트는 자동으로 되돌릴 수 없습니다. 계속 하시겠습니까?")==false){
			return;
		}

		var editFmlyCd;
		if(!inputCd){
			editFmlyCd = $("#editFmlyCd").val();
		}else{
			editFmlyCd = inputCd;
		}
		var tmpCstmrCd = '${cstmrVo.cstmrCd}';
		var tmpFmlyCd = '${cstmrVo.fmlyCd}';

		var validationLength=30;
		editFmlyCd = editFmlyCd.replace('-','000000');

		if(editFmlyCd.length>validationLength){
			alert(validationLength+'자 내로 저장 가능합니다.');
			return;
		}else if(editFmlyCd == bfFmlyCd){
			alert('수정할 내용이 없습니다.');
			return;
		}
		var url = '${ctxPath}/cstmr/editCstmrInfoType.do';

		//define commonCode
		var infoType = <%=CommonCode.CSTMR_FMLYCD%>;

		 $.ajax({
			url		: url,
			type 	: "post",
			data : "infoType=" + infoType
					+ "&editVal=" + editFmlyCd
					+ "&cstmrId=" + '${cstmrVo.cstmrId}'
					+ "&bfFmlyCd=" + bfFmlyCd
					+ "&afFmlyCd=" + editFmlyCd
					+ "&cstmrCd=" + tmpCstmrCd
			,dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){

				if(data=='success'){
					//alert('저장완료');
					g_fmlyCd = editFmlyCd;
					getCstmrPoint();
					getFmlyCd(g_fmlyCd);
					$('#cstmrSearchJQM').popup('close');
				}else{
					alert('저장 실패. 반복될 경우 관리자에게 연락 바랍니다.');
					$('#cstmrSearchJQM').popup('close');
				}
			}
		});
	}

	function fncGetPointHistory()
	{
		jQuery.ajax({
			url: '${ctxPath}/point/listPointHist.do'
			, type: "POST"
			, data 	: "fmlyCd="+g_fmlyCd

			, dataType: "html"
			, success:  function(data) {
				jQuery('#cstmrPointHist').html(data);
				$("#popPointHstry").popup( "open",{transition: "pop"});
			}
		});
	}

	function getCstmrPoint(){
		//console.log("run getCstmrPoint");
		var url = '${ctxPath}/point/getCstmrPoint.do';
		//console.log('fmlyCd1:' + g_fmlyCd);

		if(g_fmlyCd=='')
		{
			g_fmlyCd = '${cstmrVo.fmlyCd}';
		}

		$.ajax({
			url		: url,
			type 	: "post",
			data : "cstmrCd=" + '${cstmrVo.cstmrCd}'+"&fmlyCd="+g_fmlyCd,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				//console.log("success getCstmrPoint");
				var rtnData = decodeURIComponent(data);
				var pointParser = rtnData.split(',');
				pointValue = pointParser[0];
				g_fmlyCd = pointParser[1];
				fmlyName = pointParser[2];

				//document.getElementById("total_point_txt").innerHTML = format2(pointValue);
				//document.getElementById("fmly_name_txt").innerHTML = fmlyName;

				document.getElementById("total_point_txt1").innerHTML = format2(pointValue);
				document.getElementById("fmly_name_txt1").innerHTML = fmlyName;
				document.getElementById("fmly_cd_txt1").innerHTML = g_fmlyCd;

				//document.getElementById("total_point_txt2").innerHTML = pointValue;
				//document.getElementById("fmly_name_txt2").innerHTML = fmlyName;
				return;
			}
		});
	}
	function setTelnum(fullNum, formId, nameArray){
		if(fullNum.indexOf("-") > -1){
	 		var parseArray = fullNum.split('-');
	 		var telForm = document.getElementById(formId);
	 		var tels = telForm.elements[nameArray];
	 		var j = parseArray.length;
	 		for(var i = 0;i<parseArray.length;i++){
	 			parseArray[i] = parseArray[i];
	 			if(!isNaN(parseArray[i])){
	 				tels[i+3-j].value = parseArray[i];
	 			}
	 		}
		}else{
			var tmpVal = getNumberOnly(fullNum);
			//console.log('tmpVal.length:'+tmpVal.length);
			tmpSize = tmpVal.length;

			var tmpArrVal = new Array();

			tmpArrVal[0] = tmpVal.substring(tmpSize-8,tmpSize-11);
			tmpArrVal[1] = tmpVal.substring(tmpSize-4,tmpSize-8);
			tmpArrVal[2] = tmpVal.substring(tmpSize,tmpSize-4);

// 			console.log('tmpArrVal[0]:'+tmpArrVal[0]);
// 			console.log('tmpArrVal[1]:'+tmpArrVal[1]);
// 			console.log('tmpArrVal[2]:'+tmpArrVal[2]);

			var telForm = document.getElementById(formId);
			var tels = telForm.elements[nameArray];

			tels[0].value = tmpArrVal[0];
			tels[1].value = tmpArrVal[1];
			tels[2].value = tmpArrVal[2];
		}


	}
	function getNumberOnly(getVal)
	{
	    var val = getVal;
	    val = new String(val);
	    var regex = /[^0-9]/g;
	    val = val.replace(regex, '');

	    return val;
	}


	function modifyCstmrInfo(){
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
		if(regExp.test($("#cstmrForm input[id='cstmrName']").val())){
			alert("이름에는 특수문자를 사용할 수 없습니다.")
			return;
		}
		var cstmrName = $("#cstmrForm input[id='cstmrName']").val().replace(regExp, "");
		var telephone = $("#tels input[id='tel1']").val() + "-" + $("#tels input[id='tel2']").val() + "-" + $("#tels input[id='tel3']").val();
		var cellphone = $("#mobile1").val() + "-" + $("#mobile2").val() + "-" + $("#mobile3").val();
		var cellphone1 = $("#mobile1").val();
		var cellphone2 = $("#mobile2").val();
		var cellphone3 = $("#mobile3").val();
		var email = $("#cstmrEmail").val();
		var birthDay = $("#slctByear").val() + "." + $("#slctBmonth").val() + "." + $("#slctBday").val();
		var birthDayTyCd = $("#slctBirthDayTyCd").val();
		var addr = $("#cstmrAddr").val();
		var cstmrId = $("#cstmrId").val();
		var sexCd = $('input:radio[name="sexCd_"]:checked').val();
		//console.log("bigo: 756Line");
		var bigo = encodeURIComponent($("#cstmrBigo").val());
		var getSms;
		var getEmail;
		//var getCoupon;
		var getDm;
		//console.log('smsChecked:'+$('#getSms').prop('checked'));
		//console.log('emailChecked:'+$('#getEmail').prop('checked'));
		//console.log('couponChecked:'+$('#getCoupon').prop('checked'));
		if($('#getSms').prop('checked')){
			getSms='Y';
			if(cellphone1=='' || cellphone2=='' ||cellphone3==''){
				alert('휴대전화 번호가 정확하지 않아 수신 할 수 없습니다.');
				getSms='N';
				$('#getSms').prop('checked',false);
			}
		}else{
			getSms='N';
		}
		if($('#getEmail').prop('checked')){
			getEmail = 'Y';
			if(email==''){
				alert('메일주소가 정확하지 않아 수신 할 수 없습니다.');
				getEmail='N';
				$('#getEmail').prop('checked',false);
			}
		}else{
			getEmail = 'N';
		}
		/* if($('#getCoupon').prop('checked')){
			getCoupon ='Y';
		}else{
			getCoupon ='N';
		} */
		if($('#getDm').prop('checked')){
			getDm ='Y';
			if(addr==''){
				alert('주소가 정확하지 않아 수신 할 수 없습니다.');
				getDm='N';
				$('#getDm').prop('checked',false);
			}
		}else{
			getDm ='N';
		}

		var param = "cstmrName=" +  cstmrName +
					"&telephone=" + telephone +
					"&cellphone=" + cellphone +
					"&email=" + email +
					"&birthDay=" + birthDay +
					"&birthDayTyCd=" + birthDayTyCd +
					"&addr=" + addr +
					"&cstmrId=" + cstmrId +
					"&sexCd=" + sexCd +
					"&bigo=" + bigo +
					"&getSmsYn=" + getSms +
					"&getEmailYn=" + getEmail +
					/* "&getCouponYn=" + getCoupon */
					"&getDmYn=" + getDm
					;
		var url = "${ctxPath}/cstmr/modifyCstmrInfo.do";

		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				alert("변경되었습니다");
			}
		});
	}

	function getCstmrChart(){
		var cstmrId = $("#fmlyList").val();
		loadCstmrChart(cstmrId);
	}
	function setFmlyCdJQM(){
		$('#cstmrSearchJQM').popup('open');
		if(!g_fmlyCd){
			g_fmlyCd='없음';
		}
		$('#editFmlyCd').val('');
		$('#csName').val('');
		$('#cs4Digit').val('');
		$('#listFmlyCdDiv').html('');

		$('#crtFmlyCd').text('현재:'+g_fmlyCd);

		if(fmlyItem=='searchFmly'){
			$('#navSearchFmly').css("display","inline");
			$('#navInputFmly').css("display","none");
			$('#tbFmlyCd').css("display","inline");
		}else if(fmlyItem=='inputFmly'){
			$('#navSearchFmly').css("display","none");
			$('#navInputFmly').css("display","inline");
			$('#tbFmlyCd').css("display","none");
		}
	}

	function closeCstmrSearchJQM(){

		/* $('#navSearchFmly').css("display","inline");
		$('#navInputFmly').css("display","none"); */
		$('#cstmrSearchJQM').popup('close');
	}

	var fmlyItem = 'searchFmly';
	function slctNavCstmr(item){
		//console.log('item:'+item);

		if(item=='searchFmly'){
			fmlyItem = item;
			$('#navSearchFmly').css("display","inline");
			$('#navInputFmly').css("display","none");
			$('#tbFmlyCd').css("display","inline");
		}else if(item=='inputFmly'){
			fmlyItem = item;
			$('#navSearchFmly').css("display","none");
			$('#navInputFmly').css("display","inline");
			$('#tbFmlyCd').css("display","none");
		}
	}
	function fmlySearch(){
		var url = '${ctxPath}/cstmrHstry/getListFmly.do';
		var csName = $('#csName').val();
		var cs4Digit = $('#cs4Digit').val();
		if(!csName || !cs4Digit){
			alert('검색어가 누락되었습니다.');
			return;
		}
		var param = 'cstmrName='+csName+'&digit4='+cs4Digit;

		$.ajax({
			url : url,
			type : "post",
			data : param,
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				$('#listFmlyCdDiv').html('');
				$('#listFmlyCdDiv').html(data);
			}
		});
	}


	var couponItem = 'searchCoupon';

	function setCouponCdJQM(){
		//console.log('run setCouponCdJQM');
		$('#cstmrCouponSearchJQM').popup('open');
		if(couponItem=='searchCoupon'){
			$('#navSearchCoupon').css("display","inline");
			$('#navInputCoupon').css("display","none");
			$('#tbCouponCd').css("display","inline");
		}else if(couponItem=='inputCoupon'){
			$('#navInputCoupon').css("display","inline");
			$('#navSearchCoupon').css("display","none");
			$('#tbCouponCd').css("display","none");
		}
	}

	function closeCstmrCouponSearchJQM(){

		$('#cstmrCouponSearchJQM').popup('close');
	}

	function slctNavCoupon(item){
		//console.log('item:'+item);

		if(item=='searchCoupon'){
			couponItem = item;
			$('#navSearchCoupon').css("display","inline");
			$('#navInputCoupon').css("display","none");
			$('#tbCouponCd').css("display","inline");
		}else if(item=='inputCoupon'){
			couponItem = item;
			$('#navInputCoupon').css("display","inline");
			$('#navSearchCoupon').css("display","none");
			$('#tbCouponCd').css("display","none");
		}
	}


	function initCouponSearch(){
		$('#cpName').val('');
		$('#cp4Digit').val('');
		$('#cpCd').val('');
	}
	function couponSearch(){
		var url = '${ctxPath}/cstmrHstry/getListCoupon.do';
		var cpName = $('#cpName').val();
		var cp4Digit = $('#cp4Digit').val();
		var cpCd = $('#cpCd').val();
		cpCd = cpCd.replace('-','000000');
		if((!cpName || !cp4Digit) && !cpCd){
			alert('검색어가 누락되었습니다.');
			return;
		}

		var param = 'cstmrName='+cpName+'&digit4='+cp4Digit+'&cstmrCd='+cpCd;

		$.ajax({
			url : url,
			type : "post",
			data : param,
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				$('#listCouponCdDiv').html('');
				$('#listCouponCdDiv').html(data);
			}
		});
	}


	function checkBirth(inputCd) {
		//console.log('run checkBirth:inputCd='+inputCd);
		/* var couponCd = $('#birthCoupon').val(); */
		//inputCd = $('#inputBirthCd').val();

		var cpCd;
		if(!inputCd){
			//console.log('check inputCd='+inputCd);
			cpCd = $('#birthCoupon').val();
			//console.log('!inputCd case:'+cpCd);
		}else{
			cpCd = inputCd;
		}
		if(cpCd==jsonSale.cancelCoupon){
			alert('방금 해제한 쿠폰입니다. 처방 저장 후 다시 사용 바랍니다.');
			return;
		}
		// 	console.log('couponCd:'+couponCd);
		var url = "${ctxPath}/coupon/checkValidationBirthCoupon.do";
		var param = "couponCd=" + cpCd;
		$.ajax({
			url : url,
			data : param,
			dataType : "json",
			type : "post",
			success : function(data) {
// 				console.log('data:'+data);
// 				console.log('couponCd:'+data.couponCd);
// 				console.log('cstmrName:'+data.cstmrName);
// 				console.log('cstmrCd:'+data.cstmrCd);
// 				console.log('cstmrMail:'+data.couponMail);
// 				console.log('shopNum:'+data.shopNum);
// 				console.log('usingDate:'+data.usingDate);
// 				console.log('wMemo:'+data.wMemo);
				g_couponCd = data.couponCd;
				g_couponShop = data.shopNum;
				g_couponDate = data.usingDate;
				if (data.couponCd == "NOEXIST") {
					//$("#birthCoupon").val("-쿠폰없음-");
					$("#txtBirthCoupon").text("-사용불가-");
				} else if (g_couponShop == 0) {
					$("#birthCoupon").val(g_couponCd);
					$("#txtBirthCoupon").text("-사용가능-");
				} else {
					$("#birthCoupon").val(g_couponCd);
					$("#txtBirthCoupon").text("사용됨:" + g_couponDate);
				}
				closeCstmrCouponSearchJQM();

			}
		});
	}

	function getCstmrBigo(){
		//console.log('run CstmrBigo');
		var url = '${ctxPath}/cstmr/getCstmrBigo.do';
		$.ajax({
			url	 : url,
			type : "post",
			data : "cstmrId=" + '${cstmrVo.cstmrId}',
			dataType	: "text",
			success: function(data){
				//$("#memo_txtH").html(decodeURIComponent(data));
				//console.log('cstmrBigo:'+data);
				document.getElementById("cstmrBigo").value = decodeURIComponent(data);
				g_bfCstmrBigo = data;
			}
		});
	}

	function openSms(){
		//window.open("http://www.ozmailer.com");
		window.open('http://www.ozmailer.com', '', 'width=500');

	}


</script>

	<hr>
<table class="staffList" width="100%"  style="font-size: 13px; border-collapse:collapse"  border="1">
	<%-- <tr>
		<td colspan="7">
			<img src="${ctxPath	}/images/black2_line.jpg" width="100%">
		</td>
	</tr> --%>
	<tr >
			<td style="color: black; height:20px;" class="c1 blueTd" width="8%" >
				이름
			</td>
			<td bgcolor="white" style="color: black" class="c1 formWhiteTd"  width='15%'>
				<!-- <p id="cstmrName" name="cstmrName" onClick="dlgEditCstmrInfo(this);"></p> -->
				<form id="cstmrForm" style="display:inline">
					<input type="text" id="cstmrName" name="cstmrName" style=" width:100%;" />
				</form>
			</td>

			<td bgcolor="white" style="color: black" class="c1 blueTd" width="8%">
				포인트
			</td>
		<!-- <td bgcolor="white" style="color: black" class="c1"  onclick="dlgEditFmly();" width="10%"> -->

		<td bgcolor="white" style="color: black" class="c1 formWhiteTd"  width="10%">
			<!-- <a href="#dlgEditFmly" data-rel="popup" data-role="button"> -->
			<a href="javascript:setFmlyCdJQM()" data-rel="popup" data-role="button">
				<span id=fmly_name_txt1></span><span id=fmly_cd_txt1 hidden></span>
			</a>
		</td>
		<td bgcolor="white" style="color: black" class="c1 formWhiteTd" onclick= "fncGetPointHistory();"  width="12%">
			<span id=total_point_txt1>
				<fmt:formatNumber value="" pattern="#,###" />
			</span>(점)
		</td>

		<td bgcolor="white" style="color: black" class="c1 blueTd" width="8%">
			주소
		</td>
		<td colspan='5' bgcolor="white" style="color: black" class="c1 formWhiteTd" width="40%">
			<!-- <p id="cstmrAddr" name="cstmrAddr" onClick="dlgEditCstmrInfo(this);"></p> -->
			<input type="text" id="cstmrAddr" placeholder ='주소입력' name="cstmrAddr" style="width:100%"/>
		</td>
	</tr>

	<%-- <tr>
		<td colspan="7">
			<img src="${ctxPath	}/images/black_line.jpg" width="100%" >
		</td>
	</tr> --%>
	<tr>
		<td bgcolor="white" style="color: black" class="c1 blueTd">
			가입<br/>지점
		</td>
		<td bgcolor="white" style="color: black" class="c1 formWhiteTd">
			<p id="cstmrRegShop" name="cstmrCd"></p>
		</td>
		<td  bgcolor="white" style="color: black" class="c1 blueTd">
			전화<br/>번호
		</td>
		<td colspan='2' bgcolor="white" style="color: black" class="c1 formWhiteTd">
			<form id='tels' style="display:inline">
				<input id='tel1' name='tel[]' type='text' style='height: 30px; width: 55px; font-size: 15px' />
				- <input id='tel2' name='tel[]' type='text' style='height: 30px; width: 55px; font-size: 15px' />
				- <input id='tel3' name='tel[]' type='text' style='height: 30px; width: 55px; font-size: 15px' />
			</form>
		</td>
		<td  bgcolor="white" style="color: black" class="c1 blueTd">
			이메일
		</td>
		<td colspan='5' bgcolor="white" style="color: black" class="c1 formWhiteTd">
			<!-- <p id="cstmrEmail" name="email" onClick="dlgEditCstmrInfo(this);"> </p> -->
			<input type='text' placeholder='이메일 입력' id="cstmrEmail" name="email" style="width:100%"/>
		</td>


	</tr>

	<tr>
		<Td bgcolor="white" style="color: black" class="c1 blueTd">성별</Td>
		<td class="formWhiteTd">
			<label for="male" style="color: black">남</label>
			<input type="radio" id="male" name="sexCd_" value="00400001" data-role='none'>
			<label for="female" style="color: black">여</label>
			<input type="radio" id="female" name="sexCd_" value="00400002" data-role='none'>
		</td>

		<td  bgcolor="white" style="color: black" class="c1 blueTd">
			휴대폰
		</td>
		<td  colspan='2' bgcolor="white" style="color: black"class="c1 formWhiteTd" >
			<form id='mobiles' style="display:inline">
				<input id='mobile1' name='mobile[]' type='text' style='height: 30px; width: 55px; font-size: 15px' />
				- <input id='mobile2' name='mobile[]' type='text' style='height: 30px; width: 55px; font-size: 15px' />
				- <input id='mobile3' name='mobile[]' type='text' style='height: 30px; width: 55px; font-size: 15px' />
			</form>
		</td>
		<td bgcolor="white" style="color: black" class="c1 blueTd">
			생일
		</td>
		<td colspan='5' bgcolor="white" style="color: black" class="c1 formWhiteTd">
			<select id='slctBirthDayTyCd' name='slctBirthDayTyCd' style='width:20%'>
				<option value='00600001'>양</option>
				<option value='00600002'>음</option>
			</select>
			<select id='slctByear' name='slctByear' style='width:27%'>
				<option value='0'>선택</option>
				<c:forEach var='i' begin='0' end='${cyear}'>
					<option value='${cyear-i+1900}'>${cyear-i+1900}</option>
				</c:forEach>
			</select>
			<select id="slctBmonth" name="slctBmonth" style='width:22%'>
					<option value="0">선택</option>
					<option value="01">01</option>
					<option value="02">02</option>
					<option value="03">03</option>
					<option value="04">04</option>
					<option value="05">05</option>
					<option value="06">06</option>
					<option value="07">07</option>
					<option value="08">08</option>
					<option value="09">09</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
			</select>
			<select id="slctBday" name="slctBday" style='width:22%'>
				<option value="0">선택</option>
					<option value="01">01</option>
					<option value="02">02</option>
					<option value="03">03</option>
					<option value="04">04</option>
					<option value="05">05</option>
					<option value="06">06</option>
					<option value="07">07</option>
					<option value="08">08</option>
					<option value="09">09</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					<option value="24">24</option>
					<option value="25">25</option>
					<option value="26">26</option>
					<option value="27">27</option>
					<option value="28">28</option>
					<option value="29">29</option>
					<option value="30">30</option>
					<option value="31">31</option>
			</select>
		</td>
	</tr>
	<tr>
		<Td bgcolor="white" style="color: black" class="c1 blueTd">가족<br/>회원</Td>
		<td class="formWhiteTd">
			<select id="fmlyList" data-inline='true' data-mini='true' data-native-menu='false' onchange="getCstmrChart()"></select>
		</td>

		<td bgcolor="white" style="color: black" class="c1 blueTd">
			고객<br/>코드
		</td>
		<td colspan='2' bgcolor="white" style="color: black" class="c1 formWhiteTd">
			<p id="cstmrCd" name="cstmrCd" style='font-size: 13px' ></p>
			<p id="oldCstmrCd" name="oldCstmrCd" style='font-size: 13px' ></p>
		</td>


		<td  bgcolor="white" style="color: black" class="c1 blueTd">
			생일<br/>쿠폰
		</td>

		<td colspan='5' bgcolor="white" style="color: black" class="c1 formWhiteTd">
			<span><button onclick='$("#noCouponInfo").popup( "open",{transition: "pop"});'>안내</button></span><span id="cstmrBirthCoupon" name="cstmrBirthCoupon"></span>
		</td>
	</tr>
	<Tr>
		<td  bgcolor="white" style="color: black" class="c1 blueTd">
			비고
		</td>
		<td bgcolor="white" style="color: black" class="c1 formWhiteTd" colspan="4" >
			<!-- <input type="text" id="cstmrBigo" style="height:25px; width:100%"></input> -->
			<textarea rows="2" cols="80" id="cstmrBigo" data-role='none' placeholder="내용 작성 후 우측 저장버튼을 누르시면 저장됩니다."></textarea>
			<!-- <input type='edit' rows="2" cols="80" id="cstmrBigo" data-role='none' placeholder="내용 작성 후 우측 저장버튼을 누르시면 저장됩니다."></textarea> -->
			<!-- <input type="button" id="saveBigo" onclick="cstmrBigoUpdate();return false;" value="저장"></input> -->
		</td>
		<td  bgcolor="white" style="color: black" class="c1 blueTd" >
			수신<br/>동의
		</td>
		<td bgcolor="white" style="color: black" class="c1 formWhiteTd" width="7%">
			<label for='getSms'>sms</label><br/>
			<input id='getSms' type='checkbox' size='10' />
		</td>
		<td bgcolor="white" style="color: black" class="c1 formWhiteTd" width="7%">
			<label for='sendSms'>sms</label><br/>
			<input id='sendSms' type='button' onclick='openSms();' size='10' value='발송'/>
		</td>
		<td bgcolor="white" style="color: black" class="c1 formWhiteTd" width="7%">
			<label for='getEmail'>메일</label><br/>
			<input id='getEmail' type='checkbox'size='10' />
		</td>
		<td  bgcolor="white" style="color: black" class="c1 formWhiteTd" width="7%">
			<!-- <label for='getCoupon'>쿠폰</label>
			<input id='getCoupon' type='checkbox' size='10' /> -->
			<label for='getDm'>우편</label><br/>
			<input id='getDm' type='checkbox' size='10' />
		</td>
		<td align='center' class="c1 blueTd" width="7%">
			<input type='button' onclick='modifyCstmrInfo();' value='저장' />
		</td>
	</Tr>

	<!-- <tr>
		<td colspan="6"></td>
		<td>
			<input style="width:20%" type="button" id="saveBigo" onclick="cstmrInfoUpdate();return false;" value="저장"></input>
		</td>
	</tr> -->
</table>
<hr>
<!-- <div data-role="popup" id='dlgEditFmly'	data-overlay-theme="a" data-theme="c" class="ui-corner-all">
		<div data-role="header" data-theme="c" class="ui-corner-top">
			<h3>가족 코드 변경</h1>
		</div>
		<div data-role="content" data-theme="c" class="ui-corner-bottom ui-content">
		<label for="crtFmlyName" data-theme="c">현재 값:</label>
		<input type="text" name="user" id="crtFmlyName" data-theme="c" />
		</br>
		<label for="editFmlyCd" data-theme="c">변경 값:</label>
		<input type="text" name="user" id="editFmlyCd"
			placeholder="고객 코드만 입력" data-theme="c" />
		<input type='button'
			value='변경' onclick='fncSetFmlyCd();return false;' id='btnEditFmlyCd'
			style='height: 60px; width: 60px' data-theme="c">
		<input
			type='button' value='닫기' onclick='fncCloseFmlyCd();return false;'
			id='btnCloseFmlyCd' style='height: 60px; width: 60px' data-theme="c">
		</div>
</div> -->

<div data-role="popup" id='cstmrSearchJQM'	data-overlay-theme="a" data-theme="c" class="ui-corner-all">
		<a href="javascript:closeCstmrSearchJQM();" data-role="button" class='btn'  data-theme="a ui-btn-right" data-icon="delete" data-iconpos="notext">Close</a>
	<div data-role="header">
		<center>
		<h4 class='text'>가족코드 입력</h4>
		<h5 id='crtFmlyCd' class='text'>가족코드 입력</h5>
		</center>
		<div data-role="navbar" class='navbar'>
			<ul>
				<li><a href="#" onclick="slctNavCstmr('searchFmly');">고객검색</a></li>
				<li><a href="#" onclick="slctNavCstmr('inputFmly');">코드직접입력</a></li>
			</ul>
		</div>
	</div>

	<div id='navSearchFmly' style="padding:10px 20px;" class='hideDiv'>
          <input type="text" id="csName" placeholder="고객성함"
          			onKeyPress="javascript:if(event.keyCode == 13) fmlySearch();"></input>
          <input type="text" id="cs4Digit" placeholder="4자리"
          			onKeyPress="javascript:if(event.keyCode == 13) fmlySearch();"></input>
    	  <input value='검색' type="button"  onclick="fmlySearch();"> </input>
	</div>

	<div id='navInputFmly' style="padding: 10px 20px;" class='hideDiv'>
		<input type="text" name="user" id="editFmlyCd" placeholder="코드 입력" data-theme="c"
			onKeyPress="javascript:if(event.keyCode == 13) fncSetFmlyCd();"></input>
		<input type='button' value='변경' onclick='fncSetFmlyCd();return false;' id='btnEditFmlyCd'
			style='height: 60px; width: 60px' data-theme="c"></input>
	</div>
	<div id = 'listFmlyCdDiv' style='width:500px'>
	</div>
</div>

<div data-role="popup" id='cstmrCouponSearchJQM' data-overlay-theme="a" data-theme="c" class="ui-corner-all">
		<a href="javascript:closeCstmrCouponSearchJQM();" data-role="button"
			class='btn'  data-theme="a ui-btn-right" data-icon="delete" data-iconpos="notext">Close</a>
	<div data-role="header">
		<center>
		<h4 class='text'>생일쿠폰 입력</h1>
		</center>
		<div data-role="navbar" class='navbar'>
			<ul>
				<li><a href="#" onclick="slctNavCoupon('searchCoupon');">고객검색</a></li>
				<li><a href="#" onclick="slctNavCoupon('inputCoupon');">코드직접입력</a></li>
			</ul>
		</div>
	</div>

	<div id='navSearchCoupon' style="padding:10px 20px;" class='hideDiv'>
		<table>
			<tr>
				<td>
					<input type="text" id="cpName" placeholder="고객성함"
							onclick='initCouponSearch(); return false;'
							onKeyPress="javascript:if(event.keyCode == 13) couponSearch();"></input>
				</td>
				<td>
					<input type="text" id="cp4Digit" placeholder="4자리"
							onKeyPress="javascript:if(event.keyCode == 13) couponSearch();"></input>
				</td>
				<td rowspan='3'>
					<input value='검색' type="button"  onclick="couponSearch();" ></input>
				</td>
			</tr>
			<tr>
				<td colspan='2' >
					<center>
					or
					</center>
				</td>
			</tr>
			<tr>
				<td colspan='2' >
					<center>
					<input type="text" id="cpCd" placeholder="고객코드"
							onclick='initCouponSearch(); return false;'
							onKeyPress="javascript:if(event.keyCode == 13) couponSearch();" />
					</center>
				</td>
			</tr>
		</table>
	</div>
	<div id='navInputCoupon' style="padding: 10px 20px;" class='hideDiv'>
		<input type="text" name="user" id="inputBirthCd" placeholder="코드 입력" data-theme="c"
			onKeyPress="javascript:if(event.keyCode == 13) checkBirth();"></input>
		<input type='button' value='입력' onclick='checkBirth();return false;' id='btnEditFmlyCd'
			style='height: 60px; width: 60px' data-theme="c"></input>
	</div>
	<div id = 'listCouponCdDiv' style='width:500px'></div>
</div>


<div data-role="popup" id="popPointHstry" class="ui-content" data-theme="e" data-overlay-theme="a" style="overflow:scroll; height:400px; padding:10px;">
<!-- <div data-role="popup" id="popPointHstry"  data-theme="none" data-overlay-theme="none" style="overflow:scroll; height:400px; padding:10px;"> -->
    <!-- <a href="#" data-rel="back" data-role="button" data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a> -->
    <div id="cstmrPointHist"> </div>
</div>

<div data-role='popup' id='noCouponInfo' class='ui-content' data-theme='a' style='max-width:350px;'>
	<p>생일이 정확히 입력되고 sms, email 둘중 하나를 수신동의 하시면 생일에 <strong>쿠폰</strong>이 생성됩니다.</p>
</div>
