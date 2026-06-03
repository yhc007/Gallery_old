<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${!empty boardList}">
		<c:forEach var="board" items="${boardList }">
			<tr>
				<td>${board.cstmrName }</td>
				<td>${board.telephone }</td>
				<td>${board.prdctName }</td>
				<td>${board.cardComName }</td>
				<td>${board.inputTime }</td>
				<td style="color: red">
					<c:if test="${!empty board.outputTime }">
						${board.outputTime }
					</c:if>
					<c:if test="${empty board.outputTime }">
						<button onclick="completeAs('${board.no}');return false">출고</button>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="5">${board.content }</Td>
				<td><button onclick="delAs('${board.no}');return false">삭제</button> </Td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="6">등록된  A/S가 없습니다.</td>
		</tr>
	</c:otherwise>
</c:choose>