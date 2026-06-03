<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">
<%
	int shopId = (Integer) session.getAttribute("shopId");
%> 


	var csvOutput = "날짜, 고객, 프레임, 선글라스, 렌즈, 콘텍트렌즈, 팩렌즈, 렌즈 용액, 현금, 카드,카드사, 포인트, 판매금, 기타할인, 총결제, 미수금LINE";
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
		var month = addZero(String(date.getMonth() + 1));
		var day = addZero(String(date.getDate())); 
		
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

	
	function addZero(n){
		if(n.length=="1"){
			n = "0" + n;
		}
		return n;
	}
	function findShopName() {
		var url = '${ctxPath}/sale/findShopName.do';
		var param = "shopId=" + shopId;
		//javax
		$.ajax({
			type : "post",
			url : url,
			data : param,
			dataType : "text",
			beforeSend : function() {
			},
			success : function(data) {
				$(".shopId").append(data);
				srchTypeChange();
			}
		});
	}
	
	function selectShop(){
		var shop = $("#shopName").val();
		shopName = shop;
	}
	//----------------------
	var type;
	function srchTypeChange() {
		

		shopName = $("#shopName").val();
		type = $("#srchType").val();
		
		
		if (type == "store") { 
			$("#staffTd_").css("display", "none");
			$("#storeTd").css("display", "inline");
			$("#shopName").prop('disabled', false);
		} else if (type == "staff") {
			getStaffList();
			console.log("staff")
			if(shopId=="777"){
				$("#shopIdForStaff").prop("disabled",false);
			}
			$("#staffTd_").css("display", "inline");
			$("#storeTd").css("display", "none");
			$("#staffName").prop('disabled', false)
		} else if (type == "all") {
			$("#staffName").prop('disabled', true);
			$("#shopName").prop('disabled', true);
			shopName = "all";
		}
	}

	function getStaffList(){
		var param;
		if(shopId=="777"){
			param = "shopId=" + $("#shopIdForStaff").val();
		}else{
			param = "shopId=" + shopId;
		}
		var url = "${ctxPath}/staff/getStaffList.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#staffId").html(data);
			}
		});
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
	
	function initGvar(){
		frame = 0;
		sun = 0;
		lens = 0;
		clens = 0;
		dis = 0;
		acc = 0;
		cash = 0;
		card = 0;
		total = 0;
		point = 0;
		etcDscnt = 0;
		dscntPrice = 0;
		remained = 0;
	}

	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function listSalesHistData() {
		initGvar();
		$("#loader").css("display","inline");
		$("#listSaleHistForm2").css("display","none");
		$("#totalSales").css("display","none");
		$("#showBtn").attr("disabled",true);
		$("#csvBtn").attr("disabled",true);
		var url;
		
		if(type=="all"){
			url = '${ctxPath}/sale/listSalesHistDataTotal.do';
		}else if(type=="store"){
			url = '${ctxPath}/sale/listSalesHistData.do';
		}else{
			url = '${ctxPath}/sale/listSalesHistDataByStaff.do';
		}
	
		
		startT = removeHypen($("#startTime").val());
		endT = removeHypen($("#endTime").val());
		
		syear = startT.substring(0,4);
		smonth = startT.substring(4,6);
		sday = startT.substring(6,8);
		
		eyear = endT.substring(0,4);
		emonth = endT.substring(4,6);
		eday = endT.substring(6,8);
		
		frame = 0;
		sun = 0;
		lens = 0;
		clens = 0;
		dis = 0;
		acc = 0;
		
		point = 0;
		cash = 0;
		card = 0;
		total = 0;
		etcDscnt = 0;
		dscntPrice = 0;
		
		var staffId = $("#staffId").val();
		console.log('staffId:'+staffId);

		if(type=="store"){
			shopName = $("#shopName").val();
		}else{
			shopName = $("#shopIdForStaff").val();
		}
		
		
		console.log("param :" + shopName);
		
		console.log('startT:'+startT);
		console.log('endT:'+endT);

		//javax
		$.ajax({
			url : url,
			type : "post",
			data : "searchTyCd=d" + 
					 "&startTime=" + startT + 
					 "&endTime=" + endT + 
					 "&shopId=" + shopName + 
					 "&staffId=" + staffId,
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				//console.log(data)
				$("#loader").css("display","none");
				$("#showBtn").attr("disabled",false);
				if(type=="all"){
					$("#listSaleHistForm2").css("display","none");
					$("#totalSales").css("display","inline");
					$("#totalSales").html(data);					
					
				}else{
					jQuery('#listSaleHistBody').html(data);
					$("#listSaleHistForm2").css("display","inline");
					$("#totalSales").css("display","none");		
				}
				
				if(type=="all"){
				csvTotal = "합계,," + 
							frame + "," + 
							sun + "," +
							lens + "," +
							clens + "," +
							dis + "," +
							acc + "," +
							cash + "," + 
							card + "," +
							point + "," + 
							total;
				}else{
					csvTotal = "합계,,," + 
					frame + "," + 
					sun + "," +
					lens + "," + 
					clens + "," +
					dis + "," +
					acc + "," + 
					cash + "," + 
					card + ",," +
					point + "," +
					dscntPrice + "," +
					etcDscnt + "," +
					total + "," +
					remained;
				}
				csvData();
				
			}

		});

	}
	
	function csvData(){
		var url;
		var startT = removeHypen($("#startTime").val());
		var endT = removeHypen($("#endTime").val());
		var staffId = $("#staffId").val();
		
		if(type=="all"){
			url = '${ctxPath}/sale/listSalesHistDataTotalCsv.do';
		}else if(type=="store"){
			url = '${ctxPath}/sale/listSalesHistDatatoCsv.do';
		}else{
			url = '${ctxPath}/sale/listSalesHistDataByStaffCsv.do';
		}
		
		syear = startT.substring(0,4);
		smonth = startT.substring(4,6);
		sday = startT.substring(6,8);
		
		eyear = endT.substring(0,4);
		emonth = endT.substring(4,6);
		eday = endT.substring(6,8);
		
		$.ajax({
			url : url,
			type : "post",
			data : "searchTyCd=d" + 
					 "&startTime=" + startT + 
					 "&endTime=" + endT + 
					 "&shopId=" + shopName + 
					 "&staffId=" + staffId,
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				
				console.log(data)
				
				if(type=="all"){
					csvOutput = "날짜, 고객, 프레임, 선글라스, 렌즈, 콘텍트렌즈, 팩렌즈, 렌즈용액, 현금, 카드, 포인트, 합계 LINE";
				}else{
					
					csvOutput = "순번, 날짜, 고객, 프레임, 선글라스, 렌즈, 콘텍트렌즈, 팩렌즈, 렌즈용액, 현금, 카드, 카드사, 포인트, 판매금, 기타할인, 총결제, 미수금, 비고, 전화번호 LINE";	
				}
				
				//data = data.replace(/\n/gi,"");
				var cvs = data.trim().split("|");
				for(var i = 0;  i < cvs.length; i++){
					csvOutput += "" + cvs[i] + "LINE";
				}
				csvOutput += csvTotal;
				$("#csvBtn").attr("disabled",false);
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
//		console.log(csvOutput);
		csvOutput = csvOutput.replace(/\n/gi,"");
		f.csv.value=encodeURIComponent(csvOutput);
		f.startDate.value = startT;
		f.endDate.value = endT;
	//	f.setAttribute("action", "post");
		f.submit(); 
	}
		
		
	var frame = 0;
	var sun = 0;
	var lens = 0;
	var clens = 0;
	var dis = 0;
	var acc = 0;
	var cash = 0;
	var card = 0;
	var total = 0;
	var point = 0;
	var etcDscnt = 0;
	var dscntPrice = 0;
	var remained = 0;
	function sum(num, td){
		if(td=="frame"){
			frame += num;
			$("#frame").html(format(frame));
		}else if(td=="sun"){
			sun += num;
			$("#sun").html(format(sun));
		}else if(td=="lens"){
			lens += num;
			$("#lens").html(format(lens));
		}else if(td=="clens"){
			clens += num;
			$("#clens").html(format(clens));
		}else if(td=="dis"){
			dis += num;
			$("#dis").html(format(dis));
		}else if(td=="acc"){
			acc += num;
			$("#acc").html(format(acc));
		}else if(td=="cash"){
			cash += num;
			$("#cash").html(format(cash));
		}else if(td=="card"){
			card += num;
			$("#card").html(format(card));
		}else if(td=="total"){
			total += num;
			$("#total").html(format(total));
		}else if(td=="etcDscnt"){
			etcDscnt += num;
			$("#etcDscnt").html(format(etcDscnt));
		}else if(td=="dscntPrice"){
			dscntPrice += num;
			$("#dscntPrice").html(format(dscntPrice));
		}else if(td=="point"){
			point += num;
			$("#point").html(format(point));
		}else if(td=="remained"){
			remained += num;
			$("#remained").html(format(remained));
		}
		
		if(td=="frame_"){
			frame += num;
			$("#frame_").html(format(frame));
		}else if(td=="sun_"){
			sun += num;
			$("#sun_").html(format(sun));
		}else if(td=="lens_"){
			lens += num;
			$("#lens_").html(format(lens));
		}else if(td=="clens_"){
			clens += num;
			$("#clens_").html(format(clens));
		}else if(td=="dis_"){
			dis += num;
			$("#dis_").html(format(dis));
		}else if(td=="acc_"){
			acc += num;
			$("#acc_").html(format(acc));
		}else if(td=="cash_"){
			cash += num;
			$("#cash_").html(format(cash));
		}else if(td=="card_"){
			card += num;
			$("#card_").html(format(card));
		}else if(td=="total_"){
			total += num;
			$("#total_").html(format(total));
		}else if(td=="point_"){
			point += num;
			$("#point_").html(format(point));
		}
		
	};
	
	function format(n) {
		  var reg = /(^[+-]?\d+)(\d{3})/;   
		  n += '';                          

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');
 
		  return n;
		}
	function removeComma(str){
		if(!str){str='0';}
		//console.log('removeComma:'+str);
		str = str.toString();
		var result = str.replace(/,/gi,"");
		result = parseInt(result,10);
		return result;
	}
	
	
	
	function getCardInfo(){
		var param = "shopId=" + shopName + 
						"&startTime=" + startT + 
						"&endTime=" + endT;
		var url = "${ctxPath}/sale/getCardInfo.do";
		
		$.ajax({
			url : url,
			dataType : "html",
			data : param,
			type : "post",
			success: function(data){
				$("#cardDiv").dialog({
				title : "카드 매출 정보",
				width : 300,
				height :500
			});
				$("#cardDiv").html(data);
			  
			}
		});
	}
	
	
	function showCstmrCd(cstmrCd){
		$("#cstmrCd").html(cstmrCd);
		$("#cstmrCd").dialog({
			title : "고객코드",
			width : 200,
			height :100
		});
	}
	
</script>
<style>
#staffTd_ {
	display: none;
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
<title>Home</title>
</head>
<body>
	<div id="content" style="width: 100%">
	<center><div>*제품 구분별 합(ex 프레임, 렌즈 별 총액)은 잔금, 선금, 기타할인 등으로 약간의 차이가 있을 수 있습니다.</div></center>
		<form name="listSalesHistForm1" id="listSalesHistForm1" method="post"
			action="">

			<table border="1" class="search" width="100%">
				<tbody>
					<tr>
						<th style="width: 10%"><select id="srchType" >
								
													</select></th>
						<td style="width: 10%" align='center' id="storeTd">
							<select  class="shopId"id="shopName" name="shopName" onchange="selectShop();" disabled="disabled"> 
							</select>
						</td>
						
						<td id="staffTd_" width="7%">
						<center>
							<select id="shopIdForStaff" class="shopId" disabled="disabled" onchange="getStaffList()">
								
							</select>
							
							<select id="staffId">
								<option>선택</option>
							</select>
						</center>
						</td>
						<th style="width: 10%">기간</th>
						<td style="width: 50%" colspan="5" align="center">
							<input type="date"  id="startTime"> 
									
							<input type="date"  id="endTime">
									
							<button onclick="listSalesHistData();return false;" id="showBtn">조회</button>
							<button onclick="csvSend(); return false;" id="csvBtn">엑셀로 출력</button>
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
		<form action='${ctxPath}/sale/csv.do' id="f" method="post">
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
				
				<thead>
					<tr>
						<th>NO</th>
						<th>날짜</th>
						<th>고객</th>
						<th>프레임</th>
						<th>선글라스</th>
						<th>렌즈</th>
						<th>콘텍트렌즈</th>
						<th>팩렌즈</th>
						<th>렌즈용액</th>
						<th>현금</th>
						<th >카드</th>
						<th onclick="getCardInfo();">카드사</th>
						<th>포인트</th>
						<th>판매금</th>
						<th>기타<br/>할인</th>
						<th>총결제</th>
						<th>미수금</th>
						<th>비고</th>
						<th>전화번호</th>
					</tr>
				</thead>
				<tbody>

					<tr>
				<tbody id="listSaleHistBody">
				</tbody>
			</table>
			
		</form>
		
	</div>
	<div id="dialog"></div>
	<div id="totalSales"></div>
	<div id="cardDiv"></div>
	<center>
	<img src="${ctxPath	 }/images/loader.gif" id="loader">
	</center>

<div id="cstmrCd">
		
</div>
</body>
</html>
