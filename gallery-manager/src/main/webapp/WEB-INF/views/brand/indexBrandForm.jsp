<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		fncListBrandData(1);
	});
	//----------------------
	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncListBrandData(no){
		var url = 'listBrandData.do';
		if(no){
			jQuery('#listBrandForm1 input[name=currentPage]').val(no);
		}					  	
		var param = jQuery('#listBrandForm1').serialize();
		 
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
		 fncBrandDetailClear();
	}
	
	
	
	/*
	 * 밸리데이션 체크
	 */
	 
	function fncCheckValidation(){
		if(listBrandForm2.brandName.value==""){
			alert('<spring:message code="validation.put" arguments="브랜드명을"/>');
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
		
		if(jQuery('#listBrandForm2 input[name=brandId]').val() == ""){
			url = '${ctxPath}/brand/addBrandAction.do'; // 추가
			no = 1;
		} else{
			url = '${ctxPath}/brand/modifyBrandAction.do'; // 수정
			no = jQuery('#listCstmrForm1 input[name=currentPage]').val();
		}
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#listBrandForm2').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="duple"){
					alert('<spring:message code="add.duple" arguments="브랜드"/>');
				}else if(data=="addsuccess"){
					alert('<spring:message code="add.success" />');				
				}else if(data=="fail"){
					alert('<spring:message code="fail" />');
				}else if(data=="upsuccess"){
					alert('<spring:message code="update.success" />');				
				}
				  //성공시....
				fncBrandDetailClear();
				fncListBrandData(1);
			}
			
		});  
		
	}
	
	//삭제
	function fncDelBrand(){
		if(!confirm('<spring:message code="del.confirm" />')){
			return;
		}
		if(jQuery('#listBrandForm2 input[name=brandId]').val() == ""){
			return;
		} 
				
		var url = '${ctxPath}/brand/removeBrandAction.do';
		  	
		var param = jQuery('#listBrandForm2').serialize();
		 
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
					fncBrandDetailClear();
					fncListBrandData();
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
	function fncBrandDetailClear(){
		 //jQuery('#listCstmrForm2 input[name=cstmrId]').val('');
		 jQuery('#listBrandForm2 input[name=brandId]').val('');
		 jQuery('#listBrandForm2 input[name=brandName]').val('');
		 jQuery('#listBrandForm2 TEXTAREA[name=bigo]').val('');
		 
		 
		 /*
		 var viewForm = jQuery('#listBrandForm2');
		 viewForm.find('span[id=brandIdSpan]').text('');
		 viewForm.find('span[id=updDttm]').text('');
		 viewForm.find('span[id=upderNm]').text('');
		 viewForm.find("*").removeClass('formError'); // validation CSS 제거
		 */
	}
	

	/*
	 * 신규시 
	 */
	function fncNewBrand(){
		
		fncBrandDetailClear();
		
	}
	
	/*
	 * 고객 상세 
	 */
	function fncGetBrandInfo(brandId){
		 var url = '${ctxPath}/brand/getBrandData.do';
		 
		 //var userId = $('#userId').getValue();
		   
		 jQuery.ajax({
				url: url,
				type : "post",
				data : "brandId=" + brandId,
				dataType	: "json",
				beforeSend	: function(){
				},
				success		: function(data){
					 //clear 
					 fncBrandDetailClear();
					 //-----------------------------
					 //-----------------------------
					 var viewForm = jQuery('#listBrandForm2');
					 
					 //viewForm.deserialize(data);
					 jQuery('#listBrandForm2 input[name=brandId]').val(data.brandId);
		 			 jQuery('#listBrandForm2 input[name=brandName]').val(data.brandName);
		 			 jQuery('#listBrandForm2 TEXTAREA[name=bigo]').val(data.bigo);
					
					 /*
					 viewForm.find('span[id=cstmrIdSpan]').text(data.cstmrId);
					 viewForm.find('span[id=updDttm]').text(data.updDttm);
					 viewForm.find('span[id=upderNm]').text(data.upderNm);
					 
					 $('#cstmrId').val(data.cstmrId);
					 $('#cstmrNm').val(data.cstmrNm);
					 $('#cstmrTyCd').val(data.cstmrTyCd);
					 
					 
					 if(data.zip==null){
					 }else{
				  	 	$('#zipCd1').val(data.zipCd1);
				 	 	$('#zipCd2').val(data.zipCd2);
					 }
					 $('#dtlAddr1').val(data.dtlAddr1);
					 $('#dtlAddr2').val(data.dtlAddr2);
					 $('#email').val(data.email);
					 $('#tel').val(data.tel);
					 $('#bigo').val(data.bigo);
					 $('#upderId').val(data.upderId);
					 */
					 //readOnly
					  
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
					
		<form name="listBrandForm1"  id="listBrandForm1" method="post" action="">
			
			<input type="hidden" name="currentPage" value="1"/>
			<input type="hidden" name="pageSize" value="5"/>
			
			
				<table width="100%" class="search" id="listTable" border="1">
					<tbody>
					<tr id="listTr" >
						<th style="width:20%" class="header"><label for="searchName">브랜드 명</label></th>
						<td style="width:80%">
							<input type="text" id="brandName" name="brandName">
							<button onclick="fncListBrandData('1');return false;">조회</button>
						</td>
					</tr>
					</tbody>
				</table>

			</form>
		<form name="listBrandForm2"  id="listBrandForm2" method="post" action="">
				<input type="hidden" id='brandId' name='brandId'>
				
				<div id="listBrandDiv"> 
				</div>
				
				
				
				
				<table>
				<tr>
				<td>
					<img src="<c:url value="/images/content/dot.png"/>" /> 
				</td>
				<td>
					<p>브랜드 정보</p>
				</td>
				</tr>
				</table>
				
				<table width="100%" border="1" class="detail"> 
					<br>
					<tbody>
					
					<tr>
						<th style="width:20%"><label for="">브랜드 명</label></th>
						<td style="width:80%">
							<input type="text" id='brandName' name='brandName' title='브랜드 명'>
						</td>
					</tr>
					<tr>
						<th><label for="">비고</label></th>
						<td><TEXTAREA  id="bigo" name="bigo" ROWS="5" style="width:90%"></TEXTAREA></td>
					</tr>
					</tbody>
				</table>

				
				
				<div id="btn_sctn" align="right">
					<button onclick="fncNewBrand();return false;">신 규</button>
					<button onclick="fncSaveBrandAction();return false;">저 장</button>
					<button onclick="fncDelBrand();return false;">삭 제</button>
				</div>
				
		</form>
	</div>
</body>
</html>
