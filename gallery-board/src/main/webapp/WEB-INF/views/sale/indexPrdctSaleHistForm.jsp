<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		
		
		jQuery('#listSaleHistForm1 input[name=syear]').val('${cyear}');
		jQuery('#listSaleHistForm1 input[name=eyear]').val('${cyear}');
		
		
		getMax('${cyear}','${cmonth}',1);
		getMax('${cyear}','${cmonth}',2);
		
		
		jQuery('#listSaleHistForm1 select[name=smonth]').val('${cmonth}');
		jQuery('#listSaleHistForm1 select[name=sday]').val('${cday}');
		jQuery('#listSaleHistForm1 select[name=emonth]').val('${cmonth}');
		jQuery('#listSaleHistForm1 select[name=eday]').val('${cday}');
	});
	//----------------------
	
	
	/*
	 * 년 월의 마지막 일 획득
	 */
	function getMax(year,month,tp){
		if(tp==1){
			if(year==null||month==null){
				year= jQuery('#listSaleHistForm1 input[name=syear]').val();
				month= jQuery('#listSaleHistForm1 select[name=smonth]').val();
			}
			form= document.getElementById("sday"); //jQuery('#cstmrInfoForm select[name=bday]');
			getMaxOfMonth(year,month,form);
		}
		
		if(tp==2){
			if(year==null||month==null){
				year= jQuery('#listSaleHistForm1 input[name=eyear]').val();
				month= jQuery('#listSaleHistForm1 select[name=emonth]').val();
			}
			form= document.getElementById("eday"); //jQuery('#cstmrInfoForm select[name=bday]');
			getMaxOfMonth(year,month,form);
		}
	}
	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncListPrdctInvnHistData(){
		var url = '${ctxPath}/sale/listPrdctSaleHistData.do';
		var param = jQuery('#listSaleHistForm1').serialize();
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listSaleHistBody').html(data);
			}
			
		});  
		
	}
	
	
	
	
	//삭제
	function fncDelPrdctInvnHist(){
		
		if(jQuery('#listSaleHistForm2 input[name=prdctId]').val() == ""){
			return;
		} 
				
		var url = '${ctxPath}/prdct/removePrdctAction.do';
		  	
		var param = jQuery('#listSaleHistForm2').serialize();
		 
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
	<div id="content" style="width:100%">
					
			<form name="listSaleHistForm1"  id="listSaleHistForm1" method="post" action="">
				
				<table border="1" class="search" width="100%">
					<tbody>
					<tr>
						<th style="width:10%"><label for="searchPrdct">매장</label></th>
						<td style="width:15%">
							<select id='shopId' name='shopId' title='매장 명'>
								<option value="-1">전체</option>
								<c:forEach items="${listShop}" var="item" varStatus="status">
									<option value="${item.shopId}">${item.shopName}</option>
								</c:forEach>
							</select>
						</td>
						
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
						<td style="width:10%">
							<select id='prdctTyCd' name='prdctTyCd' title='타입'>
								<option value="-1">전체</option>
								<option value="00300001"><%=CommonCode.MSG_PRDCT_TY_FRAME%></option>
								<option value="00300002"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="00300003"><%=CommonCode.MSG_PRDCT_TY_CLENS%></option>
							</select>
						</td>
						<td style="width:37%">
							<table border="0" width="100%">
							<tr>
							<td>
							<input id="syear" name="syear" size="1" maxlength="4">
							<select id="smonth" name="smonth" onChange="getMax(null,null,1);">
								<c:forEach var="i" begin="1" end="12">	
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>
							<select id="sday" name="sday">
							</select>
							
							</td>
							<td rowspan="2" align="right">
							<button onclick="fncListPrdctInvnHistData('1');return false;">조회</button>
							</td>
							</tr>
							<tr>
								<td>
								<input id="eyear" name="eyear" size="1" maxlength="4">
								<select id="emonth" name="emonth" onChange="getMax(null,null,2);">
									<c:forEach var="i" begin="1" end="12">	
										<option value="${i}">${i}</option>
									</c:forEach>
								</select>
								<select id="eday" name="eday">
								</select>
								</td>
							</tr>
							</table>
						</td>					
					</tr>
					</tbody>
				</table>
 
 			</form>
			<form name="listSaleHistForm2"  id="listSaleHistForm2" method="post" action="">
				<input type="hidden" id='prdctId' name='prdctId'>
				<input type="hidden" id='prdctStatTyCd' name='prdctStatTyCd' value="00100001">
				
				
				<table style="width:100%;height:300" class="list" id="listTable" border="1">
					<colgroup>
						<col width="10%">
						<col width="20%">
						<col width="20%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="20%">
					</colgroup>
					<thead>
						<tr>
							<th>판매 코드</th>
							<th>매장</th>
							<th>모델 이름</th>
							<th>수량</th>
							<th>가격</th>
							<th>결과</th>
							<th>등록 일</th>
						</tr>
					</thead>
					<tbody>
					
					<tr>
						<tbody id="listSaleHistBody">
						</tbody>
					</tr>
				</table>				
			</form>
		</div>
		<div id="dialog"></div>
</body>
</html>
