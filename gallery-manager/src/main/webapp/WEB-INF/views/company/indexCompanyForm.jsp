<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
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
			$("#listCompanyForm2 input[id='cName']").foucs();
			return;
		}
		return true;
	}
	
	/*
	 * 고객 데이타 저장.
	 */
	function addComTy(iNum){
		var url = "${ctxPath}/company/addCompanyTy.do";
		
		$("input:checkbox[name='cTy']:checked").each(function(){
			var param = "iNum=" + iNum + 
							"&cType=" + $(this).val();

			$.ajax({
				url : url,
				data : param,
				dataTy : "text",
				type : "post",
				success : function(data){
					
				}
			});
		});	
	}
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
			addComTy(jQuery('#listCompanyForm2 input[name=iNum]').val());
		}
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#listCompanyForm2').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(item){
				var data = item.split("/");
				if(data[0]=="duple"){
					alert('<spring:message code="add.duple" arguments="업체"/>');
					$("#listCompanyForm2 input[id='cName']").foucs();
					return;
				}else if(data[0]=="addsuccess"){
					addComTy(data[1]);
					alert('<spring:message code="add.success" />');				
				}else if(data[0]=="fail"){
					alert('<spring:message code="fail" />');
					return;
				}else if(data[0]=="upsuccess"){
					alert('<spring:message code="update.success" />');				
				}else if(data[0]=="idDuple"){
					alert("동일한 아이디가 존재합니다");
					$("#listCompanyForm2 input[id='id']").foucs();
					return;
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
		 
		console.log(jQuery('#listCompanyForm2').serialize())
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
		 jQuery('#listCompanyForm2 input[name=addr]').val('');
		 jQuery('#listCompanyForm2 input[name=type]').val('');
		 jQuery('#listCompanyForm2 input[name=email]').val('');
		 jQuery('#listCompanyForm2 input[name=id]').val('');
		 jQuery('#listCompanyForm2 input[name=pwd]').val('');
		 jQuery('#listCompanyForm2 input[name=no]').val('');
		 jQuery('#listCompanyForm2 input[name=brand]').val('');
		 jQuery('#listCompanyForm2 input[name=memo]').val('');
		 $("input:checkbox[name='cTy']").prop("checked", false);
	}
	

	/*
	 * 신규시 
	 */
	function fncNewCompany(){
		
		fncCompanyDetailClear();
		
	}
	
	function getComTy(iNum){
		var url = "${ctxPath}/company/getComTy.do";
		
		var param = "iNum=" + iNum;
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				var item = data.split(",");
				
				$("input:checkbox[name='cTy']").prop("checked", false);
				var ty;
				for(var i = 0; i < item.length; i++){
					if(item[i]=="F"){
						ty = 1;
					}else if(item[i]=="L"){
						ty = 2;
					}else if(item[i]=="C"){
						ty = 3;
					}else if(item[i]=="A"){
						ty = 4;
					}else if(item[i]=="E"){
						ty = 5;
					}
					
					$("input:checkbox[id='comTy" + ty + "']").prop("checked", true);
				}
			}
		});
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
					getComTy(iNum);
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
		 			jQuery('#listCompanyForm2 input[name=email]').val(data.email);
		 			jQuery('#listCompanyForm2 input[name=addr]').val(data.addr);
		 			jQuery('#listCompanyForm2 input[name=no]').val(data.no);
		 			jQuery('#listCompanyForm2 input[name=brand]').val(data.brand);
		 			jQuery('#listCompanyForm2 input[name=pwd]').val(data.pwd);
		 			jQuery('#listCompanyForm2 input[name=id]').val(data.id);
		 			jQuery('#listCompanyForm2 input[name=type]').val(data.type);
		 		
		 			jQuery('#listCompanyForm2 select[name=cState]').val(data.cstate);
					
					  
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
								<option value="F">프레임</option>
								<option value="L">안경렌즈</option>
								<option value="C">콘텍트렌즈</option>
								<option value="A">렌즈용액</option>
								<option value="E">기타</option>
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
						<th style="width:10%"><label for="">담당자 연락처</label></th>
						<td style="width:10%">
							<input type="text" id='pNum2' name='pNum2'>
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input type="text" id="pNum1" name="pNum1">
						</td>
						
						<th>주소</th>
						<td>
							<input type="text" id="addr" name="addr">
						</td>
						<th>업태</th>
						<td>
							<input type="text" id="type" name="type">
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type="text" id="email" name="email"> </td>
						<th>아이디</th>
						<td><input type="text" id="id" name="id"> </td>
						<th>비밀번호</th>
						<td><input type="text" id="pwd" name="pwd"> </td>
					</tr>
					<tr>
						<th style="width:10%"><label for="">사업자 등록번호</label></th>
							<td style="width:10%">
								<input type="text" id='no' name='no'>
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
								<!-- <select name="cType" id="cType">
									<option value="-1">선택</option>
									<option value="F">프레임</option>
									<option value="L">안경렌즈</option>
									<option value="C">콘텍트렌즈</option>
									<option value="A">렌즈 용액</option>
									<option value="E">기타</option>
								</select> -->
								<label for="comTy1">프레임</label><input type="checkbox" id="comTy1" name="cTy" value="F">
								<label for="comTy2">렌즈</label><input type="checkbox" id="comTy2" name="cTy" value="L"><br>
								<label for="comTy3">콘텍트 렌즈</label><input type="checkbox" id="comTy3" name="cTy" value="C"><br>
								<label for="comTy4">렌즈용액</label><input type="checkbox" id="comTy4" name="cTy" value="A">
								<label for="comTy5">기타</label><input type="checkbox" id="comTy5" name="cTy" value="E">
						</td>
					</tr>
					<tr>
						<th>취급물품</th>
						<td><input type="text" id="brand" name="brand"> </td>
						<th>
						<td></td>
						<th>
						<td></td>
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
