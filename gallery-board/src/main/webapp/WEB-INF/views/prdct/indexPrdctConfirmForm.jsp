<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		fncListPrdctData(1);		
	});
	//----------------------
	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncListPrdctData(no){
		var url = '${ctxPath}/prdct/listPrdctConfirmData.do';
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
			data 	: jQuery('#listPrdctForm2').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="duple"){
					alert("동일한 이름의 상품이 등록되어있습니다.");
				}else if(data=="addsuccess"){
					alert("등록 하였습니다.");				
				}else if(data=="fail"){
					alert("실패하였습니다.");
				}else if(data=="upsuccess"){
					alert("수정 하였습니다.");				
				}
				  //성공시....
				fncPrdctDetailClear();
				fncListPrdctData(1);
			}
			
		});  
		
	}
	
	/*
	 * 승인 요청 처리.
	 */
	function fncSavePrdctActpAction(code,reqId){
		var url = '${ctxPath}/prdct/updatePrdctAcptAction.do'; // 추가
		//javax 
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: "prdctStatTyCd="+code+"&prdctId="+reqId,
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="success"){
					alert("완료 하였습니다.");				
				}else if(data=="fail"){
					alert("실패하였습니다.");
				}
				fncCancel();
				fncListPrdctData();
			}
		});  
	}

	
	//삭제
	function fncDelPrdct(){
		
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
					fncPrdctDetailClear();
					fncListPrdctData();
				}else if(data == "fail"){
				}
				
				  //성공시....
				 
			}
			
		}); 
		
	}
	 
	
	
	/*
	 * html 클리어
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
	 * 고객 상세 
	 */
	function fncGetPrdctComfirmInfo(prdctId){
		//alert("data="+prdctId);
		jQuery.ajax({  
			url: '${ctxPath}/prdct/popupPrdctForm.do'
			, type: "POST"
			, data: "prdctId="+prdctId
			, dataType: "html"
			, beforeSend: function(xhr){
				
			}
			, success:  function(data) {
				jQuery('#dialog').html(data);
			}	
		});	// end ajax	
		
		jQuery('#dialog').dialog({
			//bgiframe: true
			 title: "상품 승인"
			 , modal: true
		     , width: 900 // 가로 크기
		     , background: "#000"
			 , close: function(event, ui){
				jQuery('#dialog').dialog('destroy');
				jQuery('#dialog').html('');
			}, success:  function(data) {
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
				<input type="hidden" name="pageSize" value="10"/>
	
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
							<button onclick="fncListPrdctData('1');return false;">조회</button>
						</td>
						
					</tr>
					</tbody>
				</table>
 
 			</form>
			<form name="listPrdctForm2"  id="listPrdctForm2" method="post" action="">
					<input type="hidden" id='prdctId' name='prdctId'>
					<input type="hidden" id='prdctStatTyCd' name='prdctStatTyCd' value="00100001">
							
					<div id="listBrandDiv"></div>			
			</form>
			
		
		</div>
		<div id="dialog"></div>
</body>
</html>
