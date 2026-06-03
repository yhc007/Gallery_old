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
	var newPrdct = false; 
	var prdctId;
	var prdctName;
	var newName = false;
	var mnfCountry;
	var brandId;
	var cnt;
	var puchasPrc;
	var trdePrc;
	var shopId = ${shopId};
	
	$(function() {
		window.sessionStorage.setItem("option","-1")
		window.sessionStorage.setItem("menu","frame");
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(date.getMonth()) + 1;
		var day = addZero(date.getDate());

		//$("#date_").val(year + "-" + month + "-" + day);
		$("#save").click(function (){addPrdct(prdctId);});
		getCntryList();
		getComList();
		getColorList();
		getMtrlList();
		getBrandByTy("0300001");
	});
	
	
	function removeClr(name){
		var index = name.indexOf("(")-1;
		return name = name.substring(0,index);
		
	}
	//NFC write
	function NFC_(){
		
		if(!newPrdct){
			prdctName = removeClr($("#prdctId option:selected").text());	
		}else{
			prdctName = $("#prdctName_").val();
		}
		
		//NFC.write(shopId, prdctName, prdctId);
		setInterval(function(){
			$("#result").text("NFC 입력이 완료되었습니다.");
			$("#result").css("color","white");
			$("#result").css("display","inline");
		},1000);
		
		setInterval(function(){
			$("#result").css("display","none");
		},2000);
	}
	
	
	
	//색상 리스트
	function getColorList(){
		var url = '${ctxPath}/invn/getColorList.do';
	  	
		 $.ajax({
			url		: url,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#colorId").html(data);
				$("#colorId2").html(data);
			}	
		});  
	}
	
	//재질 리스트
	function getMtrlList(){
		var url = '${ctxPath}/invn/getMtrlList.do';
	  	
		 $.ajax({
			url		: url,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#mtrlId").html(data);
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
	
	var oldC1; 
	var oldC2;
	var colorId;
	var colorId2;
	//재고 추가
	function addPrdct(pId){
		var prdctTy = $("#prdctTy").val();
		var mtrlId = $("#mtrlId").val();
		colorId = $("#colorId").val();
		colorId2 = $("#colorId2").val();
		var prdctShape = $("#prdctShape").val(); 
		var cnt = $("#cnt").val();
		var date = $("#date_").val();
		var datetime = removeHypen(date);
		var dateParam;
		var prdct;
		var url;
		var ty_cd = $("#ty_cd").val();
		var iNum = $("#iNum").val();
		var puchasPrc = removeComma($("#puchasPrc").val());
		var trdePrc = removeComma($("#trdePrc").val());
		if(typeof(pId)=="undefined"){
			pId = $("#prdctId").val();
		}
		if(!newPrdct){
			url = "${ctxPath}/invn/addInvn.do";
			dateParam = "&datetime=" + datetime;
			prdct = "&prdctId=" + pId;
		}else if(newPrdct==true){
			
			url = "${ctxPath}/prdct/addPrdctAction.do";
			dateParam = "&whDate=" + datetime;
			prdct = "&prdctName=" + $("#prdctName_").val();
			
		}else if(oldC1!=colorId || oldC2!=colorId2 ){
			url = "${ctxPath}/prdct/addPrdctAction.do";
			dateParam = "&whDate=" + datetime;
			prdct = "&prdctName=" + $("#prdctName_").val();
		}
		if(cnt.length==0){
			alert("수량을 입력하세요.");
			document.getElementById("cnt").focus();
			return;
		}
		
		
		var param = "brandId=" + brandId + prdct + "&cnt=" + cnt + "&shopId=" +shopId + dateParam + "&invnTyCd=00900001" + "&prdctTyCd=" + ty_cd 
		+ "&prdctTy=" + prdctTy + "&mtrlId=" + mtrlId + "&prdctShape=" + prdctShape
		+ "&mnfCountry=" + mnfCountry + "&colorId=" + colorId + "&colorId2=" + colorId2 +"&iNum=" + iNum + "&puchasPrc=" + puchasPrc + "&trdePrc=" + trdePrc +"&prdctVisibleCd=00500002" + 
		"&shopTy=shop";
		
		 $.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				if(data.trim()=="ok" ){
					alert("등록 되었습니다.");
					$("#result").text("등록되었습니다.");
					$("#result").css("color","white");
					$("#result").css("display","inline");
				}else if(data.trim()=="duple"){
					alert("동일한 상품이 있습니다.");
					$("#result").text("동일한 상품이 있습니다.");
					$("#result").css("color","red");
					$("#result").css("display","inline");
					return;
				}else if(data.trim()=="addsuccess"){
					getPrdctId();
					return;
				}else{
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
	
	
	//브랜드 선택 
	function getPrdctList(){
		$("#prdctName_").css("display","none");
		$("#prdctId").css("display","inline");
		$("#mnfCountry_").css("display","none");
		$("#mnfCountry").css("display","inline");	
		brandId = $("#brandId").val(); 
		document.getElementById("prdctId").focus();
		
		
		$("#puchasPrc").val("");
		$("#trdePrc").val("");
		$("#cnt").val("");
		$("#prdctId").val("-1");
		$("#mnfCountry").val("-1");
		$("#colorId").val("-1");
		$("#mtrlId").val("-1");
		
		var url = "${ctxPath}/prdct/getPrdctListByBrand.do";
	
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : "brandId=" + brandId +"&shopTy=shop",
			success : function(data){
				$("#prdctId").html(data);
				newPrdct = false;
				$("#puchasPrc").attr("readonly",true);
				$("#trdePrc").attr("readonly",true);
			}
		})
	}
	
	//모델 선택
	function getPrdctPrc(){
		prdctId = $("#prdctId").val();
		if(prdctId=="-2"){
			$("#prdctName_").css("display","inline");
			$("#prdctId").css("display","none");
			$("#puchasPrc").attr("readonly",false);
			$("#trdePrc").attr("readonly",false);
			newPrdct = true;
			return;
		}
		document.getElementById("cnt").focus();
		var url = '${ctxPath}/prdct/getPrdctData.do';
				 
		 $.ajax({
				url: url,
				type : "post",
				data : "prdctId=" + prdctId + +"&shopTy=shop",
				dataType	: "json",
				beforeSend	: function(){
				},
				success		: function(data){
					 $("#puchasPrc").val(format(data.puchasPrc));
					 $("#trdePrc").val(format(data.trdePrc));
					 //$("#mnfCountry").val(data.mnfCountry);
					 $("#colorId").val(data.colorId);
					 $("#colorId2").val(data.colorId2);
					 $("#prdctTy").val(data.prdctTy);
					 $("#prdctShape").val(data.prdctShape);
					 $("#mtrlId").val(data.mtrlId);
					 
					 puchasPrc = data.puchasPrc;
					 trdePrc = data.trdePrc;
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
	if(!newPrdct || oldC1!=colorId || oldC2!=colorId2){
		prdct = $("#prdctId").text();
		color = "&colorId=" + colorId + "&colorId2=" + colorId2;
		
	}else{
		prdct = $("#prdctName_").val();
		color = "";
		$("#test").css("display","inline");
	}
		var url = "${ctxPath}/invn/getPrdctId.do";
		var param = "shopId=${shopId}" + "&prdctName=" + prdct + color +"&shopTy=shop";
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				prdctId = data.trim();
				newName = true;
				newPrdct = false;
				addPrdct(data.trim());
			}
		});
	}
	
	//브랜드 리스트 
	function getBrandByTy(){
		var url = "${ctxPath}/invn/getBrandList.do";
		var param = "prdctTyCd=" + $("#ty_cd").val() +"&shopTy=shop";
		
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
	#prdctName_,#mnfCountry_{
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
	
</style>
</head>
<body>
<center>
	<form id="PrdctInfo">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			<tr>
				<th>상품종류</th><td ><select id="ty_cd" onchange="getBrandByTy()">
									<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>">프레임 </option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>">콘텍트 렌즈 </option>
								</select> </td>
			<th>제조국</th><td><select id="mnfCountry" name="mnfCountry" onchange="getCntry();"><option value="-1">선택</select><input type="text" id="mnfCountry_"></td>	
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><select id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();">
								<option value="-1">선택</option>
								<c:forEach items="${listBrand}" var="item" varStatus="status">
									<option value="${item.brandId}">${item.brandName}</option>
								</c:forEach> 
							</select> 
				
				</td>
				<th width="20%">모델명</th><td width="30%"> <select id="prdctId" name="prdctId" onchange="getPrdctPrc()"><option value="-1">선택</option></select><input type="text" id="prdctName_" class="test"></td>
			</tr>
			<tr>
				
				<th>색상1</th><td><select id="colorId" name="colorId"><option value="-1">선택</select></td>
				<th>색상2</th><td><select id="colorId2" name="colorId2"><option value="-1">선택</select></td>
				
			</tr>
			<tr>
				<th>매입가</th><td><input type="text" id="puchasPrc" name="puchasPrc" readonly="readonly"></td>
				<th>판매가</th><td><input type="text" id="trdePrc" name="trdePrc" readonly="readonly"></td>
			</tr>
			<tr>
				<th>용도</th><td><select id="prdctTy" name="prdctTy" >
										<option value="-1">선택</option>
										<option value="G">도수용</option>
										<option value="S">선글라스</option>
										<option value="O">고글 </option>
										<option value="W">수경 </option>
										<option value="Z">돋보기 </option>
									</select></td>
				<th>재질</th><td><select id="mtrlId" name="mtrlId"><option value="-1">선택</option></select></td>
			</tr>
			<tr>
				<th>모양</th><td><select id="prdctShape" name="prdctShape" >
										<option value="-1">선택</option>
										<option value="1">온테</option>
										<option value="2">반무테</option>
										<option value="3">무테</option>
									</select></td>
				<th>거래처</th><td><select id="iNum" name="iNum"><option value="-1">선택</option></select></td>
			</tr>
			<tr>
				<th>수량</th><td><input type="text" id="cnt" name="cnt" size="3"></td>
				<th>입고날짜</th><td><input type="text" id="date_" name="date" placeholder="ex)20130101" ></td>
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
