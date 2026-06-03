<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		fncListPrdctRemainData(1);
			
		var id='${prdctId}';
		if(id==''){
		}else{
			fncGetPrdctInfo(id);
		}
	});
	//----------------------
	
	
	/*
	 * 밸리데이션 체크
	 */
	 
	function fncCheckValidation(){
		if(listPrdctForm2.prdctId.value==""){
			alert('<spring:message code="validation.select" arguments="상품을"/>');
			return false;
		}
		if(listPrdctForm2.invnTyCd.value=="-1"){
			alert('<spring:message code="validation.put" arguments="분류를"/>');
			return false;
		}
		if(listPrdctForm2.cnt.value==""){
			alert('<spring:message code="validation.put" arguments="수량을"/>');
			return false;
		}
		
		return true;
	}
	
	/*
	 * 내용 변경 못하도록 설정
	 */
	function fncChangeToReadOnly(){
		listPrdctForm2.prdctName.readOnly=true;
		listPrdctForm2.prdctTyCd.disabled=true;
		listPrdctForm2.mnfCountry.readOnly=true;
		listPrdctForm2.brandId.disabled=true;
		listPrdctForm2.whDate.readOnly=true;
		listPrdctForm2.puchasPrc.readOnly=true;
		listPrdctForm2.trdePrc.readOnly=true;
		
		
		
	}
	
	/*
	 * 내용 변경 가능 하도록 설정
	 */
	function fncChangeToWriteEnable(){
		listPrdctForm2.prdctName.readOnly=false;
		listPrdctForm2.prdctTyCd.disabled=false;
		listPrdctForm2.mnfCountry.readOnly=false;
		listPrdctForm2.brandId.disabled=false;
		listPrdctForm2.whDate.readOnly=false;
		listPrdctForm2.puchasPrc.readOnly=false;
		listPrdctForm2.trdePrc.readOnly=false;
		
	}
	
	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncListPrdctRemainData(no){
		var url = '${ctxPath}/prdct/listPrdctRemainData.do';
		if(no){
			jQuery('#listPrdctForm1 input[name=currentPage]').val(no);
		}					  	
		var param = jQuery('#listPrdctForm1').serialize();
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listBrandDiv').html(data);
			}
			
		});  
		 fncPrdctDetailClear();
		
	}
	

	
	/*
	 * 고객 데이타 저장.
	 */
	function fncSavePrdctAction(){
		if(!fncCheckValidation()){
			return;
		}
		var url;
		var msg;
		var no;
		url = '${ctxPath}/prdct/updatePrdctInvnAction.do'; // 수정
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#listPrdctForm2').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="success"){
					alert('<spring:message code="success"/>');
				}else if(data=="fail"){
					alert('<spring:message code="fail"/>');
				}else if(data=="shortage"){
					alert('<spring:message code="shortage"/>');
				}
				  //성공시....
				//fncPrdctDetailClear();
				  
				fncListPrdctRemainData();
			}
			
		});  
		
	}
	
	
	/*
	 * html 클리어
	 */
	function fncPrdctDetailClear(){
		 //jQuery('#listCstmrForm2 input[name=cstmrId]').val('');
		 
		jQuery('#listPrdctForm2 input[name=prdctId]').val('');
		 
		document.getElementById("pprdctName").innerHTML='';
		document.getElementById("pbrandName").innerHTML='';
		document.getElementById("pmnfCountry").innerHTML='';
		document.getElementById("pprdctTy").innerHTML='';
		document.getElementById("cName").innerHTML='';
		jQuery('#listPrdctForm2 select[name=invnTyCd]').val('-1');
		jQuery('#listPrdctForm2 input[name=cnt]').val('');
		jQuery('#listPrdctForm2 TEXTAREA[name=bigo]').val('');
		
	}
	

	/*
	 * 신규시 
	 */
	function fncNewPrdct(){
		fncPrdctDetailClear();
	}
	
	/*
	 * 고객 상세 
	 */
	function fncGetPrdctInfo(prdctId){
		 var url = '${ctxPath}/prdct/getPrdctData.do';
		 
		 //var userId = $('#userId').getValue();
		   
		 jQuery.ajax({
				url: url,
				type : "post",
				data : "prdctId=" + prdctId,
				dataType	: "json",
				beforeSend	: function(){
				},
				success		: function(data){
					console.log(data)
					 //clear 
					 fncPrdctDetailClear();
					 //-----------------------------
					 //-----------------------------
					 var viewForm = jQuery('#listPrdctForm2');
					 jQuery('#listPrdctForm2 input[name=prdctId]').val(data.prdctId);
					 jQuery('#listPrdctForm2 TEXTAREA[name=bigo]').val(data.bigo);
					 document.getElementById("pprdctName").innerHTML=data.prdctName;
					 document.getElementById("pbrandName").innerHTML=data.brandName;
					 document.getElementById("pmnfCountry").innerHTML=data.mnfCountry;
					 document.getElementById("pprdctTy").innerHTML=data.prdctTyCdMsg;
					 document.getElementById("cName").innerHTML=data.cname;
					 
					  
				}
				
			});  
	}
	
	/*
	 * 이미지 등록
	 */
	function fncSavePhotos(){
		//location.replace("/media/indexMediaForm.do");
		jQuery('#listPrdctForm2').attr('method', 'post');
		jQuery('#listPrdctForm2').attr('action', '${ctxPath}/media/indexMediaForm.do');
		jQuery('#listPrdctForm2').submit(); 
	}
