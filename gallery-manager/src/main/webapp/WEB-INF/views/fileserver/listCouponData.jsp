<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<thead>
	<tr>
		<th>NO</th>
		<th>쿠폰번호</th>
		<th>이름</th>
		<th>회원코드</th>
		<th>최근방문</th>
		<th>이메일</th>
		<th>휴대전화</th>
		<th>처리일자</th>
		<th>처리지점</th>
		<th>비고</th>
	</tr>
</thead>
<tfoot>
	<tr>
		<th>NO</th>
		<th>쿠폰번호</th>
		<th>이름</th>
		<th>회원코드</th>
		<th>최근방문</th>
		<th>이메일</th>
		<th>휴대전화</th>
		<th>처리일자</th>
		<th>처리지점</th>
		<th>비고</th>
	</tr>
</tfoot>
<tbody>
<c:choose>
	<c:when test="${!empty couponList }">
		<jsp:useBean id="now" class="java.util.Date" />
		<%-- <fmt:formatDate value="${now}" pattern="yy-MMdd" var="date" /> --%> 
		<c:set var="count" value="1"></c:set>
		<c:set var="flag" value="a">
		</c:set>
		<c:forEach items="${couponList }" var="coupon" varStatus="status">
		<c:choose>
			<c:when test="${flag eq 'a'}">
				<c:set value="grayClass" var="cssClass"></c:set>
				
				<c:set var="flag" value='b'></c:set>
			</c:when>
			<c:otherwise>
				<c:set value="whiteClass" var="cssClass">
				</c:set>
				<c:set var="flag" value="a">
				</c:set>
			</c:otherwise>
			</c:choose>
			
			<tr class="${cssClass }">
				<td>${status.count }</td>
				<td>${coupon.couponCd}</td>
				<td>${coupon.cstmrName }</td>
				<td>${coupon.cstmrCd }</td>
				<td>${coupon.lastShopName }</td>
				<td>${coupon.email }</td>
				<td>${coupon.cellphone }</td>
				<td>${coupon.usingDate }</td>
				<td>${coupon.shopName }</td>
				<td>${coupon.memo }</td>
			</tr>					
			<c:set value="${count +1 }" var="count"></c:set>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr class="${cssClass }">
			<td>${status.count }</td>
			<td>${coupon.couponCd}</td>
			<td>${coupon.cstmrName }</td>
			<td>${coupon.cstmrCd }</td>
			<td>쿠폰없음</td>
			<td>${coupon.email }</td>
			<td>${coupon.cellphone }</td>
			<td>${coupon.usingDate }</td>
			<td>${coupon.shopName }</td>
			<td>${coupon.memo }</td>
		</tr>
	</c:otherwise>
</c:choose>
</tbody>