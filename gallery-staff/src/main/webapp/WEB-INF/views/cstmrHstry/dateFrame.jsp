<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	<c:choose>
		<c:when test="${!empty listVisit }">
			<c:set var="css" value="blackTr"></c:set>
			<c:forEach var="visit" items="${listVisit }" varStatus="status">
					<c:set var="regtime" value='${visit.datetime}'/>
				    <c:set var="time" value="${fn:substring(regtime, 2,100)}" />
				    
					<c:if test="${visit.result eq '11111' }">
						<c:set var="css" value="blackTr"></c:set>
					</c:if>
					<c:if test="${visit.result ne '11111' }">
						<c:set var="css" value="redTr"></c:set>
					</c:if>
			<c:choose>
				<c:when test="${status.first}">
					<%-- <a href="javascript:getCheckInfo('${visit.saleId}');return false;"> --%>
					<input type='button' onclick='newCstmrVisit(); return;' value='새로운처방'/>
<!-- 					<a href="#"> -->
						<%-- <div class='dateSpan ${css }' id="${visit.saleId}"  onclick="changeClr(${visit.saleId});" onmouseover="visitDateMouseOver(${visit.saleId})" onmouseout="visitDateMouseOut(${visit.saleId})">${time}&nbsp;${visit.shopName }</div> --%>
						<div class='dateSpan ${css }' id="${visit.saleId}"  onclick="changeClr(${visit.saleId});" onmouseover="visitDateMouseOver(${visit.saleId})" onmouseout="visitDateMouseOut(${visit.saleId})">${time}</br>${visit.shopName }</div>
<!-- 					</a> -->
					<script>
						changeClr('${visit.saleId}');
					</script>
					</option>
				</c:when>
				<c:otherwise>
					<%-- <a href="javascript:getCheckInfo('${visit.saleId}'); return false;"> --%>
<!-- 					<a href="#"> -->
						<%-- <div class='dateSpan  ${css }' id="${visit.saleId}"  onclick="changeClr(${visit.saleId});" onmouseover="visitDateMouseOver(${visit.saleId})" onmouseout="visitDateMouseOut(${visit.saleId})">${time}&nbsp;${visit.shopName }</div> --%>
						<div class='dateSpan  ${css }' id="${visit.saleId}"  onclick="changeClr(${visit.saleId});" onmouseover="visitDateMouseOver(${visit.saleId})" onmouseout="visitDateMouseOut(${visit.saleId})">${time}</br>${visit.shopName }</div>
						<script>
// 							console.log("${visit.saleId}"+":"+"${visit.datetime }"+":"+"${visit.shopName }");
						</script>
<!-- 					</a> -->
				</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:when>
		<c:otherwise>
			방문 정보 없음
			<script>
			if(confirm("방문정보가 없습니다. 새로 생성 하시겠습니까?") == true){
				newCstmrVisit();
			}
			</script>
		</c:otherwise>
	</c:choose>
