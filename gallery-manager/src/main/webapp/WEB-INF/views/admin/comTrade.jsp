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
	$(function(){
		now();
		getComList();
		getTradeList();
	});
	
	function getComList(){
		var url = "${ctxPath}/shop/getComList.do";
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#iNum").html(data);
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
	
	function removeHypen(str){
		str = str.replace(/-/gi,"");
		return str;
	}
	function ComList(){
		var sdate = removeHypen($("#sdate").val());
		var edate = removeHypen($("#edate").val());
		var url = "${ctxPath}/shop/getComListForTrade.do";
		var param = "sdate=" + sdate +
						"&edate=" + edate;
		
		console.log(param)
		$.ajax({
			url : url,
			data :param,
			dataType : "html",
			type : "post",
			success: function(data){
				$("#comListDiv").html(data);
				$("#comList").popup("open");
			}
		});
		
	}
	
	function getTradeList(){
		var sdate = removeHypen($("#sdate").val());
		var edate = removeHypen($("#edate").val());
		var iNum = $("#iNum").val();
		var url = "${ctxPath}/prdct/getTradeListByCom.do";
		var param = "sdate=" + sdate + 
						"&edate=" + edate + 
						"&iNum=" + iNum;
		console.log(param)
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				console.log(data)
				$("#tradeList").html(data);	
			}
		});
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
	#comList{
		width : 400px;
		padding-bottom : 20px;
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
		<select data-mini="true" id="iNum" name="iNum" data-inline="true" onclick="getTradeList();" >
			<option value="-1">거래처 선택</option>
		</select>
		
		<input type="date" id="sdate" name="sdate" data-role="none" onchange="getTradeList()"> -
		<input type="date" id="edate" name="edate" data-role="none" onchange="getTradeList()">
		<button data-mini="true" data-inline="true" onclick="ComList();">거래 업체 목록</button>

		<br>
		
		
			<table width="90%" id="tradeList">
			
			</table>
		</div>
	</center>

	
	<div id="comList" data-role="popup" >
		<a href="#" data-rel="back" data-role="button" data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
		<h2>거래 업체 목록</h2>
		<center>
			<table width="90%" id="comListDiv"></table>		
		</center>
	</div>
	
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