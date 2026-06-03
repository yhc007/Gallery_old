<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ include file="/WEB-INF/views/include/printLib.jsp"%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="initial-scale=1.0; minimum-scale=1.0; maximum-scale=1.0;"/>
<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	$(function(){
		getCstmrInfo();
		getCheckInfo('${saleVo.saleId}');
		//getPaymentInfo('${saleVo.saleId}');
		getBillInfo('${saleVo.saleId}');
		getCstmrPoint();
		toDay();
	});
	
	console.log("${cstmrVo}");
	console.log("${shopVo}");
	console.log("${staffVo}"); 
	console.log("${saleVo}");
	function toDay(){
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(String(date.getMonth() + 1));
		var day = addZero(String(date.getDate()));
		var hour = addZero(String(date.getHours()));
		var minute = addZero(String(date.getMinutes()));
		
		$(".dateTd").html("방문일시 : " + year + "년 " + 
											month + "월 " + 
											day + "일 " + 
											"(" + hour + ":" + minute + ")");
	}
	
	function addZero(n){
		if(n.length=="1"){
			n = "0" + n;
		}
		return n;
	}
	
	//table1 고객 정보
	function getCstmrInfo() {
		var cstmrId = '${cstmrVo.cstmrId}';
		var param = "cstmrId=" + cstmrId;
		
		var url = "${ctxPath}/cstmr/getCstmrVIsitInfo.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : "json",
			type : "post",
			success : function(data){
				$(".visitCnt").html(data.visitCnt);
				$(".totalPrc").html(format(data.totalPrc));
			}
		});
	};
	
	//고객 포인트
	
	function getCstmrPoint(){
	var url = '${ctxPath}/point/getCstmrPoint.do';
	
	$.ajax({
		url		: url,
		type 	: "post",
		data : "cstmrCd=" + '${cstmrVo.cstmrCd}'+"&fmlyCd="+'${cstmrVo.fmlyCd}',
		dataType	: "text",
		beforeSend	: function(){
		},
		success: function(data){
			var rtnData = decodeURIComponent(data);
			var pointParser = rtnData.split(',');
			pointValue = pointParser[0];

			$(".cstmrPoint").html(format(pointValue));
			return;
		}
	}); 
};
	//table2 시력
	
	function getCheckInfo(saleId) {
		var url = '${ctxPath}/cstmrHstry/getLastData.do';
		//javax
		$.ajax({
			url : url,
			type : "post",
			data : "saleId=" + saleId,
			dataType : "json",
			beforeSend : function() {
			},
			success : function(data) {
				$("#gsphRight").html(data.gsphRight);
				$("#gcylRight").html(data.gcylRight);
				$("#gaxisRight").html(data.gaxisRight);
				$("#pdRight").html(data.pdRight);
				$("#addRight").html(data.addRight);
				$("#prismRight").html(data.prismRight);
				$("#baseRight").html(data.baseRight);
				$("#npcRight").html(data.npcRight);
				$("#npaRight").html(data.npaRight);
				
				$("#gsphLeft").html(data.gsphLeft);
				$("#gcylLeft").html(data.gcylLeft);
				$("#gaxisLeft").html(data.gaxisLeft);
				$("#pdLeft").html(data.pdLeft);
				$("#addLeft").html(data.addLeft);
				$("#prismLeft").html(data.prismLeft);
				$("#baseLeft").html(data.baseLeft);
				$("#npcLeft").html(data.npcLeft);
				$("#npaLeft").html(data.npaLeft);
				
				$("#lsphRight").html(data.lsphRight);
				$("#lcylRight").html(data.lcylRight);
				$("#laxisRight").html(data.laxisRight);
				$("#bcRight").html(data.bcRight);
				$("#diaRight").html(data.diaRight);
				
				$("#lsphLeft").html(data.lsphLeft);
				$("#lcylLeft").html(data.lcylLeft);
				$("#laxisLeft").html(data.laxisLeft);
				$("#bcLeft").html(data.bcLeft);
				$("#diaLeft").html(data.diaLeft);
				
				if(data.cstmrMemo==null){
					$("#memo").html("&nbsp;");	
				}else{
					$("#memo").html(data.cstmrMemo);
				}
				
				
				if(data.domEye="1"){
					$("#dom").html("(우)");
				}else if(data.domEye="2"){
					$("#dom").html("(좌)");
				}else{
					$("#dom").html("(없음)");
				}
			},
			error : function(e1,e2,e3){
				console.log(e2);
			}
		});
	}
	
	function format(n) {
		  var reg = /(^[+-]?\d+)(\d{3})/;   
		  n += '';                          

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');

		  return n;
		}
	
	//table3-1 결제정보
	function getPaymentInfo(saleId){
		var param = "saleId=" +saleId;
		var url = "${ctxPath}/prdct/getPaymentInfo.do";
		
		$.ajax({
			url : url,
			dataType : "html",
			data : param,
			type : "post",
			success : function(data){
				$(".paymentTbl").html(data);
				getBillInfo(saleId);
			}
		});
	}
	
	//합계
	var sum_ = 0;
	function sum(n){
		console.log(n);
		
		sum_ += parseInt(n);
		$(".totalPayment").html(format(sum_));
	}
	
	//table 3-2 결제정보
	function getBillInfo(saleId){
		var param = "saleId=" + saleId;
		var url = "${ctxPath}/prdct/getBillInfo.do";
		
		$.ajax({
			url : url,
			dataType : "json",
			data : param,
			type : "post",
			success : function(data){
				console.log(data)
				$(".deposit").html(format(data.prc));
				$(".payCash").html(format(data.payCash));
				$(".payCard").html(format(data.payCard));
				$(".payPoint").html(format(data.payPoint));
				
				$(".remain").html(format(sum_-data.prc));
			}
		});
	}
