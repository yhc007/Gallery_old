<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:choose>
	<c:when test="${!empty listLens }">
		<c:forEach var="lens" items="${listLens }">
			<li><a href="javascript:selectLens('${lens.prdctId }','${lens.prdctName }','${lens.curve }','${lens.puchasPrc }','${lens.option }')">${lens.prdctName } - ${lens.curve } 
				<c:if test="${lens.type1 eq 'plain'}">
					&nbsp;(평면)				
				</c:if>
				<c:if test="${lens.type1 eq 'spare'}">
					&nbsp;(여벌)				
				</c:if>
				<c:if test="${lens.type1 eq 'spare_rx'}">
					&nbsp;(여벌_RX)				
				</c:if>
				<c:if test="${lens.type1 eq 'spare_mt'}">
					&nbsp;(여벌_MT)				
				</c:if>
				<c:if test="${lens.type1 eq 'rx'}">
					&nbsp;(RX)				
				</c:if>
				<c:if test="${lens.type1 eq 'rx_mt'}">
					&nbsp;(RX_MT)				
				</c:if>
				<c:if test="${lens.type1 eq '변색'}">
					&nbsp;(변색)				
				</c:if>
				<c:if test="${lens.type1 eq '편광'}">
					&nbsp;(편광)				
				</c:if>
				<c:if test="${lens.type1 eq '일반 착색'}">
					&nbsp;(일반 착색)				
				</c:if>
				<c:if test="${lens.type1 eq '여벌강도착색(-)'}">
					&nbsp;(여벌강도착색(-))				
				</c:if>
				<c:if test="${lens.type1 eq '여벌강도일반착색'}">
					&nbsp;(여벌강도일반착색)				
				</c:if>
				<c:if test="${lens.type1 eq '상수도WT'}">
					&nbsp;(상수도WT)				
				</c:if>
				<c:if test="${lens.type1 eq '여벌강도난시'}">
					&nbsp;(여벌강도난시)				
				</c:if>
				<c:if test="${lens.type1 eq 'RX일반'}">
					&nbsp;(RX일반)				
				</c:if>
				<c:if test="${lens.type1 eq 'RX일반착색'}">
					&nbsp;(RX일반착색)				
				</c:if>
				 - ${lens.coating }
			</a></li>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<li>제품없음</li>
	</c:otherwise>
</c:choose>