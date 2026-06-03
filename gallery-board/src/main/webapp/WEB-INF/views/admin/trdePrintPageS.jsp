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
</script>
<style type="text/css">
	.grayClass{
		background-color: #d3d3d3;
	}
	.whiteClass{
		background-color: white;
	}
</style>
</head>
<body>
<center>
<table  class='tablesorter-ice' border="1" style="border-collapse: collapse;width:90%; text-align: center;font-size: 11px;" id="tradeDetailS" >
<thead>
	<tr style="font-size: 11px">
		<th>NO.</th>
		<th>날짜</th>
		<th>매장</th>
		<th>협력사</th>
		<th>단가</th>
		<th>수량</th>
		<th>공급가</th>
		<th>할부</th>
		<th>부가세</th>
		<th>합계</th>
		<th>수수료</th>
	</tr>	
</thead>
<tbody>
	<c:choose>
		<c:when test="${!empty trdeList}">
		<c:set var="flag" value="a">
		</c:set>
	   		<c:forEach var="trde" items="${trdeList}" varStatus="status">
	   		
	   		<c:choose>
			<c:when test="${flag eq 'a'}">
				<c:set value="grayClass" var="cssClass"></c:set>
				
				<c:set var="flag" value='b'></c:set>
			</c:when>
			<c:otherwise>
				<c:set value="whiteClass" var="cssClass">
				</c:set>
				<c:set var="flag" value="a">
				</c:set>
			</c:otherwise>
			</c:choose>
				<tr class='${cssClass}'>
					<td>${status.count }</td>
					<c:set var="day" value="${trde.deliverTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set>
					<c:set var="month" value="${fn:substring(thisMonth,5,6)}"></c:set>
					<td>${date }</td>
					<td>${trde.shopName }</td>
					<td>${trde.comName }</td>
					<td style="text-align: right; padding-left: 50px"><fmt:formatNumber value="${trde.puchasPrc }" pattern="#,###"/></td></td>
					<td>${trde.cnt }</td>
					
					
					
					
					<!--공급가  -->
					<c:set var="sum" value="${(trde.cnt * trde.puchasPrc)}"></c:set>
					<td style="text-align: right; padding-left: 50px">
						<c:choose>
							<c:when test="${trde.devide!=0 }">
								<c:set var="sum" value="${sum/trde.devide}"></c:set>
								<fmt:formatNumber value="${(trde.cnt * trde.puchasPrc)/trde.devide}" pattern="#,###" />/<fmt:formatNumber value="${trde.cnt * trde.puchasPrc}" pattern="#,###" /></td>
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${sum}" pattern="#,###" /></td>	
							</c:otherwise>	
						</c:choose>
						
						
					
					
					
					<c:if test="${trde.devide eq '0'}">
						<td>일시불</td>
					</c:if>
					<c:if test="${trde.devide eq '1'}">
						<td>이월</td>
					</c:if>
					<c:if test="${trde.devide eq '2'}">
						<td>${trde.dueMonth-(trde.dueMonth-month)}/2개월</td>
					</c:if>
					<c:if test="${trde.devide eq '3'}">
						<td>${trde.dueMonth-(trde.dueMonth-month)}/3개월</td>
					</c:if>
					<c:if test="${trde.devide eq '4'}">
						<td>${trde.dueMonth-(trde.dueMonth-month)}/4개월</td>
					</c:if>
					<c:if test="${trde.devide eq '5'}">
						<td>${trde.dueMonth-(trde.dueMonth-month)}/5개월</td>
					</c:if>
					<c:if test="${trde.devide eq '6'}">
						<td>${trde.dueMonth-(trde.dueMonth-month)}/6개월</td>
					</c:if>
					

			
					<c:set var="tax2" value="${trde.cnt * trde.puchasPrc * 0.1}"></c:set>		
					<!-- 부가세 -->
					<td style="text-align: right; padding-left: 50px">
						<c:choose>
							<c:when test="${trde.devide!=0 }">
								<c:set var="tax2" value="${tax2/trde.devide}"></c:set>
								<fmt:formatNumber value="${tax2}" pattern="#,###" />
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${tax2}" pattern="#,###" />	
							</c:otherwise>
						</c:choose>
						
					</td>
					
					
					
					<c:set var="total" value="${((trde.cnt * trde.puchasPrc) + (trde.cnt * trde.puchasPrc * 0.1))}"></c:set>
					<!-- 합계 -->
					<td style="text-align: right; padding-left: 50px">
						<c:choose>
							<c:when test="${trde.devide!=0 }">
							<c:set var="total" value="${((trde.cnt * trde.puchasPrc) + (trde.cnt * trde.puchasPrc * 0.1))/trde.devide}"></c:set>
								<fmt:formatNumber value="${total}" pattern="#,###" /></td>
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${total}" pattern="#,###" /></td>	
							</c:otherwise>
						</c:choose>
						
					<c:set var="rate" value="${trde.tax/100 }"></c:set>
					
					
					
					<!-- 수수료 -->
					<c:set var="tax" value="${((trde.cnt * trde.puchasPrc) + (trde.cnt * trde.puchasPrc * 0.1)) * rate }"></c:set>
					<td style="text-align: right; padding-left: 50px">
						<c:choose>
							<c:when test="${trde.devide!=0 }">
								<c:set var="tax" value="${((trde.cnt * trde.puchasPrc) + (trde.cnt * trde.puchasPrc * 0.1)) * rate /trde.devide}"></c:set>
								<fmt:formatNumber value="${tax}" pattern="#,###" /></td>
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${tax}" pattern="#,###" /></td>	
							</c:otherwise>
						</c:choose>
						
				</tr>
			</c:forEach>
			<tr>
				<td>합계</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td class="sum_" style="text-align: right; padding-left: 50px"></td>
				<td></td>
				<td class="tax2_" style="text-align: right; padding-left: 50px"></td>
				<td class="total_" style="text-align: right; padding-left: 50px"></td>
				<td class="tax_" style="text-align: right; padding-left: 50px"></td>
			</tr>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
</tbody>
</table>
</center>
</body>
</html>