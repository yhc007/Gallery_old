<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<title>Gallery Comunity</title>
<script type="text/javascript">
	var newPrdctName;
	var mnfCountry;
	var prdctId;
	var prdctName;
	var brandId;
	var cnt;
	var puchasPrc;
	var trdePrc;
	var shopId = ${shopId};
	var newPrdct = false;
	var newUnit = false;
	$(function() {
		window.sessionStorage.setItem("option","-1")
		window.sessionStorage.setItem("menu","clensacc");
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(date.getMonth()) + 1;
		var day = addZero(date.getDate());

		//$("#date_").val(year + "-" + month + "-" + day);
		$("#save").click(function (){getPrdctId();});
		getCntryList();
		getComList();
		getBrandByTy("00300004");
		
		$("#btn1").click(function(){location.href="${ctxPath}/invn/addPrdctM.do"; return false;})
	});
	
	
	function removeClr(name){
		var index = name.indexOf("(")-1;
		return name = name.substring(0,index);
		
	}
	//NFC write
	function NFC_(){
		console.log(shopId,prdctName,prdctId)
		NFC.write(shopId, prdctName, prdctId);
		setTimeout(function(){
			$("#result").text("NFC 입력이 완료되었습니다.");
			$("#result").css("color","white");
			$("#result").css("display","inline");
		},1000);
	}
	
	
	
	
	//제품 리스트
	function getClensList(){
		$("#prdctId").css("display","inline");
		$("#newPrdctName").css("display","none");
		newPrdct = false;
		allPrdct = false;
		var url = '${ctxPath}/prdct/getClensList.do';
		var brandId = $("#brandId").val();
		var param = "brandId=" + brandId + "&shopTy=shop"; 
		
		$.ajax({
			url		: url,
			data : param, 
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				console.log(data)
				$("#prdctId").html(data);
			}	
		});  
	}
	
	
	//유닛
	function getPrdctUnit(){
		var allPrdct = false;
		if($("#prdctId").val()=="-2"){
			$("#prdctId").css("display","none");
			$("#newPrdctName").css("display","inline");
			$("#trdePrc").attr("readonly",false);
			allPrdct = true;
			newPrdct = true;
		}
		var url = '${ctxPath}/prdct/getPrdctUnit.do';
		var brandId = $("#brandId").val();
		var prdctName = $("#prdctId option:selected").text();
		
		var param = "brandId=" + brandId + "&prdctName=" +prdctName + "&allprdct=" +allPrdct + "&shopTy=shop"; 
		
		$.ajax({
			url		: url,
			data : param, 
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#unit").html(data);
			}	
		});  
	}
	
	//거래처 리스트
	function getComList(){
		var url = '${ctxPath}/company/selectCompanyData.do';
	  	var param = "comTy=A";
		 $.ajax({
			url		: url,
			data : param,
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
		var unit;
		var mnfCountry = $("#mnfCountry").val();
		var puchasPrc = removeComma($("#puchasPrc").val());
		var trdePrc = removeComma($("#trdePrc").val());
		var brandId = $("#brandId").val();
		
		
		var datetime = $("#datetime").val();
		var cnt = $("#cnt").val();
		var iNum = $("#iNum").val();
		
		if(newUnit && newPrdct){
			prdctName = $("#newPrdctName").val();
			unit = $("#newUnit").val();
		}else if(newUnit && !newPrdct){
			prdctName = $("#prdctId option:selected").text();
			unit = $("#newUnit").val();
		}else if(!newUnit && newPrdct){
			prdctName = $("#newPrdctName").val();
			unit = $("#unit").val();
		}
		
		var param = "PrdctName=" +prdctName + 
						"&mnfCountry=" + mnfCountry +
						"&puchasPrc=" + puchasPrc +
						"&trdePrc=" + trdePrc +
						"&shopId=" + shopId + 
						"&datetime=" +datetime + 
						"&invnTyCd=00900001" +
						"&cnt=" +cnt + 
						"&unit=" + unit +
						"&iNum=" + iNum + 
						"&brandId=" + brandId + 
						"&shopTy=shop";
						
		
	
		var url = "${ctxPath}/invn/addShopClensAcc.do";
		$.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				var result = data.trim().split("|");
				prdctId = result[1];
				prdctName = $("#newPrdctName").val();
				if(result[0]=="success" ){ 
					alert("등록 되었습니다.");
					$("#save").attr("disabled", false);
					$("#result").text("등록되었습니다.");
					$("#result").css("color","blue");
					$("#result").css("font-weight","bolder");
					$("#result").css("display","inline");
					setTimeout(function(){$("#result").css("display","none");},1500);
					newPrdct = false;
				}else if(result[0]=="exist"){
					alert("동일한 상품이 있습니다.");
					$("#save").attr("disabled", false);
					$("#result").text("동일한 상품이 있습니다.");
					$("#result").css("color","red");
					$("#result").css("font-weight","bolder");
					$("#result").css("display","inline");
					setTimeout(function(){$("#result").css("display","none");},1500);
					return;
				}else{
					alert("오류가 발생했습니다.");
					$("#result").text("오류가 발생하였습니다.");
					$("#result").css("color","red");
					$("#result").css("font-weight","bolder");
					$("#result").css("display","inline");
					setTimeout(function(){$("#result").css("display","none");},1500);
					$("#save").attr("disabled", false);
				}
				//fncPrdctDetailClear();
			}
		}); 
		
		
	}
	
	
	//id 받아오기
	
	function getPrdctId(){
		var unit = $("#unit").val();
		var brandId = $("#brandId").val();
		var prdctName = $("#prdctId option:selected").text();								
		var param = "&prdctName=" + prdctName + 
						"&unit=" + unit + 
						"&brandId=" + brandId + 
						"&shopTy=shop";
		var url = '${ctxPath}/prdct/getAccId.do';
		
		 $.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				console.log(data.trim())
				addPrdct(data.trim());
			}
		}); 
		
	}
	var prdctId
	//재고 추가
	function addPrdct(pId){
		$("#save").attr("disabled", true);
		if(newPrdct || newUnit){ //새로운 prdctName
			addNewPrdct();
			return;
		}
		prdctId = pId;
		var shopId = '${shopId}';		
		var unit = $("#unit").val();
		var puchasPrc = removeComma($("#puchasPrc").val());
		var datetime = $("#datetime").val();
		var cnt = $("#cnt").val();
		var iNum = $("#iNum").val();
								
		var param = "&prdctName=" + prdctName + 
						"&prdctId=" + prdctId +
						"&shopId=" + shopId + 
						"&puchasPrc=" + puchasPrc + 
						"&datetime=" + datetime +
						"&invnTyCd=00900001" +
						"&iNum=" + iNum + 
						"&cnt=" + cnt + 
						"&unit=" + unit + 
						"&shopTy=shop";
		var url = '${ctxPath}/prdct/addClensAcc.do';
		
		 $.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				prdctId = $("#prdctId").val();
				prdctName = $("#prdctId option:selected").text();
				if(data.trim()=="success" ){ 
					alert("등록 되었습니다.");
					$("#save").attr("disabled", false);
					$("#result").text("등록되었습니다.");
					$("#result").css("color","blue");
					$("#result").css("font-weight","bolder");
					$("#result").css("display","inline");
					setTimeout(function(){$("#result").css("display","none");},1500);
					
				}else{
					alert("오류가 발생했습니다.");
					$("#result").text("오류가 발생하였습니다.");
					$("#result").css("color","red");
					$("#result").css("font-weight","bolder");
					$("#result").css("display","inline");
					setTimeout(function(){$("#result").css("display","none");},1500);
					$("#save").attr("disabled", false);
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
	
	
	//브랜드 리스트 
	function getBrandByTy(ty){
		var url = "${ctxPath}/invn/getBrandList.do";
		var param = "prdctTyCd=" + ty + "&shopTy=shop";
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
	
	function	getAccPrc(){
		if($("#unit").val()=="-2"){
			$("#unit").css("display","none");
			$("#newUnit").css("display","inline");
			$("#trdePrc").attr("readonly",false);
			newUnit = true;
			return;
		}
		var brandId = $("#brandId").val();
		var unit = $("#unit").val();
		var prdctName = $("#prdctId option:selected").text();
		var param = "brandId=" +brandId + 
						"&unit=" + unit +
						"&prdctName=" + prdctName + 
						"&shopTy=shop";
		
		var url = '${ctxPath}/prdct/getClensAccPrc.do';
		 $.ajax({
				url: url,
				type : "post",
				data : param,
				dataType	: "json",
				beforeSend	: function(){
				},
				success		: function(data){
					console.log(data);
					$("#puchasPrc").val(format(data.puchasPrc));
					$("#trdePrc").val(format(data.salePrc));
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
	#newUnit{
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
				<th>브랜드</th><td><select id="brandId" name="brandId" onchange="getClensList();">
										<option value="-1">선택</option>
									</select></td>
				<th width="20%">모델명</th><td width="30%"> <select id="prdctId" name="prdctId" onchange="getPrdctUnit()"><option value="-1">선택</option></select><input type="text" id="newPrdctName" class="test"></td>
				
			</tr>
			<tr>
			<th>용량</th><td><select id="unit" name="unit" onchange="getAccPrc();">
										<option value="-1">선택</option>
									</select>
									<input type="text" id="newUnit">
									</td>
				<th></th><td></td>
				
				
			</tr>
			<tr>
				<th>매입가</th><td><input type="text" id="puchasPrc" name="getPrdctPrc" ></td>
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
