<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	var prdctTy = window.sessionStorage.getItem("prdct"); 
	
	var shopId = ${shopId};
	$(function(){
		$("#order").val(prdctTy);
		getComPrdctList();
		getBrand();
	});
	
	var sort = "D";
	function getComPrdctList(ty){
		var brandId = $("#brandId").val();
		var prdctId = $("#prdctId").val();
		if(brandId=="-1" || brandId=="선택"){
			brandId = "";
		}
		if(prdctId=="-1" || prdctId=="선택" || prdctId==null){
			prdctId = "";
		}
		
		if(typeof(ty)=="undefined"){
			 ty = "updTime";
		}
	 	
		var param  = "sort=" + ty + sort + 
						 "&comTy=" + prdctTy +
						 "&brandId=" + brandId + 
						 "&prdctId=" + prdctId;
		var url = "${ctxPath}/prdct/getComPrdctList.do";
		if(sort=="D"){
			sort = "A";
		}else{
			sort = "D";
		}
		
		$.ajax({
			url : url,
			data : param,
			type : "post",
			dataType : "html",
			success :function(data){
				$("#prdctInfo").html(data);
			}
		});
	};
	
	var iNum;
	function getEditForm(id){
		var param = "id=" + id + "&comTy=" + prdctTy;
		var url = "${ctxPath}/invn/getComPrdctEditForm.do";
		
		$.ajax({
			url : url,
			dataType : "json",
			data : param,
			type : "post",
			success : function(data){
				console.log(data)
				iNum = data.inum;
				brandId = data.brandId;
				prdctId = data.prdctId;
				comPrdctId = data.id;
				$("#PrdctInfo" + prdctTy + " input[id='mnfCountry']").val(data.mnfCountry);
				$("#PrdctInfo" + prdctTy + " input[id='puchasPrc']").val(data.puchasPrc);
				$("#PrdctInfo" + prdctTy + " input[id='brandName']").val(data.brandName);
				$("#PrdctInfo" + prdctTy + " input[id='prdctName']").val(data.prdctName);
				$("#PrdctInfo" + prdctTy + " input[id='mtrlId']").val(data.mtrlName);
				$("#PrdctInfo" + prdctTy + " input[id='salePrc']").val(data.trdePrc);
				$("#PrdctInfo" + prdctTy + " input[id='prdctTy']").val(data.prdctTyName);
				$("#PrdctInfo" + prdctTy + " input[id='tyId']").val(data.tyId);
				$("#PrdctInfo" + prdctTy + " input[id='tyId1']").val(data.tyId1);
				$("#PrdctInfo" + prdctTy + " input[id='tyId2']").val(data.tyId2);
				$("#PrdctInfo" + prdctTy + " input[id='rate']").val(data.rate);
				$("#PrdctInfo" + prdctTy + " input[id='unit']").val(data.unit+"ml");
				$("#PrdctInfo" + prdctTy + " input[id='prdctShape']").val(data.prdctShapeName);
				$("#PrdctInfo" + prdctTy + " input[id='mtrl']").val(data.mtrl);
				$("#PrdctInfo" + prdctTy + " input[id='colorId']").val(data.colorName1);
				$("#PrdctInfo" + prdctTy + " input[id='colorId2']").val(data.colorName2);
				$("#PrdctInfo" + prdctTy + " input[id='url']").val(data.url);
				$("#img").html("<img src='" + data.urlStr + data.imgPath + "' class='prdctImg'>");
				
				 $('#dialog' + prdctTy).dialog({
						//bgiframe: true
						 title: "수정"
						 , modal: true
					     , width: 1100 // 가로 크기
					     , background: "#000"
					     , position:{my:"center",at:"middle",of: window }
						 , close: function(event, ui){
						}, success:  function(data) {
							
						} 
					});
			}
		});
		
	}
	
	function order(n){
		var cnt = $("#PrdctInfo" + n +" input[id='cnt']").val();
		if(confirm("주문하시겠습니까?\n수량 : " + cnt)==false){
			return;
		}
		var url = "${ctxPath}/prdct/orderPrdct.do";
		var param = "id=" + comPrdctId + 
						"&shopId=" + shopId + 
						"&iNum=" + iNum + 
						"&PrdctId=" + prdctId +
						"&cnt=" + cnt +
						"&prdctTy=" + n; 
		$.ajax({
			url : url,
			data :param,
			type : "post",
			success : function(data){
				if(data.trim()=="success"){
					alert("주문이 완료되었습니다.");
					$("#dialog" + n).dialog("close");
					$("#PrdctInfo" + n +" input[id='cnt']").val("");
				}else{
					alert("오류가 발생하였습니다.");
				}
			}
		});
	}
	
	function orderPrdct(){
		var menu = $("#order").val();
		if(menu=="1"){
			window.sessionStorage.setItem("prdct",1);
		}else if(menu=="2"){
			window.sessionStorage.setItem("prdct",2);
		}else if(menu=="3"){
			window.sessionStorage.setItem("prdct",3);
		}else if(menu=="4"){
			window.sessionStorage.setItem("prdct",4);
		}
		location.href="${ctxPath}/prdct/indexPrdctConfirmForm.do";
	}
	function orderCheck(){
		var menu = $("#orderChk").val();
		if(menu=="1"){
			window.sessionStorage.setItem("order",1);
		}else if(menu=="2"){
			window.sessionStorage.setItem("order",2);
		}else if(menu=="3"){
			window.sessionStorage.setItem("order",3);
		}else if(menu=="4"){
			window.sessionStorage.setItem("order",4);
		}
		window.sessionStorage.setItem("menu",-1);
		location.href="${ctxPath}/prdct/orderList.do";
	}
	
	//브랜드 리스트 
	function getBrand(){
		var brandName = $("#srchBrand").val();
		var url = "${ctxPath}/invn/srchBrand.do";
		var param = "brandName=" + brandName;
		
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				$("#brandId").html(data);
				
			}
		});
	}
	
	//모델 선택
	function getPrdctList(){
		var brandId = $("#brandId").val();
		var param = "brandId=" + brandId + 
						"&comTy=" + prdctTy;

		var url = "${ctxPath}/prdct/getPrdctListByBrand.do";
	
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : param,
			success : function(data){
				$("#prdctId").html(data);
			}
		})
	}
	
	function getPrdct(){
		var prdctName = $("#srchPrdct input[id='srchPrdct']").val();
		var brandId = $("#brandId").val(); 
		var url = "${ctxPath}/invn/srchingPrdct.do";
		var param = "PrdctName=" + prdctName + 
						"&shopTy=shop" + 
						"&brandId=" + brandId + 
						"&comTy=" + prdctTy;
		alert(param)
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				console.log(data)
				$("#prdctId").html(data);
			}
		});
	}
