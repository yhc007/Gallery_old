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
	$(function(){
		window.sessionStorage.setItem("option","4");
		getInvnList();
		getCntryList();
		getComList();
		getPrdctCnt();
		$("#save").click(editInvnData)
	});
	
	//총 재고 수량
	function getPrdctCnt(){
		var param = "shopId=${shopId}" + 
						"&comTy=4";
		var url = "${ctxPath}/prdct/getPrdctCnt.do";
		
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				console.log(data);
				$("#total").html("총 수량 : " + data + "개");
			}
		});
	}
	//제품 리스트
	function getClensList(prdctId){
		var url = '${ctxPath}/prdct/getClensList.do';
		
		$.ajax({
			url		: url,
			data : "shopTy=shop", 
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#prdctId").html(data);
				$("#prdctId").val(prdctId)
				getPrdctUnit();
			}	
		});  
	}
	//유닛
	function getPrdctUnit(){
		var url = '${ctxPath}/prdct/getPrdctUnit.do';
		
		var param = "prdctName=" + prdctName + 
						"&shopTy=shop" + 
						"&brandId=" + brandId;
		
		$.ajax({
			url		: url,
			data : param, 
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#unit").html(data);
				$("#unit").val(oldUnit);
			}	
		});  
	}
	
	//브랜드 리스트 
	function getBrandByTy(ty, val){
		var url = "${ctxPath}/invn/getBrandList.do";
		var param = "prdctTyCd=" + ty + "&shopTy=shop";
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				$("#brandId").html(data);
				$("#brandId").val(val);
			}
		});
		
	};
	function removeHypen(str){
		var result = str.replace(/-/gi,"");
		
		return result;
	}
	
	var shopId = "${shopId}";
	function insertDiffAcc(){
		var datetime = removeHypen($("#datetime").val());
		var iNum = $("#iNum").val();
		var puchasPrc = $("#puchasPrc").val();
		var cnt = $("#cnt").val();
		var unit = $("#unit").val();
		var param = "unit=" + unit +
						"&cnt=" + cnt +
						"&prdctName=" +prdctName+
						"&prdctId=" + prdctId +
						"&datetime=" +datetime + 
						"&iNum=" + iNum +
						"&puchasPrc=" + puchasPrc +
						"&invnHistId=" + invnHistId +
						"&brandId=" + brandId +
						"&shopId=" + shopId +
						"&invnTyCd=" +invnTyCd + 
						"&shopTy=shop";
		
		var url = "${ctxPath}/invn/insertDiffAcc.do";
		console.log(param)
		$.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				if(data=="444"){
					alert("해당 제품에 없는 ml입니다.")
				}else{
					$('#edit').dialog('close');
					location.reload();	
				}
				
			}
		});
			
	}

	var oldUnit;
	//재고 정보 변경
	function editInvnData(){
		
		var unit = $("#unit").val();
		if(oldUnit!=unit){
			insertDiffAcc();
			return;
		}
		var prdctId = $("#prdctId").val();
		var datetime = removeHypen($("#datetime").val());
		var iNum = $("#iNum").val();
		var puchasPrc = $("#puchasPrc").val();
		var url = "${ctxPath}/invn/modifyClensAccInvn.do";
		var param = "unit=" + unit +
						"&prdctId=" + prdctId +
						"&datetime=" +datetime + 
						"&iNum=" + iNum +
						"&puchasPrc=" + puchasPrc +
						"&invnHistId=" + invnHistId +
						"&shopTy=shop";
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
		var url = "${ctxPath}/invn/getInvnClensAccList.do";
		var param = "shopId=${shopId}&sort=" + sort + "&shopTy=shop";
		
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
		var url = "${ctxPath}/invn/getClensAccInvnHist.do";
		var param = "prdctId=" + prdctId + "&shopId=" + shopId + "&shopTy=shop";
		
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
	var prdctTyCd;
	var brandId;
	var invnHistId;
	var invnTyCd;
	var invnId_;
	function editInvn(invnId){
		invnId_ = invnId;
		$('#dialog').dialog('close');
		var url = "${ctxPath}/invn/editClensAccInvn.do";
		var param = "invnHistId=" + invnId + "&shopTy=shop";
		$("#result").css("display","none");
		$.ajax({
			url : url,
			dataType : "json",
			type : "post",
			data : param,
			success : function(data){
				console.log(data)
				prdctName = data.prdctName;
				brandId = data.brandId;
				getBrandByTy("00300004",data.brandId);
				invnTyCd = (data.invnTyCd)
				$("#prdctId").val(data.prdctId);
				getClensList(data.prdctId);
				prdctId = data.prdctId;
				$("#mnf_country").val(data.mnfCountry);
				$("#unit").val(data.unit)
				oldUnit = data.unit;
				$("#prdctTyCd").val(data.prdctTyCd);
				$("#mnfCountry").val(data.mnfCountry);
				$("#puchasPrc").val(data.puchasPrc);
				$("#trdePrc").val(data.trdePrc);
				$("#brandId").val(data.brandId)
				$("#iNum").val(data.inum);
				$("#cnt").val(data.cnt);
				$("#datetime").val(dateFormat(String(data.datetime)));
				$("#brandId").val(data.brandId);
				prdctTyCd = data.prdctTyCd;
				
				invnHistId = data.invnHistId;
				
				
				console.log("prdctId : "+ prdctId)
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
		NFC.write('${shopId}', prdctName, prdctId);
		setInterval(function(){
			$("#result").text("NFC 입력이 완료되었습니다.");
			$("#result").css("color","blue");
			$("#result").css("display","inline");
		},1000); 
		
	}
	
	
	
	
	
	var del = false;
	function delHistData(histId){
		if(!del){
			$("#" + histId).html("확인");
			$("#" + histId).addClass("delBtn");	
			del = true;
		}else{
			delHist(histId);
			del = false;
		}
		
	};
	
	
	function delHist(histId){
		var url = "${ctxPath}/prdct/delClensAccHistData.do";
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : "invnHistId=" + histId + "&shopTy=shop",
			success : function(data){
				getInvnList();
				//getPrdctCnt();
				$("#dialog").dialog("close");
			}
		})
	};
	
	
</script>
<style type="text/css">
	.delBtn{
		background-color: red;
	}
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
	#lensacc_{
		color : blue;
	}
	#total{
		font-weight: bolder;
		color: black;
	}
	</style>
</head>
<body>
<%@include file="includeM.jsp"%>
<hr>
<center>
	<span id="total"></span>
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
				<th>브랜드</th><td><select id="brandId" name="brandId" onchange="getClensList();" disabled="disabled">
										<option value="-1">선택</option>
									</select></td>
				<th width="20%">모델명</th><td width="30%"> <select id="prdctId" disabled="disabled" name="prdctId" onchange="getPrdctUnit()"><option value="-1">선택</option></select></td>
				
			</tr>
			<tr>
			<th>용량</th><td><select id="unit" name="unit" onchange="getAccPrc();">
										<option value="-1">선택</option>
									</select>
									
									</td>
			<th></th><td></td>
				
				
			</tr>
			<tr>
				<th>매입가</th><td><input type="text" id="puchasPrc" name="getPrdctPrc" ></td>
				<th>판매가</th><td><input type="text" id="trdePrc" name="trdePrc" readonly="readonly"></td>
			</tr>
			<tr>
				<th>수량</th><td><input type="text" id="cnt" name="cnt" size="3"></td>
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
