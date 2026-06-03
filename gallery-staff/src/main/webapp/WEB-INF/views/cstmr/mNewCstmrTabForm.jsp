<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>

	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		//getMax('${cyear}',1);
		jQuery('#cstmrInfoForm input[name=cstmrName]').val('${cstmrVo.cstmrName}');
		jQuery('#cstmrInfoForm input[name=cstmrId]').val('${cstmrVo.cstmrId}');
		jQuery('#cstmrInfoForm input[id=newDomain]').val("@");
		getCstmrInfo();
	});

	
	function emailChk(domain){
		//console.log(domain)
		var result = "";
		if(domain=="@naver.com"||
			domain=="@nate.com"||
			domain=="@hanmail.net"||
			domain=="@hotmail.com"||
			domain=="@google.com"){
			
			result = "exist";
		}else{
			result = "none";
			
		}
		return result;
	}
	function getCstmrInfo(){
		var param = "cstmrId=" + '${cstmrVo.cstmrId}';
		var url = "${ctxPath}/cstmr/getCstmrInfo.do"
		
		$.ajax({
			url : url,
			dataType : "json",
			data : param,
			type : "post",
			success : function(data){
				//console.log(data);
				var emailId = data.email.substr(0,data.email.lastIndexOf("@"));
				var domain = data.email.substr(data.email.lastIndexOf("@"));
				$('#cstmrInfoForm input[name=emailId]').val(emailId);
				$('#cstmrInfoForm select[name=domain]').val(domain);
				
				var eChk = emailChk(domain);
				if(eChk=="none"){
					$("#domain").css("display","none");
					$("#newDomain").css("display","inline");
					$("#newDomain").val(domain);
					
					newDOMAIN = true;
				}else{
					$("#domain").css("display","inline");
					$("#newDomain").css("display","none");
					$("#domain").val(domain);
					
					newDOMAIN = false;
				}
				//console.log(eChk)
				if(data.birthDay!=null){
					var year = data.birthDay.substr(0,4);
					var month = data.birthDay.substr(5,2);
					var day = data.birthDay.substr(8,2);					
					$('#cstmrInfoForm select[name=byear]').val(year);
					$('#cstmrInfoForm select[name=bmonth]').val(month);
					$('#cstmrInfoForm select[name=bday]').val(day);
				}
				
				
				
				$('#cstmrInfoForm input[name=telephone]').val(data.telephone);
				$('#cstmrInfoForm input[name=cellphone]').val(data.cellphone);
				$('#cstmrInfoForm input[name=email]').val(data.email);
				$('#cstmrInfoForm select[name=sexCd]').val(data.sexCd);
				$('#cstmrInfoForm select[name=birthDayTyCd]').val(data.birthDayTyCd);
				$('#cstmrInfoForm input[name=addr]').val(data.addr);
				$('#cstmrCdBox').text(data.cstmrCd);
			}
		});
	}
	//----------------------
	var mCstmrCd;
	function fncSelectCstmr(cstmrCd){
		mCstmrCd=cstmrCd;
	};
	
	function goIndexForm(){
		location.replace("${ctxPath}/cstmr/indexCstmrForm.do");
	};
	
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
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncListCstmrData(){
		var url = '${ctxPath}/cstmr/listCstmrData.do';			  	
		var param = jQuery('#cstmrSearchForm').serialize();
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){   
				jQuery('#listCstmrBody').html(data);
			}
			
		});
	};
	var mitem='tab1';
	var mbox='box1';
	function tabClick(item,box){
		document.getElementById(mitem).style.display = 'none';
		document.getElementById(mbox).style.backgroundColor  = '#D0D0D0';
		
		document.getElementById(item).style.display = '';
		document.getElementById(box).style.backgroundColor  = '#333';
		mitem=item;
		mbox=box;
	}
	
	
	/*
	 * 밸리데이션 체크
	 */
	 
	function fncCheckValidation(){
		var id;
		var idat=jQuery('#cstmrInfoForm input[name=cstmrLoginIdAt]').val();
		
		if(cstmrInfoForm.cstmrName.value==""){
			alert('<spring:message code="validation.put" arguments="이름을"/>');
			//document.getElementById("resultMsg").innerHTML='<spring:message code="validation.put" arguments="이름을"/>';
			return false;
		}
		
		if((id=cstmrInfoForm.cstmrLoginId.value)==""){
			alert('<spring:message code="validation.put" arguments="ID를"/>');
			//document.getElementById("resultMsg").innerHTML='<spring:message code="validation.put" arguments="ID를"/>';
			tabClick('tab1','box1');
			return false;
		}

		if(id!=idat){
			alert('<spring:message code="id.duple.check.confirm"/>');
			//document.getElementById("resultMsg").innerHTML='<spring:message code="id.duple.check.confirm"/>';
			tabClick('tab1','box1');
			return false;
		}
		
		var pw;
		var pw2;
		if((pw=cstmrInfoForm.cstmrLoginPw.value)==""){
			alert('<spring:message code="validation.put" arguments="비밀번호를"/>');
			//document.getElementById("resultMsg").innerHTML='<spring:message code="validation.put" arguments="비밀번호를"/>';
			tabClick('tab1','box1')
			return false;
		}
		if((pw2=cstmrInfoForm.cstmrLoginPw2.value)==""){
			alert('<spring:message code="validation.put" arguments="비밀번호를"/>');
			//document.getElementById("resultMsg").innerHTML='<spring:message code="validation.put" arguments="비밀번호를"/>';
			tabClick('tab1','box1');
			return false;
		}
		
		if(pw!=pw2){
			alert('<spring:message code="pw.eq.check"/>');
			//document.getElementById("resultMsg").innerHTML='<spring:message code="pw.eq.check"/>';
			tabClick('tab1','box1');
			return false;
		}
		return true;
	}
	
	function fncSelectCstmrId(cstmrId){
		
		var form=document.createElement("form");
		  form.name='tempPost';
		  form.method='post';
		  form.action='${ctxPath}/sale/indexSaleForm.do';  
		  
		  var input=document.createElement("input");
		  input.type="hidden";
		  input.name='cstmrId';
		  input.value= cstmrId;
		  $(form).append(input);
		  		  
		  $('body').append(form); 
		  form.submit();
		  
	};
	/*
	 * 고객 데이타 저장.
	 */
	 
	var newDOMAIN = false;
	
	
	function fncSaveCstmrAction(){
		
		/* if(!fncCheckValidation()){
			return;
		} */
		
		var url;
		var msg;
		var no;
		var emailId = $("#emailId").val();
		var domain = $("#domain").val();
		var newDomain = $("#newDomain").val();
		var email;
		
/* 		console.log("emailId1:"+emailId);
		console.log("domain1:"+domain);
		console.log("newDomain1:"+newDomain);
		console.log("email1:"+email);
 */		if(newDOMAIN){
			/* email = emailId + newDomain; */
			/* email = emailId; */
			email = emailId + newDomain;
		}else{
			email = emailId + domain;	
		}
		/* console.log("emailId2:"+emailId);
		console.log("domain2:"+domain);
		console.log("newDomain2:"+newDomain);
		console.log("email2:"+email); */
		
		//return;
		
		if($('#cstmrInfoForm input[name=cstmrId]').val()!=""){
			url = '${ctxPath}/cstmr/modifyCstmrInfo.do'; // 수정
		}else{
			url = '${ctxPath}/cstmr/mAddCstmrAction.do'; // 추가
		}
		//console.log("email:"+email);
		no = 1;
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#cstmrInfoForm').serialize() + "&email=" + email,
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				parser = data.split(',');
				result = parser[0];
				var cstmrCd = parser[1];
				var cstmrId = parser[2];


				if(result=="success"){
					fncSelectCstmrId(cstmrId,cstmrName);
					/* goIndexForm(); */
				}else if(result=="fail"){
					alert('<spring:message code="fail" />');
					//document.getElementById("resultMsg").innerHTML='<spring:message code="fail" />';
				}else if(data=="successModify"){
					alert("수정 되었습니다.");
					getCstmrInfo();
					$("#newDomain").val("");
					newDOMAIN = false;
					history.back(-1);
				}
			}
		}); 
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
					jQuery('#cstmrInfoForm input[name=cstmrLoginIdAt]').val(jQuery('#cstmrInfoForm input[name=cstmrLoginId]').val());
					alert('<spring:message code="duplecheck.canuse"/>');
				}else if(data=="false"){
					alert('<spring:message code="duplecheck.cannotuse"/>');
				}else if(data=="fail"){
					alert('<spring:message code="dont.active"/>');
				}else{
					
				}
				 
			}
		}); 
		
	}
	
	function enterCheck()
	{
	 if (event.keyCode == 13)
	 {
	  searchGames();
	  return false;
	 }
	 return true;
	}
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
		  $('body').append(form); 
		  form.submit();
	};
	
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
		  $('body').append(form); 
		  form.submit();
	};
	
	function getEmail(){
		var email = $("#domain").val();
		if(email=="-2"){
			$("#domain").css("display","none");
			$("#newDomain").css("display","inline");
			newDOMAIN = true;
		}
	}
	
