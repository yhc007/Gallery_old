<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<thead>
<tr>
	<th onclick="getComPrdctList('brandName')" class="title" width="17%">브랜드</th>
	<th onclick="getComPrdctList('prdctName')" class="title">제품</th>
	<th onclick="getComPrdctList('puchasPrc')" class="title" width="10%">매입가</th>
	<th onclick="getComPrdctList('salePrc')" class="title" width="10%">판매가</th>
	<th onclick="getComPrdctList('updTime')" class="title" width="20%">등록날짜</th>
	<th onclick="getComPrdctList('cName')" class="title" width="15%">거래처</th>
</tr>
</thead>
<tbody>
<c:choose>
	<c:when test="${!empty listPrdct }">
		<c:set var="flag" value="a">
		</c:set>
			
	
		<c:forEach var="prdct" items="${listPrdct }">
		
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
			<tr onclick="getEditForm('${prdct.id}')"  class="${cssClass }" >
				<td class="td">${prdct.brandName }</td>
				<td class="td">${prdct.prdctName }&nbsp;&nbsp; 
				<c:if test="${prdct.colorName1!=null || prdct.colorName2 }">
					(${prdct.colorName1 } / ${prdct.colorName2 })</td>
				</c:if>
				<td align="right" class="td" style="padding-right: 5px;"><fmt:formatNumber value="${prdct.puchasPrc}" pattern="#,###"/></td>
				<td align="right" class="td" style="padding-right: 5px;"><fmt:formatNumber value="${prdct.trdePrc}" pattern="#,###"/></td>
				<c:set var="regtime" value='${prdct.updTime}'/>
				    <c:set var="time" value="${fn:substring(regtime, 0, 16)}" />
				    <td align="center" class="td">${time}</td>
				<td class="td">${prdct.comName }</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="6" class="td">제품이 없습니다.</td>
		</tr>
	</c:otherwise>
</c:choose>
</tbody>