<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">

	var year;
	var month;
	var day;
	var csvOutputEu="";
	var csvOutputEsum="";
	var csvOutputUe="";
	var csvOutputUsum="";
	$(function(){
		var date = new Date();
		year = date.getFullYear();
		if((date.getMonth())==0){
			year-=1;
			month = 12;
		}else{
			month = addZero(String(date.getMonth()));	
		}
		
		day = addZero(String(date.getDate()));
		$("#today").val(year + "-" + month + "-" + day);
		
		getPointList();
	});
	
	$(function() {
	    $( "#pointTabs" ).tabs();
	  });
	
	function modifyDate(){
		var date = $("#today").val();
		year = date.substr(0,4);
		month = date.substr(5,2);
		day = date.substr(8,2);
		getCouponList();
	}
	
	function createPointTable(){
		$("#btnCalcPoint").attr("disabled",true);
		$("#btnCreateTable").attr("disabled",true);
		var couponCd = month + day;
		
		var today = year+"."+month + "."+day;
		var url = "${ctxPath}/point/calcShopPoint.do";
		var param = "dateTime=" + today;
		alert(month+"월 포인트 관리 테이블이 생성됩니다. 이 작업은 5분 정도 소요될 수 있습니다.");
		//console.log(param);
		$("#loader").css("display","inline");
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				if(data=="success"){
					alert("정산 성공!");
					$("#btnCalcPoint").attr("disabled",false);
					$("#btnCreateTable").attr("disabled",false);
					getPointList();
				}else{
					alert("정산 실패. 관리자에게 연락 바랍니다.");
				}
				$("#loader").css("display","none");
			}
		}); 
	}

	function getPointList(){
		var url = "${ctxPath}/point/listPointEuTable.do";
		$.ajax({
			url : url,
			//data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				$("#listEuTable").html(data);
			}
		});
		
		var url = "${ctxPath}/point/listPointEsumTable.do";
		$.ajax({
			url : url,
			//data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				$("#listEsumTable").html(data);
			}
		});
		
		var url = "${ctxPath}/point/listPointUeTable.do";
		$.ajax({
			url : url,
			//data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				$("#listUeTable").html(data);
			}
		});
		
		var url = "${ctxPath}/point/listPointUsumTable.do";
		$.ajax({
			url : url,
			//data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				$("#listUsumTable").html(data);
			}
		});
		createTotalCsv();
	};
	
	function createTotalCsv(){
		console.log("run createTotalCsv()");
		var euUrl = "${ctxPath}/point/listPointEuTableCsv.do";
		var euTitle = "NO, 지급매장, 수금매장, 포인트정산 LINE";
		var eSumUrl = "${ctxPath}/point/listPointEsumTableCsv.do";
		var eSumTitle = "NO, 지급매장, 포인트정산 LINE";
		var ueUrl = "${ctxPath}/point/listPointUeTableCsv.do";
		var ueTitle = "NO, 수금매장, 지급매장, 포인트정산 LINE";
		var uSumUrl = "${ctxPath}/point/listPointUsumTableCsv.do";
		var uSumTitle = "NO, 수금매장, 포인트정산 LINE";
		
		createCsv(euUrl, euTitle,'eu');
		createCsv(eSumUrl, eSumTitle,'eSum');
		createCsv(ueUrl, ueTitle,'ue');
		createCsv(uSumUrl, uSumTitle,'uSum');
		
	}
	function createCsv(urls, titles, ty){
		console.log("run createCsv() ty:"+ty);
/* 		$("#csvBtn").attr("disabled",true);
		$("#csvBtn").attr("disabled",false); */
 	
 		var tmpCsvOutput="";
		$.ajax({
			url : urls,
			type : "post",
			dataType : "text",
			beforeSend : function() {
			},
			success : function(data) {
				tmpCsvOutput = titles;
				//data = data.replace(/\n/gi,"");
				var cvs = data.trim().split("|");
				for(var i = 0;  i < cvs.length; i++){
					tmpCsvOutput += "" + cvs[i] + "LINE";
				}
				if(ty=='eu'){
					csvOutputEu = tmpCsvOutput;
				}else if(ty=='eSum'){
					csvOutputEsum = tmpCsvOutput;
				}else if(ty=='ue'){
					csvOutputUe = tmpCsvOutput;
				}else if(ty=='uSum'){
					csvOutputUsum = tmpCsvOutput;
				}else{
					alert("생성 실패. 관리자에게 연락 바랍니다.");
				}
			}
		});
	}
	
	function addZero(n){
		if(n.length=="1"){
			n = "0" + n;
		}
		return n;
	}
	
	function csvTotalSend(ty){
		if(ty==1){
			csvSend(csvOutputEu, "매장별지급금");	
		}else if(ty==2){
			csvSend(csvOutputEsum, "지급금합계");	
		}else if(ty==3){
			csvSend(csvOutputUe, "매장별미수금");	
		}else if(ty==4){
			csvSend(csvOutputUsum, "미수금합계");	
		}
	}
	function csvSend(csvOutput, title){
		console.log("@@@@run csvSend");
		sdate = title;		
		edate = year + month + day;
		csvOutput = csvOutput.replace(/\n/gi,"");
		csvOutput=encodeURIComponent(csvOutput);
		var form = document.createElement("form");
		form.name = 'tempPost';
		form.method = 'post';
		if(title=="매장별지급금"){
			form.action = '${ctxPath}/sale/csv1.do';
		}else if(title=="지급금합계"){
			form.action = '${ctxPath}/sale/csv2.do';
		}else if(title=="매장별미수금"){
			form.action = '${ctxPath}/sale/csv3.do';
		}else if(title=="미수금합계"){
			form.action = '${ctxPath}/sale/csv4.do';
		}
		var param1 = document.createElement("input");
		param1.setAttribute("type", "hidden");
		param1.setAttribute("name", "csv");
		param1.setAttribute("value", csvOutput);
		
		var param2 = document.createElement("input");
		param2.setAttribute("type", "hidden");
		param2.setAttribute("name", "startDate");
		param2.setAttribute("value", sdate);
		
		var param3 = document.createElement("input");
		param3.setAttribute("type", "hidden");
		param3.setAttribute("name", "endDate");
		param3.setAttribute("value", edate);
		$(form).append(param1);
		$(form).append(param2);
		$(form).append(param3);
		$('#body').append(form);
		
		console.log("action:"+form.action);
		form.submit();

	};