</script>
<style>
	.dialog{
		display: none;
	}
	.prdctImg{
		width : 200px;
		height : 200px;
	}
	.title{
		cursor: pointer;
	}
</style>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<center>
		<select id="order" onchange="orderPrdct();">
			<option value="-1">주문</option>
			<option value="1">프레임</option>
			<option value="2">렌즈</option>
			<option value="3">콘텍트렌즈</option>
			<option value="4">렌즈용액</option>
		</select>
		
		<select id="orderChk" onchange="orderCheck();">
			<option value="-1">주문표</option>
			<option value="1">프레임</option>
			<option value="2">렌즈</option>
			<option value="3">콘텍트렌즈</option>
			<option value="4">렌즈용액</option>
		</select>
		<br>
		<br>
		<table id="srchPrdct"  width="90%" border="1" style="border-collapse: collapse; text-align: center">
			<form id="srchForm">
				<tr>
					<th>브랜드</th> <td><input type="text" id="srchBrand" onkeyup="getBrand()" size="10"><select id="brandId" onchange="getPrdctList();">
																						<option>선택</option>
																					</select> </td>  
					<th>모델명</th><td><input type="text" id="srchPrdct" onkeyup="getPrdct()" size="10"><select id="prdctId">
																						<option>선택</option>
																					</select> </td>
					<td>
						<button onclick="getComPrdctList(); return false;">검색</button>
					</td>
				</tr>
			</form>
		</table>
		<br>
		<hr>
		<table id="prdctInfo"  width="90%" border="1" style="border-collapse: collapse; text-align: center">
			
		</table>
	</center>
	
