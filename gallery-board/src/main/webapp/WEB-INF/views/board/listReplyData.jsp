<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:choose>
	<c:when test="${!empty replyList }">
		<c:forEach var="reply" items="${replyList }">
			 <c:set var="regtime" value='${reply.updTime}'/>
		    <c:set var="time" value="${fn:substring(regtime, 5, 10)}" />
			<li>
				<a href="javascript:replydetail('${reply.content }')">
					<h2>${reply.content }<span style="float: right;">${reply.writer }(${time})</span></h2>
				</a>
				<a href="javascript:delReply('${reply.replyNo }','${reply.id }')" data-icon='delete'></a>
			</li>
		</c:forEach>
	</c:when>
</c:choose>