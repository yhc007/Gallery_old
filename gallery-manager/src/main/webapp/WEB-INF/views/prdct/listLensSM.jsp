<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
	<c:when test="${!empty lensSM }">
		<c:forEach var="lens" items="${lensSM }">
			<button onclick="getLensList('${lens.type3}',this)" class="SMBtn" data-mini="true">
				<c:if test="${lens.type3 eq 'Single'}">
					단초점
				</c:if>
				<c:if test="${lens.type3 eq 'Multi'}">
					다초점
				</c:if>		
				</button>
		</c:forEach>
	</c:when>
</c:choose>
