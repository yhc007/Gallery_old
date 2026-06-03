<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<%-- <script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script> --%>
<%-- <script src="${ctxPath}/js/jqUi/1.10.3/jquery-ui.js"></script> --%>

<script src="${ctxPath}/js/dataTables/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPath}/js/dataTables/css/jquery.dataTables.css">

<!-- <link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.css"> -->
<script type="text/javascript">

	var year;
	var month;
	var day;
	$(function(){
		var date = new Date();
		year = date.getFullYear();
		month = addZero(String(date.getMonth() + 1));
		day = addZero(String(date.getDate()))
		
		$("#today").val(year + "-" + month + "-" + day);
		getCouponList();
	});
	
	function modifyDate(){
		var date = $("#today").val();
		year = date.substr(0,4);
		month = date.substr(5,2);
		day = date.substr(8,2);
		getCouponList();
		
	}
	function createCoupon(){
		$("#couponBtn").attr("disabled",true);
		$("#csvBtn").attr("disabled",true);
		var couponCd = month + day;
		
		var today = month + "." + day;
		var url = "${ctxPath}/fileserver/createCoupon.do";
		var param = "birthDay=" + today + 
						"&couponCd=" + couponCd + 
						"&birthDayTyCd=00600001";
		//console.log(param)
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				if(data=="success"){
					createCouponForLunar();
				}
			}
		}); 
	}
	
	function createCouponForLunar(){
		console.log("Lunar")
		var today = year + "." + month + "." + day;
		var param = "birthDay=" + today;
		var url = "${ctxPath}/fileserver/createCouponForLunar.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				//console.log(data);
				$("#couponBtn").attr("disabled",false);
				getCouponList();
			}
		});
	}
	
	function getCouponList(){
		$("#csvBtn").attr("disabled",true);
		var param = "couponCd=" + String(year).substr(2,3) + month + day;
		var url = "${ctxPath}/fileserver/getCouponList.do";
		
		var url_lang = "${ctxPath}/js/dataTables/lang/Korean.txt";
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				console.log('data:'+data);
				$("#couponList").html('');
				$("#couponList").html(data);
				if ( $.fn.dataTable.isDataTable( '#couponList' ) ) {
					console.log('duple!');
					console.log('destory!');
					$("#couponList").dataTable({
						"destroy": true
					});
					/* $("#couponList").dataTable({
						"language": {
							"url" : url_lang
				        }
					}); */
					
					$("#couponList").dataTable();
				}else{
					dataTable = $("#couponList").dataTable({
						/* "language": {
							"url" : url_lang
				        } */
						"failure":function(result){alert(result.sEcho);}
					}); 
						
				}
					
				csvData();
			}
		});
	};

	function csvData(ty){
		var param = "couponCd=" + String(year).substr(2,3) + month + day;
		var url = "${ctxPath}/fileserver/getCouponListCsv.do";
		
		$.ajax({
			url : url,
			type : "post",
			data : param,
			dataType : "text",
			beforeSend : function() {
			},
			success : function(data) {
				//console.log(data)
				csvOutput = "NO, 관리번호, 이름, 회원코드, 최근방문, 이메일, 휴대전화,처리일자, 처리지점, 비고 LINE";
				//data = data.replace(/\n/gi,"");
				var cvs = data.trim().split("|");
				for(var i = 0;  i < cvs.length; i++){
					csvOutput += "" + cvs[i] + "LINE";
				}
				$("#csvBtn").attr("disabled",false);
			}
		});
	}
	
	function addZero(n){
		if(n.length=="1"){
			n = "0" + n;
		}
		return n;
	}
	
	function csvSend(){
		sdate = "생일쿠폰";
		edate = year + month + day;
		//console.log(csvOutput);
		csvOutput = csvOutput.replace(/\n/gi,"");
		f.csv.value=encodeURIComponent(csvOutput);
		f.startDate.value = sdate;
		f.endDate.value = edate;
		f.submit(); 
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
<title>Coupon Management</title>
</head>
<body>
	<center>
		<input type="date" id="today" onchange="modifyDate();">
		<button id="couponBtn" onclick="createCoupon();" >쿠폰 생성</button>
		<button onclick="csvSend();" id="csvBtn">액셀 저장</button>
	</center>
	
	<center>
		<table border="1" width="100%" id="couponList" style="text-align: center;border-collapse: collapse; font-size: 9px">
		
		</table>
	</center>
	
	
	<!--csv  -->
	<form action='${ctxPath}/sale/csv.do' id="f" method="post">
			<input type="hidden" name="csv" value="">
			<input type="hidden" name="startDate" value="">
			<input type="hidden" name="endDate" value="">
	</form>
</body> 
</html>