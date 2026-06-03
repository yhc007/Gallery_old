<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
	<c:when test="${!empty listLens } ">
		<c:forEach var="lens" items="${listLens }">
			<br><a href="#">${lens.prdctName }&nbsp; ${lens.curve }</a>
		</c:forEach>
	</c:when>
</c:choose>