</script>
<style type="text/css">
.header {
	font-family: "Arial Black", Gadget, sans-serif;
	font-size: 30px;
	text-align: left;
}
.box1 {

	-webkit-border-radius: 7px;
	padding: 10px 45px;
	border-radius: 12px / 20px;
	font-family: "Malgun Gothic";
	background-color: #D0D0D0;

	color: #FFFFFF;
	font-weight: bold;
	font-size: 18px;
	border:0px solid #004B23;
	text-align: center;
}
.box2 {
	-webkit-border-radius: 2px;
	padding: 10px 45px;
	border-radius: 12px / 20px;
	background-color: #333;
	color: #FFFFFF;
	font-weight: bold;
	font-size: 18px;
	border:0px solid #004B23;
	text-align: center;
}

body {
	background-color: #FFF;
	margin-left: 3px;
	margin-top: 10px;
	margin-right: 3px;
	margin-bottom: 10px;
}
body,td,th {
	color: #333;
	font-weight: bold;
	font-size: 18px;
}
#newDomain{
	display: none;
}
</style>
 
<html>
<head>
</head>
<body>
	<div align="center" style="width: 100%">
		<div id="content" style="width: 80%">
			<table width="800" border="0.5">
			<tr>
				<td height="26"
					onclick="staffLogin(${staffVo.staffId});return false;">매장고객</td>
				<td height="26">&nbsp;</td>
				<td height="26">&nbsp;</td>
				<td height="26">&nbsp;</td>
				<td height="26" onclick="fncGoStaffPage(${shopVo.shopId});return false;" >Log-out</td>
			</tr>
			<tr>
				<td height="78" colspan="5">
					<div class="header">
						<spring:message code="main.title"/>
					</div>
				</td>
			</tr>
				<tr>
					<td height="24" colspan="5">&nbsp;</td>
				</tr>
				<tr>
					<td width="199" height="61"><div class="box1">고객 성명</div></td>
					<td width="186"><div class="box1">회원번호</div></td>
					<td width="159"><div class="box1" id="cstmrCdBox">미확정</div></td>
				</tr>
			</table>
			<form name="cstmrInfoForm" id="cstmrInfoForm" method="post" action="" onsubmit="return false;">
				
				<input type="hidden" id="cstmrLoginIdAt" name="cstmrLoginIdAt"/>
				<input type="hidden" id="cstmrId" name="cstmrId">
				<div id="tab1">
					<table style="width: 800" class="cstmrInfo" id="listTable"
						border="0">

						<tbody>
							
							<tr>
								<td height="3" colspan="5"><img
									src="<c:url value="/images/content/GrayLine.jpg" />"
									width="800" height="1" /></td>
							</tr>
							<tr>
								<td align=center  height="66">이름</td>
								<td align=left colspan="2"><input type="tel"  size="15" id="cstmrName" name="cstmrName"  style="height:30"/ value="${cstmr.cstmrName}"></td>
							</tr>
							<tr>
								<td align=center  height="66">전화 번호</td>
								<td align=left colspan="2"><input type="tel"  size="15" id="telephone" name="telephone"  style="height:30"/></td>
								<td align=center >생일</td>
								<td align=left width="200">
									<select id="birthDayTyCd" name="birthDayTyCd" data-role="none">
										<option value="00600001">양력</option>
										<option value="00600002">음력</option>
									</select><br>
									
									<select id="byear" name="byear" onChange="getMax();">
										<option value="0">선택</option>
										<c:forEach var="i" begin="0" end="${cyear}">	
											<option value="${cyear-i+1900}">${cyear-i+1900}</option>
										</c:forEach>
									</select>
									<select id="bmonth" name="bmonth" onChange="getMax();">
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
									<select id="bday" name="bday">
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
								<td align=center  height="66">휴대전화</td>
								<td align=left colspan="2"><input type="tel" size="15" id="cellphone" name="cellphone"  style="height:30"/></td>
								<td align=center  height="66">주소</td>
								<td align=left colspan="2"><input type="tel" size="25" id="addr" name="addr"  style="height:30"/></td>
							</tr>
							<tr>
								<td align=center  width="199" height="69">E-mail</td>
								<td align=left ><input type="email" size="15" id="emailId" name="emailId"  style="height:30"/></td>
								<td align=left ><select id="domain" name="domain" onchange="getEmail();">
																	<option value="">선택</opton>
																  	<option value="@naver.com">@naver.com</opton>
																  	<option value="@nate.com">@nate.com</option>
																  	<option value="@hanmail.net">@hanmail.net</option>
																  	<option value="@hotmail.com">@hotmail.com</option>
																  	<option value="@google.com">@google.com</option>
																  	<option value="-2">직접입력</option>	
																 </select>
													<input type="text" id="newDomain">			 
													</td>
								<td align=center  width="186">성별</td>
								<td align=left width="159"><select id="sexCd" name="sexCd">
																<option value="00400001">남자</option>
																<option value="00400002">여자</option>	
														   </select> </td>
							</tr>
							<tr>
								<td colspan="5">
									<center>
										<%-- <a href="#" onclick="fncSaveCstmrAction();return false;"> <img
											src="<c:url value="/images/content/save.png" />"
											onmousedown="this.src='<c:url value="/images/content/Nextpush.png" />'"
											onmouseup="this.src='<c:url value="/images/content/Next.png" />'"
											width="72" height="72" />
										</a> --%>
										<a href="#" onclick="fncSaveCstmrAction();return false;"> <img
											src="<c:url value="/images/content/save.png" />"
											onmousedown="this.src='<c:url value="/images/content/savepush.png" />'"
											onmouseup="this.src='<c:url value="/images/content/save.png" />'"
											width="72" height="72" />
										</a>
									</center>
								</td>
							</tr>
						</tbody>
					</table>
				</div>


			</form>


			<table>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="5"></td>
				</tr>
				<!-- <tr>
					<td width="199" onclick="tabClick('tab1','box1');return false;"><div class="box2" id="box1">ID/PW</div></td>
					<td colspan="2" onclick="tabClick('tab2','box2');return false;"><div class="box1" id="box2">Address</div></td>
					<td width="186" onclick="tabClick('tab3','box3');return false;"><div class="box1" id="box3">Social</div></td>
					<td width="159" onclick="tabClick('tab4','box4');return false;"><div class="box1" id="box4">Etc.</div></td>
				</tr> -->
				<tr>
					<td>&nbsp;</td>
					<td width="73">&nbsp;</td>
					<td width="167">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
