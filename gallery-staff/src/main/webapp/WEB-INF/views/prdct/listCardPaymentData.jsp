<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@ include file="/WEB-INF/views/include/staffLib.jsp"%> --%>

<c:choose>
	<c:when test="${!empty cardPayList}">
		<c:forEach var="card" items="${cardPayList }">
			<tr>
				<td>카드</td>
				<td colspan='2' id='ccom${card.jobId}'>${card.cardCom }</td>
				<td>결제일</td>
				<td id ='cdate${card.jobId}'>${card.cardDate }</td>
				<td align="right" ><fmt:formatNumber value="${card.payCard }" pattern="#,###"/></td>
				<td>
					&nbsp;
					<%-- <input type='button' onclick="modifyCardDate('${card.jobId}');" value='날짜수정'> --%>
					<%-- <img src="<c:url value="http://jaguar.s4gallery.com/GalleryStaff/images/content/edit.png" />" onclick="modifyCardDate('${card.jobId}');"  width="35px" height="35px" > --%>
					<%-- <img src="${ctxPath}/GalleryStaff/images/content/edit.png" height='35px' width='35px' onclick="modifyCardDate('${card.jobId}');" > --%>
				</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
	<tr>
		<td>
			카드
		</td>
		<td colspan='6'>
			<center>
				결제 정보가 없습니다.
			</center>
		</td>
	</tr>
	</c:otherwise>
</c:choose>