</script> 


<head>
<title>프린트</title>
<style>
	
	#logo{
		width: 40%;
	}
	#dateTd{
		font-size: 12px;
		/* font-size: 7px; */
		/* font-size: 51%; */
	}
	#cstmrInfoTbl{
		width: 100%
	}
	
	#cstmrInfoTbl td{
		width: 15%;
	}
	hr{
		border: 1px solid black;
	}
	#staffName, #shopName{
		font-weight: bold;
	}
	#shopName{
		font-size: 28px;
		/* font-size: 51%; */
	}
	.saleId{
		background-color: #00bfFf;
		font-weight: bold;
		/* padding: 5px; */
	}
	#saleId{
		background-color: #00bfFf;
		font-weight: bold;
	}
	#cstmrInfoTbl td, #chkEyesTbl td, .paymentTbl td, .billTbl td{
		font-size: 10px;
		/* font-size: 51%; */
	}
	.dotLine{
		border-style: dotted;
	}
	.paymentTbl td, .billTbl td{
		width: 20%;
	}
	#cstmrLogo{
		width  : 70%;
		height : 7%;
	}
	.bold{
		font-weight: bold;
	}
	#saleIdB{
		margin-bottom: 15px;
		/* font-size: 51%; */
	}
	
	body{
		padding-left: 20px;
		padding-right: 40px;
	
	}
	@page container {
        size: A4;
        margin: 0;
    }
    
    @media print {
		.container{
            margin: 0;
            border: initial;
            border-radius: initial;
            width: initial;
            min-height: initial;
            box-shadow: initial;
            background: initial;
            page-break-inside: avoid;
            page-break-after: auto;
        }
    }
</style>
</head>

