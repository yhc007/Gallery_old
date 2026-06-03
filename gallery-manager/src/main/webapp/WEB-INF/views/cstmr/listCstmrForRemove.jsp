<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tr>
	<th>고객코드</th>
	<th>이름</th>
	<th>방문횟수</th>
	<th>&nbsp;</th>
</tr>

<c:choose>
	<c:when test="${!empty cstmrList }">
		<c:set var="cnt" value="1"></c:set>
		<c:forEach var="cstmr" items="${cstmrList }">
			<tr>
				<td class='cstmrCd' align="left">${cstmr.cstmrCd }</td>
				<td align="center">${cstmr.cstmrName }</td>
				<td align="center">${cstmr.visitCnt }</td>
				<td align='center'><button onclick="if(confirm('정말 삭제하시겠습니까??') == true)delCstmr('${cstmr.cstmrId }');" >삭제</button></td>
			</tr>
			<script>
				listCstmrCd.push('${cstmr.cstmrCd}');
			</script>
		</c:forEach>
<!-- 		<tr>
			<td colspan="2" align="left"><input type="text" placeholder="삭제코드" id="SC"> </td><td rowspan="2" align="center"><button onclick="mergeHistory();" >통합</button> </td>
		</tr>
		<Tr>
			<td colspan="2" align="left"><input type="text" placeholder="통합코드" id="DS"> </td>
		</Tr> -->
	</c:when>
</c:choose>