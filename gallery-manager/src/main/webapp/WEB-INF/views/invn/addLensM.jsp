<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
<script type="text/javascript">
	var newPrdctName;
	var mnfCountry;
	var brandId;
	var cnt;
	var puchasPrc;
	var trdePrc;
	var shopId = ${shopId};
	var newPrdct = false;
	var newRate = false;
	$(function() {
		window.sessionStorage.setItem("option","-1")
		window.sessionStorage.setItem("menu","lens");
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(date.getMonth()) + 1;
		var day = addZero(date.getDate());

		//$("#date_").val(year + "-" + month + "-" + day);
		$("#save").click(function (){addPrdct();});
		getCntryList();
		getComList();
		//getBrandByTy("00300002");
		getMtrlList();
		
		$("#btn1").click(function(){location.href="${ctxPath}/invn/addPrdctM.do"; return false;})
	});
	
	
	function removeClr(name){
		var index = name.indexOf("(")-1;
		return name = name.substring(0,index);
		
	}
	//NFC write
	function NFC_(){
		if(!newPrdct){
			prdctName = $("#prdctId option:selected").text();
			prdctId = $("#prdctId").val();
		}else{
			prdctName = $("#newPrdctName").val();			
		}
		
		console.log(shopId,prdctName,prdctId)
		NFC.write(shopId, prdctName, prdctId);
		setTimeout(function(){
			$("#result").text("NFC 입력이 완료되었습니다.");
			$("#result").css("color","white");
			$("#result").css("display","inline");
		},1000);
	}
	
	
	
	
	//재질 리스트
	function getMtrlList(){
		var url = '${ctxPath}/prdct/getMtrl.do';
		/* var brandId = $("#brandId").val();
		var param = "brandId=" + brandId; */
		
		$.ajax({
			url		: url,
			/* data : param, */
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#mtrl").html(data);
			}	
		});  
	}
	
	//기능 리스트
	function getfunctionList(){
		var brandId = $("#brandId").val();
		var mtrl = $("#mtrl").val();
		var param = "mtrl=" + mtrl + "&brandId=" + brandId;
		var url = '${ctxPath}/prdct/getFunction.do';
		
		
		$.ajax({
			url		: url,
			data : param,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#tyId").html(data);
			}	
		});  
		
	}
	//거래처 리스트
	function getComList(){
		var url = '${ctxPath}/company/selectCompanyData.do';
	  	
		 $.ajax({
			url		: url,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#iNum").append(data);
			}	
		});  
	}
	
	
	//국가 리스트
	function getCntryList(){
		$.ajax({
			url : "${ctxPath}/invn/getCountryList.do",
			dataType : "html",
			type : "post",
			success : function(data){
				$("#mnfCountry").html(data);
			}
		});
	}
	function addZero(n) {
		if (String(n).length == "1") {
			return "0" + n;
		} else {
			return n;
		}
	};
	
	function removeHypen(str){
		var result = str.replace(/-/gi,"");
		
		return result;
	}
	
	function removeComma(str){
		var result = str.replace(/,/gi,"");
		
		return result;
	}
	
	
	//새로운 prdct
	
	function addNewPrdct(){
		var shopId = "${shopId}";
		$("#save").attr("disabled","disabled");
		$("#save").html("등록중");
		var rate;
		var mtrl = $("#mtrl").val();
		var tyId = $("#tyId").val();
		var mnfCountry = $("#mnfCountry").val();
		var puchasPrc = removeComma($("#puchasPrc").val());
		var trdePrc = removeComma($("#trdePrc").val());
		var prdctName;
		if(!newPrdct && newRate){ //새로운 rate
			prdctName = $("#prdctId option:selected").text();
			rate = $("#newRate").val();
		}else if(newPrdct && newRate){
			prdctName = $("#newPrdctName").val();
			rate = $("#newRate").val();
		}
		else{ //새로운 prdctName
			prdctName = $("#newPrdctName").val();
			rate = $("#rate").val();
		}
		var datetime = $("#datetime").val();
		var cnt = $("#cnt").val();
		var iNum = $("#iNum").val();
		
		var param = "PrdctName=" +prdctName + 
						"&mtrl=" + mtrl + 
						"&tyId=" + tyId + 
						"&rate=" +rate + 
						"&mnfCountry=" + mnfCountry +
						"&puchasPrc=" + puchasPrc +
						"&trdePrc=" + trdePrc +
						"&shopId=" + shopId + 
						"&datetime=" +datetime + 
						"&invnTyCd=00900001" +
						"&cnt=" +cnt + 
						"&iNum=" + iNum;
						
		
	
		var url = "${ctxPath}/invn/addLens.do";
		$.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				if(data.trim()=="success" ){ 
					alert("등록 되었습니다.");
			
					$("#save").removeAttr("disabled");
					$("#save").html("저장");
					$("#result").text("등록되었습니다.");
					$("#result").css("color","white");
					$("#result").css("display","inline");
					newPrdct = false;
					newRate = false;
				}else if(data.trim()=="exist"){
					alert("동일한 상품이 있습니다.");
					$("#result").text("동일한 상품이 있습니다.");
					$("#result").css("color","red");
					$("#result").css("display","inline");
					return;
				}else{
					alert("오류가 발생했습니다.");
					$("#result").text("오류가 발생했습니다.");
					$("#result").css("color","red");
					$("#result").css("display","inline");
				}
				//fncPrdctDetailClear();
			}
		}); 
		
		
	}
	//재고 추가
	function addPrdct(pId){
		$("#save").attr("disabled","disabled");
		$("#save").html("등록중");
		if(newPrdct || newRate){ //새로운 prdctName, rate 직접입력 시
			addNewPrdct();
			return;
		}
		var shopId = '${shopId}';		
		var puchasPrc = $("#puchasPrc").val();
		var rate = $("#rate").val();
		var datetime = $("#datetime").val();
		var cnt = $("#cnt").val();
		var iNum = $("#iNum").val();
		var prdctName = $("#prdctId option:selected").text();
		var prdctId = $("#prdctId").val();						
		var param = "&prdctName=" + prdctName + 
						"&rate=" + rate + 
						"&prdctId=" + prdctId +
						"&shopId=" + shopId + 
						"&puchasPrc=" + puchasPrc + 
						"&datetime=" + datetime +
						"&invnTyCd=00900001" +
						"&iNum=" + iNum + 
						"&cnt=" + cnt;
		var url = '${ctxPath}/prdct/addLens.do';
		
		 $.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				if(data.trim()=="success" ){ 
					alert("등록 되었습니다.");
					
					$("#save").removeAttr("disabled");
					$("#save").html("저장");
					$("#result").text("등록되었습니다.");
					$("#result").css("color","white");
					$("#result").css("display","inline");
					
				}else{
					$("#result").text("오류가 발생했습니다..");
					$("#result").css("color","red");
					$("#result").css("display","inline");
					alert("오류가 발생했습니다.");
				}
				//fncPrdctDetailClear();
			}
		}); 
		
		
	};
	
	
	//국가 선택
	function getCntry(){
		mnfCountry = $("#mnfCountry").val();
		if(mnfCountry=="-2"){
			$("#mnfCountry_").css("display","inline");
			$("#mnfCountry").css("display","none");	
		}
	}
	
	
	//제품 선택 
	function getPrdctList(){
		var brandId = $("#brandId").val();
		var mtrl = $("#mtrl").val();
		var tyId = $("#tyId").val();
		var param = "brandId=" +brandId + "&mtrl=" + mtrl + "&tyId=" +tyId;
		$("#result").css("display","none");
		
		$("#puchasPrc").val("");
		$("#trdePrc").val("");
		$("#cnt").val("");
		$("#prdctId").val("-1");
		
		var url = "${ctxPath}/prdct/getPrdctListLens.do";
	
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : param,
			success : function(data){
				$("#prdctId").html(data);
				newPrdct = false;
				//$("#puchasPrc").attr("readonly",true);
				$("#trdePrc").attr("readonly",true);
				$("#newRate").css("display","none");
				$("#rate").css("display","inline");
			}
		})
	}
	
	//모델 선택
	function getPrdctRate(){
		
		var brandId = $("#brandId").val();
		var mtrl = $("#mtrl").val();
		var tyId = $("#tyId").val();
		var prdctId = $("#prdctId").val();
		var prdctName= $("#prdctId option:selected").text();
		var allPrdct = "false";
		if(prdctId=="-2"){
			$("#newPrdctName").css("display","inline");
			$("#prdctId").css("display","none");
			$("#puchasPrc").attr("readonly",false);
			$("#trdePrc").attr("readonly",false);
			newPrdct = true;
			allPrdct = "true";
		}else{
			$("#newRate").css("display","none");
			$("#rate").css("display","inline");
		}
		
		var param = "brandId=" +brandId + "&mtrl=" + mtrl + "&tyId=" +tyId + "&prdctName=" + prdctName + "&allPrdct=" + allPrdct;
		var url = '${ctxPath}/prdct/getLensData.do';
		 $.ajax({
				url: url,
				type : "post",
				data : param,
				dataType	: "html",
				beforeSend	: function(){
				},
				success		: function(data){
					$("#rate").html(data)
				}
			});  
	}
	
	function fncPrdctDetailClear(){
		$("#brandId").val("-1");
		$("#puchasPrc").val("");
		$("#trdePrc").val("");
		$("#cnt").val("");
		$("#prdctId").val("-1");
		$("#mnfCountry").val("-1");
		$("#colorId").val("-1");
		$("#mtrlId").val("-1");
	}
	
	function format(n) {
		  var reg = /(^[+-]?\d+)(\d{3})/;   
		  n += '';                          

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');

		  return n;
		}
	//제품 등록 후 Id 가져오기
	function getPrdctId(){
		var prdct;
		var color;
		var Name = $("#prdctName").val();
	if(!newPrdct && newName!= Name){
		prdct = removeClr($("#prdctId option:selected").text());
		color = "&colorId=" + colorId + "&colorId2=" + colorId2;
	}else{
		prdct = $("#prdctName_").val();
		color = "";
		$("#test").css("display","inline");
	}
		var url = "${ctxPath}/invn/getPrdctId.do";
		var param = "shopId=${shopId}" + "&prdctName=" + prdct + color + "&brandId=" + brandId;
		$.ajax({
			url : url,
			dataType : "text",//tests//test
			type : "post",
			data : param,
			success : function(data){
				console.log("new Id : " + data)
				prdctId = data.trim();
				newPrdct = false;
				addPrdct(prdctId);
			}
		});
	}
	
	//브랜드 리스트 
	function getBrandByTy(ty){
		var url = "${ctxPath}/invn/getBrandList.do";
		var param = "prdctTyCd=" + ty;
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				$("#brandId").html(data);
			}
		});
		
	};
	
	
	
	//가격
	
	function	getPrdctPrc(){
		var rate = $("#rate").val();
		if(rate=="-2"){
			$("#newRate").css("display","inline");
			$("#rate").css("display","none");
			$("#trdePrc").attr("readonly",false);
			$("#trdePrc").attr("readonly",false);
			newRate = true;
			return;
		}
		
		var brandId = $("#brandId").val();
		var mtrl = $("#mtrl").val();
		var tyId = $("#tyId").val();
		var rate = $("#rate").val();
		var prdctName= $("#prdctId option:selected").text();
		var param = "brandId=" +brandId + 
						"&mtrl=" + mtrl + 
						"&tyId=" +tyId + 
						"&prdctName=" + prdctName + 
						"&rate=" + rate;
		
		var url = '${ctxPath}/prdct/getPrdctPrc.do';
		 $.ajax({
				url: url,
				type : "post",
				data : param,
				dataType	: "json",
				beforeSend	: function(){
				},
				success		: function(data){
					console.log(data);
					$("#trdePrc").val(format(data.trdePrc));
				}
			});  
		
	}
