<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<thead>
<tr>
	<th>NO</th>
	<th>이름</th>
	<th>휴대전화</th>
	<th>SMS 수신 여부</th>
	<th>성인 여부</th>
	<th>최근 방문 일</th>
</tr>
</thead>
<tfoot>
<tr>
	<th>NO</th>
	<th>이름</th>
	<th>휴대전화</th>
	<th>SMS 수신 여부</th>
	<th>성인 여부</th>
	<th>최근 방문 일</th>
</tr>
</tfoot>

<c:set var="flag" value="a"/>


<tbody>
<c:choose>
	<c:when test="${!empty cstmrList || !empty cstmrList2}">
		<c:forEach var="cstmr" items="${cstmrList }" varStatus="status1">
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
				<td>${status1.count }</td>
				<Td align="center">${cstmr.cstmrName }</Td>
				<Td align="center">${cstmr.cellphone }</Td>
				<Td align="center">${cstmr.getSmsYn }</Td>
				<Td align="center"> N </Td>
				<Td align="center">${cstmr.datetime}</Td>
			</tr>
		</c:forEach>
		
		
		<c:forEach var="cstmr2" items="${cstmrList2 }" varStatus="status2">
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
				<c:choose>
					<c:when test="${!empty cstmrList && !empty cstmrList2}">
						<td>${fn:length(cstmrList) + status2.count }</td>
					</c:when>
					<c:otherwise>
						<td>${status2.count }</td>
					</c:otherwise>
				</c:choose>
				<Td align="center">${cstmr2.cstmrName }</Td>
				<Td align="center">${cstmr2.cellphone }</Td>
				<Td align="center">${cstmr2.getSmsYn }</Td>
				<Td align="center"> Y </Td>
				<Td align="center">${cstmr2.datetime}</Td>
			</tr>
		</c:forEach>
	</c:when>
</c:choose>
</tbody>
		
