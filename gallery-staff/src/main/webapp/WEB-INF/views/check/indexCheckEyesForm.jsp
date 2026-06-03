<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>


<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script>
	//----------------------
	//화면 초기 실행
	
	var writable = true;
	var cstmrId = '${cstmrId}';
	var pageUrl='${ctxPath}/prdct/indexPrdctProcessForm.do';
	var pop = window.sessionStorage.getItem("popup");
	
	jQuery(document).ready(function() {
		var pop = window.sessionStorage.getItem("popup");
		if(pop==1){
			newWindow();
		}else{
			getVisitInfo();
			getVisitList();
			jQuery('#cstmrId').val('${cstmrId}');
			
			$("input:radio").each(function(index) {
			    $("<label>").text("")
			                .attr("for", this.id = "radio" + index + 1)
			                .insertAfter(this);
			});
		};
	});
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
						  form.submit();
					}, success:  function(data) {
					}
				});
				}
		});
	}

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

	function getCheckInfo(histId) {
		if (histId < -2) {
			return;
		}
		//console.log("@@@@@@@@@@@@@@@@" +histId)
		
		if(histId=="-1"){
			$("#ctmrVisitTitle").html("처방생성");
		}else{
			$("#ctmrVisitTitle").html("진행상태");
		}
		var url = 'getCheckData.do';

		//javax
		$.ajax({
			url : url,
			type : "post",
			data : "histId=" + histId,
			dataType : "json",
			beforeSend : function() {
			},
			success : function(data) {
				jQuery('#gsphRight').val(data.gsphRight);
				jQuery('#gcylRight').val(data.gcylRight);
				jQuery('#gaxisRight').val(data.gaxisRight);
				jQuery('#addRight').val(data.addRight);
				jQuery('#pdRight').val(data.pdRight);
				jQuery('#npcRight').val(data.npcRight);
				jQuery('#npaRight').val(data.npaRight);
				jQuery('#prismRight').val(data.prismRight);
				jQuery('#baseRight').val(data.baseRight);

				jQuery('#gsphLeft').val(data.gsphLeft);
				jQuery('#gcylLeft').val(data.gcylLeft);
				jQuery('#gaxisLeft').val(data.gaxisLeft);
				jQuery('#addLeft').val(data.addLeft);
				jQuery('#pdLeft').val(data.pdLeft);
				jQuery('#npcLeft').val(data.npcLeft);
				jQuery('#npaLeft').val(data.npaLeft);
				jQuery('#prismLeft').val(data.prismLeft);
				jQuery('#baseLeft').val(data.baseLeft);

				jQuery('#lsphRight').val(data.lsphRight);
				jQuery('#lcylRight').val(data.lcylRight);
				jQuery('#laxisRight').val(data.laxisRight);
				jQuery('#bcRight').val(data.bcRight);
				jQuery('#diaRight').val(data.diaRight);

				//pointer
				jQuery('#lsphLeft').val(data.lsphLeft);
				jQuery('#lcylLeft').val(data.lcylLeft);
				jQuery('#laxisLeft').val(data.laxisLeft);
				jQuery('#bcLeft').val(data.bcLeft);
				jQuery('#diaLeft').val(data.diaLeft);

				//shop and staff

				jQuery('#shopName').text(data.shopName);
				/* console.log('data.staffName:'+data.shopName);
				console.log('data.staffName:'+data.staffName); */
				jQuery('#staffName').text(data.staffName);
				jQuery('#staffId').text(data.staffId);
				
				if(data.domEye=="1"){
					$('input:radio[name="domEye"]').filter('[value="1"]').attr('checked', true);
				}else if(data.domEye=="2"){
					$('input:radio[name="domEye"]').filter('[value="2"]').attr('checked', true);
				}else{// if(data.domEye=="0"){
					$('input:radio[name="domEye"]').filter('[value="0"]').attr('checked', true);
					$('input:radio[name="domEye"]').filter('[value="1"]').attr('checked', false);
					$('input:radio[name="domEye"]').filter('[value="2"]').attr('checked', false);
				}
				
				/* gsphRight.readOnly = true;
				gcylRight.readOnly = true;
				gaxisRight.readOnly = true;
				addRight.readOnly = true;
				pdRight.readOnly = true;
				npcRight.readOnly = true;
				npaRight.readOnly = true;
				prismRight.readOnly = true;
				baseRight.readOnly = true;

				gsphLeft.readOnly = true;
				gcylLeft.readOnly = true;
				gaxisLeft.readOnly = true;
				addLeft.readOnly = true;
				pdLeft.readOnly = true;
				npcLeft.readOnly = true;
				npaLeft.readOnly = true;
				prismLeft.readOnly = true;
				baseLeft.readOnly = true;

				lcylRight.readOnly = true;
				laxisRight.readOnly = true;
				bcRight.readOnly = true;
				diaRight.readOnly = true;

				lsphLeft.readOnly = true;
				lcylLeft.readOnly = true;
				laxisLeft.readOnly = true;
				bcLeft.readOnly = true;
				diaLeft.readOnly = true; */

				/* btnEdit.disabled = true;
				btnSave.disabled = true;
 */
			}
		});
		/*
		alert(val);
		alert(val.histId);
		jQuery('#gsphRight').val(gsphRight);
		jQuery('#gcylRight').val(gcylRight);
		jQuery('#gaxisRight').val(gaxisRight);
		jQuery('#addRight').val(addRight);
		jQuery('#pdRight').val(pdRight);
		jQuery('#npcRight').val(npcRight);
		jQuery('#npaRight').val(npaRight);
		jQuery('#prismRight').val(prismRight);
		jQuery('#baseRight').val(baseRight);
		

		jQuery('#gsphLeft').val(gsphLeft);
		jQuery('#gcylLeft').val(gcylLeft);
		jQuery('#gaxisLeft').val(gaxisLeft);
		jQuery('#addLeft').val(addLeft);
		jQuery('#pdLeft').val(pdLeft);
		jQuery('#npcLeft').val(npcLeft);
		jQuery('#npaLeft').val(npaLeft);
		jQuery('#prismLeft').val(prismLeft);
		jQuery('#baseLeft').val(baseLeft);
		
		jQuery('#lsphRight').val(lsphRight);
		jQuery('#lcylRight').val(lcylRight);
		jQuery('#laxisRight').val(laxisRight);
		jQuery('#bcRight').val(bcRight);
		jQuery('#diaRight').val(diaRight);
		
		jQuery('#lsphLeft').val(lsphLeft);
		jQuery('#lcylLeft').val(lcylLeft);
		jQuery('#laxisLeft').val(laxisLeft);
		jQuery('#bcLeft').val(bcLeft);
		jQuery('#diaLeft').val(diaLeft);
		 */
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
			error: function(XMLHttpRequest, textStatus, errorThrown) { 
		        //alert("Status: " + textStatus);
		        //alert("Error: " + errorThrown);
		        
		        var zero = '';
		        jQuery('#gsphRight').val(zero);
				jQuery('#gcylRight').val(zero);
				jQuery('#gaxisRight').val(zero);
				jQuery('#addRight').val(zero);
				jQuery('#pdRight').val(zero);
				jQuery('#npcRight').val(zero);
				jQuery('#npaRight').val(zero);
				jQuery('#prismRight').val(zero);
				jQuery('#baseRight').val(zero);

				jQuery('#gsphLeft').val(zero);
				jQuery('#gcylLeft').val(zero);
				jQuery('#gaxisLeft').val(zero);
				jQuery('#addLeft').val(zero);
				jQuery('#pdLeft').val(zero);
				jQuery('#npcLeft').val(zero);
				jQuery('#npaLeft').val(zero);
				jQuery('#prismLeft').val(zero);
				jQuery('#baseLeft').val(zero);

				jQuery('#lsphRight').val(zero);
				jQuery('#lcylRight').val(zero);
				jQuery('#laxisRight').val(zero);
				jQuery('#bcRight').val(zero);
				jQuery('#diaRight').val(zero);

				jQuery('#lsphLeft').val(zero);
				jQuery('#lcylLeft').val(zero);
				jQuery('#laxisLeft').val(zero);
				jQuery('#bcLeft').val(zero);
				jQuery('#diaLeft').val(zero);
				$('input:radio[name="domEye"]').filter('[value="0"]').attr('checked', true);
		        
		    },   
			success : function(data) {
				jQuery('#gsphRight').val(data.gsphRight);
				jQuery('#gcylRight').val(data.gcylRight);
				jQuery('#gaxisRight').val(data.gaxisRight);
				jQuery('#addRight').val(data.addRight);
				jQuery('#pdRight').val(data.pdRight);
				jQuery('#npcRight').val(data.npcRight);
				jQuery('#npaRight').val(data.npaRight);
				jQuery('#prismRight').val(data.prismRight);
				jQuery('#baseRight').val(data.baseRight);

				jQuery('#gsphLeft').val(data.gsphLeft);
				jQuery('#gcylLeft').val(data.gcylLeft);
				jQuery('#gaxisLeft').val(data.gaxisLeft);
				jQuery('#addLeft').val(data.addLeft);
				jQuery('#pdLeft').val(data.pdLeft);
				jQuery('#npcLeft').val(data.npcLeft);
				jQuery('#npaLeft').val(data.npaLeft);
				jQuery('#prismLeft').val(data.prismLeft);
				jQuery('#baseLeft').val(data.baseLeft);

				jQuery('#lsphRight').val(data.lsphRight);
				jQuery('#lcylRight').val(data.lcylRight);
				jQuery('#laxisRight').val(data.laxisRight);
				jQuery('#bcRight').val(data.bcRight);
				jQuery('#diaRight').val(data.diaRight);

				jQuery('#lsphLeft').val(data.lsphLeft);
				jQuery('#lcylLeft').val(data.lcylLeft);
				jQuery('#laxisLeft').val(data.laxisLeft);
				jQuery('#bcLeft').val(data.bcLeft);
				jQuery('#diaLeft').val(data.diaLeft);
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
	};

	function getVisitList() {
		var url = 'listVisitData.do';

		//javax
		$.ajax({
			url : url,
			type : "post",
			data : "cstmrId=" + '${cstmrId}',
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				jQuery('#visitList').html(data);

			}
		});
	};

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
		$('body').append(form);
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
		
		var dateTile = window.sessionStorage.getItem("dateTile");

		//console.log("dateTile:"+dateTile);
		param = jQuery('#checkForm').serialize()+"&dateTile=" + dateTile;
		
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
					alert('<spring:message code="fail"/> 빈칸을 확인하여 주십시오.');
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

	function resetAllvisit()
	{
		$('.resetAll').val('0');
		$('input:radio[name="domEye"]').filter('[value="0"]').attr('checked', true);
		$('input:radio[name="domEye"]').filter('[value="1"]').attr('checked', false);
		$('input:radio[name="domEye"]').filter('[value="2"]').attr('checked', false);
	}
	
