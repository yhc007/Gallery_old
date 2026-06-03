<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">
<%
	int shopId = (Integer) session.getAttribute("shopId");
%> 
	var csvOutput = "날짜, 매장, 안경, 렌즈, 현금, 카드, 합계line";
	var csvTotal = "";
	var shopName;
	var startT = "";
	var endT = "";
	var shopId = <%=shopId%>;
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function() {

		
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var day = date.getDate().toString(); 
		if(day.length=="1"){
			day = "0" + day;
		}
		
		document.getElementById("startTime").value = year + "-" + month + "-" + day;
		document.getElementById("endTime").value = year + "-" + month + "-" + day;
		
		$("#srchType").change(srchTypeChange);
		

		var option;
		if(shopId=="777"){
			option = "<option value='all'>전체</option>" + 
					 "<option value='store'>매장별</option>" + 
				     "<option value='staff'>사원별</option>";	
		}else{
			option = "<option value='store'>매장별</option>" + 
		    		 "<option value='staff'>사원별</option>";	
		}
		
		$("#srchType").html(option);
		
		findShopName();
	});

	function findShopName() {
		var url = '${ctxPath}/sale/findShopName.do';

		//javax
		$.ajax({
			type : "post",
			url : url,
			dataType : "text",
			beforeSend : function() {
			},
			success : function(data) {
				$("#shopName").append(data);
				srchTypeChange();
			}
		});
	}
	
	function selectShop(){
		var shop = $("#shopName").val();
		shopName = shop;
	}
	//----------------------
	function srchTypeChange() {
		

		shopName = $("#shopName").val();
		var type = $("#srchType").val();
		
		
		if (type == "store") { 
			$("#staffTd").css("display", "none");
			$("#storeTd").css("display", "inline");
			$("#shopName").prop('disabled', false);
			console.log(shopName)
		} else if (type == "staff") {
			$("#staffTd").css("display", "inline");
			$("#storeTd").css("display", "none");
			$("#staffName").prop('disabled', false)
		} else if (type == "all") {
			$("#staffName").prop('disabled', true);
			$("#shopName").prop('disabled', true);
			shopName = "all";
		}
	}

	/*
	 * 년 월의 마지막 일 획득
	 */
	/* function getMax(year, month, tp) {
		if (tp == 1) {
			if (year == null || month == null) {
				year = jQuery('#listSalesHistForm1 input[name=syear]').val();
				month = jQuery('#listSalesHistForm1 select[name=smonth]').val();
			}
			form = document.getElementById("sday"); //jQuery('#cstmrInfoForm select[name=bday]');
			getMaxOfMonth(year, month, form);
		}
	} */

	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function listSalesHistData() {

		var url = '${ctxPath}/sale/listSalesHistData.do';
		
		
		startT = removeHypen($("#startTime").val());
		endT = removeHypen($("#endTime").val());
		
		syear = startT.substring(0,4);
		smonth = startT.substring(4,6);
		sday = startT.substring(6,8);
		
		eyear = endT.substring(0,4);
		emonth = endT.substring(4,6);
		eday = endT.substring(6,8);
		
		frame = 0;
		lens = 0;
		cash = 0;
		card = 0;
		total = 0;
		
		//javax
		$.ajax({
			url : url,
			type : "post",
			data : "searchTyCd=d" + "&startTime=" + startT + "&endTime=" + endT + "&shopId=" + shopName,
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				
				jQuery('#listSaleHistBody').html(data);
				
				
				csvTotal = "합계,," + frame + "," + lens + "," + cash + "," + card + "," + total;
				csvData();
				
			}

		});

	}
	
	function csvData(){
		var url = '${ctxPath}/sale/listSalesHistDatatoCsv.do';
		var startT = removeHypen($("#startTime").val());
		var endT = removeHypen($("#endTime").val());
		
		syear = startT.substring(0,4);
		smonth = startT.substring(4,6);
		sday = startT.substring(6,8);
		
		eyear = endT.substring(0,4);
		emonth = endT.substring(4,6);
		eday = endT.substring(6,8);
		
		$.ajax({
			url : url,
			type : "post",
			data : "searchTyCd=d" + "&startTime=" + startT + "&endTime=" + endT + "&shopId=" + shopName,
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				csvOutput = "날짜, 매장, 안경, 렌즈, 현금, 카드, 합계line";
				//data = data.replace(/\n/gi,"");
				console.log(data.trim());
				var cvs = data.trim().split("|");
				for(var i = 0;  i < cvs.length; i++){
					csvOutput += "" + cvs[i] + "line";
				}
				csvOutput += csvTotal;
			}

		});
	}
	function change_search_ty(val) {
		if (val == 'y') {

			syear.style.display = '';
			tyear.style.display = '';

			smonth.style.display = 'none';
			tmonth.style.display = 'none';

			sday.style.display = 'none';
			tday.style.display = 'none';
		} else if (val == 'm') {
			syear.style.display = '';
			tyear.style.display = '';

			smonth.style.display = '';
			tmonth.style.display = '';

			sday.style.display = 'none';
			tday.style.display = 'none';
		} else if (val == 'd') {
			syear.style.display = '';
			tyear.style.display = '';

			smonth.style.display = '';
			tmonth.style.display = '';

			sday.style.display = '';
			tday.style.display = '';
		}
	}

	function removeHypen(str){
		var result = str.replace(/-/gi,"");
		
		return result;
	}
	
	
	
	//csv
	
	function csvSend(){
		if(startT == "" || endT == ""){
			alert("조회를 먼저 해주세요");
			$("#startTime").focus();
			return;
		}
		console.log(csvOutput)
		csvOutput = csvOutput.replace(/\n/gi,"");
		f.csv.value=encodeURIComponent(csvOutput);
		f.startDate.value = startT;
		f.endDate.value = endT;
		f.submit(); 
	
		console.log(csvOutput)
	}
		
		
	var frame = 0;
	var lens = 0;
	var cash = 0;
	var card = 0;
	var total = 0;
	
	function sum(num, td){
		if(td=="frame"){
			frame += num;
			$("#frame").html(format(frame));
		}else if(td=="lens"){
			lens += num;
			$("#lens").html(format(lens));
		}else if(td=="cash"){
			cash += num;
			$("#cash").html(format(cash));
		}else if(td=="card"){
			card += num;
			$("#card").html(format(card));
		}else if(td=="total"){
			total += num;
			$("#total").html(format(total));
		}
		
	};
	
	function format(n) {
		  var reg = /(^[+-]?\d+)(\d{3})/;   
		  n += '';                          

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');
 
		  return n;
		}
	
	
	
