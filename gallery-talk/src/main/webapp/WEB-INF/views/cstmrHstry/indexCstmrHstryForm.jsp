<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script>
	//----------------------
	//화면 초기 실행
	
	var writable = true;
	
	/* function toggle(){
		if(!writable){
			fncCheckWrite();
		}else{
			fncSave();
			writable = false;
		}
	} */
	
	function changeClr(id){
		$(".dateSpan").css("color","black");
		$(".dateSpan").css("background-color","white");
		$("#" + id).css("background-color", "#3399ff");
		$("#" + id).css("color", "white");
	}
	
	var g_saleId = 0;
	
	jQuery(document).ready(function() {
		getCstmrInfo();
		//getVisitInfo();
		getVisitList();
		getVisitListForFrame();
		//getCstmrMemoDlg();
		jQuery('#cstmrId').val('${cstmrId}');
		
		$("input:radio").each(function(index) {
		    $("<label>").text("")
		                .attr("for", this.id = "radio" + index + 1)
		                .insertAfter(this);
		});
	});
	//----------------------
	var mCstmrCd;
	function fncSelectCstmr(cstmrCd) {
		mCstmrCd = cstmrCd;
	};
	function resetInput(id)
	{
		id.value="";
	}

	/* function getSelectedPrdctListData() {
		var url = 'listSelectedPrdctData.do';

		$.ajax({
			url : url,
			type : "post",
			data : "cstmrId=" + '${cstmrId}',
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				jQuery('#listSelectedPrdctDiv').html(data);
			}
		});
	} */
	
	function getSaleMemoH(saleId){
		//var saleId = '${saleVo.saleId}';
		//var g_saleId = $('#saleIdH').val();
		console.log('run getSaleMemoH saleId:'+saleId);
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
		g_saleId = saleId;
		
		getListPaymentNew(saleId);
		if (saleId < 0) {
			return;
		}

		var url = '${ctxPath}/cstmrHstry/getCheckData.do';
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
				console.log("Run getCheckInfo Success!!");
				//console.log(data);
				/* if(data.cstmrMemo!=null){
					$("#memoSpan").text(data.cstmrMemo);	
				}else{
					$("#memoSpan").text("");
				} */
				jQuery("#cstmrHist span[id='gsphRight']").text(data.gsphRight);
				jQuery("#cstmrHist span[id='gcylRight']").text(data.gcylRight);
				jQuery("#cstmrHist span[id='gaxisRight']").text(data.gaxisRight);
				jQuery("#cstmrHist span[id='addRight']").text(data.addRight);
				jQuery("#cstmrHist span[id='pdRight']").text(data.pdRight);
				jQuery("#cstmrHist span[id='npcRight']").text(data.npcRight);
				jQuery("#cstmrHist span[id='npaRight']").text(data.npaRight);
				jQuery("#cstmrHist span[id='prismRight']").text(data.prismRight);
				jQuery("#cstmrHist span[id='baseRight']").text(data.baseRight);

				jQuery("#cstmrHist span[id='gsphLeft']").text(data.gsphLeft);
				jQuery("#cstmrHist span[id='gcylLeft']").text(data.gcylLeft);
				jQuery("#cstmrHist span[id='gaxisLeft']").text(data.gaxisLeft);
				jQuery("#cstmrHist span[id='addLeft']").text(data.addLeft);
				jQuery("#cstmrHist span[id='pdLeft']").text(data.pdLeft);
				jQuery("#cstmrHist span[id='npcLeft']").text(data.npcLeft);
				jQuery("#cstmrHist span[id='npaLeft']").text(data.npaLeft);
				jQuery("#cstmrHist span[id='prismLeft']").text(data.prismLeft);
				jQuery("#cstmrHist span[id='baseLeft']").text(data.baseLeft);

				jQuery("#cstmrHist span[id='lsphRight']").text(data.lsphRight);
				jQuery("#cstmrHist span[id='lcylRight']").text(data.lcylRight);
				jQuery("#cstmrHist span[id='laxisRight']").text(data.laxisRight);
				jQuery("#cstmrHist span[id='bcRight']").text(data.bcRight);
				jQuery("#cstmrHist span[id='diaRight']").text(data.diaRight);

				//pointer
				jQuery("#cstmrHist span[id='lsphLeft']").text(data.lsphLeft);
				jQuery("#cstmrHist span[id='lcylLeft']").text(data.lcylLeft);
				jQuery("#cstmrHist span[id='laxisLeft']").text(data.laxisLeft);
				jQuery("#cstmrHist span[id='bcLeft']").text(data.bcLeft);
				jQuery("#cstmrHist span[id='diaLeft']").text(data.diaLeft);

				//shop and staff
 	
				jQuery("#cstmrHistForm span[id='shopNameH']").text(data.shopName);
				console.log('shopName:'+data.shopName);
				jQuery("#cstmrHistForm span[id='staffNameH']").text(data.staffName);
				console.log('staffName:'+data.staffName);
				jQuery("#cstmrHistForm span[id='staffIdH']").text(data.staffId);
				console.log('staffId:'+data.staffId);
				jQuery("#cstmrHistForm span[id='saleIdH']").text(saleId);
				getSaleMemoH(saleId);
				 
				if(data.domEye=="1"){
					$("#dom").html("(우)");
				}else if(data.domEye=="2"){
					$("#dom").html("(좌)");
				}else if(data.domEye=="0"){
					$("#dom").html("(없음)");
				}else{
					$('input:radio[name="domEye"]').filter('[value="1"]').attr('checked', false);
					$('input:radio[name="domEye"]').filter('[value="2"]').attr('checked', false);
				}
				
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
				jQuery('#cardDate').text(data.cardDate);

				jQuery('#payPoint_txt').text(format2(String(data.payPoint * data.oldDigit)));
				
				//console.log("card_date:"+data.cardDate);
				//console.log("cname:"+data.cname);
				//jQuery('#card_date_txt').text(data.cardDate);
				//jQuery('#cname_txt').text(data.cname);

				if(data.isOld==0){
					$(".hiddenOld").css("display","none");
					$(".hiddenNew").css("display","inline");
				}else if(data.isOld==1){
					$(".hiddenNew").css("display","none");
					$(".hiddenOld").css("display","inline");
				}

				$(".eyeChk").css("font-size","12px");
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

	function getVisitInfo() {
		var url = 'getCheckDataForSale.do';

		//javax
		$.ajax({
			url : url,
			type : "post",
			data : null,
			dataType : "json",
			beforeSend : function() {
			},
			success : function(data) {
				jQuery("#cstmrHist span[id='gsphRight']").text(data.gsphRight);
				jQuery("#cstmrHist span[id=gcylRight']").text(data.gcylRight);
				jQuery("#cstmrHist span[id='gaxisRight']").text(data.gaxisRight);
				jQuery("#cstmrHist span[id='addRight']").text(data.addRight);
				jQuery("#cstmrHist span[id='pdRight']").text(data.pdRight);
				jQuery("#cstmrHist span[id='npcRight']").text(data.npcRight);
				jQuery("#cstmrHist span[id='npaRight']").text(data.npaRight);
				jQuery("#cstmrHist span[id='prismRight']").text(data.prismRight);
				jQuery("#cstmrHist span[id='baseRight']").text(data.baseRight);

				jQuery("#cstmrHist span[id='gsphLeft']").text(data.gsphLeft);
				jQuery("#cstmrHist span[id='gcylLeft']").text(data.gcylLeft);
				jQuery("#cstmrHist span[id='gaxisLeft']").text(data.gaxisLeft);
				jQuery("#cstmrHist span[id='addLeft']").text(data.addLeft);
				jQuery("#cstmrHist span[id='pdLeft']").text(data.pdLeft);
				jQuery("#cstmrHist span[id='npcLeft']").text(data.npcLeft);
				jQuery("#cstmrHist span[id='npaLeft']").text(data.npaLeft);
				jQuery("#cstmrHist span[id='prismLeft']").text(data.prismLeft);
				jQuery("#cstmrHist span[id='baseLeft']").text(data.baseLeft);

				jQuery("#cstmrHist span[id='lsphRight']").text(data.lsphRight);
				jQuery("#cstmrHist span[id='lcylRight']").text(data.lcylRight);
				jQuery("#cstmrHist span[id='laxisRight']").text(data.laxisRight);
				jQuery("#cstmrHist span[id='bcRight']").text(data.bcRight);
				jQuery("#cstmrHist span[id='diaRight']").text(data.diaRight);

				//pointer
				jQuery("#cstmrHist span[id='lsphLeft']").text(data.lsphLeft);
				jQuery("#cstmrHist span[id='lcylLeft']").text(data.lcylLeft);
				jQuery("#cstmrHist span[id='laxisLeft']").text(data.laxisLeft);
				jQuery("#cstmrHist span[id='bcLeft']").text(data.bcLeft);
				jQuery("#cstmrHist span[id='diaLeft']").text(data.diaLeft);
			
			}
		});
	};

	function getVisitList() {
		//location.replace("${ctxPath}/cstmrHstry/indexCstmrHstryForm.do");
		var url = '${ctxPath}/cstmrHstry/listVisitData.do';

		//javax
		$.ajax({
			url : url,
			type : "post",
			data : "cstmrId=" + '${cstmrId}',
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				jQuery('#visitList2').html(data);

			}
		});
	};
	
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

		console.log("run getCstmrInfo cstmrId is :"+'${cstmrId}');
		//javax
		$.ajax({
			url : url,
			type : "post",
			data : "cstmrId=" + '${cstmrId}',
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				console.log("success CstmrInfo");
				console.log("cstmr : "+'${cstmr}');
				console.log("cstmr.fmlyCd : "+'${cstmr.fmlyCd}');
				jQuery('#cstmrInfo').html(data);
			}
		});
	};
	
	function getListPaymentNew()
	{
		var url = '${ctxPath}/cstmrHstry/listPaymentNew.do';

		//javax
		$.ajax({
			url : url,
			type : "post",
			/* data : "saleId=" + '${saleId}', */
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				console.log("success listPaymentNew");
				jQuery('#paymentList').html(data);
			}
		});
	}

	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function goCstmrListPage() {

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
	
	
 	function format(id){
 		var n = id.value;
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
			data : "memo=" + memo + "&saleId=" + saleId,
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
		  		  
		  $('#body').append(form); 
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
	
	
	
</script>

<style>
	/* body{
		background-color: gray;'
	} */
	
	/* #cstmrHstry_memo{
		height: 50px;
		width: 200px;
	}
	#cstmrHstry_memo_txt{
		display: none;
	} */
	#cstmr_memo_dlg{
		height: 50px;
		width: 200px;
	}
	#cstmr_memo_dlg_txt{
		display: none;
	}
	
