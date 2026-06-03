<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}"  pattern="MMdd" var="today" />
<c:choose>
	<c:when test="${!empty boardList}">
		<c:forEach var="board" items="${boardList }" varStatus="status">
			<script>
				var fnlCnt = ${status.count}; 
			</script>
			 <c:set var="regtime" value='${board.updTime}'/>
		    <c:set var="time" value="${fn:substring(regtime, 5, 10)}" />
		    <c:set var="nmonth" value="${fn:substring(regtime, 5, 7)}" />
		    <c:set var="nday" value="${fn:substring(regtime, 8, 10)}" />  
		    <c:set var="date2" value="${nmonth}${nday }"></c:set>
		    <c:if test="${nday>=30 }">
				<c:set value="74" var="period"> </c:set>		    
		    </c:if>
		    <c:if test="${nday<30 }">
				<c:set value="4" var="period"> </c:set>		    
		    </c:if>
			 <li ><a href="javascript:viewContent('${board.no}')">
				 <c:if test="${board.priority ==1}">
					<font class="noticeTitle">
						${board.title } [${board.reply }] - ${board.writer }
						<c:if test="${today <= (date2+period) && (today+4) >= (date2+4)}"><font style="color:red;">New</font></c:if>
						<span style="float: right;">${time}</span> <span class="ui-li-count">${board.cnt  }</span></a>
					</font>			 
				 </c:if>
				 
				 <c:if test="${board.priority ==0}">
					<font>
						<c:if test="${board.ty  eq 'S'}">
							<c:if test="${board.complete==1}">
								<img src="${pageContext.request.contextPath}/images/complete.png" style="width: 15px;">
							</c:if>
							<c:if test="${board.complete==0}">
								<img src="${pageContext.request.contextPath}/images/incomplete.png" style="width: 15px;">
							</c:if>
						</c:if>
						${board.title } [${board.reply}] - ${board.writer }
						<c:if test="${today <= (date2+period) && (today+4) >= (date2+4)}">
							<c:if test="${board.ty eq 'N'}">
								<font style="color:red;">New</font>
							</c:if>
						</c:if>
						<span style="float: right;">${time}</span> <span class="ui-li-count">${board.cnt }</span></a>
					</font>			 
				 </c:if>
			 </li>
		</c:forEach>
	</c:when>
</c:choose>