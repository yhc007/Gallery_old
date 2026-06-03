<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:choose>
	<c:when test="${!empty specList }">
		<c:forEach var="spec" items="${specList }">
		 ${spec.data }
		</c:forEach>
	</c:when>
	<c:otherwise>

	</c:otherwise>
</c:choose>
