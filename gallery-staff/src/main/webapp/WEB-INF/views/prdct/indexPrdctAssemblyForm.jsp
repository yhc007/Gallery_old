<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>

<script>
	var cstmrId = '${cstmrId}';
	var pageUrl='${ctxPath}/prdct/indexPrdctProcessForm.do';
	var pop = window.sessionStorage.getItem("popup");

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
	var initListInformPrdctId = "";
	var initListUnInformPrdctId = "";
	var initListInformPrdctIdNew = "";
	var initListUnInformPrdctIdNew = "";
	function fncInitCheckValue() {
		var inputElements = document.getElementsByTagName('input');
		for ( var i = 0; i < inputElements.length; ++i) {
			if (inputElements[i].className == "assemblyCheckbox"
					&& inputElements[i].checked) {
				initListPrdctId += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "assemblyCheckbox"
					&& inputElements[i].checked == false) {
				initListUnPrdctId += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "assemblyCheckboxNew"
				&& inputElements[i].checked) {
				
				initListPrdctIdNew += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "assemblyCheckboxNew"
					&& inputElements[i].checked == false) {
				initListUnPrdctIdNew += inputElements[i].value + ',';
				
			}
			if (inputElements[i].className == "informCheckbox"
				&& inputElements[i].checked) {
				
				initListInformPrdctId += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "informCheckbox"
					&& inputElements[i].checked == false) {
				initListUnInformPrdctId += inputElements[i].value + ',';
				
			}
			if (inputElements[i].className == "informCheckboxNew"
				&& inputElements[i].checked) {
				
				initListInformPrdctIdNew += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "informCheckboxNew"
					&& inputElements[i].checked == false) {
				initListUnInformPrdctIdNew += inputElements[i].value + ',';
				
			}
			
			
		}
		console.log(initListInformPrdctIdNew);
	
	}
	

	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	 
	 function getSelectedPrdctListData(){
		var url = '${ctxPath}/prdct/listAssembledPrdctData.do';
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: 'cstmrId='+'${cstmrId}'+'&saleId='+'${saleVo.saleId}',
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				
				jQuery('#listAssembledPrdctDiv').html(data);
				/* for (var i=0;i<data.length;i++)
				{ 
					//document.write(cars[i] + "<br>");
					alert();
				} */ 
				
			}
		});  
	}
	
	
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

	function fncSelect(prdctId) {
		var listCheckBox = document.getElementById('listCheckBox');

		var param = jQuery('#checkForm').serialize();

		/* var url='${ctxPath}/prdct/assemblyCheck.do';
		
		
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				if(data=="success"){
					alert("저장 완료.");
					writable=false;
					//getVisitList();
					location.replace("${ctxPath}/check/indexCheckEyesForm.do");
					
				}else if(data=="fail"){
					alert('<spring:message code="fail"/>');
				}				
			}
		});*/
	}
	function fncSave() {
		var url = '${ctxPath}/prdct/updateAssemblyCheck.do';

		var listPrdctId = "";
		var listUnPrdctId = "";
		var listPrdctIdNew = "";
		var listUnPrdctIdNew = "";
		var listInformPrdctId = "";
		var listUnInformPrdctId = "";
		var listInformPrdctIdNew = "";
		var listUnInformPrdctIdNew = "";
		var inputElements = document.getElementsByTagName('input');
		
		for ( var i = 0; i < inputElements.length; ++i) {
			if (inputElements[i].className == "assemblyCheckbox"
					&& inputElements[i].checked) {
				listPrdctId += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "assemblyCheckbox"
					&& inputElements[i].checked == false) {
				listUnPrdctId += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "assemblyCheckboxNew"
					&& inputElements[i].checked) {
				listPrdctIdNew += inputElements[i].value + ',';
			}
			
			if (inputElements[i].className == "assemblyCheckboxNew"
				&& inputElements[i].checked == false) {
					listUnPrdctIdNew += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "informCheckbox"
				&& inputElements[i].checked) {
				listInformPrdctId += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "informCheckbox"
				&& inputElements[i].checked == false) {
				listUnInformPrdctId += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "informCheckboxNew"
				&& inputElements[i].checked) {
				listInformPrdctIdNew += inputElements[i].value + ',';
			}
			if (inputElements[i].className == "informCheckboxNew"
				&& inputElements[i].checked == false) {
				listUnInformPrdctIdNew += inputElements[i].value + ',';
			}
		}
				
		if (initListPrdctId == listPrdctId && initListUnPrdctId == listUnPrdctId
			&& initListPrdctIdNew == listPrdctIdNew && initListUnPrdctIdNew == listUnPrdctIdNew
			&& initListInformPrdctId == listInformPrdctId && initListUnInformPrdctId == listUnInformPrdctId
			&& initListInformPrdctIdNew == listInformPrdctIdNew && initListUnInformPrdctIdNew == listUnInformPrdctIdNew
		)
		{
			alert("변경사항이 없습니다.");
			return;
		}
		
		var dateTile = window.sessionStorage.getItem("dateTile");
		//javax
		$.ajax({
					url : url,
					type : "post",
					data : "listCheckedPrdctId=" + listPrdctId
							+ "&listUnCheckedPrdctId=" + listUnPrdctId
							+ "&listCheckedPrdctIdNew=" + listPrdctIdNew
							+ "&listUnCheckedPrdctIdNew=" + listUnPrdctIdNew
							+ "&listInformPrdctId=" + listInformPrdctId
							+ "&listUnInformPrdctId=" + listUnInformPrdctId
							+ "&listInformPrdctIdNew=" + listInformPrdctIdNew
							+ "&listUnInformPrdctIdNew=" + listUnInformPrdctIdNew
							+ "&dateTile=" + dateTile,
					/* dataType	: "json", */
					dataType : "text",
					success : function(data) {
						if (data == "success") {
							//alert("저장 완료.");
							//writable=false;
							//getVisitList();
							location.replace("${ctxPath}/prdct/indexPrdctAssemblyForm.do");

						} else if (data == "fail") {
							alert('<spring:message code="fail"/>');
						}
					}
				});
		

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
<style>
	#btn1	{
		height: 40px;
	
</style>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Assembly Page</title>

</head>

<body onload="changeHashOnLoad(); ">
<center>

	<div class="transBoxTable">
	    <div id='listAssembledPrdctDiv' >
	    </div>
	    <img onclick="fncSave();return false;" src="<c:url value="/images/content/save.png" />"
		onmousedown="this.src='<c:url value="/images/content/savepush.png" />'"
		onmouseup="this.src='<c:url value="/images/content/save.png" />'" width="72" height="72" />
    </div>
	
	<%-- <div class="btnSave" >
	TEST
		<img onclick="checkSms();return false;" src="<c:url value="/images/content/save.png" />"
		onmousedown="this.src='<c:url value="/images/content/savepush.png" />'"
		onmouseup="this.src='<c:url value="/images/content/save.png" />'" width="72" height="72" />
	TEST
	</div> --%>
<br><br>
		
	<div id = 'tablecstmrIssue'></div>  
 
</center>
</body>
</html>


