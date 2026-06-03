<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		getMax('${cyear}',1);
		jQuery('#cstmrInfoForm input[name=cstmrName]').val('${cstmr.cstmrName}');
	});
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
		  		  
		  $('#body').append(form); 
		  form.submit();
		  
	};
	/*
	 * 고객 데이타 저장.
	 */
	function fncSaveCstmrAction(){
		
		/* if(!fncCheckValidation()){
			return;
		} */
		
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
		  $('#body').append(form); 
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
		  $('#body').append(form); 
		  form.submit();
	};
	
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
					<td colspan="2"><div class="box1">${cstmr.cstmrName}</div></td>
					<td width="186"><div class="box1">회원번호</div></td>
					<td width="159"><div class="box1">미확정</div></td>
				</tr>
			</table>
			
			<form name="cstmrInfoForm" id="cstmrInfoForm" method="post" action="" onsubmit="return false;">
				<input type="hidden" id="cstmrName" name="cstmrName" value="${cstmr.cstmrName}">
				<input type="hidden" id="cstmrLoginIdAt" name="cstmrLoginIdAt"/>
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
								<td align=center width="199" height="63">아이디</td>
								<td align=left colspan="2"><input type="text" id="cstmrLoginId" name="cstmrLoginId" style="height:30" /></td>
								<td align=center width="186"><input type="button" onclick="dupleCheck();return false;" value="중복 확인" /></td>
								<td align=left width="159">&nbsp;</td>
							</tr>
							<tr>
								<td height="3" colspan="5"><img
									src="<c:url value="/images/content/GrayLine.jpg" />"
									width="800" height="1" /></td>
							</tr>
							<tr>
								<td align=center height="66">패스워드</td>
								<td align=left colspan="2"><input type="password" id="cstmrLoginPw" name="cstmrLoginPw" style="height:30" /></td>
								<td align=center colspan="2">고객님 직접 입력 바랍니다.</td>
							</tr>
							<tr>
								<td height="3" colspan="5"><img
									src="<c:url value="/images/content/GrayLine.jpg" />"
									width="800" height="1" /></td>
							</tr>
							<tr>
								<td align=center height="69">패스워드 확인</td>
								<td align=left colspan="2"><input type="password" id="cstmrLoginPw2" name="cstmrLoginPw2" style="height:30" /></td>
								<td align=center >&nbsp;</td>
								<td align=center >&nbsp;</td>
							</tr>
							<tr>
								<td colspan="5">
									<center>
										<a href="#" onclick="tabClick('tab2','box2');return false;"> <img
											src="<c:url value="/images/content/Next.png" />"
											onmousedown="this.src='<c:url value="/images/content/Nextpush.png" />'"
											onmouseup="this.src='<c:url value="/images/content/Next.png" />'"
											width="72" height="72" />
										</a>
									</center>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="tab2" style="display: none">
					<table style="width: 800" class="cstmrInfo" id="listTable"
						border="1">

						<tbody>
							<tr>
								<td height="3" colspan="5"><img
									src="<c:url value="/images/content/GrayLine.jpg" />"
									width="800" height="1" /></td>
							</tr>
							<tr>
								<td align=center  height="63">주소</td>
								<td align=left width="601" colspan="4" ><input id="addr" size="50" name="addr"  style="height:30"/></td>
							</tr>
							<tr>
								<td height="3" colspan="5"><img
									src="<c:url value="/images/content/GrayLine.jpg" />"
									width="800" height="1" /></td>
							</tr>
							<tr>
								<td align=center  height="66">전화 번호</td>
								<td align=left colspan="2"><input size="15" id="cellphone" name="cellphone"  style="height:30"/></td>
								<td align=center >생일</td>
								<td align=left>
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
								<td height="3" colspan="5"><img
									src="<c:url value="/images/content/GrayLine.jpg" />"
									width="800" height="1" /></td>
							</tr>
							<tr>
								<td align=center  width="199" height="69">E-mail</td>
								<td align=left colspan="2"><input size="15" id="email" name="email"  style="height:30"/></td>
								<td align=center  width="186">성별</td>
								<td align=left width="159"><input size="15" id="sexCd" name="sexCd"  style="height:30"/></td>
							</tr>
							<tr>
								<td colspan="5">
									<center>
										<a href="#" onclick="tabClick('tab3','box3');return false;"> <img
											src="<c:url value="/images/content/Next.png" />"
											onmousedown="this.src='<c:url value="/images/content/Nextpush.png" />'"
											onmouseup="this.src='<c:url value="/images/content/Next.png" />'"
											width="72" height="72" />
										</a>
									</center>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="tab3" style="display: none">
					<table style="width: 800" class="cstmrInfo" id="listTable"
						border="1">

						<tbody>
							<tr>
								<td height="3" colspan="5"><img
									src="<c:url value="/images/content/GrayLine.jpg" />"
									width="800" height="1" /></td>
							</tr>
							<tr>
								<td align=center  height="63">Facebook</td>
								<td align=left colspan="4"><input size="40" id="facebook" name="facebook"  style="height:30"/></td>
							</tr>
							<tr>
								<td height="3" colspan="5"><img
									src="<c:url value="/images/content/GrayLine.jpg" />"
									width="800" height="1" /></td>
							</tr>
							<tr>
								<td align=center  height="66">Twitter</td>
								<td align=left colspan="4"><input size="40" id="twitter" name="twitter"  style="height:30"/></td>
							</tr>
							<tr>
								<td height="3" colspan="5"><img
									src="<c:url value="/images/content/GrayLine.jpg" />"
									width="800" height="1" /></td>
							</tr>
							<tr>
								<td align=center  width="199" height="69">Instagram</td>
								<td align=left colspan="4"><input size="40" id="instagram" name="instagram"  style="height:30"/></td>
							</tr>
							<tr>
								<td colspan="5">
									<center>
										<a href="#" onclick="tabClick('tab4','box4');return false;"> <img
											src="<c:url value="/images/content/Next.png" />"
											onmousedown="this.src='<c:url value="/images/content/Nextpush.png" />'"
											onmouseup="this.src='<c:url value="/images/content/Next.png" />'"
											width="72" height="72" />
										</a>
									</center>
								</td>
							</tr>

						</tbody>
					</table>
				</div>
				<div id="tab4" style="display: none">
					<table style="width: 800" class="cstmrInfo" id="listTable"
						border="1">

						<tbody>
							<tr>
								<td align=center  height="3" colspan="5"><img src="<c:url value="/images/content/GrayLine.jpg" />"
									width="800" height="1" /></td>
							</tr>
							<tr>
								<td align=center height="63">기타 사항</td>
								<td align=left colspan="4"><input size="40"  id="bigo" name="bigo"  style="height:30"/></td>
							</tr>
							<tr>
								<td height="3" colspan="5"><img src="<c:url value="/images/content/GrayLine.jpg" />"
									width="800" height="1" /></td>
							</tr>
							<tr>
								<td height="66">&nbsp;</td>
								<td colspan="2">&nbsp;</td>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td height="3" colspan="5"><img src="<c:url value="/images/content/GrayLine.jpg" />"
									width="800" height="1" /></td>
							</tr>
							<tr>
								<td width="199" height="69">&nbsp;</td>
								<td colspan="2">&nbsp;</td>
								<td width="186">&nbsp;</td>
								<td width="159">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="5">
									<center>
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
				<div id="tab5" style="display: none">e</div>


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
				<tr>
					<td width="199" onclick="tabClick('tab1','box1');return false;"><div class="box2" id="box1">ID/PW</div></td>
					<td colspan="2" onclick="tabClick('tab2','box2');return false;"><div class="box1" id="box2">Address</div></td>
					<td width="186" onclick="tabClick('tab3','box3');return false;"><div class="box1" id="box3">Social</div></td>
					<td width="159" onclick="tabClick('tab4','box4');return false;"><div class="box1" id="box4">Etc.</div></td>
				</tr>
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