input[type=radio] {
    display:none;
  }
 
  input[type=radio] + label
   {
       background-image : url("/GalleryStaff/images/checkbox.png");
       height: 32px;
       width: 32px;
       display:inline-block;
       padding: 0 0 0 0px;
   }

   input[type=radio]:checked + labelval
    {
        background-image : url("/GalleryStaff/images/checkbox_c.png");
        height: 32px;
        width: 32px;
        display:inline-block;
        padding: 0 0 0 0px;
    }
    
    #dateFrame{
    	font-size :13px;
    	width: 200px;
    	height: 550px;
    	overflow: inherit;
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
   		margin: 10px;
   		font-weight: bold;
   	}
   	#dateSelect{
   		display: none;
   	}
   	.blueTr{
   		background-color: #99ccff;
   	}
   	.borderL{
   		border-top-left-radius:0.5em;
   	}
   	.borderR{
   		border-top-right-radius:0.5em;
   	}
</style>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>CstmrHistory Page</title>
<link rel="stylesheet" href="../css/toggle-switch.css">
</head>

<body>
	<center>
	<!-- <div calss="transBoxTable" style="font-size: 13px;"> -->
		<table style="font-size: 13px;" width="90%">
			<tr>
				<td colspan="2"><div id="cstmrInfo"></div></td>
			</tr>			
			<tr>
				<td colspan="2"><div id="visitList2"></div></td>
			</tr>
			<Tr>
				<td rowspan="4" valign="top"><div id="dateFrame"> </div></td>
				<td valign="top">
			
					<form name="checkForm" id="checkForm" method="post" action="">
			<input type="hidden" id="histId" name="histId"></input> <input
				type="hidden" id="cstmrId" name="cstmrId"></input>
			<!-- <div class="transBoxTable" style="font-size: 13px;"> --> 
			<table width="90%"  style="font-size: 13px; text-align: center" id="staffList"  >
			<form id="cstmrHist">
				<%-- <tr >
					<td height="3" colspan="10"><img
						src="<c:url value="/images/content/Whiteline.jpg" />" width="800"
						height="1" /></td>
				</tr> --%>

				<tr bgcolor="white" style="color: black" class="blueTr">
					<td width="65px" class="borderL">Glasses</td>
					<td width="60px">SPH</td>
					<td width="60px">CYL</td>
					<td width="60px">AXIS</td>
					<td width="60px">PD</td>
					<td width="60px">ADD</td>
					<td width="60px">PRISM</td>
					<td width="60px">BASE</td>
					<td width="60px">NPC</td>
					<td width="60px">NPA</td>
				</tr>
				
				<tr>
					<td colspan="10">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">					
					</td>
				</tr>
				
				<tr style="color: black" bgcolor="white" class="eyeChk">
					<td width="65px">Right</td>
					<td width="60px"><span type="text"    id="gsphRight" class="eyeChk"
						name="gsphRight" style="font-size: 17px" onclick ="resetInput(gsphRight);" onchange="format(gsphRight);"></span></td>
					<td width="60px"><span type="text" size="3"   id="gcylRight" class="eyeChk"
						name="gcylRight" style="font-size: 17px" onclick ="resetInput(gcylRight);" onchange="format(gcylRight)"></span></td>
					<td width="60px"><span type="text" size="3"   class="eyeChk"
						id="gaxisRight" name="gaxisRight" style="font-size: 17px" onclick ="resetInput(gaxisRight);"> </span></td>
					<td width="60px"><span type="text" size="3" class="eyeChk"  style="font-size: 17px" onclick ="resetInput(pdRight);"
						id="pdRight" name="pdRight" ></span></td>
					<td width="60px"><span type="text" size="3" class="eyeChk"  id="addRight" name="addRight" style="font-size: 17px"
						onchange="formatNoSign(addRight)" onclick ="resetInput(addRight);"></span></td>
					
					<td width="60px"><span type="text" size="3" class="eyeChk"style="font-size: 17px"  class="notUse"
						id="npcRight" name="npcRight" onchange="formatNoSign(npcRight)" onclick ="resetInput(npcRight);"></span></td>
					<td width="60px"><span type="text" size="3"class="eyeChk" style="font-size: 17px"  class="notUse"
						id="npaRight" name="npaRight" onchange="format(npaRight)" onclick ="resetInput(npaRight);"></span></td>
					<td width="60px"><span type="text" size="3" class="eyeChk" style="font-size: 17px"   class="notUse"
						id="prismRight" name="prismRight" onchange="formatNoSign(prismRight)" onclick ="resetInput(prismRight);"></span></td>
					<td width="60px"><span type="text" class="eyeChk" size="3"style="font-size: 17px"   class="notUse"
						id="baseRight" name="baseRight" onchange="formatNoSign(baseRight)" onclick ="resetInput(baseRight);"></span></td>
				</tr >
				<tr>
					<td colspan="10">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">					
					</td>
				</tr>
				
				<tr style="color: black" bgcolor="white">
					<td >Left</td>
					<td><span onclick ="resetInput(gsphLeft);" class="eyeChk" type="text" size="3" style="font-size: 17px"  id="gsphLeft"
						name="gsphLeft" onchange="format(gsphLeft)" ></span></td>
					<td><span onclick ="resetInput(gcylLeft);" class="eyeChk" type="text" size="3" style="font-size: 17px"  id="gcylLeft"
						name="gcylLeft" onchange="format(gcylLeft)"></span></td>
					<td><span onclick ="resetInput(gaxisLeft);"class="eyeChk" type="text" size="3" style="font-size: 17px"  id="gaxisLeft"
						name="gaxisLeft"></span></td>
					<td><span onclick ="resetInput(pdLeft);" class="eyeChk" type="text" size="3" style="font-size: 17px"  id="pdLeft"
						name="pdLeft" ></span></td>
					<td><span onclick ="resetInput(addLeft);" class="eyeChk"type="text" size="3" style="font-size: 17px"  id="addLeft"
						name="addLeft" onchange="formatNoSign(addLeft)"></span></td>
						
					<td ><span onclick ="resetInput(npcLeft);" class="eyeChk"type="text" size="3" style="font-size: 17px"  class="notUse"
						id="npcLeft" name="npcLeft" onchange="formatNoSign(npcLeft)"></span></td>
					<td ><span onclick ="resetInput(npaLeft);" class="eyeChk"type="text" size="3" style="font-size: 17px"  class="notUse"
						id="npaLeft" name="npaLeft" onchange="format(npaLeft)"></span></td>
					<td ><span onclick ="resetInput(prismLeft);" class="eyeChk"type="text" size="3" style="font-size: 17px"  class="notUse"
						id="prismLeft" name="prismLeft" onchange="formatNoSign(prismLeft)"></span></td>
					<td ><span onclick ="resetInput(baseLeft);" class="eyeChk"type="text" size="3" style="font-size: 17px"  class="notUse"
						id="baseLeft" name="baseLeft" onchange="formatNoSign(baseLeft)"></span></td>
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
				
				<tr class="blueTr" style="color: black">
					<td class="borderL">C/L</td>
					<td>SPH</td>
					<td>CYL</td>
					<td>AXIS</td>
					<td>B.C</td>
					<td class="borderR">DIA</td>
					<td bgcolor="white">&nbsp;</td>
					<td bgcolor="white">&nbsp;</td>
					<td bgcolor="white">&nbsp;</td>
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
						<input onclick="resetInput(lsphRight);" class="eyeChk"
						type="text" size="3" style="font-size: 17px" id="lsphRightIn" hidden
						name="lsphRight" onchange="format(lsphRight)">
						
						<span onclick="resetInput(lsphRight);" class="eyeChk"
						type="text" size="3" style="font-size: 17px" id="lsphRight"
						name="lsphRight" onchange="format(lsphRight)"></span>
						</td>
					<td>
						<input onclick="resetInput(lcylRight);" class="eyeChk"
						type="text" size="3" style="font-size: 17px" id="lcylRightIn" hidden
						name="lcylRight" onchange="format(lcylRight)">
						<span onclick="resetInput(lcylRight);" class="eyeChk"
						type="text" size="3" style="font-size: 17px" id="lcylRight"
						name="lcylRight" onchange="format(lcylRight)"></span>
						</td>
					<td>
						<input onclick="resetInput(laxisRight);" class="eyeChk"
						type="text" size="3" style="font-size: 17px" id="laxisRightIn" hidden
						name="laxisRight">
						<span onclick="resetInput(laxisRight);" class="eyeChk"
						type="text" size="3" style="font-size: 17px" id="laxisRight"
						name="laxisRight"></span>
						</td>
					<td>
						<input onclick="resetInput(bcRight);" class="eyeChk"
						type="text" size="3" style="font-size: 17px" id="bcRightIn" hidden
						name="bcRight" onchange="formatNoSign(bcRight)">
						<span onclick="resetInput(bcRight);" class="eyeChk"
						type="text" size="3" style="font-size: 17px" id="bcRight"
						name="bcRight" onchange="formatNoSign(bcRight)"></span></td>
					<td>
						<input onclick="resetInput(diaRight);" class="eyeChk"
						type="text" size="3" style="font-size: 17px" id="diaRightIn" hidden
						name="diaRight" onchange="formatNoSign(diaRight)">
						<span onclick="resetInput(diaRight);" class="eyeChk"
						type="text" size="3" style="font-size: 17px" id="diaRight"
						name="diaRight" onchange="formatNoSign(diaRight)"></span></td>

					<td colspan="4" width="20" style="color: black" bgcolor="white">우위안<span id="dom"></span></td>
					
				</tr>
				
				<tr>
					<td colspan="10">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">					
					</td>
				</tr>
				
				<tr style="color: black" bgcolor="white">
					<td >Left</td>
						<td><input type="text" onclick="resetInput(lsphLeft);" class="eyeChk"
							type="text" size="3" style="font-size: 17px" id="lsphLeftIn" hidden
							name="lsphLeft" onchange="format(lsphLeft)" >
							<span onclick="resetInput(lsphLeft);" class="eyeChk"
							type="text" size="3" style="font-size: 17px" id="lsphLeft"
							name="lsphLeft" onchange="format(lsphLeft)"></span></td>
						<td>
							<input onclick="resetInput(lcylLeft);" class="eyeChk"
							type="text" size="3" style="font-size: 17px" id="lcylLeftIn" hidden
							name="lcylLeft" onchange="format(lcylLeft)">
							<span onclick="resetInput(lcylLeft);" class="eyeChk"
							type="text" size="3" style="font-size: 17px" id="lcylLeft"
							name="lcylLeft" onchange="format(lcylLeft)"></span>
							</td>
						<td>
							<input onclick="resetInput(laxisLeft);" class="eyeChk"
							type="text" size="3" style="font-size: 17px" id="laxisLeftIn" hidden
							name="laxisLeft"></span>
							<span onclick="resetInput(laxisLeft);" class="eyeChk"
							type="text" size="3" style="font-size: 17px" id="laxisLeft"
							name="laxisLeft"></span>
							</td>
						<td>
							<input onclick="resetInput(bcLeft);" class="eyeChk"
							type="text" size="3" style="font-size: 17px" id="bcLeftIn" hidden
							name="bcLeft" onchange="formatNoSign(bcLeft)">
							<span onclick="resetInput(bcLeft);" class="eyeChk"
							type="text" size="3" style="font-size: 17px" id="bcLeft"
							name="bcLeft" onchange="formatNoSign(bcLeft)"></span>
							</td>
						<td>
							<input onclick="resetInput(diaLeft);" class="eyeChk"
							type="text" size="3" style="font-size: 17px" id="diaLeftIn" hidden
							name="diaLeft" onchange="formatNoSign(diaLeft)">
							<span onclick="resetInput(diaLeft);" class="eyeChk"
							type="text" size="3" style="font-size: 17px" id="diaLeft"
							name="diaLeft" onchange="formatNoSign(diaLeft)"></span>
							</td>
						<td bgcolor="white">&nbsp;</td>
					<td bgcolor="white">&nbsp;</td>
					<td bgcolor="white">&nbsp;</td>
					<td bgcolor="white">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="10">
						<img src="${ctxPath	}/images/black_line.jpg" width="100%">					
					</td>
					<!-- <td bgcolor="white">&nbsp;</td>
					<td bgcolor="white">&nbsp;</td>
					<td bgcolor="white">&nbsp;</td>
					<td bgcolor="white">&nbsp;</td> -->
				</tr>
				