</script>

<style>
	td > input[type="text"]{
		height: 50px;
		width: 65px;
	}
	/* .notUse{
		display: none;
	} */
	/* #resetAll {
		background: url("../images/button/btn_reset.png");
		border: none;
		color: #FFF;
		cursor: hand;
		font-size: 11px;
		width: 30px;
		height: 30px;
		margin: 0px;
		padding: 1px 1px 1px 1px;
	} */

	
	
/* 	label {
	color: transparent;
	background: url('http://rainycafe.com/img/sprite.png') -40px 0  no-repeat;
	border-radius: 14px;
	box-shadow: 0 1px 2px #888, 0 0px 3px #777, inset 0 -1px 5px #333;
	display: block;
	position: relative;
	text-indent: 100%;
	width: 65px; height: 29px;
	-webkit-transition: background-position .3s ease;
	-moz-transition: background-position .3s ease;
	cursor: pointer;
	font-size: .01em;
	float: left;
	left: 30px;
}

input[type=checkbox] {
	display: none;
}

label span {
	background: url('http://rainycafe.com/img/sprite.png') -1px -30px no-repeat;
	border: 0px solid transparent;
	border-radius: 14px;
	box-shadow: 0 1px 3px #000, 0 2px 13px #000;
	content: "";
	display: block;
	position: absolute; top: 0; left: -1px;
	width: 28px; height: 28px;
	-webkit-transition: left .3s ease;
	-moz-transition: left .3s ease;
}

input[type=checkbox]:checked + label {
	background-position: 0 0;
}

input[type=checkbox]:checked + label span {
	left: 40px;
} */



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

   input[type=radio]:checked + label
    {
        background-image : url("/GalleryStaff/images/checkbox_c.png");
        height: 32px;
        width: 32px;
        display:inline-block;
        padding: 0 0 0 0px;
    }
