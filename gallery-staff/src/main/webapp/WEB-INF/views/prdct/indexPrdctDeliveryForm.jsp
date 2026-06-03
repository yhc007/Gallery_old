<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script>

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
			getSelectedPrdctListData();
		};

	});
	
	
	//----------------------
	var mCstmrCd;
	function fncSelectCstmr(cstmrCd){
		mCstmrCd=cstmrCd;
	};
	function fncCancel(){
		jQuery('#dialog').dialog( 'close' );
		jQuery('#dialog').html('');
		/*
		jQuery('#dialog').dialog( 'close' );
		jQuery('#dialog').html('');
		*/
	};
	
	var initListPrdctId="";
	var initListUnPrdctId="";
	var initListPrdctIdNew="";
	var initListUnPrdctIdNew="";
	
	function fncInitCheckValue() {
		var inputElements = document.getElementsByTagName('input');
		for ( var i = 0; i < inputElements.length; ++i) {
			if (inputElements[i].className == "dlvryCheckbox"
					&& inputElements[i].checked) {
				initListPrdctId += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "dlvryCheckbox"
					&& inputElements[i].checked == false) {
				initListUnPrdctId += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "dlvryCheckboxNew"
				&& inputElements[i].checked) {
				initListPrdctIdNew += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "dlvryCheckboxNew"
					&& inputElements[i].checked == false) {
				initListUnPrdctIdNew += inputElements[i].value + ',';
			}
		}
	}
	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	 
	 function getSelectedPrdctListData(){
		var url = '${ctxPath}/prdct/listDeliveredPrdctData.do';
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: 'cstmrId='+'${cstmrId}'+'&saleId='+'${saleVo.saleId}',
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listDeliveredPrdctDiv').html(data);
			}
		});  
	}
	
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
	
	function fncSave(){
		if (initListPrdctId == listPrdctId && initListUnPrdctId == listUnPrdctId
			&& initListPrdctIdNew == listPrdctIdNew && initListUnPrdctIdNew == listUnPrdctIdNew
				)
		{	alert("변경사항이 없습니다."); 	return;	}
		
		var url = '${ctxPath}/prdct/updateDeliveryCheck.do';
		var listPrdctId="";
		var listUnPrdctId="";
		var listPrdctIdNew="";
		var listUnPrdctIdNew="";
		var inputElements = document.getElementsByTagName('input');
		
		for ( var i = 0; i < inputElements.length; ++i) {
			if (inputElements[i].className == "dlvryCheckbox"
					&& inputElements[i].checked) {
				listPrdctId += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "dlvryCheckbox"
					&& inputElements[i].checked == false) {
				listUnPrdctId += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "dlvryCheckboxNew"
				&& inputElements[i].checked) {
				listPrdctIdNew += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "dlvryCheckboxNew"
					&& inputElements[i].checked == false) {
				listUnPrdctIdNew += inputElements[i].value + ',';
			}
		}
		
		var dateTile = window.sessionStorage.getItem("dateTile");
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data : "listCheckedPrdctId=" + listPrdctId
			+ "&listUnCheckedPrdctId=" + listUnPrdctId
			+ "&listCheckedPrdctIdNew=" + listPrdctIdNew
			+ "&listUnCheckedPrdctIdNew=" + listUnPrdctIdNew
			+ "&dateTile" + dateTile
			,

			/* dataType	: "json", */
			dataType	: "text",
			success: function(data){
				if(data=="success"){
					alert("저장 완료.");
					//writable=false;
					//getVisitList();
					location.replace("${ctxPath}/prdct/indexPrdctDeliveryForm.do");
					
				}else if(data=="fail"){
					alert('<spring:message code="fail"/>');
				}				
			}
		});
		
}
	
	function goPrint()
	{
		location.href="${ctxPath}/prdct/indexPrdctProcessFormPrint.do";
		//location.href="http://ilmol.com/wp/wp-content/uploads/html5.pdf";
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
<title>Delivery Page</title>
<style>
	
</style>
</head>

<body onload="changeHashOnLoad(); ">
<center>

	<div class="transBoxTable">
	    <div id='listDeliveredPrdctDiv' >
	    </div>
	      <img onclick="fncSave();return false;" src="<c:url value="/images/content/save.png" />"
		onmousedown="this.src='<c:url value="/images/content/savepush.png" />'"
		onmouseup="this.src='<c:url value="/images/content/save.png" />'" width="72" height="72" />
    </div>
 </div>
		
<div id = 'tableCstmrIssue'></div>
</center>
</body>
</html>

