<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gallery Comunity</title>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>


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
<script type="text/javascript" src="${ctxPath }/js/jq/jquery.mobile.datepicker.js"></script>
<link rel="stylesheet" href="${ctxPath }/js/jq/jquery.mobile.datepicker.css"/>  
<script type="text/javascript">
	$(function(){
		$("#sdate").datepicker({
			 dateFormat: 'yymmdd'
		});
		$("#edate").datepicker({
			 dateFormat: 'yymmdd'
		});
		$("#sdateS").datepicker({
			 dateFormat: 'yymmdd'
		});
		$("#edateS").datepicker({
			 dateFormat: 'yymmdd'
		});
		$("#sdateA").datepicker({
			 dateFormat: 'yymmdd'
		});
		$("#edateA").datepicker({
			 dateFormat: 'yymmdd'
		});
		getComList();
		getShopList();
		getTradeGroupData('comName');
		now();
		
		sdate_ = $("#sdate").val();
		edate_ = $("#edate").val();
		sdateS = $("#sdateS").val();
		edateS = $("#edateS").val();
	});
	
	
	var csvOutput = "매장, 매출금액, 반품금액, 결제금액line";
	
	function csvSend(){
		sdate_ = $("#sdate").val();
		edate_ = $("#edate").val();
		console.log(csvOutput);
		csvOutput = csvOutput.replace(/\n/gi,"");
		f.csv.value=encodeURIComponent(csvOutput);
		f.startDate.value = sdate_;
		f.endDate.value = edate_;
		f.submit(); 
	}
	
	function csvData(){
		var url =  "${ctxPath}/prdct/getTradeDataCsv.do";
		sdate_ = $("#sdate").val();
		edate_ = $("#edate").val();
		var iNum = $("#iNum").val();
		var param = "iNum=" + iNum + 
						"&sdate=" + sdate_ +
						"&edate=" + edate_;
		$.ajax({
			url : url,
			type : "post",
			data : param,
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				console.log(data)
				csvOutput = "협력업체 : " + $("#iNum option:selected").text() + ",,,,기간 : " + sdate_ + "~" + edate_ + "lineNO,매장, 매출금액, 반품금액, 결제금액line";
				//data = data.replace(/\n/gi,"");
				var cvs = data.trim().split("|");
				for(var i = 0;  i < cvs.length; i++){
					csvOutput += "" + cvs[i] + "line";
				}
			}
		});
	}
	
	var sdate_;
	var edate_;
	var order = "D";
	function getTradeGroupData(sort){
		sdate_ = $("#sdate").val();
		edate_ = $("#edate").val();
		$("#tradeTbl").fadeOut(500);
		setTimeout(function(){
			var iNum = $("#iNum").val();
			if(iNum!="-1"){
				$("#csvBtn").css("display","inline");
			}
			var prdctTy = $("#prdctTy").val();
			var param = "comTy=" + prdctTy +
							"&sdate=" + sdate_ + 
							"&edate=" + edate_ + 
							"&shopId=-1" +  
							"&iNum=" + iNum + 
							"&sort=" + sort + order;
			var url =  "${ctxPath}/prdct/getTradeGroupData.do";
			
			if(order=="D"){
				order = "A";
			}else{
				order = "D";
			}
			
			$.ajax({
				url : url,
				data : param,
				dataType : "html",
				type : "post",
				success : function(data){
					sum = 0;
					tax = 0;
					tax2 = 0;
					total = 0;
					sum_ = 0;
					tax_ = 0;
					tax2_ = 0;
					total_ = 0;
					
					$("#tradeTbl").html(data);
					$("#tradeTbl").tablesorter();
					$("#tradeTbl").fadeIn(500);
					//csvData();
				}
			});	
		},500)
	}
	function getShopList(){
		var url = "${ctxPath}/shop/selectAllShop.do";
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#shopId").append(data);
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
	
	function addZero(n){
		if(n.length=="1"){
			n = "0" + n;
		}
		return n;
	}
	function now(){
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(String(date.getMonth()+1));
		var day = addZero(String(date.getDate()));
		
		$(".date").val(year + month + day);
	}
	
	
	var order2 = "D";
	function getTradeDataS(sort){
		var shopId = $("#shopId").val();
		sdateS = $("#sdateS").val();
		edateS = $("#edateS").val();
		$("#tradeTblS").fadeOut(500);
		
		setTimeout(function(){
			var prdctTy = $("#prdctTyS").val();
			var param = "comTy=" + prdctTy +
							"&sdate=" + sdateS + 
							"&edate=" + edateS + 
							"&shopId=" + shopId +   
							"&iNum=-1" + 
							"&sort=" + sort + order2;
			var url =  "${ctxPath}/prdct/getTradeGroupDataS.do";
			
			if(order2=="D"){
				order2 = "A";
			}else{
				order2 = "D";
			}
			$.ajax({
				url : url,
				data : param,
				dataType : "html",
				type : "post",
				success : function(data){
					sum = 0;
					tax = 0;
					tax2 = 0;
					total = 0;
					sum_ = 0;
					tax_ = 0;
					tax2_ = 0;
					total_ = 0;
					
					$("#tradeTblS").html(data);
					$("#tradeTblS").tablesorter();
					$("#tradeTblS").fadeIn(500);
					
				}
			});	
		},500)
		
	}
	var sum = 0;
	var tax = 0;
	var tax2 = 0;
	var total = 0;
	var sum_ = 0;
	var tax_ = 0;
	var tax2_ = 0;
	var total_ = 0;
	function getSum(n, div){
		if(div=="sum"){
			sum += n;
		}else if(div=="tax"){
			tax += n;
		}else if(div=="tax2"){
			tax2 += n;
		}else if(div=="total"){
			total += n;
		}
		
		$(".sum").html(format(parseInt(sum)));
		$(".tax").html(format(parseInt(tax)));
		$(".tax2").html(format(parseInt(tax2)));
		$(".total").html(format(parseInt(total)));
	}
	
	var frameTotal = 0;
	var lensTotal = 0;
	var clensTotal = 0;
	var accTotal = 0;
	var etcTotal = 0;
	var revenu = 0;
	var totalAll = 0;
	
	function sumAll(div, n){
		if(div=="frameTotal"){
			frameTotal += parseInt(n);
		}else if(div=="lensTotal"){
			lensTotal += parseInt(n);
		}else if(div=="clensTotal"){
			clensTotal += parseInt(n);
		}else if(div=="accTotal"){
			accTotal += parseInt(n);
		}else if(div=="etcTotal"){
			etcTotal += parseInt(n);
		}else if(div=="sum_"){
			sum_ += parseInt(n);
		}else if(div=="tax_"){
			tax_ += parseInt(n);
		}else if(div=="total_"){
			totalAll += parseInt(n);
			console.log(n)
		}else if(div=="revenue"){
			revenu += parseInt(n);
		}
		console.log("TOTAL : " + totalAll)
		$(".frameTotal").html(format(parseInt(frameTotal)));
		$(".lensTotal").html(format(parseInt(lensTotal)));
		$(".clensTotal").html(format(parseInt(clensTotal)));
		$(".accTotal").html(format(parseInt(accTotal)));
		$(".etcTotal").html(format(parseInt(etcTotal)));
		$(".sum_").html(format(parseInt(sum_)));
		$(".tax_").html(format(parseInt(tax_)));
		$(".total_").html(format(parseInt(sum_ + tax_)));
		$(".revenue").html(format(parseInt(revenu)));
	}
	
	function getSum2(n, div){
		if(div=="sum"){
			sum_ += n;
		}else if(div=="tax"){
			tax_ += n;
		}else if(div=="tax2"){
			tax2_ += n;
		}else if(div=="total"){
			total_ += n;
		}
		
		$(".sum_").html(format(parseInt(sum_)));
		$(".tax_").html(format(parseInt(tax_)));
		$(".tax2_").html(format(parseInt(tax2_)));
		$(".total_").html(format(parseInt(total_)));
	}
	
	function format(n) {
		  var reg = /(^[+-]?\d+)(\d{3})/;   
		  n += '';                          

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');

		  return n;
		}
	
	
	function shopPage(){
		$.mobile.changePage("#shop", {transition: "flip"});
		getTradeDataS("shopName");	
	}
	
	function comPage(){
		$.mobile.changePage("#com", {transition: "flip"});
		getTradeGroupData("comName");	
	}
	
	function allSales(){
		$.mobile.changePage("#all", {transition: "flip"});
		getTradeListAll();
	}
	
	function allSalesC(){
		$.mobile.changePage("#allC", {transition: "flip"});
		getTradeListAllC();
	}
	var iNumP;
	var shopIdP;
	var comTyP;
	var sdateP;
	var edateP;
	function getDetail(iNum, shopId){
		
		
		var comTy = $("#prdctTy").val();
		var param = "iNum=" + iNum + 
					  "&shopId=" + shopId + 
					  "&sdate=" + sdate_ + 
					  "&edate=" + edate_ +
					  "&comTy=" + comTy;
		
		iNumP = iNum;
		shopIdP = shopId;
		comTyP = comTy;
		sdateP = sdate_;
		edateP = edate_;
		
		var url =  "${ctxPath}/prdct/getTradeData.do";
			$.ajax({
				url : url,
				data : param,
				dataType : "html",
				type : "post",
				success : function(data){
					sum = 0;
					tax = 0;
					tax2 = 0;
					total = 0;
					sum_ = 0;
					tax_ = 0;
					tax2_ = 0;
					total_ = 0;
					totalAll = 0;
					
					$("#dialog").popup("open");
					$("#detailDiv").html(data);
					$("#tradeDetailS").tablesorter();
				}
			});	
	}
	
	function getDetailS(iNum, shopId){
		var comTy = $("#prdctTyS").val();
		var param = "iNum=" + iNum + 
					  "&shopId=" + shopId + 
					  "&sdate=" + sdateS + 
					  "&edate=" + edateS +
					  "&comTy=" + comTy;
		
		
		iNumP = iNum;
		shopIdP = shopId;
		comTyP = comTy;
		sdateP = sdateS;
		edateP = edateS;
	
		var url =  "${ctxPath}/prdct/getTradeDataS.do";
			$.ajax({
				url : url,
				data : param,
				dataType : "html",
				type : "post",
				success : function(data){
					sum = 0;
					tax = 0;
					tax2 = 0;
					total = 0;
					sum_ = 0;
					tax_ = 0;
					tax2_ = 0;
					total_ = 0;
					totalAll = 0;
					
					$("#dialogS").popup("open");
					$("#detailDivS").html(data);
					$("#tradeDetailS").tablesorter();
				}
			});	
	}
	
	
	
	function goPrintPage(){
		location.href = "${ctxPath}/prdct/goPrintPage.do?iNum=" + iNumP + "&shopId=" + shopIdP + "&comTy=" + comTyP + "&sdate=" + sdateP + "&edate=" + edateP;
	}
	
	
	
	function goPrintPageS(){
		location.href = "${ctxPath}/prdct/goPrintPageS.do?iNum=" + iNumP + "&shopId=" + shopIdP + "&comTy=" + comTyP + "&sdate=" + sdateP + "&edate=" + edateP;
	}
	
	function printAllTrde(ty){
		var url;
		var iNum = $("#iNum").val();
		if(ty=="C"){
			sdate_ = $("#sdate").val();
			edate_ = $("#edate").val();
			url = "${ctxPath}/prdct/getTradeDataCsv.do?sdate=" + sdate_ + "&edate=" + edate_ + "&iNum=" + iNum;
		}else{
			sdate_ = $("#sdateS").val();
			edate_ = $("#edateS").val();
			url = "${ctxPath}/prdct/getTradeDataCsvS.do?sdate=" + sdate_ + "&edate=" + edate_ + "&iNum=" + iNum;
		}
		
		
		location.href = url;
	}
	
	function getTradeListAll(){
		
		
		sdate_ = $("#sdateA").val();
		edate_ = $("#edateA").val();
		var param = "sdate=" + sdate_ + 
						"&edate=" + edate_;
		$("#tradeTbl").fadeOut(500);
		setTimeout(function(){
			
			var url = "${ctxPath}/prdct/getTradeListAll.do";
			$.ajax({
				url : url,
				data : param,
				dataType : "html",
				type : "post",
				success : function(data){
					frameTotal = 0;
					lensTotal = 0;
					clensTotal = 0;
					accTotal = 0;
					etcTotal = 0;
					revenu = 0;
					sum_ = 0;
					tax_ = 0;
					total = 0;
					revenue = 0;
					
					$("#tradeTblA").html(data);
					$("#tradeTblA").tablesorter();
					$("#tradeTblA").fadeIn(500);
					
				}
			});	
		},500)
	}
	
function getTradeListAllC(){
		
		
		sdate_ = $("#sdateC").val();
		edate_ = $("#edateC").val();
		var param = "sdate=" + sdate_ + 
						"&edate=" + edate_;
		$("#tradeTblC").fadeOut(500);
		setTimeout(function(){
			
			var url = "${ctxPath}/prdct/getTradeListAllC.do";
			$.ajax({
				url : url,
				data : param,
				dataType : "html",
				type : "post",
				success : function(data){
					sum = 0;
					tax = 0;
					tax2 = 0;
					total = 0;
					sum_ = 0;
					tax_ = 0;
					tax2_ = 0;
					total_ = 0;
					totalAll = 0;
					frameTotal = 0;
					lensTotal = 0;
					clensTotal = 0;
					accTotal = 0;
					etcTotal = 0;
					revenu = 0;
					sum_ = 0;
					tax_ = 0;
					total = 0;
					revenue = 0;
					
					$("#tradeTblC").html(data);
					$("#tradeTblC").tablesorter();
					$("#tradeTblC").fadeIn(500);
					
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
	#dialog{
		position: fixed;
		top: 5px;
		left: 200px;
	}
	#csvBtn{
		display: none;
	}
</style>
</head>
<body>
	<div data-role="page" id="com">
		<div rata-role="content">
			<center>
				<a href="#" data-role="button" data-inline="true" >협력사</a>
				<button onclick="shopPage();" data-inline="true" >매장</button>
				<button onclick="allSalesC();" data-inline="true" >전체</button>
				
				<br><br>
				
				<select id="prdctTy" data-native-menu="false" data-inline="true" onchange="getTradeGroupData('comName')">
					<option value="1" selected="selected">프레임</option>
					<option value="2">렌즈</option>
					<option value="3">콘텍트 렌즈</option>
					<option value="4">렌즈 용액</option>
					<option value="5">기타</option>
				</select>

	<div data-role="fieldcontain" style="width: 600px">
		<label><select id="iNum" data-inline="true" onchange="getTradeGroupData('comName')"><option value="-1">협력사 전체</option></select></label>
		<!-- <label><button data-inline="true"  onclick="csvSend(); return false;" id="csvBtn">엑셀</button> </label> -->
		<label><button onclick="printAllTrde('C');">출력</button> </label>
		<label><input type="text" id="sdate" data-role="date" onchange="getTradeGroupData('comName')" class="date"></label>
		<label><input type="text" id="edate" data-role="date" onchange="getTradeGroupData('comName')" class="date"></label>
	</div>

	<form id="trdeForm">
		<table  class='tablesorter-ice' border="1" style="border-collapse: collapse;text-align: center;" id="tradeTbl">
		
		</table>
	</form>
			</center>
		</div>	
		
		
		
	<div data-role="popup" id="dialog" data-theme="a" class="ui-corner-all" style="width: 1000px">
		<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
		<br>
		<center>
		<button id="printBtn" onclick="goPrintPage()" data-mini="true" data-inline="true">출력</button>
			<div id="detailDiv">
			
			</div>
		</center>	
	</div>
	
	<form action='${ctxPath}/sale/csv.do' id="f" >
			<input type="hidden" name="csv" value="">
			<input type="hidden" name="startDate" value="">
			<input type="hidden" name="endDate" value="">
		</form>

	</div>
	
	
	<div data-role="page" id="shop">
		<div rata-role="content">
			<center>
				<button onclick="comPage();" data-inline="true" >협력사</button>
				<a href="#" data-role="button" data-inline="true">매장</a>
				
				<button onclick="allSales();" data-inline="true" >전체</button>
				
				<br><br>
				
				<select id="prdctTyS" data-native-menu="false" data-inline="true" onchange="getTradeDataS('shopName');">
					<option value="1" selected="selected">프레임</option>
					<option value="2">렌즈</option>
					<option value="3">콘텍트 렌즈</option>
					<option value="4">렌즈 용액</option>
					<option value="5">기타</option>
				</select>

				<div data-role="fieldcontain" style="width: 650px">
					<label><select id="shopId" data-inline="true" onchange="getTradeDataS('shopName');"><option value="-1">매장 전체</option></select></label>
					<label><button onclick="printAllTrde('S');">출력</button> </label>
					<label><input type="text" id="sdateS" data-role="date" onchange="getTradeDataS('shopName')" class="date"></label>
					<label><input type="text" id="edateS" data-role="date" onchange="getTradeDataS('shopName')" class="date"></label>
				</div>
			
				<form id="trdeForm">
					<table  class='tablesorter-ice' border="1" style="border-collapse: collapse;text-align: center;" id="tradeTblS">
					
					</table>
				</form>
			</center>
		</div>	
		
		<div data-role="popup" id="dialogS" data-theme="a" class="ui-corner-all" style="width: 1000px">
		<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
		<br>
		<center>
		<button id="printBtn" onclick="goPrintPageS()" data-mini="true" data-inline="true">출력</button>
			<div id="detailDivS">
			
			</div>
		</center>	
	</div>
	</div>
	
	<div data-role="page" id="all">
		<div rata-role="content">
			<center>
				<button onclick="comPage();" data-inline="true" >협력사</button>
				<a href="javascript:shopPage();" data-role="button" data-inline="true">매장</a>
				<button data-inline="true">전체</button>
				
				<br><br>
				
				
				<div data-role="fieldcontain" style="width: 500px">
					
					<label>&nbsp;</label>
					<label><input type="text" id="sdateA" data-role="date" onchange="getTradeListAll()" class="date"></label>
					<label><input type="text" id="edateA" data-role="date" onchange="getTradeListAll()" class="date"></label>
				</div>
			
				<form id="trdeForm">
					<table  class='tablesorter-ice' border="1" style="border-collapse: collapse;text-align: center;" id="tradeTblA">
					
					</table>
				</form>
			</center>
		</div>	
		
		<div data-role="popup" id="dialogS" data-theme="a" class="ui-corner-all" style="width: 1000px">
		<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
		<br>
		<center>
		<button id="printBtn" onclick="goPrintPageS()" data-mini="true" data-inline="true">출력</button>
			<div id="detailDivS">
			
			</div>
		</center>	
	</div>
	</div>
	
	
	<div data-role="page" id="allC">
		<div rata-role="content">
			<center>
				<button onclick="comPage();" data-inline="true" >협력사</button>
				<a href="javascript:shopPage();" data-role="button" data-inline="true">매장</a>
				<button data-inline="true">전체</button>
				
				<br><br>
				
				
				<div data-role="fieldcontain" style="width: 500px">
					<label>&nbsp;</label>
					<label><input type="text" id="sdateC" data-role="date" onchange="getTradeListAllC()" class="date"></label>
					<label><input type="text" id="edateC" data-role="date" onchange="getTradeListAllC()" class="date"></label>
				</div>
			
				<form id="trdeForm">
					<table  class='tablesorter-ice' border="1" style="border-collapse: collapse;text-align: center;" id="tradeTblC">
					
					</table>
				</form>
			</center>
		</div>	
		
		<div data-role="popup" id="dialogS" data-theme="a" class="ui-corner-all" style="width: 1000px">
		<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
		<br>
		<center>
		<button id="printBtn" onclick="goPrintPageS()" data-mini="true" data-inline="true">출력</button>
			<div id="detailDivS">
			
			</div>
		</center>	
	</div>
	</div>
	
</body>
</html>