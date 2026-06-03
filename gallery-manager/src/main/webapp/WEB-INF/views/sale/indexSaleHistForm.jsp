<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
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
		
		jQuery('#listSaleHistForm1 input[name=syear]').val('${cyear}');
		jQuery('#listSaleHistForm1 input[name=eyear]').val('${cyear}');

		//getMax('${cyear}', '${cmonth}', 1);
		//getMax('${cyear}', '${cmonth}', 2);

		jQuery('#listSaleHistForm1 select[name=smonth]').val('${cmonth}');
		jQuery('#listSaleHistForm1 select[name=sday]').val('${cday}');
		jQuery('#listSaleHistForm1 select[name=emonth]').val('${cmonth}');
		jQuery('#listSaleHistForm1 select[name=eday]').val('${cday}');
	});
	//----------------------

	/*
	 * 년 월의 마지막 일 획득
	 */
/* 	function getMax(year, month, tp) {
		if (tp == 1) {
			if (year == null || month == null) {
				year = jQuery('#listSaleHistForm1 input[name=syear]').val();
				month = jQuery('#listSaleHistForm1 select[name=smonth]').val();
			}
			form = document.getElementById("sday"); //jQuery('#cstmrInfoForm select[name=bday]');
			getMaxOfMonth(year, month, form);
		}

		if (tp == 2) {
			if (year == null || month == null) {
				year = jQuery('#listSaleHistForm1 input[name=eyear]').val();
				month = jQuery('#listSaleHistForm1 select[name=emonth]').val();
			}
			form = document.getElementById("eday"); //jQuery('#cstmrInfoForm select[name=bday]');
			getMaxOfMonth(year, month, form);
		}
	} */

	/*
	 * 판매 이력 데이터 리스트
	 */
	 var shopId = ${shopId};
	 function chkManager(){
			$("#ManagerDiv").dialog({
				title : "비밀번호",
				width : 300,
				height : 150
			});
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
	function listSaleHistData() {
		var url = '${ctxPath}/sale/listSaleHistData.do';
		var param = jQuery('#listSaleHistForm1').serialize() + "&searchTyCd=d";
		console.log(param)

		
		var startT = removeHypen($("#startTime").val());
		var endT = removeHypen($("#endTime").val());
		
		syear = startT.substring(0,4);
		smonth = startT.substring(4,6);
		sday = startT.substring(6,8);
		
		eyear = endT.substring(0,4);
		emonth = endT.substring(4,6);
		eday = endT.substring(6,8);

		gap = (eyear - syear) * 12 + (emonth - smonth);

		if (gap > 1) {
			alert('<spring:message code="search.period.long"/>');
			return;
		}

		//javax
		$.ajax({
			url : url,
			type : "post",
			data : param + "&syear=" + syear + "&smonth=" + smonth + "&sday=" + sday + "&eyear=" + eyear + "&emonth=" + emonth + "&eday=" + eday,
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				jQuery('#listSaleHistBody').html(data);

			}

		});

	}
	
	function removeHypen(str){
		var result = str.replace(/-/gi,"");
		
		return result;
	}
	
	
	var total = 0;
	
	function sum(num){
		total += num;
		$("#total").html(format(total));
		
	};
	
	function format(n) {
		  var reg = /(^[+-]?\d+)(\d{3})/;   
		  n += '';                          

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');
 
		  return n;
	};
</script>
<style>
.total{
	background-color: #fff8dc;
}
td,th{
	padding: 2px;
}
*{
	font-family: 나눔고딕;
	font-size: 14px;
	font-weight: bold;
}
#ManagerDiv{
	display : none;
}
</style>
<html>
<head>
<title>Home</title>
</head>
<body>
	<div id="content" style="width: 100%">

		<form name="listSaleHistForm1" id="listSaleHistForm1" method="post"
			action="">

			<table border="1" class="search" width="100%">
				<tbody>
					<tr>
						<th style="width: 10%"><label for="searchPrdct">고객 명</label></th>
						<td style="width: 12%"><input size="10" id="cstmrName"
							name="cstmrName"></td>
						
						<th style="width: 10%"><label for="searchTy">결과</label></th>
						<td style="width: 12%"><select id='result' name='result'>
								<option value="-1">전체</option>
								<option value="0000"><%=CommonCode.MSG_SALE_RST_SUCCESS%></option>
								<option value="-1000"><%=CommonCode.MSG_SALE_RST_WAIT%></option>
								<option value="2005"><%=CommonCode.MSG_SALE_RST_CANCEL%></option>
								<option value="0001"><%=CommonCode.MSG_SALE_RST_TIME_OVER%></option>
						</select></td>
						
						<th style="width: 10%">기간</th>
						<td style="width: 45%">
							<table width="100%">
								<tr>
									<%-- <input id="syear" name="syear" size="1" maxlength="4">
										<select id="smonth" name="smonth"
										onChange="getMax(null,null,1);">
											<c:forEach var="i" begin="1" end="12">
												<option value="${i}">${i}</option>
											</c:forEach>
									</select> <select id="sday" name="sday">
									</select> &nbsp;~&nbsp; <input id="eyear" name="eyear" size="1"
										maxlength="4"> <select id="emonth" name="emonth"
										onChange="getMax(null,null,2);">
											<c:forEach var="i" begin="1" end="12">
												<option value="${i}">${i}</option>
											</c:forEach>
									</select> <select id="eday" name="eday">
									</select> --%>
									<td><input type="date"  id="startTime"> </td>
									
									<td><input type="date"  id="endTime"> </td>
									
									
									<td align="right">
										<button onclick="listSaleHistData('1');return false;">조회</button>
									<td>
								</tr>
							</table> <!-- 
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
							<button onclick="listSaleHistData('1');return false;">조회</button>
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
		<form name="listSaleHistForm2" id="listSaleHistForm2" method="post"
			action="">
			<input type="hidden" id='prdctId' name='prdctId'> <input
				type="hidden" id='prdctStatTyCd' name='prdctStatTyCd'
				value="00100001">


			<table style="width: 100%; height: 300" class="list" id="listTable"
				border="1">
				<colgroup>
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="20%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th>판매 코드</th>
						<th>매장</th>
						<th>고객 이름</th>
						<th>주소</th>
						<th>휴대전화</th>
						<th>결제 금액</th>
						<th>판매 결과</th>
						<th>등록 일시</th>
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
	<div id="ManagerDiv">
<center>
<!-- onkeypress="if(event.keyCode==13){goShopSalesPage();}" -->
	<input type="password" id="pwd" onkeypress="if(event.keyCode==13){goShopSalesPage();}"><br>
	<button onclick="goShopSalesPage();" >확인</button>
</center>
</div>
</body>
</html>
