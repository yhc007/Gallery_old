<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script src="${ctxPath}/js/dataTables/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPath}/js/dataTables/css/jquery.dataTables.css">
<script type="text/javascript">
	var csvOutput;
	$(function(){
		getShopList();
		today();
		$("#tabs").tabs();
	});
	
	function today(){
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(String(date.getMonth() +1));
		var day = addZero(String(date.getDate()));
		
		$("#visitorForm input[id='sdate']").val(year + "-" + month);
		$("#visitorForm input[id='edate']").val(year + "-" + month);
		$(".sdate").val(year + "-" + month + "-" + day);
		$(".edate").val(year + "-" + month + "-" + day);
	};
	
	function addZero(n){
		if(n.length=="1"){
			n = "0" + n;
		};
		return n;
	};
	
	function getShopList(){
		var url = "${ctxPath}/shop/getShopList.do";
		
		$.ajax({
			url : url,
			dataType : "json",
			type : "post",
			success : function(json){
				var shop = json.shopList;
				var option = "";
				for(var i = 0; i < shop.length; i++){
					var shopName = replacePlus(decodeURIComponent(shop[i].shopName));
					var shopId = shop[i].shopId;
					var shopNum = shop[i].shopNum;
					option += "<option value='" + shopId + "/" + shopNum + "'>" + shopName + "</option>";
				};
				$(".shopId").html(option);
				getCntVisitor();
			}
		});
	};
	
	function replacePlus(str){
		str = str.replace(/\+/gi," ");
		return str;
	};
	
	function replace(str){
		str = str.replace(/-/gi,".");
		return str;
	};
	function getCntVisitor(){
		var url = "${ctxPath}/cstmr/getCntVisitor.do";
		var shop = $("#visitorForm select[id='shopId']").val().split("/");
		var shopId = shop[0];
		var shopNum = shop[1];
		var sdate = replace($("#visitorForm input[id='sdate']").val()).substr(0,7);
		var edate = replace($("#visitorForm input[id='edate']").val()).substr(0,7);
		
		var param = "shopId=" + shopId +
						"&shopNum=" + shopNum + 
						"&sdate=" + sdate +
						"&edate=" + edate;
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#visitorCntList").html('');
				$("#visitorCntList").html(data);
				if ( $.fn.dataTable.isDataTable( '#visitorCntList' ) ) {
					$("#visitorCntList").dataTable({
						"destroy": true
					});
					$("#visitorCntList").dataTable();
				}else{
					dataTable = $("#visitorCntList").dataTable();
				};		
			}
		});
	};
	
	function getDscntList(){
		var url = "${ctxPath}/admin/getDscntList.do";
		var sdate = replace($("#dscntListForm input[id='sdate']").val());
		var edate = replace($("#dscntListForm input[id='edate']").val());
		var param = "sdate=" + sdate + 
						"&edate=" + edate;
		
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#dscntList").html('');
				$("#dscntList").html(data);
				if ( $.fn.dataTable.isDataTable( '#dscntList' ) ) {
					$("#dscntList").dataTable({
						"destroy": true
					});
					$("#dscntList").dataTable();
				}else{
					dataTable = $("#dscntList").dataTable();
				};		
			}
		});
	};
	
	function getCstmrList(){
		var url = "${ctxPath}/cstmr/getCstmrList.do";
		var sdate = replace($("#cstmrListForm input[id='sdate']").val());
		var edate = replace($("#cstmrListForm input[id='edate']").val());
		var shop = $("#cstmrListForm select[id='shopId']").val().split("/");
		var shopId = shop[0];
		var shopNum = shop[1];
		var param = "sdate=" + sdate + 		
						"&edate=" + edate + 
						"&shopId=" + shopId + 
						"&shopNum=" + shopNum;
		
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type: "post",
			success : function(data){
				$("#cstmrList").html('');
				$("#cstmrList").html(data);
				if ( $.fn.dataTable.isDataTable( '#cstmrList' ) ) {
					$("#cstmrList").dataTable({
						"destroy": true
					});
					$("#cstmrList").dataTable();
				}else{
					dataTable = $("#cstmrList").dataTable();
				};		
			}
		});
	};
	
	function csvData(ty, title){
		var url = "";
		var param = "";
		if(ty=="visitor"){
			url = "${ctxPath}/cstmr/getCntVisitorForCSV.do";
			
			var shop = $("#shopId").val().split("/");
			var shopId = shop[0];
			var shopNum = shop[1];
			var sdate = replace($("#visitorForm input[id='sdate']").val()).substr(0,7);
			var edate = replace($("#visitorForm input[id='edate']").val()).substr(0,7);
			
			var param = "shopId=" + shopId +
							"&shopNum=" + shopNum + 
							"&sdate=" + sdate +
							"&edate=" + edate;
			
		}else if(ty=="dscnt"){
			url = "${ctxPath}/admin/getDscntListForCSV.do";
			
			var sdate = replace($("#dscntListForm input[id='sdate']").val());
			var edate = replace($("#dscntListForm input[id='edate']").val());
			param = "sdate=" + sdate + 
						"&edate=" + edate;
		}else if(ty=="cstmr"){
			url = "${ctxPath}/cstmr/getCstmrVisitListForCSV.do";
			
			var sdate = replace($("#cstmrListForm input[id='sdate']").val());
			var edate = replace($("#cstmrListForm input[id='edate']").val());
			var shop = $("#cstmrListForm select[id='shopId']").val().split("/");
			var shopId = shop[0];
			var shopNum = shop[1];
			param = "sdate=" + sdate + 		
							"&edate=" + edate + 
							"&shopId=" + shopId + 
							"&shopNum=" + shopNum;
			
		};
		$.ajax({
			url : url,
			type : "post",
			data : param,
			dataType : "json",
			beforeSend : function() {
			},
			success : function(json) {
				if(ty=="visitor"){
					csvOutput = "NO, 월, 방문수 LINE";
					var cstmr = json.cstmrList;
					var i = 1;
					$(cstmr).each(function(){
						var month = this.monthly;
						var visitCnt = this.visitCnt;
						
						csvOutput += i + "," + month + "," + visitCnt + " LINE";
						i++;
					});
				}else if(ty=="dscnt"){
					csvOutput = "NO, 협력사, 매장, 건수, 총액 LINE";
					var dscnt = json.dscntList;
					var i = 1;
					$(dscnt).each(function(){
						var comName = replacePlus(decodeURIComponent(this.comName));
						var shopName = replacePlus(decodeURIComponent(this.shopName));
						var cnt = this.cnt;
						var prc= this.prc;
						
						csvOutput += i + "," + 
										comName + "," +
										shopName + "," +
										cnt + "," +
										prc + " LINE";
						i++;
					});
				}else if(ty=="cstmr"){
					csvOutput = "NO, 고객코드, 이름, 전화번호, 휴대전화, 이메일, 주소, SMS 수신, email 수신, 우편수신, 방문일 LINE";
					var cstmr = json.cstmrList;
					var i = 1;
					$(cstmr).each(function(){
						var cstmrCd = this.cstmrCd;
						var cstmrName = replacePlus(decodeURIComponent(this.cstmrName));
						var telephone = this.telephone;
						var cellphone = this.cellphone;
						var email = this.email;
						var addr = replacePlus(decodeURIComponent(this.addr));
						var getSmsYn = this.getSmsYn;
						var getEmailYn = this.getEmailYn;
						var getDmYn = this.getDmYn;
						var datetime = this.datetime;

						csvOutput += i + "," + 
								cstmrCd + "," +
								cstmrName + "," +
								telephone + "," +
								cellphone + "," +
								email + "," +
								addr + "," +
								getSmsYn + "," +
								getEmailYn + "," +
								getDmYn + "," +
								datetime + " LINE";
						i++;
					});
				};
				csvSend(title);
			}
		});
	};
	
	function csvSend(title){
		var sdate = title;
		var edate = "";
		if(title=="매장별 방문객 수"){
			var date1 = replace($("#visitorForm input[id='sdate']").val());
			var date2 = replace($("#visitorForm input[id='edate']").val());
			edate = date1 + " - " + date2;			
		}else if(title=="협력사 할인 내역"){
			var date1 = replace($("#dscntListForm input[id='sdate']").val());
			var date2 = replace($("#dscntListForm input[id='edate']").val());
			edate = date1 + " - " + date2;		
		}else if(title=="기간별 방문 고객"){
			var date1 = replace($("#cstmrListForm input[id='sdate']").val());
			var date2 = replace($("#cstmrListForm input[id='edate']").val());
			edate = date1 + " - " + date2;
		};
		//console.log(csvOutput);
		csvOutput = csvOutput.replace(/\n/gi,"");
		f.csv.value=encodeURIComponent(csvOutput);
		f.startDate.value = sdate;
		f.endDate.value = edate;
		f.submit(); 
	};
	
	function setInit(ty){
		if(ty=="visitor"){
			getCntVisitor();	
		}else if(ty=="dscnt"){
			getDscntList();
		}else if(ty=="cstmr"){
			getCstmrList();
		};
	};
