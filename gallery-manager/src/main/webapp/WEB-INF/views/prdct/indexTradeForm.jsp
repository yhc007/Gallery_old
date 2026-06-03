<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
<script type="text/javascript" src="${ctxPath }/js/jq/jquery.mobile.datepicker.js"></script>
<link rel="stylesheet" href="${ctxPath }/js/jq/jquery.mobile.datepicker.css"/> 

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.css" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.js"></script> 

<script type="text/javascript" src="${ctxPath }/js/jq/jquery.tablesorter.js"></script>
<script type="text/javascript" src="${ctxPath }/js/jq/jquery.tablesorter.widgets.js"></script>

<link rel="stylesheet" href="${ctxPath }/js/jq/theme.blue.css"/>
<link rel="stylesheet" href="${ctxPath }/js/jq/theme.dark.css"/>
<link rel="stylesheet" href="${ctxPath }/js/jq/theme.green.css"/>
<link rel="stylesheet" href="${ctxPath }/js/jq/theme.grey.css"/>
<link rel="stylesheet" href="${ctxPath }/js/jq/theme.ice.css"/>
<link rel="stylesheet" href="${ctxPath }/js/jq/theme.jui.css"/>

<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<!-- <script src="http://code.jquery.com/jquery-1.10.2.js"></script> -->
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script> 

<script type="text/javascript">
	$(function(){
		getTradeData();
		getShopList();
		$("#sdate").datepicker({
			 dateFormat: 'yymmdd'
		});
		$("#edate").datepicker({
			 dateFormat: 'yymmdd'
		});
		
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(String(date.getMonth() + 1));
		var day = addZero(String(date.getDate()));
		
		$("#sdate").val(year+month+day);
		$("#edate").val(year+month+day);
	});
	
	function addZero(n){
		if(n.length=="1"){
			n = "0" + n;
		}
		return n;
	}
	
	//매장 리스트
	function getShopList(){
		var url = "${ctxPath}/shop/shopList.do";
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			success : function (data){
				$("#shopId").append(data);
			}
		});
	}
	
	function getTradeData(){
		$("#tradeTbl").fadeOut(500);
		setTimeout(function(){
			var prdctTy = $("#prdctTy").val();
			var sdate = $("#sdate").val();
			var edate = $("#edate").val();
			var shopId = $("#shopId").val();
			var param = "comTy=" + prdctTy +
							"&sdate=" + sdate + 
							"&edate=" + edate + 
							"&shopId=" + shopId;
			var url =  "${ctxPath}/prdct/getTradeData.do";
			
			$.ajax({
				url : url,
				data : param,
				dataType : "html",
				type : "post",
				success : function(data){
					$("#tradeTbl").html(data);
					$("#tradeTbl").tablesorter();
					$("#tradeTbl").fadeIn(500);
					
				}
			});	
		},500)
		
	}
</script>
<style type="text/css">
	.grayClass{
		background-color: #d3d3d3;
	}
	.whiteClass{
		background-color: white;
	}
</style>
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
</head>
<body>
<center>
	<select id="prdctTy" data-native-menu="false" data-inline="true" onchange="getTradeData();">
		<option value="1" selected="selected">프레임</option>
		<option value="2">렌즈</option>
		<option value="3">콘텍트 렌즈</option>
		<option value="4">렌즈 용액</option>
		<option value="5">기타</option>
	</select>

	<div data-role="fieldcontain">
		<label><select id="shopId" data-inline="true" onchange="getTradeData();"><option value="-1">매장</option></select></label>
		<label><input type="text" id="sdate" data-role="date" onchange="getTradeData()"></label>
		<label><input type="text" id="edate" data-role="date" onchange="getTradeData()"></label>
	</div>

	<form id="trdeForm">
		<table  class='tablesorter-ice' border="1" style="border-collapse: collapse;text-align: center;" id="tradeTbl">
		</table>
	</form>
</center>	
</body>
</html>