</form>
			</table>
			<!-- </div> -->

			<%-- <table width="800" border="0.5">
	    <tr>
	      <td height="78" colspan="3"><div class="header">전달사항</div></td>
	    </tr>
	    <tr class="c1">
	      <td width="135" height="24" bgcolor="#FFFFFF" class="c1">선택</td>
	      <td width="128" bgcolor="#FFFFFF" class="c1">담당자이름</td>
	      <td bgcolor="#FFFFFF" class="c1">주의</td>
	     </tr>
	    <tr>
	      <td  height="60" colspan="3">(전달사항 입력)</td>
	    </tr>
	    <tr>
	      	<td height="24" colspan="3">
	      		<a href="#" onclick="fncSave();return false;"> <img
					src="<c:url value="/images/content/save.png" />"
					onmousedown="this.src='<c:url value="/images/content/savepush.png" />'"
					onmouseup="this.src='<c:url value="/images/content/save.png" />'"
					width="72" height="72" />
				  </a>
			</td>
	    </tr>
	  </table> --%>
			<!-- <div class="transBoxTable"> -->
				<table class="hiddenOld" width="90%" style="font-size: 13px; text-align: center;">
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
					<td width="20%">FRAME</td>
					<td ><span id=gframe1></span></td>
					<td ><span id=gframe2></span></td>
					<td ><span id=gframe3></span></td>
					<td ><span id=gframe3></span></td>
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
					<td colspan='1'><span id=glens3></span></td>
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
					<td ><span id=gpayment></span></td>
					<td>Clens</td>
					<td ><span id=clpayment></span></td>
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
					<td><span id=cname></span>(<span id=cardDate></span>)</td>
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
				
				</table>
			<!-- </div> -->
		</form>
		
			</Tr>
			<tr style="color: black">
				<td valign="top"><div id="paymentList" class="hiddenNew"></div></td>
			</tr > 
			
			<!-- <tr width="90%" style="color: black; text-align: center; color:black; font-size: 15px;font-weight: bold;" bgcolor="white">
				<td colspan="5">
					<button id="cstmr_memo_dlg" onclick="showCstmrMemoDlg(); return false;">메모 열기</button><br>
					<textarea rows="10" cols="80" id="cstmr_memo_dlg_txt"></textarea>
				</td>
			</tr> -->
			<tr>
				<td>	
					<img src="${ctxPath	}/images/black2_line.jpg" width="100%" height="2px">						
				</td> 
				</tr>
			<tr style="text-align: left; vertical-align: top">
				<td style="background-color:white; height: 100px"><span id="memoSpan"></span></td>
			</tr>
		</table>
		
		<!-- </div> -->
		<!-- <button id="memo" onclick="showMemo(); return false;">메모</button><br>
			<textarea rows="10" cols="100" id="memo_txt"></textarea> -->
		
	</center>
	
</body>
</html>
