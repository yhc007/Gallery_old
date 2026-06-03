<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<center>
	<table id="receiptTbl" width="90%"border="1" style="border-collapse: collapse; text-align: center" > 
	<tr>
		<th  class="title">날짜</th>
		<th  class="title">제품</th>
		<th  class="title">수량</th>
		<th  class="title">단가</th>
		<th  class="title">공급가액</th>
		<th  class="title">부가세</th>
		
	</tr>
	<c:choose>
		<c:when test="true">
			<c:forEach var="prdct" items="${listRecepit }"> 
				<tr >
					<c:set var="day" value="${prdct.updTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set>
					<td width="10%">${date }</td>
					<td width="30%" align="left">${prdct.prdctName }</td>
					<td align="right" width="8%"><fmt:formatNumber value="${prdct.cnt}" pattern="#,###"/>EA</td>
					<td align="right" width="14%"><fmt:formatNumber value="${prdct.puchasPrc}" pattern="#,###"/></td>
					<c:set var="sum" value="${prdct.cnt * prdct.puchasPrc}"></c:set>
					<c:set var="tax" value="${(prdct.puchasPrc * 0.1 - (prdct.puchasPrc * 0.1%1)) * prdct.cnt}"></c:set>
					
					<td align="right" width="14%"><fmt:formatNumber value="${sum}" pattern="#,###"/></td>
					<td align="right" width="14%"><fmt:formatNumber value="${tax}" pattern="#,###"/></td>
					
					<script>
						getSum(${prdct.cnt},"cnt_");
						getSum(${sum},"sum_");	
						getSum(${tax},"tax_");
						getSum(${sum + tax},"total_");
					</script>
				</tr>
				
				
			</c:forEach>
			<c:forEach var="prdct" items="${listRecepitLens }"> 
				<tr >
					<c:set var="day" value="${prdct.updTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set>
					<td width="10%">${date }</td>
					<td width="30%" align="left">${prdct.prdctName }</td>
					<td align="right" width="8%"><fmt:formatNumber value="${prdct.cnt}" pattern="#,###"/>EA</td>
					<td align="right" width="14%"><fmt:formatNumber value="${prdct.puchasPrc}" pattern="#,###"/></td>
					<c:set var="sum" value="${prdct.cnt * prdct.puchasPrc}"></c:set>
					<c:set var="tax" value="${(prdct.puchasPrc * 0.1 - (prdct.puchasPrc * 0.1%1)) * prdct.cnt}"></c:set>
					
					<td align="right" width="14%"><fmt:formatNumber value="${sum}" pattern="#,###"/></td>
					<td align="right" width="14%"><fmt:formatNumber value="${tax}" pattern="#,###"/></td>
					
					<script>
						getSum(${prdct.cnt},"cnt_");
						getSum(${sum},"sum_");
						getSum(${tax},"tax_");
						getSum(${sum + tax},"total_");
					</script>
				</tr>
				
				
			</c:forEach>
			<c:forEach var="prdct" items="${listRecepitClens }"> 
				<tr >
					<c:set var="day" value="${prdct.updTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set>
					<td width="10%">${date }</td>
					<td width="30%" align="left">${prdct.prdctName }</td>
					<td align="right" width="8%"><fmt:formatNumber value="${prdct.cnt}" pattern="#,###"/>EA</td>
					<td align="right" width="14%"><fmt:formatNumber value="${prdct.puchasPrc}" pattern="#,###"/></td>
					<c:set var="sum" value="${prdct.cnt * prdct.puchasPrc}"></c:set>
					<c:set var="tax" value="${(prdct.puchasPrc * 0.1 - (prdct.puchasPrc * 0.1%1)) * prdct.cnt}"></c:set>
					
					<td align="right" width="14%"><fmt:formatNumber value="${sum}" pattern="#,###"/></td>
					<td align="right" width="14%"><fmt:formatNumber value="${tax}" pattern="#,###"/></td>
					
					<script>
						getSum(${prdct.cnt},"cnt_");
						getSum(${sum},"sum_");
						getSum(${tax},"tax_");
						getSum(${sum + tax},"total_");
					</script>
				</tr>
				
				
			</c:forEach>
			<c:forEach var="prdct" items="${listRecepitAcc }"> 
				<tr >
					<c:set var="day" value="${prdct.updTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set>
					<td width="10%">${date }</td>
					<td width="30%" align="left">${prdct.prdctName }</td>
					<td align="right" width="8%"><fmt:formatNumber value="${prdct.cnt}" pattern="#,###"/>EA</td>
					<td align="right" width="14%"><fmt:formatNumber value="${prdct.puchasPrc}" pattern="#,###"/></td>
					<c:set var="sum" value="${prdct.cnt * prdct.puchasPrc}"></c:set>
					<c:set var="tax" value="${(prdct.puchasPrc * 0.1 - (prdct.puchasPrc * 0.1%1)) * prdct.cnt}"></c:set>
					
					<td align="right" width="14%"><fmt:formatNumber value="${sum}" pattern="#,###"/></td>
					<td align="right" width="14%"><fmt:formatNumber value="${tax}" pattern="#,###"/></td>
					
					<script>
						getSum(${prdct.cnt},"cnt_");
						getSum(${sum},"sum_");
						getSum(${tax},"tax_");
						getSum(${sum + tax},"total_");
					</script>
				</tr>
				
				
			</c:forEach>
			<c:forEach var="prdct" items="${listRecepitEtc }"> 
				<tr >
					<c:set var="day" value="${prdct.updTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set>
					<td width="10%">${date }</td>
					<td width="30%" align="left">${prdct.prdctName }</td>
					<td align="right" width="8%"><fmt:formatNumber value="${prdct.cnt}" pattern="#,###"/>EA</td>
					<td align="right" width="14%"><fmt:formatNumber value="${prdct.puchasPrc}" pattern="#,###"/></td>
					<c:set var="sum" value="${prdct.cnt * prdct.puchasPrc}"></c:set>
					<c:set var="tax" value="${(prdct.puchasPrc * 0.1 - (prdct.puchasPrc * 0.1%1)) * prdct.cnt}"></c:set>
					
					<td align="right" width="14%"><fmt:formatNumber value="${sum}" pattern="#,###"/></td>
					<td align="right" width="14%"><fmt:formatNumber value="${tax}" pattern="#,###"/></td>
					
					<script>
						getSum(${prdct.cnt},"cnt_");
						getSum(${sum},"sum_");
						getSum(${tax},"tax_");
						getSum(${sum + tax},"total_");
					</script>
				</tr>
				
				
			</c:forEach>
			
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="6">거래 목록이 없습니다.</td>
			</tr>
		</c:otherwise>
	</c:choose>
	
	<!-- 반품내역  -->
	<tr>
		<th colspan="6" text-align="center">반품 내역</th>
	</tr>
	
	<c:forEach var="prdct" items="${getRtnFrame }"> 
				<tr >
					<c:set var="day" value="${prdct.updTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set>
					<td width="10%">${date }</td>
					<td width="30%" align="left">${prdct.prdctName }</td>
					<td align="right" width="8%"><fmt:formatNumber value="${prdct.cnt}" pattern="#,###"/>EA</td>
					<td align="right" width="14%"><fmt:formatNumber value="${prdct.puchasPrc}" pattern="#,###"/></td>
					<c:set var="sum" value="${prdct.cnt * prdct.puchasPrc}"></c:set>
					<c:set var="tax" value="${(prdct.puchasPrc * 0.1 - (prdct.puchasPrc * 0.1%1)) * prdct.cnt}"></c:set>
					
					<td align="right" width="14%"><fmt:formatNumber value="${sum}" pattern="#,###"/></td>
					<td align="right" width="14%"><fmt:formatNumber value="${tax}" pattern="#,###"/></td>
					
					<script>
						getMinus(${prdct.cnt},"cnt_");
						getMinus(${sum},"sum_");
						getMinus(${tax},"tax_");
						getMinus(${sum + tax},"total_");
					</script>
				</tr>
				
				
			</c:forEach>
			<c:forEach var="prdct" items="${getRtnLens }"> 
				<tr >
					<c:set var="day" value="${prdct.updTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set>
					<td width="10%">${date }</td>
					<td width="30%" align="left">${prdct.prdctName }</td>
					<td align="right" width="8%"><fmt:formatNumber value="${prdct.cnt}" pattern="#,###"/>EA</td>
					<td align="right" width="14%"><fmt:formatNumber value="${prdct.puchasPrc}" pattern="#,###"/></td>
					<c:set var="sum" value="${prdct.cnt * prdct.puchasPrc}"></c:set>
					<c:set var="tax" value="${(prdct.puchasPrc * 0.1 - (prdct.puchasPrc * 0.1%1)) * prdct.cnt}"></c:set>
					
					<td align="right" width="14%"><fmt:formatNumber value="${sum}" pattern="#,###"/></td>
					<td align="right" width="14%"><fmt:formatNumber value="${tax}" pattern="#,###"/></td>
					
					<script>
						getMinus(${prdct.cnt},"cnt_");
						getMinus(${sum},"sum_");
						getMinus(${tax},"tax_");
						getMinus(${sum + tax},"total_");
					</script>
				</tr>
				
				
			</c:forEach>
			<c:forEach var="prdct" items="${getRtnClens }"> 
				<tr >
					<c:set var="day" value="${prdct.updTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set>
					<td width="10%">${date }</td>
					<td width="30%" align="left">${prdct.prdctName }</td>
					<td align="right" width="8%"><fmt:formatNumber value="${prdct.cnt}" pattern="#,###"/>EA</td>
					<td align="right" width="14%"><fmt:formatNumber value="${prdct.puchasPrc}" pattern="#,###"/></td>
					<c:set var="sum" value="${prdct.cnt * prdct.puchasPrc}"></c:set>
					<c:set var="tax" value="${(prdct.puchasPrc * 0.1 - (prdct.puchasPrc * 0.1%1)) * prdct.cnt}"></c:set>
					
					<td align="right" width="14%"><fmt:formatNumber value="${sum}" pattern="#,###"/></td>
					<td align="right" width="14%"><fmt:formatNumber value="${tax}" pattern="#,###"/></td>
					
					<script>
						getMinus(${prdct.cnt},"cnt_");
						getMinus(${sum},"sum_");
						getMinus(${tax},"tax_");
						getMinus(${sum + tax},"total_");
					</script>
				</tr>
				
				
			</c:forEach>
			<c:forEach var="prdct" items="${getRtnAcc }"> 
				<tr >
					<c:set var="day" value="${prdct.updTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set>
					<td width="10%">${date }</td>
					<td width="30%" align="left">${prdct.prdctName }</td>
					<td align="right" width="8%"><fmt:formatNumber value="${prdct.cnt}" pattern="#,###"/>EA</td>
					<td align="right" width="14%"><fmt:formatNumber value="${prdct.puchasPrc}" pattern="#,###"/></td>
					<c:set var="sum" value="${prdct.cnt * prdct.puchasPrc}"></c:set>
					<c:set var="tax" value="${(prdct.puchasPrc * 0.1 - (prdct.puchasPrc * 0.1%1)) * prdct.cnt}"></c:set>
					
					<td align="right" width="14%"><fmt:formatNumber value="${sum}" pattern="#,###"/></td>
					<td align="right" width="14%"><fmt:formatNumber value="${tax}" pattern="#,###"/></td>
					
					<script>
						getMinus(${prdct.cnt},"cnt_");
						getMinus(${sum},"sum_");
						getMinus(${tax},"tax_");
						getMinus(${sum + tax},"total_");
					</script>
				</tr>
				
				
			</c:forEach>
			<c:forEach var="prdct" items="${getRtnEtc }"> 
				<tr >
					<c:set var="day" value="${prdct.updTime}"></c:set>
					<c:set var="date" value="${fn:substring(day,5,10)}"></c:set>
					<td width="10%">${date }</td>
					<td width="30%" align="left">${prdct.prdctName }</td>
					<td align="right" width="8%"><fmt:formatNumber value="${prdct.cnt}" pattern="#,###"/>EA</td>
					<td align="right" width="14%"><fmt:formatNumber value="${prdct.puchasPrc}" pattern="#,###"/></td>
					<c:set var="sum" value="${prdct.cnt * prdct.puchasPrc}"></c:set>
					<c:set var="tax" value="${(prdct.puchasPrc * 0.1 - (prdct.puchasPrc * 0.1%1)) * prdct.cnt}"></c:set>
					
					<td align="right" width="14%"><fmt:formatNumber value="${sum}" pattern="#,###"/></td>
					<td align="right" width="14%"><fmt:formatNumber value="${tax}" pattern="#,###"/></td>
					
					<script>
						getMinus(${prdct.cnt},"cnt_");
						getMinus(${sum},"sum_");
						getMinus(${tax},"tax_");
						getMinus(${sum + tax},"total_");
					</script>
				</tr>
				
				
			</c:forEach>
	
	
	<table id="sumTbl" width="90%"border="1" style="border-collapse: collapse; text-align: center" >
				<tr>
					<th width="10%">수량</th><td width="10%" id="cnt_" align="right"></td><th width="15%" >공급가액</th><td width="15%" id="sum_" align="right"></td><th width="10%" >부가세</th><td width="15%" id="tax_" align="right"></td><th width="10%" >합계</th><td width="15%" id="total_" align="right"> </td>
				</tr>
			</table>
	</table>
</center>