<div id="dialog1" class="dialog">
<center>
	<form id="PrdctInfo1">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			<tr>
			<td id="img" rowspan="6"></td>
				<th>상품종류</th><td ><select id="prdctTyCd" name="prdctTyCd" onchange="getBrandByTy()" disabled="disabled">
									<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>" selected="selected">프레임 </option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>" >렌즈</option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>">콘텍트 렌즈 </option>
								</select> </td>
			<th>제조국</th><td><input id="mnfCountry" name="mnfCountry" onchange="getCntry();" readonly="readonly"></td>	
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><input id='brandName' name='brandName' title='브랜드 명' readonly="readonly"><input type="hidden" id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();">
				
							</td>
				<th width="20%">모델명</th><td width="30%">  <input id="prdctName" name="prdctName"readonly="readonly"><input type="hidden" id="prdctId" name="prdctId" onchange="getPrdctPrc()"> </td>
			</tr>
			<tr>
				<th>색상1</th><td><input id="colorId" name="colorId" readonly="readonly"></td>
				<th>색상2</th><td><input id="colorId2" name="colorId2" readonly="readonly"></td>
				
			</tr>
			<tr>
				<th>매입가</th><td><input type="text" id="puchasPrc" name="puchasPrc" readonly="readonly"></td>
				<th>추천 판매가</th><td><input type="text" id="salePrc" name="salePrc" readonly="readonly"></td>
			</tr>
			<tr>
				<th>용도</th><td><input id="prdctTy" name="prdctTy" readonly="readonly"></td>
				<th>재질</th><td><input id="mtrlId" name="mtrlId" readonly="readonly"></td>
			</tr>
			<tr>
				<th>모양</th><td><input id="prdctShape" name="prdctShape" readonly="readonly"></td>
				<th>URL</th><td><input type="text" id="url" name="url" readonly="readonly"> </td>
			</tr>
			
		</table>
		<input type="text" id="cnt" size="3"> <button onclick="order('1'); return false;">주문</button>
	</form>		
		
</center>
</div>


<!-- 렌즈 -->

<div id="dialog2" class="dialog">
<center>
	<form id="PrdctInfo2">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			<tr>
				<th>상품종류</th><td ><select id="prdctTyCd" name="prdctTyCd" onchange="getBrandByTy()" disabled="disabled">
									<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>" >프레임 </option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>" selected="selected"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>">콘텍트 렌즈 </option>
								</select> </td>
			<th>제조국</th><td><input id="mnfCountry" name="mnfCountry" onchange="getCntry();" readonly="readonly"></td>	
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><input id='brandName' name='brandName' title='브랜드 명' readonly="readonly"><input type="hidden" id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();">
				
							</td>
				<th width="20%">모델명</th><td width="30%">  <input id="prdctName" name="prdctName"readonly="readonly" ><input type="hidden" id="prdctId" name="prdctId" onchange="getPrdctPrc()"> </td>
			</tr>
			<tr>
				<th>기능</th><td><input id="tyId" name="tyId" readonly="readonly"></td>
				<th>재질</th><td><input id="mtrl" name="mtrl" readonly="readonly"></td>
				
			</tr>
			<tr>
				<th>매입가</th><td><input type="text" id="puchasPrc" name="puchasPrc" readonly="readonly"></td>
				<th>추천 판매가</th><td><input type="text" id="salePrc" name="salePrc" readonly="readonly"></td>
			</tr>
			<tr>
				<th></th><td><input id="rate" name="rate" readonly="readonly"></td>
				<th>URL</th><td><input type="text" id="url" name="url" readonly="readonly"> </td>
			</tr>
			
		</table>
		<input type="text" id="cnt" size="3"> <button onclick="order('2'); return false;">주문</button>
	</form>		
		
