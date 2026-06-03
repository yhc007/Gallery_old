<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gallery Comunity</title>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<style type="text/css" media="print">
      div.page
      {
        page-break-after: always;
        page-break-inside: avoid;
      }
      
     /* body{
     	padding-left: 20px;
     	padding-right: 20px;
     } */
</style>  
<script type="text/javascript">

</script>
</head>
<body>
<center>
<div class="page">
	<c:choose>
		<c:when test="${!empty trdeList}">
		
			<c:set var="shopName" value=""></c:set>
			<c:set var="endTable" value=""></c:set>
			<c:set var="endDiv" value=""></c:set>
			
			<c:set var="sale" value="0"></c:set>
			<c:set var="returnPrc" value="0"></c:set>
			<c:set var="pay" value="0"></c:set>
			<c:set var="devidePay" value="0"></c:set>
			
			<c:set var="number" value="1"></c:set>
			<c:set var="pageCntS" value="1"></c:set>
			<c:set var="pageCntE" value="1"></c:set>
			<c:set var="init" value="1"></c:set>
			<jsp:useBean id="now" class="java.util.Date" />
			<c:forEach var="trde" items="${trdeList}" varStatus="status">
			
			
			
				  <c:if test="${trde.shopName != shopName}">
						<c:if test="${init ==1 }">
			
						</c:if>
						<c:if test="${init ==2 }">
							<tr>
							  	<td style="text-align: center;">합계</td>
							  	<td ></td>
							  	<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${sale}" pattern="#,###" /></td>
							  	<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${returnPrc}" pattern="#,###" /></td>
							  	<td style="text-align: right;padding-right: 10px;"> <fmt:formatNumber value="${pay}" pattern="#,###" /></td>
							  	<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${devidePay}" pattern="#,###" /></td>
							  </tr>
						</c:if>
						
						<c:set var="init" value="2"></c:set>	  
					  ${endTable }
					  
					  <c:if test="${number>=10 }">
					  		${endDiv }
					  </c:if>

						<c:if test="${number<10 }">
				  		<c:set var="pageCntE" value="${pageCntE + 1}"></c:set>
				  		<c:if test="${pageCntE ==3 }">
				  			${endDiv }
				  			<c:set var="pageCntE" value="0"></c:set>
				  		</c:if>
					  </c:if>
						
					  
					  <br>
					  <c:if test="${number>=10 }">
					  	 <div class="page">
					  </c:if>
					  
					  
					  
					  <c:if test="${number<10 }">
				  		<c:set var="pageCntS" value="${pageCntS + 1}"></c:set>
				  		<c:if test="${pageCntS ==3 }">
				  			<div class="page">
				  			<c:set var="pageCntS" value="0"></c:set>
				  		</c:if>
					  </c:if>
					  
						<table width="90%">
							<c:set var="sale" value="0"></c:set>
							<c:set var="returnPrc" value="0"></c:set>
							<c:set var="pay" value="0"></c:set>
							<c:set var="devidePay" value="0"></c:set>
							<c:set var="number" value="1"></c:set>
							<tr>
								<td style="font-weight: bold; font-size: 17px">${trde.shopName }</td>
								<td></td>
								<td></td>
								<td></td>
								<td style="font-weight: bold; font-size: 14px;text-align: right;">기간 : ${sdate } ~ ${edate }<br>
								<span style="font-size: 12px; font-weight: normal;">출력일자 : <fmt:formatDate value="${now}" pattern="yyyy-MM-dd a hh:mm" /></span>
								</td>
							</tr>
						</table>
						<table width="90%"  class='tablesorter-ice table' border="1" style="border-collapse: collapse; font-size: 12px;"> 
						<c:set var="endTable" value="</table>"></c:set>
						<c:set var="endDiv" value="</div>"></c:set>
							<thead>
								<tr>
									<td width="5%" style="text-align: center">NO.</td>
									<td width="15%" style="text-align: center">협력사</td>
									<td width="20%" style="text-align: center">매출금액</td>
									<td width="20%" style="text-align: center">반품금액</td>
									<td width="20%" style="text-align: center">결재금액</td>
									<td width="20%" style="text-align: center">할부금액</td>		
								</tr>
							</thead>
							<c:set var="shopName" value="${trde.shopName }"></c:set>			
					</c:if>
					
					<c:if test="${trde.shopName == shopName}">
						<tbody>
							<tr>
								<td style="text-align: center">${number }</td>
								<td style="text-align: center">${trde.comName }</td>
								<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${trde.sales}" pattern="#,###" /></td>
								<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${trde.returnPrc}" pattern="#,###" /></td>
								<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${trde.pay}" pattern="#,###" /></td>
								<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${trde.devidePay}" pattern="#,###" /></td>
								
								<c:set var="sale" value="${sale + trde.sales }"></c:set>
								<c:set var="returnPrc" value="${returnPrc + trde.returnPrc}"></c:set>
								<c:set var="pay" value="${pay + trde.pay}"></c:set>
								<c:set var="devidePay" value="${devidePay + trde.devidePay}"></c:set>
								<c:set var="number" value="${number + 1}"></c:set>
							</tr>
					  </tbody>	
					</c:if>
			</c:forEach>
					<tr>
					  	<td style="text-align: center;">합계</td>
					  	<td ></td>
					  	<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${sale}" pattern="#,###" /></td>
					  	<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${returnPrc}" pattern="#,###" /></td>
					  	<td style="text-align: right;padding-right: 10px;"> <fmt:formatNumber value="${pay}" pattern="#,###" /></td>
					  	<td style="text-align: right;padding-right: 10px;"><fmt:formatNumber value="${devidePay}" pattern="#,###" /></td>
					</tr>
		</c:when>
	</c:choose>
	</center>
</body>
</html>