</script>
<style type="text/css">
.grayClass{
	background-color: #d3d3d3;
}
.whiteClass{
		background-color: white;
}

#loader{
	display: none;
}
</style>
<title>Point Management</title>
</head>
<body>
	<center>
		<img src="${ctxPath	 }/images/loader.gif" id="loader">
	</center>
	<center>
		<input type="date" id="today" onchange="modifyDate();">
		<button id="btnCalcPoint" onclick="createPointTable();" >월 포인트 정산</button>
		<button id="btnCreateTable" onclick="getPointList();" >포인트 정산 테이블 생성</button>
		<!-- <button onclick="csvTotalSend();" id="csvBtn">액셀 저장</button> -->
	</center>
	
	<div id="pointTabs">
	  <ul>
	    <li><a href="#pointTab1">매장별 지급금</a></li>
	    <li><a href="#pointTab2">지급금 합계</a></li>
	    <li><a href="#pointTab3">매장별 미수금</a></li>
	    <li><a href="#pointTab4">미수금 합계</a></li>
	  </ul>
	  <div id="pointTab1">
	  	<center>
	  		<button onclick="csvTotalSend(1);">액셀 저장</button>
			<table border="1" width="100%" id="listEuTable" style="text-align: center;border-collapse: collapse; font-size: 14px">
			</table>
		</center>
	  </div>
	  <div id="pointTab2">
	    <center>
	    <button onclick="csvTotalSend(2);">액셀 저장</button>
			<table border="1" width="100%" id="listEsumTable" style="text-align: center;border-collapse: collapse; font-size: 14px">
			</table>
		</center>
	  </div>
	  <div id="pointTab3">
	    <center>
	    <button onclick="csvTotalSend(3);">액셀 저장</button>
			<table border="1" width="100%" id="listUeTable" style="text-align: center;border-collapse: collapse; font-size: 14px">
			</table>
		</center>
	  </div>
	  <div id="pointTab4">
	    <center>
	    <button onclick="csvTotalSend(4);">액셀 저장</button>
			<table border="1" width="100%" id="listUsumTable" style="text-align: center;border-collapse: collapse; font-size: 14px">
			</table>
		</center>
	  </div>
	</div>
	
</body> 
</html>