</center>
</div>

<!--콘텍트-->

<div id="dialog3" class="dialog">
<center>
	<form id="PrdctInfo3">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			<tr>
				<th>상품종류</th><td ><select id="prdctTyCd" name="prdctTyCd" onchange="getBrandByTy()" disabled="disabled">
									<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>" >프레임 </option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>" selected="selected">콘텍트 렌즈 </option>
								</select> </td> 
			<th>제조국</th><td><input id="mnfCountry" name="mnfCountry" onchange="getCntry();" readonly="readonly"></td>	
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><input id='brandName' name='brandName' title='브랜드 명' readonly="readonly"><input type="hidden" id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();">
				
							</td>
				<th width="20%">모델명</th><td width="30%">  <input id="prdctName" name="prdctName" readonly="readonly"><input type="hidden" id="prdctId" name="prdctId" onchange="getPrdctPrc()"> </td>
			</tr>
			<tr>
				<th>타입</th><td><input id="tyId1" name="tyId2" readonly="readonly"></td>
				<th>기능</th><td><input id="tyId2" name="tyId2" readonly="readonly"></td>
				
			</tr>
			<tr>
				<th>매입가</th><td><input type="text" id="puchasPrc" name="puchasPrc"  readonly="readonly"></td>
				<th>추천 판매가</th><td><input type="text" id="salePrc" name="salePrc" readonly="readonly"></td>
			</tr>
			<tr>
				<th></th><td><input id="rate" name="rate"readonly="readonly"></td>
				<th>URL</th><td><input type="text" id="url" name="url" readonly="readonly"> </td>
			</tr>
			
		</table>
		<input type="text" id="cnt" size="3"> <button onclick="order('3'); return false;">주문</button>
	</form>		
		
</center>
</div>


<!--용액-->

<div id="dialog4" class="dialog">
<center>
	<form id="PrdctInfo4">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			<tr>
				<th>상품종류</th><td ><select id="prdctTyCd" name="prdctTyCd" onchange="getBrandByTy()" disabled="disabled">
									<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>">프레임 </option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>">콘텍트 렌즈 </option>
								</select> </td>
			<th>제조국</th><td><input id="mnfCountry" name="mnfCountry" onchange="getCntry();" readonly="readonly"></td>	
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><input id='brandName' name='brandName' title='브랜드 명' readonly="readonly"><input type="hidden" id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();">
				
							</td>
				<th width="20%">모델명</th><td width="30%">  <input id="prdctName" name="prdctName" readonly="readonly"><input type="hidden" id="prdctId" name="prdctId" onchange="getPrdctPrc()"> </td>
			</tr>
			<tr>
				<th>매입가</th><td><input type="text" id="puchasPrc" name="puchasPrc"  readonly="readonly" readonly="readonly"></td>
				<th>추천 판매가</th><td><input type="text" id="salePrc" name="salePrc"  readonly="readonly" readonly="readonly"></td>
			</tr>
			<tr>
				<th>용량</th><td><input id="unit" name="unit" readonly="readonly"></td>
				<th>URL</th><td><input type="text" id="url" name="url" readonly="readonly"> </td>
			</tr>
			
		</table>
		<input type="text" id="cnt" size="3"> <button onclick="order('4'); return false;">주문</button>
	</form>		
		
</center>
</div>
</body>
</html>
