<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">
</script>
<style type="text/css">
body {
	background-image: url('../${ctxPat}/images/shop4.jpg');
	background-size: 100% 100%;
}
.edit{
	display : none;
	height : 29px;
	font-size : 20px;
}
table {
	color: white;
	background-color: black;
	opacity: 0.7;
	font-weight : bold;
	border : 10px solid #696969;
	font-size : 25px;
}
#title{
	font-size : 50px;
	font-weight : bold;
}

td {
	padding: 5px;
	text-align : center;
}
#date{
	font-size : 20px;
	font-weight : bold;
}
</style>
</head>
<body>
	<Center>
	<Center><span id="title">시력측정 결과</span>
	<c:forEach var='eye' items="${eyeCheck }">
		<span id="date">(${eye.datetime })</span>
	</c:forEach>
	</Center>
	<br>
	<table width="80%">
		
	<c:choose>
		
		<c:when test="${!empty eyeCheck }">
			<tr>
				<td>Glasses</td><td>SPH</td><td>CYL</td><td>AXIS</td><td>PD</td><td>ADD</td><td>NPC</td><td>NPA</td><td>PRISM</td><td>BASE</td>
			</tr>
			<c:forEach var="eye" items="${eyeCheck }">
					<td>Right</td>
					<td>${eye.gsphRight }</td>
					<td>${eye.gcylRight }</td>
					<td>${eye.gaxisRight }</td>
					<td>${eye.pdRight }</td>
					<td>${eye.addRight }</td>
					<td>${eye.npcRight }</td>
					<td>${eye.npaRight }</td>
					<td>${eye.prismRight }</td>
					<td>${eye.baseRight }</td>
				</tr>
				<tr>
					<td>Left</td>
					<td>${eye.gsphLeft }</td>
					<td>${eye.gcylLeft }</td>
					<td>${eye.gaxisLeft }</td>
					<td>${eye.pdLeft }</td>
					<td>${eye.addLeft }</td>
					<td>${eye.npcLeft }</td>
					<td>${eye.npaLeft }</td>
					<td>${eye.prismLeft }</td>
					<td>${eye.baseLeft }</td>
				</tr>
				
				<tr>
					<td>C/L</td><td>SPH</td><td>CYL</td><td>AXIS</td><td>B.C</td><td>DIA</td>
				</tr>
				<tr>
					<td>Left</td>
					<td>${eye.lsphRight }</td>
					<td>${eye.lcylRight }</td>
					<td>${eye.laxisRight }</td>
					<td>${eye.bcRight }</td>
					<td>${eye.diaRight }</td>
				</tr>
				<tr>
					<td>Right</td>
					<td>${eye.lsphLeft }</td>
					<td>${eye.lcylLeft }</td>
					<td>${eye.laxisLeft }</td>
					<td>${eye.bcLeft }</td>
					<td>${eye.diaLeft }</td>
				</tr>
			</c:forEach>
		</c:when>
			<c:otherwise>
				<tr>
					<td colspan="10" align="center">시력 검사 자료가 없습니다.</td>
				</tr>
			</c:otherwise>
	</c:choose>
	</table>
	</Center>
</body>
</html>