</script>
<style type="text/css">
</style>
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />

<title>Gallery Manager</title>
</head>
<body>
	
	<div id="tabs" style="width: 100%">
		<ul>
		    <li><a href="#tabs-1" onclick="setInit('visitor')">매장별 월 방문객 수</a></li>
		    <li><a href="#tabs-2" onclick="setInit('dscnt')">협력사 할인 내역</a></li>
		    <li><a href="#tabs-3" onclick="setInit('cstmr')">기간별 방문 고객</a></li>
	  	</ul>
	  	
	   <div id="tabs-1">
	   		<center>
	   			<div style="font-weight: bold;">※ 매장, 날짜를 선택 하세요. ※</div>
	   			<form action="" id="visitorForm">
	   				<select class="shopId" id="shopId" data-role="none" onchange="getCntVisitor();">
					</select>

					<input type="month" id="sdate"  data-role="none" onchange="getCntVisitor();"> - 
					<input type="month" id="edate"  data-role="none" onchange="getCntVisitor();">
					<button data-role="none" onclick="csvData('visitor','매장별 방문객 수');return false;"  class="csvBtn" id="csvBtn">엑셀 저장</button>
					<table border="1" width="100%" id="visitorCntList" style="text-align: center;border-collapse: collapse; font-size: 9px">
					
					</table>
	   			</form>
			</center>
	   </div>
	   <div id="tabs-2">
			<center>
				<div style="font-weight: bold;">※ 날짜를 선택 하세요. ※</div>
				<form action="" id="dscntListForm">
					<input type="date" id="sdate" class="sdate" data-role="none" onchange="getDscntList();"> - 
					<input type="date" id="edate" class="edate" data-role="none" onchange="getDscntList();">
					<button onclick="csvData('dscnt','협력사 할인 내역'); return false;" data-role="none" id="csvBtn" class="csvBtn">엑셀 저장</button>
					<table border="1" width="100%" id="dscntList" style="text-align: center;border-collapse: collapse; font-size: 9px">
						
					</table>
				</form>
			</center>
	   </div>
	   <div id="tabs-3">
			<center>
			<div style="font-weight: bold;">※ 매장, 날짜를 선택 하세요. ※</div>
				<form action="" id="cstmrListForm">
					<select class="shopId" id="shopId" data-role="none" onchange="getCstmrList();">
					</select>
					<input type="date" id="sdate" class="sdate" data-role="none" onchange="getCstmrList();"> - 
					<input type="date" id="edate" class="edate" data-role="none" onchange="getCstmrList();">
					<button onclick="csvData('cstmr','기간별 방문 고객'); return false;" class="csvBtn" id="csvBtn"  data-role="none">엑셀 저장</button>
					<table border="1" width="100%" id="cstmrList" style="text-align: center;border-collapse: collapse; font-size: 9px">
					
					</table>
				</form>
			</center>
	   </div>
	</div>
	<!--csv  -->
	<form action='${ctxPath}/sale/csv.do' id="f" method="post">
			<input type="hidden" name="csv" value="">
			<input type="hidden" name="startDate" value="">
			<input type="hidden" name="endDate" value="">
	</form>
</body> 
</html>