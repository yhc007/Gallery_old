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
	$(function(){
		window.sessionStorage.setItem("option","2");
		getInvnList();
		getCntryList();
		getComList();
		getMtrlList();
		getfunctionList();
		
		
		$("#save").click(editInvnData)
	});
	//rate리스트
	function getRateList(rate){
		var param = "brandId=" + brandId + "&mtrl=" + mtrl + "&tyId=" + tyId + "&prdctName=" + prdctName;
		var url = '${ctxPath}/prdct/getLensData.do';
		 $.ajax({
				url: url,
				data : param,
				type : "post",
				dataType	: "html",
				beforeSend	: function(){
				},
				success		: function(data){
					$("#rate").html(data)
					$("#rate").val(rate)
				}
			});  
	}
	
	//제품 리스트
	function getPrdctList(prdctId){
		
		var url = "${ctxPath}/prdct/getPrdctListLens.do";
		var param = "edit='true'" + "&mtrl=" + mtrl + "&tyId=" + tyId; 
		
		
		$.ajax({
			url : url,
			dataType : "html",
			data : param,
			type : "post",
			success : function(data){
				$("#prdctId").html(data);
				$("#prdctId").val(prdctId);
			}
		})
	}
	//기능 리스트
	
	function getfunctionList(){
		var url = '${ctxPath}/prdct/getFunction.do';
		
		
		$.ajax({
			url		: url,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#tyId").html(data);
			}	
		});  
	}
	
	
	function removeHypen(str){
		var result = str.replace(/-/gi,"");
		
		return result;
	}
	
	function insertDiffLens(){
		var url = "${ctxPath}/invn/insertDiffLens.do";
		var rate = $("#rate").val();
		var datetime = removeHypen($("#datetime").val());
		var iNum = $("#iNum").val();
		var puchasPrc = $("#puchasPrc").val();
		var cnt = $("#cnt").val();
		var param = "rate=" + rate +
						"&prdctName=" + prdctName + 
						"&prdctId=" + prdctId +
						"&tyId=" + tyId + 
						"&mtrl=" + mtrl + 
						"&brandId=" + brandId + 
						"&datetime=" +datetime + 
						"&iNum=" + iNum +
						"&puchasPrc=" + puchasPrc +
						"&invnHistId=" + invnHistId + 
						"&shopId=" + shopId + 
						"&cnt=" + cnt;
		$.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				$('#edit').dialog('close');
				location.reload();
			}
		});
	}
	var oldRate;
	//재고 정보 변경
	function editInvnData(){
		var rate = $("#rate").val();
		if(oldRate != rate ){
			insertDiffLens();
			return;
		}
		var rate = $("#rate").val();
		var prdctId = $("#prdctId").val();
		var tyId = $("#tyId").val();
		var mtrl = $("#mtrl").val();
		var datetime = removeHypen($("#datetime").val());
		var iNum = $("#iNum").val();
		var puchasPrc = $("#puchasPrc").val();
		var url = "${ctxPath}/invn/modifyLensInvn.do";
		var param = "rate=" + rate +
						"&prdctId=" + prdctId +
						"&tyId=" + tyId + 
						"&mtrl=" + mtrl + 
						"&datetime=" +datetime + 
						"&iNum=" + iNum +
						"&puchasPrc=" + puchasPrc +
						"&invnHistId=" + invnHistId;
		$.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				$('#edit').dialog('close');
				location.reload();
			}
		});
		
	}
	function getInvnList(sort){
		if(typeof(sort)=="undefined"){
			sort="no";
		}
		var url = "${ctxPath}/invn/getInvnLensList.do";
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
		var url = "${ctxPath}/invn/getLensInvnHist.do";
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
	var invnHistId;
	var prdctName;
	var prdctTyCd;
	var brandId;
	var invnHistId;
	var invnTyCd;
	var mtrl;
	var tyId;
	var rate;
	var shopId = "${shopId}";
	function editInvn(invnId){
		$('#dialog').dialog('close');
		var url = "${ctxPath}/invn/editLensInvn.do";
		var param = "invnHistId=" + invnId;
		$("#result").css("display","none");
		$.ajax({
			url : url,
			dataType : "json",
			type : "post",
			data : param,
			success : function(data){
				console.log(data)
				invnTyCd = (data.invnTyCd)
				prdctId = data.prdctId;
			
				prdctName = data.prdctName;
				$("#mnfCountry").val(data.mnfCountry);
				$("#puchasPrc").val(data.puchasPrc);
				$("#trdePrc").val(data.trdePrc);
				$("#iNum").val(data.inum);
				$("#cnt").val(data.cnt);
				$("#datetime").val(dateFormat(String(data.datetime)));
				mtrl = data.mtrl;
				tyId = data.tyId;
				brandId = data.brandId;
				$("#mtrl").val(data.mtrl)
				$("#tyId").val(data.tyId);
				
				rate = data.rate;
				getPrdctList(data.prdctId);
				getRateList(data.rate);
				oldRate = data.rate;
				
				invnHistId = data.invnHistId;
				
				
			}
		});
		
		  $("#edit").css("display","inline");
		  $('#edit').dialog({
			//bgiframe: true
			 title: "수정"
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
	
	
	var prdctId;
	var prdctName;
	//NFC write
	function NFC_(){
		NFC.write('${shopId}', prdctName, prdctId);
		setInterval(function(){
			$("#result").text("NFC 입력이 완료되었습니다.");
			$("#result").css("color","blue");
			$("#result").css("display","inline");
		},1000); 
		
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
	
	
	
	
	function delHistData(histId){
		$("#confirm").css("display","inline");
		var btn = $("#confirm");
		btn.click(function(){
			del(histId);
		});
	};
	
	
	function del(histId){
var url = "${ctxPath}/prdct/delLensHistData.do";
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : "invnHistId=" + histId,
			success : function(data){
				location.reload();
			}
		})
		setInterval(function(){
			location.reload();
		},1000);
	}
	
	
	
	
</script>
<style type="text/css">
	body{
		background-image: url("${ctxPath}/images/bg_staff.jpg");
	}
	th{
		background-color: black;
		opacity : 0.9;
		color :white;
	}
	/* tr{
		background-color: black;
		opacity :0.5;
		color : white;
	
	} */#edit{
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
	select{
		height: 40px;
	}
	table{
		color : white;
		background-color:black;
	}
	#confirm{
		display : none;
	}
	.subTitle{
		font-size: 25px;
		margin: 10px;
		color : white;
	}
	#lens_{
		color : blue;
	}
	</style>
</head>
<body>
<%@include file="includeM.jsp"%>
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
				<th>제조국</th><td><select id="mnfCountry" name="mnfCountry" onchange="getCntry();"><option value="-1">선택</select></td>
				<th>거래처</th><td><select id="iNum" name="iNum"><option value="-1">선택</option></select></td>	
			</tr>
			<tr>
				<input type="hidden"id="brandId">
				<th>재질</th><td><select id="mtrl" name="mtrl" onchange="getfunctionList();" disabled="disabled">
										<option value="-1">선택</option>
									</select></td>
				<th>기능</th><td><select id="tyId" name="tyId" onchange="getPrdctList();" disabled="disabled">
										<option value="-1">선택</option>
									</select></td>
			</tr>
			<tr>
				
				<th width="20%">모델명</th><td width="30%"> <select id="prdctId" name="prdctId" disabled="disabled" ><option value="-1">선택</option></select></td>
				<th></th><td><select id="rate" onchange="getPrdctPrc()">
									<option value='-1'>선택</option>									
								</select>
							</td>
			</tr>
			<tr>
				<th>매입가</th><td><input type="text" id="puchasPrc" name="puchasPrc" ></td>
				<th>판매가</th><td><input type="text" id="trdePrc" name="trdePrc" readonly="readonly"></td>
			</tr>
			<tr>
				<th>수량</th><td><input type="text" id="cnt" name="cnt" size="3" readonly="readonly"></td>
				<th>입고날짜</th><td><input type="date" id="datetime" name="datetime" placeholder="ex)20130101" ></td>
			</tr>
			
		</table>
		<div id="histId"></div>
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
