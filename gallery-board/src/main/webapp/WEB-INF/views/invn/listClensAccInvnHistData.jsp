<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		<table id="invnHistTable" width="100%">
			<tr >
				<th width="20%" >브랜드명</th>
				<th width="20%">상품명</th>
				<th width="10%">구분 </th>
				<th width="10%" >수량</th>
				<th width="10%" >거래날짜</th>
				<th width="20%" >거래처</th>
				<th width="10%">삭제</th>
			</tr>
			<c:forEach var="invn" items="${invnHist}">
			<tr >
				<td style="text-align: center;">${invn.brandName }</td>
				<td style="text-align: center;" onclick='editInvn(${invn.invnHistId});'>${invn.prdctName } <%-- (${invn.colorName } / ${invn.colorName2 }) --%></td>
				<c:if test="${invn.invnTyCd==00900001}">
					<td style="text-align: center;">입고</td>
				</c:if>
				<c:if test="${invn.invnTyCd==00900002}">
					<td style="text-align: center;">출고</td>
				</c:if>
				<c:if test="${invn.invnTyCd==00900003}">
					<td style="text-align: center;">반품</td>
				</c:if>
				<td style="text-align: center;">${invn.cnt }</td>
				<td style="text-align: center">${invn.datetime }</td>
				<td style="text-align: center">${invn.comName }</td>
				<td align="center"><button onclick="delHistData(${invn.invnHistId })" id="${invn.invnHistId }">삭제</button></td>
			</tr>	
			</c:forEach>
		</table>
