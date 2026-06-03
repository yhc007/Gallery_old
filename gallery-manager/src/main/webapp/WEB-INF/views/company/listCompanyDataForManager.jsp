<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<center>
<button onclick="getListCom('1')">프레임</button><button onclick="getListCom('2')">렌즈</button><button onclick="getListCom('3')">콘텍트 렌즈</button><button onclick="getListCom('4')">렌즈용액</button>
<table class="list" width="90%" border="1">
	<tr>
		<th width="25%">업체명</th>
		<th width="25%">담당자</th>
		<th width="25%">전화번호1</th>
		<th width="25%">전화번호2</th>
	</tr>
	<c:choose>
		<c:when test="${!empty listCom}">
		<c:set var="flag" value="a">
		</c:set>
	   		<c:forEach var="company" items="${listCom}" varStatus="status">
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
				<tr class="${cssClass }">
					<td>${company.comName }</td>
					<td>${company.comName2 }</td>
					<td>${company.PNum1 }</td> 
					<td>${company.PNum2 }</td> 
				</tr>			
			</c:forEach>
		</c:when>		
		<c:otherwise>
		</c:otherwise>
	</c:choose>
</table>
</center>