</script> 
<html>
<head>
	<title>Home</title>
</head>
<body>
	<div id="content">
					
			<form name="listPrdctForm1"  id="listPrdctForm1" method="post" action="">
				
				<input type="hidden" name="currentPage" value="1"/>
				<input type="hidden" name="pageSize" value="5"/>
				
				
				<table border="1" class="search">
					<tbody>
					<tr>
						<th style="width:10%"><label for="searchPrdct">모델 명</label></th>
						<td style="width:15%"><input type="text" id="prdctName" name="prdctName"></td>
						<th style="width:10%"><label for="searchBrand">브랜드</label></th>
						<td style="width:13%">
							<select id='brandId' name='brandId' title='브랜드 명'>
								<option value="-1">전체</option>
								<c:forEach items="${listBrand}" var="item" varStatus="status">
									<option value="${item.brandId}">${item.brandName}</option>
								</c:forEach>
							</select>
						</td>
						<th style="width:10%"><label for="searchTy">상품 종류</label></th>
						<td style="width:13%">
							<select id='prdctTyCd' name='prdctTyCd' title='타입'>
								<option value="-1">전체</option>
								<option value="00300001"><%=CommonCode.MSG_PRDCT_TY_FRAME%></option>
								<option value="00300002"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="00300003"><%=CommonCode.MSG_PRDCT_TY_CLENS%></option>
							</select>
						</td>
						<th style="width:10%"><label for="searchStatTy">승인 상태</label></th>
						<td style="width:24%">
							<select id='prdctStatTyCd' name='prdctStatTyCd' title='타입'>
								<option value="-1">전체</option>
								<option value="00100001"><%=CommonCode.MSG_PRDCT_STAT_SALE_STAY%></option>
								<option value="00100002"><%=CommonCode.MSG_PRDCT_STAT_SALE_REQ%></option>
								<option value="00100003"><%=CommonCode.MSG_PRDCT_STAT_SALE_ING%></option>
								<option value="00100004"><%=CommonCode.MSG_PRDCT_STAT_SALE_DNY%></option>
							</select>
							<button onclick="fncListPrdctRemainData('1');return false;">조회</button>
						</td>
						
					</tr>
					</tbody>
				</table>
 			</form>
			<form name="listPrdctForm2"  id="listPrdctForm2" method="post" action="">
					<input type="hidden" id='prdctId' name='prdctId'>
					
					<div id="listBrandDiv"> 
					</div>
					
					<table>
					<tr>
					<td>
						<img src="<c:url value="/images/content/dot.png"/>" /> 
					</td>
					<td>
						<p>모델 정보</p>
					</td>
					</tr>
					</table>
					
					<table width="100%" border="1" class="detail"> 
						<br>
						<tbody>
						
						<tr>
							<th style="width:20%"><label for="">모델 </label></th>
							<td style="width:30%">
								<p id='pprdctName' title='모델 명'></p>
							</td>
							<th style="width:20%"><label for="">타입</label></th>
							<td style="width:30%">
								<p id='pprdctTy' title='타입'></p>
							</td>
						</tr>
						<tr>
							<th style="width:20%"><label for="">제조 국</label></th>
							<td style="width:30%">
								<p id='pmnfCountry' title='제조 국'></p>
							</td>
							<th style="width:20%"><label for="">브랜드 명</label></th>
							<td style="width:30%">
								<p id='pbrandName'></p>
							</td>
						</tr>
						<tr>
							
							<th><label for="">분류</label></th>
							<td>
								<select id='invnTyCd' name='invnTyCd' title='타입'>
									<option value="-1">선택</option>
									<option value="00900001"><%=CommonCode.MSG_INVN_TY_IN%></option>
									<option value="00900002"><%=CommonCode.MSG_INVN_TY_OUT%></option>
								</select>
							</td>
							<th><label for="">수량</label></th>
							<td>
								<input type="text" id='cnt' name='cnt' title='수량' onkeydown="numCheck();" onkeypress="numCheck();">
							</td>
						</tr>
						<tr>
							<th><label for="">거래처</label></th>
							<td>
								<p id='cName' name='cName' >
							</td>
							
							<th></th>
							<td>
							</td>
						</tr>
						<tr>
							<th><label for="">비고</label></th>
							<td colspan="3"><TEXTAREA  id="bigo" name="bigo" ROWS="5" style="width:90%"></TEXTAREA></td>
						</tr>
						</tbody>
					</table>

					
					<br>
					<div id="btn_sctn" align="right">
						<button onclick="fncSavePrdctAction();return false;">저장</button>
					</div>
					
			</form>
	
		
		</div>
</body>
</html>
