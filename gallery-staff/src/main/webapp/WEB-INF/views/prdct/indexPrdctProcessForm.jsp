<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->
<!-- <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script> -->
<script>
	var cstmrId = '${cstmrId}';
	var pageUrl='${ctxPath}/prdct/indexPrdctProcessForm.do';
	var pop = window.sessionStorage.getItem("popup");
	console.log('pop:'+pop);
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		var pop = window.sessionStorage.getItem("popup");
		console.log('pop:'+pop);
		if(pop==1){
			//newWindow();
		}else{
			getSelectedPrdctListData();		
		};

	});
	
	var mCstmrCd;
	function fncSelectCstmr(cstmrCd){
		mCstmrCd=cstmrCd;
	};
	
	function fncGetSaleId(){
		return '${saleVo.saleId}';
	}
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
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
	
	function getSelectedPrdctListData(){
		var url = 'listSelectedPrdctData.do';
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: "cstmrId="+'${cstmrId}'+"&saleId="+'${saleVo.saleId}',
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listSelectedPrdctDiv').html(data);
			}
		});
	}
	
	function getPrdct(){
		jQuery.ajax({
			url: '${ctxPath}/prdct/popupSelectPrdctForm.do'
			, type: "POST"
			, data: null
			, dataType: "html"
			, beforeSend: function(xhr){
				
			}
			, success:  function(data) {
				jQuery('#dialog').html(data);
			}	
		});	// end ajax	
		
		jQuery('#dialog').dialog({
			//bgiframe: true
			 title: "상품 선택"
			 , modal: true
		     , width: 900 // 가로 크기
		     , background: "#000"
		     , position:{my:"center",at:"bottom",of:"#tile" }
			 , close: function(event, ui){
			}, success:  function(data) {
				
			} 
		});	
	};
	
	
	function fncCancelSelect(prdctId, wasDlvry){
		if(wasDlvry==1)
		{
			alert('<spring:message code="prdct.cannot.edit" />');
			return;
		}
		var url = 'removeSalePrdct.do';
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: "prdctId="+prdctId,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				getSelectedPrdctListData();
				/* alert(${saleVo.result}); */
				location.replace(pageUrl);
			}
		}); 
	}

	
	function fncIncCnt(prdctId, prdctCnt, prc, wasDelivery){
		if(wasDelivery==1)
		{
			alert('<spring:message code="prdct.cannot.edit" />');
			return;
		}
		var url = 'incCntSalePrdct.do';
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: "prdctId="+prdctId+"&prdctCnt="+prdctCnt+"&prc="+prc,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				getSelectedPrdctListData();
				location.replace(pageUrl);
			}
		}); 
	}
	function fncDecCnt(prdctId, prdctCnt, prc, wasDelivery){
		if(wasDelivery==1)
		{
			alert('<spring:message code="prdct.cannot.edit" />');
			return;
		}
		if(prdctCnt<2)
		{return;}
		
		var url = 'decCntSalePrdct.do';
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: "prdctId="+prdctId+"&prdctCnt="+prdctCnt+"&prc="+prc,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				getSelectedPrdctListData();
				location.replace(pageUrl);
			}
		}); 
	}
	
	function fncCancelSelectNew(prdctId, wasDlvry){
		if(wasDlvry==1)
		{
			alert('<spring:message code="prdct.cannot.edit" />');
			return;
		}
		//alert('prdctId:'+prdctId);
		var url = 'removeNewSalePrdct.do';
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: "prdctId="+prdctId,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				getSelectedPrdctListData();
				/* alert(${saleVo.result}); */
				location.replace(pageUrl);
			}
		}); 
	}
	
	function fncIncCntNew(prdctId, prdctCnt, prc, wasDelivery){
		if(wasDelivery==1)
		{
			alert('<spring:message code="prdct.cannot.edit" />');
			return;
		}
		var url = 'incCntSalePrdctNew.do';
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: "prdctId="+prdctId+"&prdctCnt="+prdctCnt+"&prc="+prc,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				getSelectedPrdctListData();
				location.replace(pageUrl);
			}
		}); 
	}
	function fncDecCntNew(prdctId, prdctCnt, prc, wasDelivery){
		if(wasDelivery==1)
		{
			alert('<spring:message code="prdct.cannot.edit" />');
			return;
		}
		if(prdctCnt<2)
		{return;}
		
		var url = 'decCntSalePrdctNew.do';
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: "prdctId="+prdctId+"&prdctCnt="+prdctCnt+"&prc="+prc,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				getSelectedPrdctListData();
				location.replace(pageUrl);
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


<head>
<title>Select Page.</title>
<style>
/* 	#dialog{ 
		background-image: url("/GalleryStaff/images/content/bg_base2.jpeg");
		background-size : 100% 100%;
	} */
	
	#cstmrHist{
		display: none;
	}
</style>
</head>

<body onload="changeHashOnLoad(); ">

<center>

	<div class="transBoxTable">
		<div id="listSelectedPrdctDiv"></div> 
	</div>
  
   <div id = 'tableCstmrIssue'></div>
   
</center>

	<%-- <div class="btnSave" > 
		<a  href="#" onclick="return false;"> <img
			src="<c:url value="/images/content/save.png" />"
			onmousedown="this.src='<c:url value="/images/content/savepush.png" />'"
			onmouseup="this.src='<c:url value="/images/content/save.png" />'"
			width="72" height="72" />
	  	</a>
	</div> --%>
	<br><br>
		

<div id="dialog"> 
</div>

<div id="cstmrHist">
</div>
</body>
</html>

