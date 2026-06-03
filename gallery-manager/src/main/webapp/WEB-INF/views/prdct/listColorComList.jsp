<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
	<c:when test="${!empty comList }">
		<c:forEach var="lens" items="${comList }">
      			<li><a href="javascript:appendColorList('${lens.comName}','this')">${lens.comName }</a></li>
		</c:forEach>
			<li><a href="javascript:selectSampleColor('샘플')">샘플컬러</a></li>
	</c:when>
</c:choose>