</script>


<style>
	#nfc{
		margin-left : 100px;
		margin-right: 200px;
		float: left;
	}
	#save{
		width:100px;
		height : 50px;
		margin-top: 20px;
	}
	#newPrdctName,#mnfCountry_{
		display: none;
	}
	body{
		background-image: url("${ctxPath}/images/bg_staff.jpg");
	}
	th{
		background-color: black;
		opacity : 0.5;
		color :white;
	}
	#result{
		color :white;
		display: none;
	}
	.clensTbl{
		display: none;
	}
	#newRate{
		display: none;
	}
</style>
</head>
<body>
<%@include file="includeM.jsp"%>
<hr>
<center>
	<form id="PrdctInfo" class="frameTbl">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			
			<tr>
				<th>제조국</th><td><select id="mnfCountry" name="mnfCountry" onchange="getCntry();"><option value="-1">선택</select><input type="text" id="mnfCountry_"></td>
				<th>거래처</th><td><select id="iNum" name="iNum"><option value="-1">선택</option></select></td>	
			</tr>
			<tr>
				<input type="hidden"id="brandId">
				<th>재질</th><td><select id="mtrl" name="mtrl" onchange="getfunctionList();">
										<option value="-1">선택</option>
									</select></td>
				<th>기능</th><td><select id="tyId" name="tyId" onchange="getPrdctList();">
										<option value="-1">선택</option>
									</select></td>
			</tr>
			<tr>
				
				<th width="20%">모델명</th><td width="30%"> <select id="prdctId" name="prdctId" onchange="getPrdctRate()"><option value="-1">선택</option></select><input type="text" id="newPrdctName" class="test"></td>
				<th></th><td><select id="rate" onchange="getPrdctPrc()">
									<option value='-1'>선택</option>									
								</select>
							<input type="text" id="newRate" class="test">
							</td>
			</tr>
			<tr>
				<th>매입가</th><td><input type="text" id="puchasPrc" name="puchasPrc" ></td>
				<th>판매가</th><td><input type="text" id="trdePrc" name="trdePrc" readonly="readonly"></td>
			</tr>
			<tr>
				<th>수량</th><td><input type="text" id="cnt" name="cnt" size="3"></td>
				<th>입고날짜</th><td><input type="text" id="datetime" name="datetime" placeholder="ex)20130101" ></td>
			</tr>
			
		</table>
	</form>		
	
	
	
	
		<center>
			<div id="result">등록되었습니다.</div>
		</center>	
		<a href="javascript:NFC_();"><img src="${ctxPath }/images/NFC.png" width="100px" id="nfc"></a>
		<button id="save">저장</button>
			
		
</center>
		
		
		
</body>
</html>
