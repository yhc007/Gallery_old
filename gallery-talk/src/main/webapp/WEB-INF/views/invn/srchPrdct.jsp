<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		getInvnList();
		getCntryList();
		getComList();
		getColorList();
		getMtrlList();
		$("#save").click(editInvnData)
	});
	
	
	
	function removeHypen(str){
		var result = str.replace(/-/gi,"");
		
		return result;
	}
	
	//재고 정보 변경
	function editInvnData(){
		var url = "${ctxPath}/invn/modifyInvn.do";
		var param = $("#PrdctInfo").serialize() + "&invnHistId=" + invnHistId + "&datetime=" + removeHypen($("#datetime").val() + "&shopId=${shopId}");
		console.log(param)
		$.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				$('#edit').dialog('close');
			}
		});
		
	}
	function getInvnList(sort){
		if(typeof(sort)=="undefined"){
			sort="no";
		}
		var url = "${ctxPath}/invn/getInvnList.do";
		var param = "shopId=${shopId}&sort=" + sort;
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : param,
			success : function(data){
				$("#container").html(data);				
			}
		});
	}
	
	var sort_ty = "ASC";
	function sort(ty){
		ty += sort_ty;
		getInvnList(ty);

		if(sort_ty=="ASC"){
			sort_ty = "DESC";
		}else{
			sort_ty = "ASC";	
		}
	}
	
	function getInvnInfo(prdctId,shopId){
		var url = "${ctxPath}/invn/getInvnHist.do";
		var param = "prdctId=" + prdctId + "&shopId=" + shopId;
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : param,
			success : function(data){
				$('#dialog').html(data);		
			}
		});
		
		  $('#dialog').dialog({
			//bgiframe: true
			 title: "거래 내역"
			 , modal: true
		     , width: 700 // 가로 크기
		     , background: "#000"
		     , position:{my:"center",at:"middle",of: window }
			 , close: function(event, ui){
			}, success:  function(data) {
				
			} 
		});
	}
	
	function invnTyCd(ty){
		if(ty=="00900001"){
			return "입고";
		}else{
			return "출고";
		}
	}
	var brandId;
	var invnHistId;
	function editInvn(invnId){
		$('#dialog').dialog('close');
		var url = "${ctxPath}/invn/editInvn.do";
		var param = "invnHistId=" + invnId;
		$("#result").css("display","none");
		$.ajax({
			url : url,
			dataType : "json",
			type : "post",
			data : param,
			success : function(data){
				console.log(data)
				getBrandByTy(data.prdctTyCd);
				
				$("#prdctId").val(data.prdctId);
				prdctId = data.prdctId;
				prdctName = data.prdctName;
				$("#prdctTyCd").val(data.prdctTyCd);
				$("#mnfCountry").val(data.mnfCountry);
				$("#colorId").val(data.colorId);
				$("#colorId2").val(data.colorId2);
				$("#puchasPrc").val(data.puchasPrc);
				$("#trdePrc").val(data.trdePrc);
				$("#prdctTy").val(data.prdctTy);
				$("#mtrlId").val(data.mtrlId);
				$("#prdctShape").val(data.prdctShape);
				$("#iNum").val(data.iNum);
				$("#cnt").val(data.cnt);
				$("#datetime").val(dateFormat(String(data.datetime)));
				brandId = data.brandId;
				invnHistId = data.invnHistId;
			}
		});
		
		  $("#edit").css("display","inline");
		  $('#edit').dialog({
			//bgiframe: true
			 title: "거래 내역"
			 , modal: true
		     , width: 700 // 가로 크기
		     , background: "#000"
		     , position:{my:"center",at:"middle",of: window }
			 , close: function(event, ui){
			}, success:  function(data) {
				
			} 
		});
		
	};
	
	//데이트 포맷
	function dateFormat(date){
		year = date.substr(0,4);
		month = date.substr(4,2);
		day = date.substr(6,2);
		return year + "-" +month + "-" + day;
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
				//console.log(data);
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
	
	
	var prdctId;
	var prdctName;
	//NFC write
	function NFC_(){
		
		/* NFC.write(shopId, prdctName, prdctId);
		setInterval(function(){
			$("#result").text("NFC 입력이 완료되었습니다.");
			$("#result").css("color","blue");
			$("#result").css("display","inline");
		},1000); */
		
		console.log(shopId +"/" + prdctId + "/" + prdctName)
		window.android2.callAndroid("https://jaguar.s4g.kr/invn/NFC/find.do?shopId=" + "${shopId}" + "&prdctName=" + prdctName + "&prdctId=" + prdctId +"&sort=no");
	}
	
	function getBrandByTy(){
		var url = "${ctxPath}/invn/getBrandList.do";
		var param = "prdctTyCd=" + $("#prdctTyCd").val();
		
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				$("#brandId").html(data);
				$("#brandId").val(brandId)
				getPrdctList();
			}
		});
	};
	
	
	function getPrdctList(){
		$("#prdctName_").css("display","none");
		$("#prdctId").css("display","inline");
		$("#mnfCountry_").css("display","none");
		$("#mnfCountry").css("display","inline");	
		brandId = $("#brandId").val(); 
		
		
		
		var url = "${ctxPath}/prdct/getPrdctListByBrand.do";
	
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : "brandId=" + brandId,
			success : function(data){
				$("#prdctId").html(data);
				$("#puchasPrc").attr("readonly",true);
				$("#trdePrc").attr("readonly",true);
				$("#prdctId").val(prdctId)
			}
		})
	}
	
</script>
<style type="text/css">
	body,#dialog{
			background-image: url("${ctxPath}/images/bg_staff.jpg");
		}
	th{
		background-color: black;
		opacity : 0.9;
		color :white;
	}
	tr{
		background-color: black;
		opacity :0.5;
		color : white;
	}td{
		padding :20px;
	}
	*{
		font-size: 20px;
	}
	input{
		height: 50px;
	}
	table{
		width: 100%;
	}
	#edit{
		display: none;
	}
	#result{
		display: none;
	}
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
	
	</style>
</head>
<body>
<%@include file="include.jsp"%>
<hr>
<center>
	
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			
		</table>
</center>

<div id="dialog"></div>
<div id="edit">
	<center>
	<form id="PrdctInfo">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			<tr>
				<th>상품종류</th><td ><select id="prdctTyCd" name="prdctTyCd" onchange="getBrandByTy()">
									<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>">프레임 </option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>">콘텍트 렌즈 </option>
								</select> </td>
			<th>제조국</th><td><select id="mnfCountry" name="mnfCountry" onchange="getCntry();"><option value="-1">선택</select></td>	
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><select id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();"></select></td>
				<th width="20%">모델명</th><td width="30%"> <select id="prdctId" name="prdctId" onchange="getPrdctPrc()"><option value="-1">선택</option></select></td>
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
				<th>수량</th><td><input type="text" id="cnt" name="cnt" size="3" readonly="readonly"></td>
				<th>입고날짜</th><td><input type="date" id="datetime" name="date"></td>
			</tr>
			
		</table>
	</form>		
	
		<center>
			<div id="result">등록되었습니다.</div>
		</center>	
		<a href="javascript:NFC_();"><img src="${ctxPath }/images/NFC.png" width="100px" id="nfc"></a>
		<button id="save">저장</button>
			
		</center>
</div>
</body>
</html>
