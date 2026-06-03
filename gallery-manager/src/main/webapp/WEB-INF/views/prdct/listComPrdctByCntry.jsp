<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
	<c:when test="${!empty comList }">
		<c:forEach var="lens" items="${comList }">
			<button onclick="getLensTyByCom('${lens.test}',this)" class="btn" data-mini="true">${lens.comName }</button>
		</c:forEach>
	</c:when>
</c:choose>
