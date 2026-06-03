<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
	<c:when test="${!empty mtrlList}">
	<option value='-1'>선택</option>
		<c:forEach var="mtrl" items="${mtrlList}">
			
			<option value="${mtrl.mtrl }">
				<c:if test="${mtrl.mtrl==1 }">
					플라스틱
				</c:if>
				<c:if test="${mtrl.mtrl==2 }">
					유리
				</c:if>
			</option>
		</c:forEach>
	</c:when>
</c:choose>