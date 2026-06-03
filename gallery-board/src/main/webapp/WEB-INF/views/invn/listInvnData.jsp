<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
	<c:when test="${!empty invnList}">
			<tr id="tr">
				<th width="30%" onclick="sort('brand');">브랜드명</th><th onclick="sort('prdct');">상품명</th><th width="10%" onclick="sort('cnt');">수량</th>
			</tr>
		<c:forEach var="Invn" items="${invnList}">7
			<tr onclick="getInvnInfo('${Invn.prdctId}','${Invn.shopId}')">
				<td>${Invn.brandName }</td><td>${Invn.invnHistId }${Invn.prdctName } (${ Invn.colorName} / ${Invn.colorName2})</td><td>${Invn.cnt }</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="3">상품이 없습니다.</td>
		</tr>
	</c:otherwise>
</c:choose>