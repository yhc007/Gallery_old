<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tr>
	<th>고객코드</th>
	<th>이름</th>
	<th>방문횟수</th>
	<th>선택</th>
</tr>

<c:choose>
	<c:when test="${!empty cstmrList }">
		<c:set var="cnt" value="1"></c:set>
		<c:forEach var="cstmr" items="${cstmrList }">
			<tr>
				<td class='cstmrCd' align="left">${cstmr.cstmrCd }</td>
				<td align="center">${cstmr.cstmrName }</td>
				<td align="center">${cstmr.visitCnt }</td>
				<td align="center"><input type="radio" name="merge_info" value="${cstmr.cstmrCd }"></td>
			</tr>
			<script>
				listCstmrCd.push('${cstmr.cstmrCd}');
			</script>
		</c:forEach>
		<tr>
			<!-- <td colspan="2" align="left"><input type="text" placeholder="삭제코드" id="SC"> </td> -->
			<td  align="center" colspan="4"><button onclick="mergeHistory();" >통합</button> </td>
		</tr>
		<!-- <Tr>
			<td colspan="2" align="left"><input type="text" placeholder="통합코드" id="DS"> </td>
		</Tr> -->
	</c:when>
</c:choose>