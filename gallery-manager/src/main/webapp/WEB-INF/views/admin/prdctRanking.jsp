<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>

<script type="text/javascript">
	var shopId = ${shopId};
	function chkManager(){
			$("#ManagerDiv").popup("open");
			$("#pwd").focus();
		}
	
	function goShopSalesPage(){
		var pwd = $("#pwd").val();
		
		var param = "shopId=" + shopId + 
						"&pwd=" + pwd;
		var url = "${ctxPath}/shop/chkManager.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				if(data=="success"){
					location.href='${ctxPath}/sale/indexSalesHistForm.do';			
				}else{
					alert("비밀번호가 일치하지 않습니다.");
					$("#pwd").focus();
				}
			}
		});
	}

	var itemTy = 1;
	$(function(){
		now();
		getShopId();
		getPrdctRanking();
		$("#frame").addClass("selectedBtn");
	});
	
	function getShopId(){
		var url = '${ctxPath}/shop/shopList.do';
		//javax
		$.ajax({
			type : "post",
			url : url,
			dataType : "text",
			beforeSend : function() {
			},
			success : function(data) {
				$("#shopId").html(data);
			}
		});
	}
	function now(){
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(String(date.getMonth()+1));
		var date = addZero(String(date.getDate()));
		
		$("#sdate").val(year + "-" + month + "-" + date);
		$("#edate").val(year + "-" + month + "-" + date);
	};
	
	function addZero(str){
		if(str.length=="1"){
			str = "0" + str;
		}
		return str;
	}
	
	function remvoeHypen(str){
		str = str.replace(/-/gi,"");
		return str;
	}
	function getPrdctRanking(){
		var url = "${ctxPath}/prdct/getPrdctRanking.do";
		var sdate = remvoeHypen($("#sdate").val());
		var edate = remvoeHypen($("#edate").val());
		var shopId = $("#shopId").val();
		var param = "shopId=" + shopId + 
						"&sdate=" + sdate + 
						"&edate=" + edate +
					  	"&itemTy=" + itemTy;
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#rankList").html(data);
			}
		});
	}
	
	function changeItemTy(ty){
		itemTy = ty;
		$(".itemTy").removeClass("selectedBtn");
		if(ty==1){
			$("#frame").addClass("selectedBtn");
		}else if(ty==2){
			$("#lens").addClass("selectedBtn");
		}else if(ty==3){
			$("#clens").addClass("selectedBtn");
		}else if(ty==4){
			$("#acc").addClass("selectedBtn");
		}else if(ty==5){
			$("#etc").addClass("selectedBtn");
		}
		
		getPrdctRanking();
	}
</script>
<style type="text/css">
	.grayClass{
		background-color: #d3d3d3;
	}
	.whiteClass{
			background-color: white;
	}
	.selectedBtn{
		background-color: #4682b4 !important;
		color : white !important;
	}
	#ManagerDiv{
		width :200px;
		padding : 20px;
	}
</style>
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
</head>
<body>
	<center>
	<div data-role="controllgruop" data-type="horizontal">
		<select data-mini="true" id="shopId" name="shopId" data-inline="true" onchange="getPrdctRanking()">
			<option value="-1">매장선택</option>
		</select>
		
		<input type="date" id="sdate" name="sdate" data-role="none" onchange="getPrdctRanking()"> -
		<input type="date" id="edate" name="edate" data-role="none" onchange="getPrdctRanking()">
		<div data-role="controllgruop" data-type="horizontal">
			<button data-inline="true" data-mini="true" id="frame" class="itemTy" onclick="changeItemTy(1);" >프레임</button>
			<button data-inline="true" data-mini="true" id="lens" class="itemTy" onclick="changeItemTy(2);">렌즈</button>
			<button data-inline="true" data-mini="true" id="clens" class="itemTy" onclick="changeItemTy(3);">콘텍트 렌즈</button>
			<button data-inline="true" data-mini="true" id="acc" class="itemTy" onclick="changeItemTy(4);">렌즈용액</button>
			<button data-inline="true" data-mini="true" id="etc" class="itemTy" onclick="changeItemTy(5);">기타</button>
		</div>
		<br>
		
		
			<table width="90%" id="rankList">
			
			</table>
	</div>
	</center>
	<div id="ManagerDiv" data-role="popup" >
		<a href="#" data-rel="back" data-role="button" data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
		<h2>비밀번호</h2>
		<center>
			<input type="password" id="pwd" onkeypress="if(event.keyCode==13){goShopSalesPage();}">
			<button onclick="goShopSalesPage();" data-inline='true' data-mini='true'>확인</button>		
		</center>
	</div>
</body> 
</html>