<body>
	<div id="container">
	<center >
	<table id="printTable" width="100%" >
		<tr id='tr_1'>
			<td colspan='2'>
				<table id="titleTbl" width="100%">
					<tr>
						<td width="33%"><span class="saleId">${saleVo.saleId }</span></td>
						<td rowspan="2" align="center" width="33%">
						<img src="${ctxPath}/images/Gallery-jay.png" id="logo"></td>
						<td style="text-align: right" width="33%" id="shopName">${shopVo.shopName }</td>
					</tr>
					<tr>
						<td id="staffName" class="bold">안경사 : ${staffVo.staffName }</td>
						<td class="dateTd" style="text-align: right"></td>
					</tr>	
				</table>

		<tr id='tr_2'>
			<td width='50%'>
				<table id="cstmrInfoTbl1" width='100%' border="1" style="border-collapse: collapse; text-align: center">
					<tr>
						<td>이름</td>
						<td>${cstmr.cstmrName}</td>
						<td>포인트</td>
						<td class="cstmrPoint"></td>
					</tr>
					<tr>
						<td>가입지점</td>
						<td>${cstmr.strRegShop}</td>
						<td>전화번호</td>
						<td>${cstmrVo.telephone }</td>
						
					</tr>
					<tr>
						<td>생일</td>
						<td>${cstmr.birthDay}</td>
						<td>휴대폰</td>
						<td>${cstmrVo.cellphone }</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center">주소</td>
						<td colspan="2" style="text-align: center">${cstmr.addr}</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center">고객코드</td>
						<td colspan="2" style="text-align: center">${cstmr.cstmrCd}</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center">이메일</td>
						<td colspan="2" style="text-align: center">${cstmr.email}</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center">총 방문 횟수 : <span class="visitCnt"> 회</span></td>
						<td colspan="2" style="text-align: center">구매금액 : <span class="totalPrc"></span>원</td>
					</tr>
				</table>
			</td>
			<td width='50%' >
				<table id='paymentTbl1' class="paymentTbl" width="100%" border="1" style="border-collapse: collapse; text-align: center">
					<tr>
						<td>상품코드</td>
						<td>제품명</td>
						<td>수량</td>
						<td>판매가격</td>
						<td>비고</td>
					</tr>
					
					<c:choose>
						<c:when test="${!empty FramePrdct || !empty AccPrdct || !empty ClensPrdct || !empty LensPrdct || !empty NewPrdct}">
							<c:forEach var="prdct" items="${FramePrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
								<script>
									sum('${prdct.prc * prdct.cnt * dc}');
								</script>
								
							</c:forEach>
								<c:forEach var="prdct" items="${NewPrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
								<script>
									sum('${prdct.prc * prdct.cnt * dc}');
								</script>
								
							</c:forEach>
								<c:forEach var="prdct" items="${LensPrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
								<script>
									sum('${prdct.prc * prdct.cnt * dc}');
								</script>
								
							</c:forEach>
								<c:forEach var="prdct" items="${ClensPrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
								<script>
									sum('${prdct.prc * prdct.cnt * dc}');
								</script>
								
							</c:forEach>
								<c:forEach var="prdct" items="${AccPrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
								<script>
									sum('${prdct.prc * prdct.cnt * dc}');
								</script>
								
							</c:forEach>
						</c:when>
					</c:choose>
					<tr>
						<td></td>
						<td></td>
						<td>총액</td>
						<td class="totalPayment" style="text-align: right;padding-right: 5px;"></td>
						<td></td>
					</tr>
					<tr>
					<td colspan='5'>
						<hr>
					</td>
					</tr>
					
					<tr>
						<td>선금</td>
						<td class="deposit"
							style="text-align: right; padding-right: 5px">&nbsp;</td>
						<td>현금</td>
						<td class="payCash"
							style="text-align: right; padding-right: 5px">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>잔금</td><td class="remain" style="text-align: right; padding-right: 5px">&nbsp;</td><td>카드</td><td class="payCard" style="text-align: right; padding-right: 5px">&nbsp;</td><td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td><td >&nbsp;</td><td>포인트</td><td class="payPoint" style="text-align: right; padding-right: 5px">&nbsp;</td><td>&nbsp;</td>
					</tr>
			</table>
			</td>
		</tr>
		
		<tr>
			<td colspan='2'>
				<hr class="dotLine">
			</td>
		</tr>
		
		<!-- table1 고객정보 -->
		<tr id='tr_3'>
			<td width='50%'>
				<table id="cstmrInfoTbl2" width='100%' border="1" style="border-collapse: collapse; text-align: center">
					<tr>
						<td colspan="2" class="saleId" >${saleVo.saleId }</td>
						<td colspan="8"></td>
					</tr>
					<tr>
						<td colspan="1" >이름</td>
						<td colspan="3" >${cstmr.cstmrName}</td>
						<td colspan="2" >포인트</td>
						<td colspan="4" class="cstmrPoint"></td>
					</tr>
					<tr>
						<td colspan="1" >가입점</td>
						<td colspan="3" >${cstmr.strRegShop}</td>
						<td colspan="2" >전화</td>
						<td colspan="4">${cstmrVo.telephone }</td>
						
					</tr>
					<tr>
						<td colspan="1" >생일</td>
						<td colspan="3" >${cstmr.birthDay}</td>
						<td colspan="2" >휴대폰</td>
						<td colspan="4" >${cstmrVo.cellphone }</td>
					</tr>
					<tr>
						<td colspan="1" style="text-align: center">주소</td>
						<td colspan="9" style="text-align: center">${cstmr.addr}</td>
					</tr>
					<tr>
						<td colspan="1" style="text-align: center">코드</td>
						<td colspan="9" style="text-align: center">${cstmr.cstmrCd}</td>
					</tr>
					<tr>
						<td colspan="1" style="text-align: center">이메일</td>
						<td colspan="9" style="text-align: center">${cstmr.email}</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center">총 방문 횟수 : <span class="visitCnt"> 회</span></td>
						<td colspan="6" style="text-align: center">구매금액 : <span class="totalPrc"></span>원</td>
					</tr>
					<tr>
						<td>Glasses</td><td>SPH</td><td>CYL</td><td>AXIS</td><td>PD</td><td>ADD</td><td>PRISM</td><td>BASE</td><Td>NPC</Td><td>NPA</td>
					</tr>
					<tr>
						<td>Right</td><td id="gsphRight"></td><td id="gcylRight"></td><td id="gaxisRight"></td><td id="pdRight"></td><td id="addRight"></td><td id="prismRight"></td><td id="baseRight"></td><td id="npcRight"></td><td id="npaRight"></td>
					</tr>
					<tr>
						<td>Left</td><td id="gsphLeft"></td><td id="gcylLeft"></td><td id="gaxisLeft"></td><td id="pdLeft"></td><td id="addLeft"></td><td id="prismLeft"></td><td id="baseLeft"></td><td id="npcLeft"></td><td id="npaLeft"></td>
					</tr>
					<tr>
						<td>C/L</td><td>SPH</td><td>CYL</td><td>AXIS</td><td >B.C</td><td>DIA</td><td colspan="4" rowspan="3" valign="middle">우위안 <span id="dom"></span></td>
					</tr>
					<tr>
						<td>Right</td><td id="lsphRight"></td><td id="lcylRight"></td><td id="laxisRight"></td><td id="bcRight"></td><td id="diaRight"></td>
					</tr>
					<tr>
						<td>Left</td><td id="lsphLeft"></td><td id="lcylLeft"></td><td id="laxisLeft"></td><td id="bcLeft"></td><td id="diaLeft"></td>
					</tr>
					<!--
 					<tr>
						<td colspan="10">메모</td>
					</tr>
					<tr>
						<td id="memo" colspan="10">&nbsp;</td>
					</tr>
					-->
				</table>
			</td>
			<td width='50%'>
				<table id='paymentTbl2' class="paymentTbl" width="100%" border="1" style="border-collapse: collapse; text-align: center">
					<tr>
						<td>상품코드</td>
						<td>제품명</td>
						<td>수량</td>
						<td>판매가격</td>
						<td>비고</td>
					</tr>
					
					<c:choose>
						<c:when test="${!empty FramePrdct || !empty AccPrdct || !empty ClensPrdct || !empty LensPrdct || !empty NewPrdct}">
							<c:forEach var="prdct" items="${FramePrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
							</c:forEach>
								<c:forEach var="prdct" items="${NewPrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
							</c:forEach>
								<c:forEach var="prdct" items="${LensPrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
							</c:forEach>
								<c:forEach var="prdct" items="${ClensPrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
							</c:forEach>
								<c:forEach var="prdct" items="${AccPrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
							</c:forEach>
						</c:when>
					</c:choose>
						<tr>
							<td></td>
							<td></td>
							<td>총액</td>
							<td class="totalPayment" style="text-align: right;padding-right: 5px;"></td>
							<td></td>
						</tr>
						<tr>
						<td colspan='5'>
							<hr>
						</td>
						</tr>
						
						<tr>
							<td>선금</td>
							<td class="deposit"
								style="text-align: right; padding-right: 5px">&nbsp;</td>
							<td>현금</td>
							<td class="payCash"
								style="text-align: right; padding-right: 5px">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
								<td>잔금</td>
								<td class="remain" style="text-align: right; padding-right: 5px">&nbsp;</td>
								<td>카드</td>
								<td class="payCard"
									style="text-align: right; padding-right: 5px">&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
						<tr>
							<td>&nbsp;</td><td >&nbsp;</td><td>포인트</td><td class="payPoint" style="text-align: right; padding-right: 5px">&nbsp;</td><td>&nbsp;</td>
						</tr>
				</table>
			</td>
		</tr>
		
		<tr>
			<td colspan='2'>
				<hr class="dotLine">
			</td>
		</tr>
		
		<!-- table4 고객정보 -->
		<tr id='tr_4'>
			<td colspan='2'>
				<table id="cstmrTitle" width="100%">
					<tr><td class="saleId" id="saleIdB">${saleVo.saleId }</td>
						
						<td width="40%" style="text-align: center" class="bold">갤러리안경
							고객 인수증(고객용)</td>
						<!-- <td width="20%" style="text-align: right; font-size: 51%;" -->
						<td width="30%" style="text-align: right; font-size: 13px;"
							class="bold">고객명 : ${cstmrVo.cstmrName } 
							<c:if test="${cstmrVo.sexCd == 00400001}">(남)</c:if>
							<c:if test="${cstmrVo.sexCd == 00400002}">(여)</c:if>
						</td>
					</tr>
					<tr><td rowspan="2" width="30%">
							<img src="${ctxPath}/images/Logo.jpg" id="Cstmrlogo">
						</td>
						<td width="40%" style="text-align: center;font-size: 12px" class="dateTd bold"></td>
						<td width="30%" style="text-align: right; font-size: 12px" class="bold">전화번호 : ${cstmrVo.telephone }</Td>
						<%-- <td width="60%" style="text-align: center;font-size: 51%" class="dateTd bold"></td> <Td width="20%" style="text-align: right; font-size: 51%" class="bold">전화번호 : ${cstmrVo.telephone }</Td> --%>
					</tr>
					<tr>
						
						<td width="40%" style="text-align: center;" class="bold">${staffVo.staffName } 안경사</td>
						<td width="30%"style="text-align: right;font-size: 12px " class="bold">휴대폰 : ${cstmrVo.cellphone }</td>
						<%-- <td width="60%" style="text-align: center;" class="bold">${staffVo.staffName } 안경사</td><td style="text-align: right;font-size: 51% " class="bold">휴대폰 : ${cstmrVo.cellphone }</td> --%>
					</tr>
				</table>
			</td>
		</tr>
		<tr id='tr_5'>
			<td colspan='2'>
			<table id='paymentTbl3' class="paymentTbl" width="100%" border="1" style="border-collapse: collapse; text-align: center">
					<tr>
						<td>상품코드</td>
						<td>제품명</td>
						<td>수량</td>
						<td>판매가격</td>
						<td>비고</td>
					</tr>
					
					<c:choose>
						<c:when test="${!empty FramePrdct || !empty AccPrdct || !empty ClensPrdct || !empty LensPrdct || !empty NewPrdct}">
							<c:forEach var="prdct" items="${FramePrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
							</c:forEach>
								<c:forEach var="prdct" items="${NewPrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
							</c:forEach>
								<c:forEach var="prdct" items="${LensPrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
							</c:forEach>
								<c:forEach var="prdct" items="${ClensPrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
							</c:forEach>
								<c:forEach var="prdct" items="${AccPrdct }">
								<tr>
									<td>${prdct.prdctId }</td>
									<td>${prdct.prdctName }${prdct.dscntPrcnt }</td>
									<c:set var="dc" value="${(100 - prdct.dscntPrcnt)*0.01 }"></c:set>
									<td>${prdct.cnt }</td>
									<td style="text-align: right;padding-right: 5px;"><fmt:formatNumber value="${prdct.prc * dc}" pattern="#,###"/></td>
									<td></td>
								</tr>
								
							</c:forEach>
						</c:when>
					</c:choose>
						<tr>
							<td></td>
							<td></td>
							<td>총액</td>
							<td class="totalPayment" style="text-align: right;padding-right: 5px;"></td>
							<td></td>
						</tr>
						<tr>
						<td colspan='5'>
							<hr>
						</td>
						</tr>
						
						<tr>
							<td>선금</td>
							<td class="deposit"
								style="text-align: right; padding-right: 5px">&nbsp;</td>
							<td>현금</td>
							<td class="payCash"
								style="text-align: right; padding-right: 5px">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
								<td>잔금</td>
								<td class="remain" style="text-align: right; padding-right: 5px">&nbsp;</td>
								<td>카드</td>
								<td class="payCard" style="text-align: right; padding-right: 5px">&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
						<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>포인트</td>
								<td class="payPoint" style="text-align: right; padding-right: 5px">&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
					</table>
				</td>
			</tr>
		<tr id='tr_6'>
			<td colspan='2'>
				<center>
				<span class="bold">* 안경 완성품은 3개월간 보관 처리 합니다.</span> 
				<hr>
				갤러리 안경 ${shopVo.shopName } (T:${shopVo.telephone }) 갤러리 안경 ${shopVo.shopName }
				</center>
			</td>
		</tr>
	</table>
	</center>
	</div>
	<script>
		$(".totalPayment").html(format(sum_));
		var element1 = document.getElementById("printTable");
		element1.style.height = '27.7cm';
		//element1.style.height = '25cm';
		element1.style.width = '21cm';
		var tr1 = document.getElementById('tr_1');
		var tr2 = document.getElementById('tr_2');
		var tr3 = document.getElementById('tr_3');
		var tr4 = document.getElementById('tr_4');
		var tr5 = document.getElementById('tr_5');
		var tr6 = document.getElementById('tr_6');
		tr1.style.height = '8%';
		tr2.style.height = '20%';
		tr3.style.height = '30%';
		tr4.style.height = '10%';
		tr5.style.height = '20%';
		tr6.style.height = '5%';

		var element2 = document.getElementById("cstmrInfoTbl1");
		var element3 = document.getElementById("paymentTbl1");
		element2.style.fontSize = "51%";
		element3.style.fontSize = "51%";
		element2.style.height = $('#tr_2').height()+'px';
		element3.style.height = $('#tr_2').height()+'px';
		
		var element4 = document.getElementById("cstmrInfoTbl2");
		var element5 = document.getElementById("paymentTbl2");
		element4.style.fontSize = "51%";
		element5.style.fontSize = "51%";
		element4.style.height = $('#tr_3').height()+'px';
		element5.style.height = $('#tr_3').height()+'px';
		//element5.style.height = $('#cstmrInfoTbl2').height()+'px';
		var element6 = document.getElementById("paymentTbl3");
		element6.style.height = $('#tr_5').height()+'px';
		
	    window.print(); 
	</script>
</body>
</html>


