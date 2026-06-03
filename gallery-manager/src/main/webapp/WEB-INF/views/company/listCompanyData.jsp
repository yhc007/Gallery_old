<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="list" width="100%" border="1">
	<colgroup>
		<col width="5%">
	</colgroup>
	<thead>
	<tr>
		<th>NO</th>
		<th>업체명</th>
		<th>담당자</th>
		<th>연락처</th>
		<th>담당자 연락처</th>
		<th>메모</th>
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listCompany}">
	   		<c:forEach var="company" items="${listCompany}" varStatus="status">
				<tr onclick="fncGetCompanyInfo('${company.INum}');return false;" class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->
				    <td>${company.rownum }</td>			
				    <td>${company.CName }</td>
				    <td>${company.EName }</td>
				    <td>${company.PNum1}</td>
				    <td>${company.PNum2 }</td>
				    <td>${company.CMemo }</td>
				    
				</tr>			
			</c:forEach>
			
			<script>
				makePagingButton("${pv.currentPage}","${pv.startPage}","${pv.endPage}","${pv.totalPage}","fncListCompanyData");
			</script>
		</c:when>		
		<c:otherwise>
			<tr>					
				<td colspan="9" align="center">거래처 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<br>
	<div align="center" id="paging_button_div">
</div>
