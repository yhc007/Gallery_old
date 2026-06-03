<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<option value="-1">추가옵션 (+0원)</option>
<c:choose>
	<c:when test="${!empty optionList }">
		<c:forEach var="option" items="${optionList }">
			<option value="${option.optionId }">${option.optionName } (+<fmt:formatNumber value="${option.puchasPrc }" pattern="#,###"/>원)</option>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<option value="0">없음</option>
	</c:otherwise>
</c:choose>
