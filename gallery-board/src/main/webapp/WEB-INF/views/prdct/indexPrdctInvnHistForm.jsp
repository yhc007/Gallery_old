<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		fncListPrdctInvnHistData(1);		
	});
	//----------------------
	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncListPrdctInvnHistData(no){
		var url = '${ctxPath}/prdct/listPrdctInvnHistData.do';
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
		
	}
	
	
	
	
	//삭제
	function fncDelPrdctInvnHist(){
		
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
					fncListPrdctInvnHistData();
				}else if(data == "fail"){
				}
				
				  //성공시....
				 
			}
			
		}); 
		
	}
	
	
	/*
	 * 재고 이력 상세 
	 */
	function fncGetPrdctInvnHistInfo(invnHistId){
		//alert("data="+invnHistId);
		jQuery.ajax({  
			url: '${ctxPath}/prdct/popupPrdctInvnHistForm.do'
			, type: "POST"
			, data: "invnHistId="+invnHistId
			, dataType: "html"
			, beforeSend: function(xhr){
				
			}
			, success:  function(data) {
				jQuery('#dialog').html(data);
			}	
		});	// end ajax	
		
		jQuery('#dialog').dialog({
			//bgiframe: true
			 title: "이력 상세"
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
						<td style="width:47%">
							<table border="0" width="100%">
							<tr>
							<td>
							<select id='prdctTyCd' name='prdctTyCd' title='타입'>
								<option value="-1">전체</option>
								<option value="00300001"><%=CommonCode.MSG_PRDCT_TY_FRAME%></option>
								<option value="00300002"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="00300003"><%=CommonCode.MSG_PRDCT_TY_CLENS%></option>
							</select>
							</td>
							<td align="right">
							<button onclick="fncListPrdctInvnHistData('1');return false;">조회</button>
							</td>
							</tr>
							</table>
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