</script>
<style>
#staffTd {
	display: none;
}
.total{
	background-color: #fff8dc;
}
*{
	font-family: 나눔고딕;
	font-size: 14px;
	font-weight: bold;
}
td,th{
	padding: 2px;
}
#csv1{
	display: none;
}
</style>
<title>Home</title>
</head>
<body>

	<div id="content" style="width: 100%">
		<form name="listSalesHistForm1" id="listSalesHistForm1" method="post"
			action="">

			<table border="1" class="search" width="100%">
				<tbody>
					<tr>
						<th style="width: 10%"><select id="srchType">
								
						</select></th>
						<td style="width: 10%" align='center' id="storeTd">
							<select id="shopName" name="shopName" onchange="selectShop();"> 
							</select>
						</td>
						
						<td id="staffTd" width="7%"><input type="text" id="staffName"
							name="">
						</td>
						<th style="width: 10%">기간</th>
						<td style="width: 50%" colspan="5" align="center">
							<input type="date"  id="startTime"> 
									
							<input type="date"  id="endTime">
									
							<button onclick="listSalesHistData();return false;">조회</button>
							<button onclick="csvSend(); return false;">엑셀로 출력</button>
							 <!-- 
							<table border="0" width="100%">
							
							<tr>
							<td>
							<input id="syear" name="syear" size="1" maxlength="4">
							<select id="smonth" name="smonth" onChange="getMax(null,null,1);">
								<c:forEach var="i" begin="1" end="12">	
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>
							<select id="sday" name="sday">
							</select>
							
							</td>
							<td rowspan="2" align="right">
							<button onclick="listSalesHistData('1');return false;">조회</button>
							</td>
							</tr>
							<tr>
								<td>
								<input id="eyear" name="eyear" size="1" maxlength="4">
								<select id="emonth" name="emonth" onChange="getMax(null,null,2);">
									<c:forEach var="i" begin="1" end="12">	
										<option value="${i}">${i}</option>
									</c:forEach>
								</select>
								<select id="eday" name="eday">
								</select>
								</td>
							</tr>
							</table>
							 -->
						</td>
					</tr>
				</tbody>
			</table>


		</form>
		<form action='${ctxPath}/sale/csv.do' id="f" >
			<input type="hidden" name="csv" value="">
			<input type="hidden" name="startDate" value="">
			<input type="hidden" name="endDate" value="">
		</form>
		<form name="listSaleHistForm2" id="listSaleHistForm2" method="post"
			action="">
			<input type="hidden" id='prdctId' name='prdctId'> <input
				type="hidden" id='prdctStatTyCd' name='prdctStatTyCd'
				value="00100001">


			<table style="width: 100%; height: 300" class="list" id="listTable"
				border="1">
				<colgroup>
					<col width="10%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
				</colgroup>
				<thead>
					<tr>
						<th>날짜</th>
						<th>매장</th>
						<th>안경</th>
						<th>렌즈</th>
						<th>현금</th>
						<th>카드</th>
						<th>합계</th>
					</tr>
				</thead>
				<tbody>

					<tr>
				<tbody id="listSaleHistBody">
				</tbody>
				</tr>
			</table>
		</form>
	</div>
	<div id="dialog"></div>
</body>
</html>