</style>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Eye Check Page</title>
<link rel="stylesheet" href="../css/toggle-switch.css">
</head>

<body onload="changeHashOnLoad(); ">
	
	<center>
	<div id="visitList"></div>
		<form name="checkForm" id="checkForm" method="post" action="">
			<input type="hidden" id="histId" name="histId"></input>
			<input type="hidden" id="cstmrId" name="cstmrId"></input>
			<div class="transBoxTable">
			<table class="staffList" width="800" border="0.5">
				<tr>
					<td height="3" colspan="10"><img
						src="<c:url value="/images/content/Whiteline.jpg" />" width="800"
						height="1" /></td>
				</tr>

				<tr>
					<td height="66" width="100">Glasses</td>
					<td width="65">SPH</td>
					<td width="65">CYL</td>
					<td width="65">AXIS</td>
					<td width="65">PD</td>
					<td width="65">ADD</td>
					<td width="65" class="notUse">PRISM</td>
					<td width="65" class="notUse">BASE</td>
					<td width="65" class="notUse">NPC</td>
					<td width="65" class="notUse">NPA</td>
					<%-- <td width="65"><img src="<c:url value="/images/button/Select_p.png" />" onclick="showOther(); return false;" id="btn1" ></button></td> --%>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td height="66">Right</td>
					<td><input class ='resetAll' type="text"    id="gsphRight" tabindex=1
						name="gsphRight" style="font-size: 17px" onclick ="resetInput(gsphRight);" onchange="format(gsphRight);"></input></td>
					<td><input class ='resetAll' type="text" size="3"   id="gcylRight" tabindex=2
						name="gcylRight" style="font-size: 17px" onclick ="resetInput(gcylRight);" onchange="format(gcylRight)"></input></td>
					<td><input class ='resetAll' type="text" size="3"  tabindex=3
						id="gaxisRight" name="gaxisRight" style="font-size: 17px" onclick ="resetInput(gaxisRight);"> </input></td>
					<td><input class ='resetAll' type="text" size="3" tabindex=4  
						style="font-size: 17px" onclick ="resetInput(pdRight);"
						id="pdRight" name="pdRight" ></input></td>
					<td><input class ='resetAll' type="text" size="3" tabindex=5
								id="addRight" name="addRight" style="font-size: 17px"
								onchange="formatNoSign(addRight)" onclick ="resetInput(addRight);"></input></td>
					
					<td height="66"><input type="text" size="3" tabindex=11 style="font-size: 17px"   class="notUse, resetAll"
						id="prismRight" name="prismRight" onchange="formatNoSign(prismRight)" onclick ="resetInput(prismRight);"></input></td>
					<td height="66"><input type="text" size="3" tabindex=12 style="font-size: 17px"   class="notUse, resetAll"
						id="baseRight" name="baseRight" onchange="formatNoSign(baseRight)" onclick ="resetInput(baseRight);"></input></td>	
					<td height="66"><input type="text" size="3" tabindex=13 style="font-size: 17px"  class="notUse, resetAll"
						id="npcRight" name="npcRight" onchange="formatNoSign(npcRight)" onclick ="resetInput(npcRight);"></input></td>
					<td height="66"><input type="text" size="3" tabindex=14 style="font-size: 17px"  class="notUse, resetAll"
						id="npaRight" name="npaRight" onchange="format(npaRight)" onclick ="resetInput(npaRight);"></input></td>
					
					
				</tr>
				<tr>
					<td height="66">Left</td>
					<td><input class ='resetAll' onclick ="resetInput(gsphLeft);" tabindex=6
						type="text" size="3" style="font-size: 17px"  id="gsphLeft"
						name="gsphLeft" onchange="format(gsphLeft)" ></input></td>
					<td><input class ='resetAll' onclick ="resetInput(gcylLeft);" tabindex=7 type="text" size="3" style="font-size: 17px"  id="gcylLeft"
						name="gcylLeft" onchange="format(gcylLeft)"></input></td>
					<td><input class ='resetAll' onclick ="resetInput(gaxisLeft);" tabindex=8 type="text" size="3" style="font-size: 17px"  id="gaxisLeft"
						name="gaxisLeft"></input></td>
					<td><input class ='resetAll' onclick ="resetInput(pdLeft);" tabindex=9 type="text" size="3" style="font-size: 17px"  id="pdLeft"
						name="pdLeft" ></input></td>
					<td><input class ='resetAll' onclick ="resetInput(addLeft);" tabindex=10 type="text" size="3" style="font-size: 17px"  id="addLeft"
						name="addLeft" onchange="formatNoSign(addLeft)"></input></td>
					
					<td height="66"><input onclick ="resetInput(prismLeft);" tabindex=15 type="text" size="3" style="font-size: 17px"  class="notUse, resetAll"
						id="prismLeft" name="prismLeft" onchange="formatNoSign(prismLeft)"></input></td>
					<td height="66"><input onclick ="resetInput(baseLeft);" tabindex=16 type="text" size="3" style="font-size: 17px"  class="notUse, resetAll"
						id="baseLeft" name="baseLeft" onchange="formatNoSign(baseLeft)"></input></td>	
					<td height="66"><input onclick ="resetInput(npcLeft);" tabindex=17 type="text" size="3" style="font-size: 17px"  class="notUse, resetAll"
						id="npcLeft" name="npcLeft" onchange="formatNoSign(npcLeft)"></input></td>
					<td height="66"><input onclick ="resetInput(npaLeft);" tabindex=18 type="text" size="3" style="font-size: 17px"  class="notUse, resetAll"
						id="npaLeft" name="npaLeft" onchange="format(npaLeft)"></input></td>
					
				</tr>
				<tr>
					<td height="66">C/L</td>
					<td>SPH</td>
					<td>CYL</td>
					<td>AXIS</td>
					<td>B.C</td>
					<td>DIA</td>
					<td colspan="3">우위안</td>
					
					<td height="66">&nbsp;</td>
				</tr>
				<tr>
					<td height="66">Right</td>
					<td><input class ='resetAll' onclick ="resetInput(lsphRight);" tabindex=22 type="text" size="3" style="font-size: 17px"  id="lsphRight"
						name="lsphRight" onchange="format(lsphRight)"></td>
					<td><input class ='resetAll' onclick ="resetInput(lcylRight);" tabindex=23 type="text" size="3" style="font-size: 17px"  id="lcylRight"
						name="lcylRight" onchange="format(lcylRight)"></td>
					<td><input class ='resetAll' onclick ="resetInput(laxisRight);" tabindex=24 type="text" size="3" style="font-size: 17px" 
						id="laxisRight" name="laxisRight"></td>
					<td><input class ='resetAll' onclick ="resetInput(bcRight);" tabindex=25 type="text" size="3" style="font-size: 17px"  id="bcRight"
						name="bcRight"onchange="formatNoSign(bcRight)"></td>
					<td><input class ='resetAll' onclick ="resetInput(diaRight);" tabindex=26 type="text" size="3" style="font-size: 17px"  id="diaRight"
						name="diaRight" onchange="formatNoSign(diaRight)"></td>
						
					<td height="66" colspan="3">
					 우 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 좌 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 없음 </br>
						<input class="dom_eye" tabindex=19 type="radio"  value='1' name="domEye" id="domR">
						&nbsp;&nbsp;
						<input class="dom_eye" tabindex=20 type="radio"  value='2' name="domEye" id="domL">
						&nbsp;&nbsp;
						<input class="dom_eye" tabindex=21 type="radio"  value='0' name="domEye" id="domN">
					</td>
					
					<td height="66">&nbsp;</td>
				</tr>
				<tr>
					<td height="66">Left</td>
					<td><input class ='resetAll' onclick ="resetInput(lsphLeft);" type="text" tabindex=27 size="3" style="font-size: 17px"  id="lsphLeft"
						name="lsphLeft" onchange="format(lsphLeft)"></td>
					<td><input class ='resetAll' onclick ="resetInput(lcylLeft);" type="text" tabindex=28 size="3" style="font-size: 17px"  id="lcylLeft"
						name="lcylLeft" onchange="format(lcylLeft)"></td>
					<td><input class ='resetAll' onclick ="resetInput(laxisLeft);" type="text" tabindex=29 size="3" style="font-size: 17px"  id="laxisLeft"
						name="laxisLeft"></td>
					<td><input class ='resetAll' onclick ="resetInput(bcLeft);" type="text" size="3" tabindex=30 style="font-size: 17px"  id="bcLeft"
						name="bcLeft" onchange="formatNoSign(bcLeft)"></td>
					<td><input class ='resetAll' onclick ="resetInput(diaLeft);" type="text" size="3" tabindex=31 style="font-size: 17px"   id="diaLeft"
						name="diaLeft" onchange="formatNoSign(diaLeft)"></td>
					<td width="50" colspan="2">
							<a href="#" tabindex=32 onclick="fncSaveCheck();return false;">
							<img src="<c:url value="/images/content/save.png" />"
							onmousedown="this.src='<c:url value="/images/content/savepush.png" />'"
							onmouseup="this.src='<c:url value="/images/content/save.png" />'"
							width="66" height="66" />
						</a>
					</td>
					
					<td width="50">
							<!-- <input type="reset" id='resetAll' value="전체삭제" > -->
							<input type="button" onclick='resetAllvisit();' id='resetAll' value="전체삭제" >
							
							<%-- <a href="#" tabindex=32 onclick="resetAll();return false;">
							<img src="<c:url value="/images/content/save.png" />"
							onmousedown="this.src='<c:url value="/images/content/savepush.png" />'"
							onmouseup="this.src='<c:url value="/images/content/save.png" />'"
							width="66" height="66" />
							</a> --%>
					</td>
					
					<td height="66">&nbsp;</td>
					<td height="66">&nbsp;</td>
				</tr>
				<tr>
					<td height="3" colspan="10"><img
						src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
						width="800" height="1" /></td>
				</tr>

			</table>
			</div>

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
		</form>
		
			<br><br>
		
	</center>
</body>
</html>
