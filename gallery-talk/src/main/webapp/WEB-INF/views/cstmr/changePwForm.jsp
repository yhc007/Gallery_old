<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
	});
	
	/*
	 * 밸리데이션 체크
	 */
	 
	function fncCheckValidation(){
		if(changePwForm.cstmrLoginPw.value==""){
			alert('<spring:message code="validation.put" arguments="비밀번호를"/>');
			return false;
		}
		if(changePwForm.cstmrLoginPw2.value==""){
			alert('<spring:message code="validation.put" arguments="비밀번호를"/>');
			return false;
		}
		if(changePwForm.cstmrLoginPw.value.length<6){
			alert('<spring:message code="validation.check.length" arguments="비밀번호,6"/>');
			return false;
		}
		
		if(changePwForm.cstmrLoginPw.value!=changePwForm.cstmrLoginPw2.value){
			alert('<spring:message code="validation.pw.check"/>');
			return false;
		}
		return true;
	}
	
	/*
	 * 고객 데이타 저장.
	 */
	function fncSaveBrandAction(){
		
		if(!fncCheckValidation()){
			return;
		}
		var url;
		var msg;
		var no;
		url = '${ctxPath}/cstmr/updatePwAction.do'; // 수정
		
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#changePwForm').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="success"){
					alert('<spring:message code="success" />');
					
				}else if(data=="fail"){
					alert('<spring:message code="fail" />');
				}
			}
			
		});  
	}
</script> 
<html>
<head>
	<title>Home</title>
</head>
<body>		
		
				<br>
		<form name="changePwForm"  id="changePwForm" method="post" action="">
			
			<input type="hidden" id="cstmrId" name="cstmrId" value=${cstmrId} />
			
			<div width="100%" align="center">
			<table width="50%" border="0">
				<tbody>
				<tr>
					<td colspan="2"><h3>Gallery Member's Password Change Page</h3></td></tr>
				<tr>
					<td style="width:30%" class="header" align="right"><label for="pw1">비밀번호 :</label></th>
					<td style="width:70%">
						<input type="password" id="cstmrLoginPw" name="cstmrLoginPw">
					</td>
				</tr>
				<tr>
					<td style="width:30%" class="header" align="right"><label for="pw2">비밀번호 확인 :</label></th>
					<td style="width:70%">
						<input type="password" id="cstmrLoginPw2" name="cstmrLoginPw2">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button onclick="fncSaveBrandAction();return false;">확인 </button>
					</td>
				</tr>
				</tbody>
			</table>
			</div>
		</form>
</body>
</html>
