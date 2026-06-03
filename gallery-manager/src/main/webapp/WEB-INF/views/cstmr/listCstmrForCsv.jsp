<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
<c:when test="${!empty cstmrList || !empty cstmrList2}">
		<c:forEach var="cstmr" items="${cstmrList}">
${cstmr.cstmrName },${cstmr.cellphone },${cstmr.getSmsYn },N,${cstmr.datetime}|
		</c:forEach>
		<c:forEach var="cstmr2" items="${cstmrList2 }">
${cstmr2.cstmrName },${cstmr2.cellphone },${cstmr2.getSmsYn },Y,${cstmr2.datetime}|
		</c:forEach>
	</c:when>
</c:choose>
			
		
