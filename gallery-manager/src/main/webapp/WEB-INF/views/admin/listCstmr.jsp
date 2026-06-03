<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<thead>
	<tr>
		<th style="padding: 5px;">NO</th>
		<th>고객 코드</th>
		<th>이름</th>
		<th>전화번호</th>
		<th>휴대전화</th>
		<th>email</th>
		<th>주소</th>
		<th style="padding: 5px;">sms 수신</th>
		<th style="padding: 5px;">email 수신</th>
		<th style="padding: 5px;">우편 수신</th>
		<th>방문일</th>
	</tr>
</thead>

<tfoot>
	<tr>
		<th style="padding: 5px;">NO</th>
		<th>고객 코드</th>
		<th>이름</th>
		<th>전화번호</th>
		<th>휴대전화</th>
		<th>email</th>
		<th>주소</th>
		<th style="padding: 5px;">sms 수신</th>
		<th style="padding: 5px;">email 수신</th>
		<th style="padding: 5px;">우편 수신</th>
		<th>방문일</th>
	</tr>
</tfoot>

<tbody>
<c:choose>
	<c:when test="${!empty cstmrList }">
		<c:forEach var="cstmr" items="${cstmrList }" varStatus="status">
			<tr>
				<td >${status.count}</td>
				<td>${cstmr.cstmrCd }</td>
				<td>${cstmr.cstmrName }</td>
				<td>${cstmr.telephone }</td>
				<td>${cstmr.cellphone }</td>
				<td>${cstmr.email }</td>
				<td>${cstmr.addr }</td>
				<td>${cstmr.getSmsYn }</td>
				<td>${cstmr.getEmailYn }</td>
				<td>${cstmr.getDmYn }</td>
				<td>${cstmr.datetime }</td>
			</tr>			
		</c:forEach>
	</c:when>
		
	<c:otherwise>
	</c:otherwise>
</c:choose>
</tbody>