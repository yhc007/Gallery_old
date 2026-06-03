<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>


<table style='width:100%;border:1' class="transBoxTable listItemJQM">
	<thead>
	<tr>
		<th width="10%" class=list_prdct style="color: #000"></th>
		<th width="20%" class=list_prdct style="color: #000">할인명</th>
		<th width="10%" class=list_prdct style="color: #000">할인율</th>
		<th width="20%" class=list_prdct style="color: #000">조건</th>
		<th width="40%" class=list_prdct style="color: #000">상세</th>
	</tr>
	</thead>
	
	<c:choose>
		<c:when test="${!empty listPartner}">
		<c:set var="count" value="1"></c:set>
	   		<c:forEach var="partner" items="${listPartner}" varStatus="status">
				<tr>
				    <td width="10%" style="color:white;" align="center"> ${count} </td>
				    <td width="20%" style="color:white;" align="center">${partner.partnerName}</td>
				    <td width="10%" style="color:white;" align="center">${partner.dscntPrcnt}</td>
				    <td width="20%" style="color:white;" align="center">${partner.partnerCert}</td>
				    <td width="40%" style="color:white;" align="center">${partner.partnerMemo}</td>
				</tr>
				<c:set value="${count +1 }" var="count"></c:set>
			</c:forEach>
		</c:when>
		<c:otherwise>	
			<tr>
				<td colspan="5">정보가 없습니다.</td>
			</tr>
		</c:otherwise>
	</c:choose>
</table>