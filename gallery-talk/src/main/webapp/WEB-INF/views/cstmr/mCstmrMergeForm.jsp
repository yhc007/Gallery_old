<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
	});
	//----------------------
	
	/*
	 * 밸리데이션 체크
	 */
	 
	function fncCheckValidation(){
		var id;
		var idat=jQuery('#cstmrInfoForm input[name=cstmrLoginIdAt]').val();
		if((id=cstmrInfoForm.cstmrLoginId.value)==""){
			alert('<spring:message code="validation.put" arguments="ID를"/>');
			return false;
		}

		if(id!=idat){
			alert('<spring:message code="id.duple.check.confirm"/>');
			return false;
		}
		
		var pw;
		var pw2;
		if((pw=cstmrInfoForm.cstmrLoginPw.value)==""){
			alert('<spring:message code="validation.put" arguments="비밀번호를"/>');
			return false;
		}
		if((pw2=cstmrInfoForm.cstmrLoginPw2.value)==""){
			alert('<spring:message code="validation.put" arguments="비밀번호를"/>');
			return false;
		}
		
		if(cstmrInfoForm.cstmrName.value==""){
			alert('<spring:message code="validation.put" arguments="이름을"/>');
			return false;
		}
		
		
		if(pw!=pw2){
			alert('<spring:message code="pw.eq.check"/>');
			return false;
		}
		return true;
	}
	
	/*
	 * 고객 데이타 저장.
	 */
	function fncSaveCstmrAction(){
		if(!fncCheckValidation()){
			return;
		}
		var url;
		var msg;
		var no;
		url = '${ctxPath}/cstmr/mAddCstmrAction.do'; // 추가
		no = 1;
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#cstmrInfoForm').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="success"){
					document.getElementById("resultMsg").innerHTML='<spring:message code="success" />';
					fncCstmrClear();
				}else if(data=="fail"){
					document.getElementById("resultMsg").innerHTML='<spring:message code="fail" />';
				}
			}
			
		});  
		
	}
	
	function fncCstmrClear(){
		 //jQuery('#listCstmrForm2 input[name=cstmrId]').val('');
		 jQuery('#cstmrInfoForm input[name=cstmrInfo1]').val('');
		 jQuery('#cstmrInfoForm input[name=cstmrInfo2]').val('');
		 
	}
	
	function fncCstmrMerge(){
		if(cstmrInfoForm.cstmrInfo1.value==""){
			document.getElementById("resultMsg").innerHTML='통합할 고객을 선택하세요';
			return false;
		}
		if(cstmrInfoForm.cstmrInfo2.value==""){
			document.getElementById("resultMsg").innerHTML='통합할 고객을 선택하세요';
			return false;
		}
		
		var url;
		url = '${ctxPath}/cstmr/cstmrMergeAction.do'; // 추가
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#cstmrInfoForm').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="success"){
					document.getElementById("resultMsg").innerHTML='<spring:message code="success" />';
					fncCstmrClear();
				}else if(data=="fail"){
					document.getElementById("resultMsg").innerHTML='<spring:message code="fail" />';
				}
			}
			
		});  
	}
	
	function getCstmr(num){
		document.getElementById("resultMsg").innerHTML='';
		jQuery.ajax({  
			url: '${ctxPath}/cstmr/mPopupCstmrForm.do'
			, type: "POST"
			, data: "num="+num
			, dataType: "html"
			, beforeSend: function(xhr){
				
			}
			, success:  function(data) {
				jQuery('#dialog').html(data);
			}	
		});	// end ajax	
		
		jQuery('#dialog').dialog({
			//bgiframe: true
			 title: "고객 조회 팝업"
			 , modal: true
		     , width: 900 // 가로 크기
		     , background: "#000"
			 , close: function(event, ui){
			}, success:  function(data) {
			} 
		});	
	};
	
	 
</script> 
<html>
<head>
	<!-- 
	<meta name="viewport" content="target-densitydpi=low-dpi, width=device-width,initial-scale=1.0" />
	 -->
	<title>Home</title>
</head>
<body>
	<div align="left" style="width:100%">
	<div id="content" style="width:100%">
		<h4>계정 통합 페이지</h4>
		<form name="cstmrInfoForm"  id="cstmrInfoForm" method="post" action="">
			<p style="color:blue;" id="resultMsg"></p> 		
			<table style="width:100%" class="search" id="listTable" border="1">
				<colgroup>
					<col width="25%">
					<col width="75%">
				</colgroup>
				<tbody>
				<tr>
					<th>
						<font size="1">신규 ID</font>
					</th>
					<td>
						<input readonly="true" type="text" size="11" id="cstmrInfo1" name="cstmrInfo1"/>
						<button onclick="getCstmr(1);return false;"><font size="1">조회</font></button>
					</td>
				</tr>
				<tr>
					<th>
						<font size="1">기존 ID</font>
					</th>
					<td>
						<input readonly="true" type="text" size="11" id="cstmrInfo2" name="cstmrInfo2"/>
						<button onclick="getCstmr(2);return false;"><font size="1">조회</font></button>
					</td>
				</tr>
				
				</tbody>
			</table>
			<div align="right">
				<button onClick="fncCstmrMerge();return false"><font size="1">통합</font></button>
			</div>
		</form>
		
	</div>
	</div>
	<div id="dialog"></div>
</body>
</html>
