<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		//fncListBrandData(1);
		getMax('${cyear}',1);
	});
	//----------------------
	
	/*
	 * 밸리데이션 체크
	 */
	 
	function fncCheckValidation(){
		var id;
		var idat=jQuery('#cstmrInfoForm input[name=cstmrLoginIdAt]').val();
		if((id=cstmrInfoForm.cstmrLoginId.value)==""){
			//alert('<spring:message code="validation.put" arguments="ID를"/>');
			document.getElementById("resultMsg").innerHTML='<spring:message code="validation.put" arguments="ID를"/>';
			return false;
		}

		if(id!=idat){
			//alert('<spring:message code="id.duple.check.confirm"/>');
			document.getElementById("resultMsg").innerHTML='<spring:message code="id.duple.check.confirm"/>';
			return false;
		}
		
		var pw;
		var pw2;
		if((pw=cstmrInfoForm.cstmrLoginPw.value)==""){
			///alert('<spring:message code="validation.put" arguments="비밀번호를"/>');
			document.getElementById("resultMsg").innerHTML='<spring:message code="validation.put" arguments="비밀번호를"/>';
			return false;
		}
		if((pw2=cstmrInfoForm.cstmrLoginPw2.value)==""){
			//alert('<spring:message code="validation.put" arguments="비밀번호를"/>');
			document.getElementById("resultMsg").innerHTML='<spring:message code="validation.put" arguments="비밀번호를"/>';
			return false;
		}
		
		if(cstmrInfoForm.cstmrName.value==""){
			//alert('<spring:message code="validation.put" arguments="이름을"/>');
			document.getElementById("resultMsg").innerHTML='<spring:message code="validation.put" arguments="이름을"/>';
			return false;
		}
		
		
		if(pw!=pw2){
			//alert('<spring:message code="pw.eq.check"/>');
			document.getElementById("resultMsg").innerHTML='<spring:message code="pw.eq.check"/>';
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
					//alert('<spring:message code="add.success" />');
					document.getElementById("resultMsg").innerHTML='<spring:message code="add.success" />';
					fncCstmrClear();
				}else if(data=="fail"){
					//alert('<spring:message code="fail" />');
					document.getElementById("resultMsg").innerHTML='<spring:message code="fail" />';
				}
			}
		});  
	}
	
	function fncCstmrClear(){
		 //jQuery('#listCstmrForm2 input[name=cstmrId]').val('');
		 jQuery('#cstmrInfoForm input[name=cstmrLoginId]').val('');
		 jQuery('#cstmrInfoForm input[name=cstmrLoginPw]').val('');
		 jQuery('#cstmrInfoForm input[name=cstmrLoginPw2]').val('');
		 jQuery('#cstmrInfoForm input[name=cstmrName]').val('');
		 jQuery('#cstmrInfoForm input[name=phone1]').val('');
		 jQuery('#cstmrInfoForm input[name=phone2]').val('');
		 jQuery('#cstmrInfoForm input[name=phone3]').val('');
		 jQuery('#cstmrInfoForm input[name=addr]').val('');
		 jQuery('#cstmrInfoForm input[name=email]').val('');
		 
	}
	
	/*
	 * 년 월의 마지막 일 획득
	 */
	function getMax(){
		year= jQuery('#cstmrInfoForm select[name=byear]').val();
		month= jQuery('#cstmrInfoForm select[name=bmonth]').val();
		form= document.getElementById("bday"); //jQuery('#cstmrInfoForm select[name=bday]');
		
		getMaxOfMonth(year,month,form);
	}
	
	/*
	 * 중복 확인
	 */
	function dupleCheck(){
		if(jQuery('#cstmrInfoForm input[name=cstmrLoginId]').val() == ""){
			//alert('<spring:message code="validation.put" arguments="ID를"/>');
			document.getElementById("resultMsg").innerHTML='<spring:message code="validation.put" arguments="ID를"/>';
			return;
		} 
		
		var url = '${ctxPath}/cstmr/idDupleCheck.do';
	  	
		var param = jQuery('#cstmrInfoForm').serialize();
		//javax 
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: param,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				if(data=="true"){
					/*
					ck=confirm('<spring:message code="id.use.confirm"/>');
					if(ck==true){
						jQuery('#cstmrInfoForm input[name=cstmrLoginIdAt]').val(jQuery('#cstmrInfoForm input[name=cstmrLoginId]').val());
						
					}else{
						jQuery('#cstmrInfoForm input[name=cstmrLoginId]').val('');
					}
					*/
					jQuery('#cstmrInfoForm input[name=cstmrLoginIdAt]').val(jQuery('#cstmrInfoForm input[name=cstmrLoginId]').val());
					document.getElementById("resultMsg").innerHTML='사용 가능 합니다.';
				}else if(data=="false"){
					document.getElementById("resultMsg").innerHTML='사용 할 수  없습니다.';
				}else if(data=="fail"){
					document.getElementById("resultMsg").innerHTML='요청하신 동작을  수행하지 못하였습니다.';
				}else{
					
				}
				/*
				if(data == "success"){
					alert('<spring:message code="del.success" />');
					fncBrandDetailClear();
					fncListBrandData();
				}else if(data == "fail"){
					alert('<spring:message code="fail" />');
				}else if(data == "exist"){
					alert('<spring:message code="del.exist" arguments="브랜드,상품이"/>');
				}
				*/
				  //성공시....
				 
			}
		}); 
		
	}
	 
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
		<h4>회원 가입 페이지</h4>
		<form name="cstmrInfoForm"  id="cstmrInfoForm" method="post" action="">
			<p style="color:red;" id="resultMsg"></p> 		
			<input type="hidden" id="cstmrLoginIdAt" name="cstmrLoginIdAt"/>
			<table style="width:100%" class="search" id="listTable" border="1">
				<colgroup>
					<col width="25%">
					<col width="75%">
				</colgroup>
				<tbody>
				<tr>
					<th>
						<font size="1">ID</font>
					</th>
					<td>
						<input type="text" size="11" id="cstmrLoginId" name="cstmrLoginId"/>
						<button onclick="dupleCheck();return false;"><font size="1">중복 확인</font></button>
					</td>
				</tr>
				<tr>
					<th>
						<font size="1">비밀 번호</font>
					</th>
					<td>
						<input type="password" size="13" id="cstmrLoginPw" name="cstmrLoginPw"/>
					</td>
				</tr>
				<tr>
					<th>
						<font size="1">비밀 번호 확인</font>
					</th>
					<td>
						<input type="password" size="13" id="cstmrLoginPw2" name="cstmrLoginPw2"/>
					</td>
				</tr>
				<tr>
					<th>
						<font size="1">이름</font>
					</th>
					<td>
						<input type="text" size="13" id="cstmrName" name="cstmrName"/>
					</td>
				</tr>
				<tr>
					<th>
						<font size="1">생년 월일</font>
					</th>
					<td>
						<select id="byear" name="byear" onChange="getMax();">
							<c:forEach var="i" begin="0" end="${cyear}">	
								<option value="${cyear-i+1900}">${cyear-i+1900}</option>
							</c:forEach>
						</select>
						<select id="bmonth" name="bmonth" onChange="getMax();">
							<c:forEach var="i" begin="1" end="12">	
								<option value="${i}">${i}</option>
							</c:forEach>
						</select>
						<select id="bday" name="bday">
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<font size="1">휴대폰 번호</font>
					</th>
					<td>
						<input type="text" size="1" maxlength="3" id="phone1" name="phone1" onKeypress="numCheck();" style="ime-mode:disabled"/>
						-
						<input type="text" size="2" maxlength="4" id="phone2" name="phone2" onKeypress="numCheck();" style="ime-mode:disabled"/>
						-
						<input type="text" size="2" maxlength="4" id="phone3" name="phone3" onKeypress="numCheck();" style="ime-mode:disabled"/>
					</td>
				</tr>
				<tr>
					<th>
						<font size="1">주소</font>
					</th>
					<td>
						<input type="text" size="13" id="addr" name="addr"/>							
					</td>
				</tr>
				<tr>
					<th>
						<font size="1">이메일</font>
					</th>
					<td>
						<input type="text" size="13" id="email" name="email"/>						
					</td>
				</tr>
				
				</tbody>
			</table>
			<div align="right">
				<button onClick="fncCstmrClear();return false"><font size="1">초기화</font></button>&nbsp;&nbsp;
				<button onClick="fncSaveCstmrAction();return false"><font size="1">저장</font></button>
			</div>
		</form>
		
	</div>
	</div>
</body>
</html>
