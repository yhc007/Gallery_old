<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">

var sort2 = "D";

function getReceipt(ty){
	if(typeof(ty)=="undefined"){
		 ty = "updTime";
	}
	
	
	var iNum = ${iNum};
	var shopId = ${shopId};
	var sdate = ${sdate};
	var edate = ${edate};
	var param = "shopId=" + shopId +
					"&sdate=" + sdate + 
					"&edate=" + edate +
					"&iNum=" + iNum + 
					"&sort=" + ty + sort2;
	console.log(param)
	var url = "${ctxPath}/prdct/getReceipt.do";
	
	if(sort2=="D"){
		sort2 = "A";
	}else{
		sort2 = "D";
	}
	$.ajax({
		url : url,
		dataType : "html",
		data : param,
		type : "post",
		success : function(data){
			$("#receiptList").append(data);
		}
	});
}

var sum = 0;
var total = 0;
var cnt = 0;
var tax = 0;
function getSum(n, ty){
	if(ty=="sum_"){
		sum += n;
		n = sum;
	}else if(ty=="total_"){
		total += n;
		n = total;
	}else if(ty=="cnt_"){
		cnt += n;
		n = cnt;
		console.log(cnt)
	}else if(ty=="tax_"){
		tax += n;
		n = tax;
	}
	
	$("#" + ty).html(format(parseInt(n)));
}



function getMinus(n, ty){
	if(ty=="sum_"){
		sum -= n;
		n = sum;
	}else if(ty=="total_"){
		total -= n;
		n = total;
	}else if(ty=="cnt_"){
		cnt -= n;
		n = cnt;
		console.log(cnt)
	}else if(ty=="tax_"){
		tax -= n;
		n = tax;
	}
	
	$("#" + ty).html(format(parseInt(n)));
}

function format(n) {
	  var reg = /(^[+-]?\d+)(\d{3})/;   
	  n += '';                          

	  while (reg.test(n))
	    n = n.replace(reg, '$1' + ',' + '$2');

	  return n;
	}
	
	
	
	$(function(){
		getReceipt();
	});

</script>
</head>
</html>
	<center>
	<table id="receiptHeaderTbl" width="90%" border="1" style="border-collapse: collapse; text-align: center" >
																						
	<c:choose>
		<c:when test="${!empty shopData}">
	   		<c:forEach var="shop" items="${shopData}" varStatus="status">
				<tr >
					<th width="35%">공급 받는 자</th> <th rowspan="4" width="5%">공 급 자 </th><th width="15%">사업자 번호</th><td>${shop.no }</td><th>업태</th><td>${shop.type }</td>  
				</tr>																		
				<tr>
					<td style="padding: 10px" rowspan="3">${shop.shopName }<br>${shop.telephone }</td> <th width="10%">TEL</th><td width="20%">${shop.ty1 }</td><th width="10%">담당자</th><td width="20%">${shop.mtrlName }</td>                                        
				</tr>
				<tr>
					<th>상호</th><td colspan="3">${shop.comName }</td>
				</tr>
				<tr>
					<th>주소</th><td colspan="3">${shop.addr }</td>
				</tr>
			</c:forEach>
		</c:when>
	</c:choose>
				
</table>
<hr width="90%">
<div id="receiptList">
</div>
</center>