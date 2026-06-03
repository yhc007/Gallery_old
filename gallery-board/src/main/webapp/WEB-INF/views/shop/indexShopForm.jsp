<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		fncListShopData(1);
		
	});
	//----------------------
	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncListShopData(no){
		var url = 'listShopData.do';
		if(no){
			jQuery('#listShopForm1 input[name=currentPage]').val(no);
		}					  	
		var param = jQuery('#listShopForm1').serialize();
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listShopDiv').html(data);
			}
			
		});  
		 fncShopDetailClear();
		
	}
	
	
	
	
	/*
	 * 고객 데이타 저장.
	 */
	function fncSaveShopAction(){
		
		var url;
		var msg;
		var no;
		
		if(jQuery('#listShopForm2 input[name=shopId]').val() == ""){
			url = '${ctxPath}/shop/addShopAction.do'; // 추가
			no = 1;
		} else{
			url = '${ctxPath}/shop/modifyShopAction.do'; // 수정
			no = jQuery('#listCstmrForm1 input[name=currentPage]').val();
		}
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#listShopForm2').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="duple"){
					alert("동일한 매장 명이 등록되어있습니다.");
				}else if(data=="addsuccess"){
					alert("등록 하였습니다.");				
				}else if(data=="fail"){
					alert("실패하였습니다.");
				}else if(data=="upsuccess"){
					alert("수정 하였습니다.");				
				}
				  //성공시....
				fncShopDetailClear();
				fncListShopData();
			}
			
		});  
		
	}
	
	//삭제
	function fncDelShop(){
		
		if(jQuery('#listShopForm2 input[name=shopId]').val() == ""){
			return;
		} 
				
		var url = '${ctxPath}/shop/removeShopAction.do';
		  	
		var param = jQuery('#listShopForm2').serialize();
		 
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
					fncShopDetailClear();
					fncListShopData();
				}else if(data == "fail"){
				}
				
				  //성공시....
				 
			}
			
		}); 
		
	}
	 
	
	
	/*
	 * html 클리어
	 */
	function fncShopDetailClear(){
		 //jQuery('#listCstmrForm2 input[name=cstmrId]').val('');
		 
		 jQuery('#listShopForm2 input[name=shopId]').val('');
		 jQuery('#listShopForm2 input[name=shopName]').val('');
		 jQuery('#listShopForm2 input[name=telephone]').val('');
		 jQuery('#listShopForm2 select[name=shopStatTyCd]').val('00500001');
		 jQuery('#listShopForm2 input[name=lat]').val('');
		 jQuery('#listShopForm2 input[name=lot]').val('');
		 
		 
		 /*
		 var viewForm = jQuery('#listShopForm2');
		 viewForm.find('span[id=shopIdSpan]').text('');
		 viewForm.find('span[id=updDttm]').text('');
		 viewForm.find('span[id=upderNm]').text('');
		 viewForm.find("*").removeClass('formError'); // validation CSS 제거
		 */
	}
	

	/*
	 * 신규시 
	 */
	function fncNewShop(){
		
		fncShopDetailClear();
		
	}
	
	/*
	 * 고객 상세 
	 */
	function fncGetShopInfo(shopId){
		 var url = '${ctxPath}/shop/getShopData.do';
		 //var userId = $('#userId').getValue();
		   
		 jQuery.ajax({
				url: url,
				type : "post",
				data : "shopId=" + shopId,
				dataType	: "json",
				beforeSend	: function(){
				},
				success		: function(data){
					console.log(data) 
					//clear 
					 fncShopDetailClear();
					 //-----------------------------
					 //-----------------------------
					 var viewForm = jQuery('#listShopForm2');
					 
					 //viewForm.deserialize(data);
					 
					 jQuery('#listShopForm2 input[name=shopId]').val(data.shopId);
					 jQuery('#listShopForm2 input[name=shopName]').val(data.shopName);
					 jQuery('#listShopForm2 input[name=telephone]').val(data.telephone);
					 jQuery('#listShopForm2 select[name=shopStatTyCd]').val(data.shopStatTyCd);
					 jQuery('#listShopForm2 input[name=lat]').val(data.lat);
					 jQuery('#listShopForm2 input[name=lot]').val(data.lot);
					 /*
					 $('#shopId').val(data.shopId);
					 $('#shopName').val(data.shopName);
					 $('#shopId').val(data);
					 $('#shopName').val('');
					 $('#telephone').val('');
					 $('#shopstateCd').val('00500001');
					 $('#lat').val('');
					 $('#lot').val('');
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
					
			<form name="listShopForm1"  id="listShopForm1" method="post" action="">
				
				<input type="hidden" name="currentPage" value="1"/>
				<input type="hidden" name="pageSize" value="5"/>
				 
				
					<table width="100%" border="1" class="search">
						<tbody>
						<tr>
							<th style="width:20%"><label for="searchName">매장 명</label></th>
							<td style="width:80%">
								<input style="width:25%" type="text" id="shopName" name="shopName">
								<button onclick="fncListShopData('1');return false;">조회</button>
							</td>
						</tr>
						</tbody>
					</table>
 
 			</form>
			<form name="listShopForm2"  id="listShopForm2" method="post" action="">
					<input type="hidden" id='shopId' name='shopId'>
					
					 <div id=listShopDiv align="left"></div>
					
					
					<table>
					<tr>
					<td>
						<img src="<c:url value="/images/content/dot.png"/>" /> 
					</td>
					<td>
						<p>매장 정보</p>
					</td>
					</tr>
					</table>
					
					<table width="100%" border="1" class="detail"> 
						<br>
						<tbody>
						
						<tr>
							<th style="width:20%"><label for="">매장 명</label></th>
							<td style="width:30%">
								<input type="text" id='shopName' name='shopName' title='매장 명'>
							</td>
							<th style="width:20%"><label for="">운영 상태</label></th>
							<td style="width:30%">
								<select id="shopStatTyCd" name="shopStatTyCd">
									<option value="00500001">운영 중</option>
									<option value="00500002">운영 중지</option>
								</select>
							</td>
						</tr>
						<tr>
							<th><label for="">전화번호</label></th>
							<td colspan="3">
								<input type="text" id='telephone' name='telephone' title='전화번호'>
							</td>
						</tr>
						<tr>
							<th><label for="">위도</label></th>
							<td>
								<input type="text" id='lat' name='lat' title='전화번호'>
							</td>
							<th><label for="">경도</label></th>
							<td>
								<input type="text" id='lot' name='lot' title='전화번호'>
							</td>
						</tr>
						</tbody>
					</table>
					
					<div id="btn_sctn" align="right">
						<button onclick="fncNewShop();return false;">신 규</button>
						<button onclick="fncSaveShopAction();return false;">저 장</button>
						<button onclick="fncDelShop();return false;">삭 제</button>
					</div>
			</form>
	
		
		</div>
</body>
</html>
