<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	var shopId = "${shopId}";
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		fncListCompanyData(1);
		if(shopId != "777"){
			$("#detail").css("display","none");
		}
	});
	
	
	//----------------------
	
	/*
	 * 업체 데이타 리스트 보드 페이징
	 */
	  
	function fncListCompanyData(no,ty){
		console.log(ty)
		var url = 'listCompanyData.do';
		if(no){
			jQuery('#listCompanyForm1 input[name=currentPage]').val(no);
		}
		var param;
		if(typeof(ty)=="undefined"){
			param = jQuery('#listCompanyForm1').serialize();
		}else{
			param = jQuery('#listCompanyForm1').serialize() + "&cType=" + ty;				
		}
		
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listCompanyDiv').html(data);
			}
			
		});  
		 fncCompanyDetailClear();
	}
	
	
	
	/*
	 * 밸리데이션 체크
	 */
	 
	function fncCheckValidation(){
		if(listCompanyForm2.cName.value==""){
			alert('<spring:message code="validation.put" arguments="업체명을"/>');
			return false;
		}
		return true;
	}
	
	/*
	 * 고객 데이타 저장.
	 */
	function fncSaveCompanyAction(){
		if(!fncCheckValidation()){
			return;
		}
		var url;
		var msg;
		var no;
		
		if(jQuery('#listCompanyForm2 input[name=iNum]').val() == ""){
			url = '${ctxPath}/company/addCompanyAction.do'; // 추가
			no = 1;
		} else{
			url = '${ctxPath}/company/modifyCompanyAction.do'; // 수정
			no = jQuery('#listCstmrForm1 input[name=currentPage]').val();
		}
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#listCompanyForm2').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="duple"){
					alert('<spring:message code="add.duple" arguments="업체"/>');
				}else if(data=="addsuccess"){
					alert('<spring:message code="add.success" />');				
				}else if(data=="fail"){
					alert('<spring:message code="fail" />');
				}else if(data=="upsuccess"){
					alert('<spring:message code="update.success" />');				
				}
				  //성공시....
				fncCompanyDetailClear();
				fncListCompanyData(1);
			}
			
		});  
		
	}
	
	//삭제
	function fncDelCompany(){
		if(!confirm('<spring:message code="del.confirm" />')){
			return;
		}
		if(jQuery('#listCompanyForm2 input[name=iNum]').val() == ""){
			return;
		} 
				
		var url = '${ctxPath}/company/removeCompanyAction.do';
		  	
		var param = jQuery('#listCompanyForm2').serialize();
		 
		//javax 
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: param,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				if(data == "success"){
					alert('<spring:message code="del.success" />');
					fncCompanyDetailClear();
					fncListCompanyData();
				}else if(data == "fail"){
					alert('<spring:message code="fail" />');
				}else if(data == "exist"){
					alert('<spring:message code="del.exist" arguments="브랜드,상품이"/>');
				}
				
				  //성공시....
				 
			}
			
		}); 
		
	}
	 
	
	
	/*
	 * html 클리어
	 */
	function fncCompanyDetailClear(){
		 jQuery('#listCompanyForm2 input[name=iNum]').val('');
		 jQuery('#listCompanyForm2 input[name=cName]').val('');
		 jQuery('#listCompanyForm2 TEXTAREA[name=cMemo]').val('');
		 jQuery('#listCompanyForm2 input[name=eName]').val('');
		 jQuery('#listCompanyForm2 input[name=pNum1]').val('');
		 jQuery('#listCompanyForm2 input[name=pNum2]').val('');
		 jQuery('#listCompanyForm2 select[name=cType]').val('-1');
		 jQuery('#listCompanyForm2 select[name=cState]').val('-1');
		 
	}
	

	/*
	 * 신규시 
	 */
	function fncNewCompany(){
		
		fncCompanyDetailClear();
		
	}
	
	/*
	 * 고객 상세 
	 */
	function fncGetCompanyInfo(iNum){
		 var url = '${ctxPath}/company/getCompanyData.do';
		 
		 jQuery.ajax({
				url: url,
				type : "post",
				data : "iNum=" + iNum,
				dataType	: "json",
				beforeSend	: function(){
				},
				success		: function(data){
					console.log(data)
					 //clear 
					 fncCompanyDetailClear();
					 //-----------------------------
					 //-----------------------------
					 var viewForm = jQuery('#listCompanyForm2');
					 
					 //viewForm.deserialize(data);
					 jQuery('#listCompanyForm2 input[name=iNum]').val(data.inum);
		 			 jQuery('#listCompanyForm2 input[name=cName]').val(data.cname);
		 			 jQuery('#listCompanyForm2 TEXTAREA[name=cMemo]').val(data.cmemo);
		 			jQuery('#listCompanyForm2 input[name=eName]').val(data.ename);
		 			jQuery('#listCompanyForm2 input[name=pNum1]').val(data.pnum1);
		 			jQuery('#listCompanyForm2 input[name=pNum2]').val(data.pnum2);
		 			var type;
		 			if(data.ctype=="C"){
		 				type = "C";
		 			}else if(data.ctype=="G"){
		 				type = "G";
		 			}else if(data.ctype=="L"){
		 				type = "L";
		 			}else if(data.ctype=="P"){
		 				type = "P";
		 			}
		 			jQuery('#listCompanyForm2 select[name=cType]').val(type);
		 			jQuery('#listCompanyForm2 select[name=cState]').val(data.cstate);
					console.log(data.ctype);
					
					  
				}
				
			});  
	}
