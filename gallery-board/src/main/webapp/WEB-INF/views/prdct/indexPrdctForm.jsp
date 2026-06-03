<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		$("#puchasPrc_").val("");
		$("#trdePrc_").val("");
		 if("${shopId}"!="777"){
			 $("#prdctInfo").css("display","none");
		 }
		findShopName() 
		fncListPrdctData(1);
		slctcomData();
		selectShop();
		var id='${prdctId}';
		if(id==''){
		}else{
			fncGetPrdctInfo(id);
		}
		
 		//var obj = document.getElementById("imgSaveHref");
		 
		//obj.style.display="none";
		
		
	});
	//----------------------
	
	
	/*
	 * 밸리데이션 체크
	 */
	 
	function fncCheckValidation(){
		if(listPrdctForm2.prdctName.value==""){
			alert('<spring:message code="validation.put" arguments="모델명을"/>');
			return false;
		}
		
		if(listPrdctForm2.prdctTyCd.value=="-1"){
			alert('<spring:message code="validation.select" arguments="타입을"/>');
			return;
		}
		if(listPrdctForm2.mnfCountry.value==""){
			alert('<spring:message code="validation.put" arguments="제조국을"/>');
			return false;
		}
		if(listPrdctForm2.brandId.value=="-1"){
			alert('<spring:message code="validation.select" arguments="브랜드를"/>');
			return;
		}
		if(listPrdctForm2.puchasPrc.value==""){
			alert('<spring:message code="validation.put" arguments="구매가격을"/>');
			return false;
		}
	/* 	if(listPrdctForm2.trdePrc.value==""){
			alert('<spring:message code="validation.put" arguments="판매가격을"/>');
			return false;
		} */
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
		
		var obj = document.getElementById("imgSaveHref");
		 
		obj.style.display="none";
		
	
	
	
	
	}
	
	//select value(거래처)
	function slctcomData(){
		var url = '${ctxPath}/company/selectCompanyData.do';
						  	
		 $.ajax({
			url		: url,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				//console.log(data);
				$("#iNum").append(data);
			}	
		});  
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
		var obj = document.getElementById("imgSaveHref");
		 
		 obj.style.display="";
	}
	
	
	/*
	 * 데이타 리스트 보드 페이징
	 */
	function fncListPrdctData(no){
		var url = '${ctxPath}/prdct/listPrdctData.do';
		if(no){
			jQuery('#listPrdctForm1 input[name=currentPage]').val(no);
		}					  	
		var param = jQuery('#listPrdctForm1').serialize();
		
		var shopParam = "";
		if("${shopId}"!=""){
			shopParam = "&shopId=${shopId}";
		}
		
		var iNumParam = "";
		if("${i_num}"!=""){
			shopParam = "&iNum=${i_num}";
		}
		
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param + iNumParam + shopParam,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listBrandDiv').html(data);
				$("#puchasPrc_").val("");
				$("#trdePrc_").val("");
			}
			
		});  
		 fncPrdctDetailClear();
		
	}
	

	
	/*
	 * 승인 요청
	 */
	 function  fncPrdctRequestAction(){
		 jQuery('#listPrdctForm2 input[name=prdctStatTyCd]').val('00100002');
		 fncSavePrdctAction(2);
	}
	
	
	//판매가, 매입가 변경
	function modifyPrdctPrc(){
		 $.ajax({
				url 	: '${ctxPath}/prdct/modifyPrdctPrc.do',
				type 	: "post",
				data 	: jQuery('#prdctInfoForm').serialize(),
				dataType	: "text",
				beforeSend	: function(){
					
				},
				success : function(){
					alert("수정되었습니다.");
					$("#puchasPrc_").val("");
					$("#trdePrc_").val("");
				}	
				});
				
	}
	/*
	 * 데이타 저장.
	 */
	function fncSavePrdctAction(reqno){
		if(!fncCheckValidation()){
			return;
		}
		var url;
		var msg;
		var no;
		if(jQuery('#listPrdctForm2 input[name=prdctId]').val() == ""){
			url = '${ctxPath}/prdct/addPrdctAction.do'; // 추가
			no = 1;
		} else{
			url = '${ctxPath}/prdct/modifyPrdctAction.do'; // 수정
			no = jQuery('#listCstmrForm1 input[name=currentPage]').val();
		}
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#listPrdctForm2').serialize() + "&iNum=" + '${i_num}',
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="duple"){
					alert('<spring:message code="add.duple" arguments="상품"/>');
				}else if(data=="addsuccess"){
					alert('<spring:message code="add.success"/>');
					fncPrdctDetailClear();
					fncListPrdctData(1);
				}else if(data=="fail"){
					alert('<spring:message code="fail"/>');
				}else if(data=="upsuccess"){
					if(reqno=="2"){
						alert('<spring:message code="update.complete" arguments="승인요청"/>');
					}else{
						alert('<spring:message code="update.success"/>');
					}
					fncPrdctDetailClear();
					fncListPrdctData();
				}
				  //성공시....
				
			}
			
		});  
		
	}
	
	//삭제
	function fncDelPrdct(){
		if(!confirm('<spring:message code="del.confirm"/>')){
			return;
		}
		if(jQuery('#listPrdctForm2 input[name=prdctId]').val() == ""){
			return;
		} 
				
		var url = '${ctxPath}/prdct/removePrdctAction.do';
		  	
		var param = jQuery('#listPrdctForm2').serialize();
		 
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
					alert('<spring:message code="del.success"/>');
					fncPrdctDetailClear();
					fncListPrdctData();
				}else if(data == "fail"){
					alert('<spring:message code="fail"/>');
				}
				
				  //성공시....
				 
			}
			
		}); 
		
	}
	 
	
	
	/*
	 * 입력 내용 초기화
	 */
	function fncPrdctDetailClear(){
		 //jQuery('#listCstmrForm2 input[name=cstmrId]').val('');
		 
		 jQuery('#listPrdctForm2 input[name=prdctId]').val('');
		 jQuery('#listPrdctForm2 input[name=prdctName]').val('');
		 jQuery('#listPrdctForm2 select[name=brandId]').val('-1');
		 jQuery('#listPrdctForm2 input[name=mnfCountry]').val('');
		 jQuery('#listPrdctForm2 input[name=whDate]').val('');
		 jQuery('#listPrdctForm2 select[name=prdctTyCd]').val('-1');
		 jQuery('#listPrdctForm2 input[name=prdctStatTyCd]').val('00100001');
		 jQuery('#listPrdctForm2 input[name=puchasPrc]').val('');
		 jQuery('#listPrdctForm2 input[name=trdePrc]').val('');
		 jQuery('#listPrdctForm2 select[name=prdctVisibleCd]').val('00500001');
		 jQuery('#listPrdctForm2 select[name=iNum]').val('-1');
		 
		 //var obj = document.getElementById("imgSaveHref");
		 
		 //obj.style.display="none";
		 /*
		 var viewForm = jQuery('#listPrdctForm2');
		 viewForm.find('span[id=prdctIdSpan]').text('');
		 viewForm.find('span[id=updDttm]').text('');
		 viewForm.find('span[id=upderNm]').text('');
		 viewForm.find("*").removeClass('formError'); // validation CSS 제거
		 */
	}
	

	/*
	 * 신규시 
	 */
	function fncNewPrdct(){
		
		fncPrdctDetailClear();
		
	}
	
	/*
	 * 상세 정보 
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
					 //clear 
					 fncPrdctDetailClear();
					 //-----------------------------
					 //-----------------------------
					 var viewForm = jQuery('#listPrdctForm2');
					 
					 jQuery('#listPrdctForm2 input[name=prdctId]').val(data.prdctId);
					 jQuery('#prdctInfoForm input[name=prdctId]').val(data.prdctId);
					 jQuery('#listPrdctForm2 input[name=prdctName]').val(data.prdctName);
					 jQuery('#listPrdctForm2 select[name=brandId]').val(data.brandId);
					 jQuery('#listPrdctForm2 input[name=brandName]').val(data.brandName);
					 jQuery('#listPrdctForm2 input[name=mnfCountry]').val(data.mnfCountry);
					 jQuery('#listPrdctForm2 input[name=whDate]').val(data.whDate);
					 jQuery('#listPrdctForm2 select[name=prdctTyCd]').val(data.prdctTyCd);
					 jQuery('#listPrdctForm2 input[name=prdctStatTyCd]').val(data.prdctStatTyCd);
					 jQuery('#listPrdctForm2 input[name=puchasPrc]').val(data.puchasPrc);
					 jQuery('#prdctInfoForm input[name=puchasPrc]').val(format(data.puchasPrc));
					 jQuery('#listPrdctForm2 input[name=trdePrc]').val(data.trdePrc);
					 jQuery('#prdctInfoForm input[name=trdePrc]').val(data.trdePrc);
					 jQuery('#listPrdctForm2 select[name=prdctVisibleCd]').val(data.prdctVisibleCd);
					 jQuery('#listPrdctForm2 select[name=iNum]').val(data.inum);
					 
					 /*
					 if(data.prdctStatTyCd=="00100002"||data.prdctStatTyCd=="00100003"){
						 fncChangeToReadOnly();
					 }else{
						 fncChangeToWriteEnable();
					 }
					 */
					 
					 var obj = document.getElementById("imgSaveHref");
					 
					 obj.style.display="";
					 
					  
				}
				
			});  
	}
	
	function format(n) {
		console.log(n)
		  var reg = /(^[+-]?\d+)(\d{3})/;   
		  n += '';                          

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');

		  return n;
		}
	
	
	function formatChange(num) {
		var n = num.value;
		
		  var reg = /(^[+-]?\d+)(\d{3})/;   
		  n += '';                          

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');
		  document.getElementById(num.id).value = n;
		}
	/*
	 * 이미지 등록
	 */
	function fncSavePhotos(){
		//location.replace("/media/indexMediaForm.do");
		if(!fncCheckValidation()){
			return;
		}
		
		/*
		jQuery('#listPrdctForm2').attr('method', 'post');
		jQuery('#listPrdctForm2').attr('action', '${ctxPath}/media/indexMediaForm.do');
		jQuery('#listPrdctForm2').submit();
		*/
		
		
		var url;
		var msg;
		var no;
		if(jQuery('#listPrdctForm2 input[name=prdctId]').val() == ""){
			url = '${ctxPath}/prdct/addPrdctMediaUploadAction.do'; // 추가
			no = 1;
		} else{
			url = '${ctxPath}/prdct/modifyPrdctAction.do'; // 수정
			no = jQuery('#listCstmrForm1 input[name=currentPage]').val();
		}
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#listPrdctForm2').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="duple"){
					alert('<spring:message code="add.duple" arguments="상품"/>');
				}else if(data=="fail"){
					alert('<spring:message code="fail"/>');
				}else{
					if(jQuery('#listPrdctForm2 input[name=prdctId]').val() != ""){
						//data=jQuery('#listPrdctForm2 input[name=prdctId]').val();
					}else{
						jQuery('#listPrdctForm2 input[name=prdctId]').val(data);
					}
					
					jQuery('#listPrdctForm2').attr('method', 'post');
					jQuery('#listPrdctForm2').attr('action', '${ctxPath}/media/indexMediaForm.do');
					jQuery('#listPrdctForm2').submit();
				}
				  //성공시....
				
			}
			
		});
	}
	
	var shopId;
	function selectShop(){
		shopId = $("#shopId").val();
		
	}
	function findShopName() {
		var url = '${ctxPath}/shop/findShopName.do';

		//javax
		$.ajax({
			url : url,
			type : "post",
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				$("#shopId").html(data);
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
								<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>"><%=CommonCode.MSG_PRDCT_TY_FRAME%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>"><%=CommonCode.MSG_PRDCT_TY_CLENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS_DIS%>"><%=CommonCode.MSG_PRDCT_TY_LENS_DIS%></option>
							</select>
						</td>
						<th style="width:10%"><label for="searchStatTy">승인 상태</label></th>
						<td style="width:24%">
							<select id='prdctStatTyCd' name='prdctStatTyCd' title='타입'>
								<option value="-1">전체</option>
								<option value="<%=CommonCode.CODE_PRDCT_STAT_SALE_STAY%>"><%=CommonCode.MSG_PRDCT_STAT_SALE_STAY%></option>
								<option value="<%=CommonCode.CODE_PRDCT_STAT_SALE_REQ%>"><%=CommonCode.MSG_PRDCT_STAT_SALE_REQ%></option>
								<option value="<%=CommonCode.CODE_PRDCT_STAT_SALE_ING%>"><%=CommonCode.MSG_PRDCT_STAT_SALE_ING%></option>
								<option value="<%=CommonCode.CODE_PRDCT_STAT_SALE_DNY%>"><%=CommonCode.MSG_PRDCT_STAT_SALE_DNY%></option>
							</select>
							<button onclick="fncListPrdctData('1');return false;">조회</button>
						</td>
						
					</tr>
					</tbody>
				</table>
 			</form>
 			
			<form name="listPrdctForm2"  id="listPrdctForm2" method="post" action="">
					<input type="hidden" id='prdctId' name='prdctId'>
					<input type="hidden" id='prdctStatTyCd' name='prdctStatTyCd' value="00100001">
					<input type="hidden" id="brandName" name="brandName" value="${item.brandName}"/>
					
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
					
					
					
					<table width="100%" border="1" > 
						<tbody>
						
						<tr>
							<th style="width:20%"><label for="">모델 명*</label></th>
							<td style="width:30%">
								<input type="text" id='prdctName' name='prdctName' title='모델 명' onkeydown="if (event.keyCode == 13){return false;}">
							</td>
							<th style="width:20%"><label for="">타입*</label></th>
							<td style="width:30%">
								<select id='prdctTyCd' name='prdctTyCd' title='타입'>
									<option value="-1">선택</option>
									<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>"><%=CommonCode.MSG_PRDCT_TY_FRAME%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>"><%=CommonCode.MSG_PRDCT_TY_CLENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS_DIS%>"><%=CommonCode.MSG_PRDCT_TY_LENS_DIS%></option>
								</select>
							</td>
						</tr>
						<tr>
							<th style="width:20%"><label for="">제조 국*</label></th>
							<td style="width:30%">
								<input type="text" id='mnfCountry' name='mnfCountry' title='제조 국' onkeydown="if (event.keyCode == 13){return false;}">
							</td>
							<th style="width:20%"><label for="">브랜드 명*</label></th>
							<td style="width:30%">
								<select id='brandId' name='brandId' title='브랜드 명'>
									<option value="-1">선택</option>
									<c:forEach items="${listBrand}" var="item" varStatus="status">
										<option value="${item.brandId}">${item.brandName}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							
							<th><label for="">예상 배송일</label></th>
							<td>
								<input type="text" id='whDate' name='whDate' title='입고 일자' onkeydown="if (event.keyCode == 13){return false;}">
							</td>
							<th><label for="">이미지</label></th>
							<td>
								<a href="#" id="imgSaveHref" onclick="fncSavePhotos();return false;">이미지 등록</a>
							</td>
						</tr>
						<tr>
							<th><label for="">금액</label></th>
							<td>
								<input type="text" id='puchasPrc'onchange="formatChange(puchasPrc)"name='puchasPrc' title='구매가' onkeydown="if (event.keyCode == 13){return false;}">
							</td>
							<th><label for=""><!-- 판매 가* -->매장</label></th>
							<td>
								<select id="shopId" name="shopId" onchange="selectShop();"> 
		
								</select>
								<!-- <input type="text" id='trdePrc' name='trdePrc' title='판매가' onkeydown="if (event.keyCode == 13){return false;}"> -->
							</td>
						</tr>
						<tr>
							<!-- <th><label for="">판매 여부*</label></th>
							<td>
								<select id='prdctVisibleCd' name='prdctVisibleCd' title='판매 여부'>
									<option value="00500001">판매 중</option>
									<option value="00500002">판매 중지</option>
								</select>
							</td> -->
							<!-- <th><label for="">거래처</label></th>
							<td>
								<select id='iNum' name='iNum' title='거래처'>
									<option id="-1">선택</option>
								</select>
							</td> -->
						</tr>
						</tbody>
					</table>
			
					
					<br>
					<div id="btn_sctn" align="right">
						<button onclick="fncNewPrdct();return false;">신규</button>
						<button onclick="fncSavePrdctAction();return false;">저장</button>
						<button onclick="fncPrdctRequestAction();return false;">승인요청</button>
						<button onclick="fncDelPrdct();return false;">삭제</button>
					</div>
			</form>
		
		
		<div id="prdctInfo">
			<form action="" id="prdctInfoForm" method="post" name="prdctInfoForm">
				<table width="100%" border="1">
				<input type="hidden" name="prdctId">
					<tr>
						<th>매입가</th><td><input type="text" id="puchasPrc_" name="puchasPrc" > </td>
						<th>판매가</th><td><input type="text" id="trdePrc_" name="trdePrc" > </td>
						<td><center><button onclick="modifyPrdctPrc()">수정</button></center></td>
					</tr>
				</table>
			</form>
		</div>
		
		</div>
</body>
</html>
