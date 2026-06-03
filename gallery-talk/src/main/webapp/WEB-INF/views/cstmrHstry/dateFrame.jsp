<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<title>Insert title here</title>
</head>
<body>
	<c:choose>
		<c:when test="${!empty listVisit }">
			<c:forEach var="visit" items="${listVisit }" varStatus="status">
				<%-- <a href="javascript:getCheckInfo('${visit.saleId}')">
						<div class='dateSpan' id="${visit.saleId}"  onclick="changeClr(${visit.saleId});">${visit.datetime }&nbsp;${visit.shopName }</div>
						
					</a> --%>
			<c:choose>
			<%-- <option selected="selected" value='${visit.saleId}'> --%>
				<c:when test="${status.first}">
					<a href="javascript:getCheckInfo('${visit.saleId}')">
						<div class='dateSpan' id="${visit.saleId}"  onclick="changeClr(${visit.saleId});">${visit.datetime }&nbsp;${visit.shopName }</div>
						<script>
							//console.log("first ${visit.saleId}"+":"+"${visit.datetime }"+":"+"${visit.shopName }");
						</script>
					</a>
					<script>
						getCheckInfo('${visit.saleId}');
					</script>
					</option>
				</c:when>
				<c:otherwise>
					<a href="javascript:getCheckInfo('${visit.saleId}')">
						<div class='dateSpan' id="${visit.saleId}"  onclick="changeClr(${visit.saleId});">${visit.datetime }&nbsp;${visit.shopName }</div>
						<script>
							//console.log("${visit.saleId}"+":"+"${visit.datetime }"+":"+"${visit.shopName }");
						</script>
					</a>
				</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:when>
		<c:otherwise>
				방문 정보가 없습니다.
		</c:otherwise>
	</c:choose>
</body>
</html>