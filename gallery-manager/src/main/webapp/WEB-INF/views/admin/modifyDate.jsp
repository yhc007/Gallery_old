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
	$(function(){
		getiNumList();
		getShopId();
		getTrdeList();
		now();
	});
	
	function getTrdeList(){
		var url = "${ctxPath}/prdct/getTradeListForModify.do";
		var iNum = $("#iNum").val();
		var shopId = $("#shopId").val();
		var sdate = removeHypen($("#sdate").val());
		var edate = removeHypen($("#edate").val());
		
		var param = "iNum=" + iNum + 
					"&shopId=" + shopId + 
					"&sdate=" + sdate + 
					"&edate=" + edate;
		
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#trdeList").html(data);
			}
		});
	}
	
	function getiNumList(){
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
	
	function getShopId(){
		
		var url = '${ctxPath}/shop/shopList.do';
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
	
	var orderId;
	function modifyDate(id, date){
		orderId = id;
		var year = date.substr(0,4);
		var month = date.substr(5,2);
		var day = date.substr(8,2);
		
		$("#datePop").popup('open');
		$("#mdate").val(year + "-" + month + "-" + day);
	}
	
	function moidyDate_(){
		var sdate = $("#mdate").val();
		var url = "${ctxPath}/prdct/modifyDate.do";
		var param = "id=" + orderId + 
					"&sdate=" + sdate + " 11:11:11.0";

		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				if(data=="success"){
					$("#datePop").popup("close");
					getTrdeList();
				}
			}
		});
	}
	
	function delDate_(){
		if(confirm("해당 거래 기록을 삭제하시겠습니까?")==false){
			return;
		};
		var url ="${ctxPath}/prdct/delData.do";
		var param = "id=" + orderId;
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			tpye : "post",
			success : function(data){
				if(data=="success"){
					$("#datePop").popup("close");
					getTrdeList();
				}
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
	

</style>
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
</head>
<body>
	<center>
		<select id="iNum" data-mini="true" data-inline="true" onchange="getTrdeList();">
			<option>거래처 선택</option>
		</select>
		
		<input type="date" id="sdate" data-role="none" onchange="getTrdeList();">-
		<input type="date" id="edate" data-role="none" onchange="getTrdeList();">
		
		<select data-mini="true" id="shopId" name="shopId" data-inline="true" onchange="getTrdeList();">
			<option value="-1">매장선택</option>
		</select>
		<Br>
		
		<table id="trdeList" width="80%">
		
		</table>	
	</center>
	
	<div data-role="popup" id="datePop" style="padding: 10px;">
	<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>	
		<input type="date" id="mdate" data-role="none">
		<center>
			<button data-inline='true' data-mini='true' onclick="moidyDate_()">변경</button>
			<button data-inline='true' data-mini='true' onclick="delDate_()">삭제</button>
		</center>
	</div>
</body> 
</html>