</script> 
<html>
<head>
	<title>Home</title>
</head>
<body>
	<div id="content">
					
		<form name="listCompanyForm1"  id="listCompanyForm1" method="post" action="">
			
			<input type="hidden" name="currentPage" value="1"/>
			<input type="hidden" name="pageSize" value="5"/>
			
			
				<table width="100%" class="search" id="listTable" border="1">
					<tbody>
					<tr id="listTr" >
						<th style="width:10%" class="header"><label for="searchName">업체 명</label></th>
						<td style="width:10%">
							<input type="text" id="cName" name="cName" width="100%">
							
						</td>
						
						<th style="width:10%" class="header"><label for="cType">종류</label></th>
						<td style="width:50%">
							<select id="cType" name="cType">
								<option value="all">전체</option>
								<option value="G">안경</option>
								<option value="L">안경렌즈</option>
								<option value="C">콘텍트렌즈</option>
								<option value="P">기획사</option>
							</select>
							<button onclick="fncListCompanyData('1');return false;">조회</button>
						</td>
						
					</tr>
					</tbody>
				</table>

			</form>
		<div id="listCompanyDiv"> 
				</div>
				
		<div id="detail">
			<!-- <button onclick="javascript:fncListCompanyData(1,'G')">안경</button><button onclick="javascript:fncListCompanyData(1,'L')">안경렌즈</button><button onclick="javascript:fncListCompanyData(1,'C')">콘텍트렌즈</button><button onclick="javascript:fncListCompanyData(1,'P')">기획사</button> -->
		<form name="listCompanyForm2"  id="listCompanyForm2" method="post" action="">
				<input type="hidden" id='iNum' name='iNum'>
				
				
				<table>
				<tr>
				<td>
					<img src="<c:url value="/images/content/dot.png"/>" /> 
				</td>
				<td>
					<p>업체 정보</p>
				</td>
				</tr>
				</table>
				<table width="100%" border="1" class="detail"> 
					<br>
					<tbody>
					<tr>
						<th style="width:10%"><label for="">업체 명</label></th>
						<td style="width:10%">
							<input type="text" id='cName' name='cName' >
						</td>
						<th style="width:10%"><label for="">담당자</label></th>
						<td style="width:10%">
							<input type="text" id='eName' name='eName' >
						</td>
						<th style="width:10%"><label for="">연락처</label></th>
						<td style="width:10%">
							<input type="text" id='pNum1' name='pNum1'>
						</td>
					</tr>
					<tr>
						<th style="width:10%"><label for="">담당자 연락처</label></th>
							<td style="width:10%">
								<input type="text" id='pNum2' name='pNum2'>
							</td>
							<th style="width:10%" ><label for="">상태</label></th>
							<td style="width:10%">
								<select name="cState" id="cState">
									<option value="-1">선택</option>
									<option value="Y">거래</option>
									<option value="N">중지</option>
								</select>
						</td>
						<th style="width:10%" ><label for="">분류</label></th>
							<td style="width:10%">
								<select name="cType" id="cType">
									<option value="-1">선택</option>
									<option value="G">안경</option>
									<option value="L">안경렌즈</option>
									<option value="C">콘텍트렌즈</option>
									<option value="P">기획사</option>
								</select>
						</td>
					</tr>
					<tr>
						<th><label for="">비고</label></th>
						<td colspan="5"><TEXTAREA  id="cMemo" name="cMemo" ROWS="5" style="width:100%"></TEXTAREA></td>
					</tr>
					</tbody>
				</table>

				
				
				<div id="btn_sctn" align="right">
					<button onclick="fncNewCompany();return false;">신 규</button>
					<button onclick="fncSaveCompanyAction();return false;">저 장</button>
					<button onclick="fncDelCompany();return false;">삭 제</button>
				</div>
				
		</form>
	</div>
	</div>
</body>
</html>
