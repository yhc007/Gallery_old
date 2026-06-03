<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
	<c:when test="${!empty colorList }">
	<li onclick="colorCdView()">뒤로</li>
		<c:forEach var="color" items="${colorList }">
        		<li><a href="javascript:selectColor('${color.colorCd }')" >${color.colorCd }</a></li>
		</c:forEach>
	</c:when>
</c:choose>
