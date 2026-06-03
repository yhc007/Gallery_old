<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<thead>
<tr>
	<th width="6%">선택</th>
	<th onclick="getOrderList('brandName')" class="title" width="15%">브랜드</th>
	<th onclick="getOrderList('prdctName')" class="title">제품</th>
	<th class="title">비고</th>
	<th onclick="getOrderList('cnt')" class="title" width="5%">수량</th>
	<th onclick="getOrderList('updTime')" class="title" width="18%">주문 날짜</th>
	<th onclick="getOrderList('cName')" class="title" width="10%">거래처</th>
	<th onclick="getOrderList('state')" class="title" width="10%">상태</th>
	<th onclick="getOrderList('receive')" class="title" width="7%">수취확인</th>
	<th class="title" width="8%">구매취소</th>
</tr>
</thead>
<tbody>
<c:choose>
	<c:when test="${!empty listPrdct || !empty listNewLens}">
		<c:set var="flag" value="a">
		</c:set>
		
		<c:forEach var="prdct" items="${listPrdct }">
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
			
			<c:choose>
				<c:when test="${prdct.comOrder==1 }">
					<tr class="redTr">	
				</c:when>
				<c:otherwise>
					<tr class="${cssClass }">	
				</c:otherwise>
			</c:choose>
			
				<td><input type="checkbox" name="delChk" value="${prdct.id }" data-role="none"></td>
				<td onclick="getEditForm('${prdct.prdctId}')" class="td">${prdct.comName }</td>
				<td onclick="getEditForm('${prdct.prdctId}')"class="td">${prdct.prdctName }&nbsp;&nbsp;
					<c:if test="${prdct.colorName1!=null || prdct.colorName2 }">
						(${prdct.colorName1 } / ${prdct.colorName2 })</td>
					</c:if>
					<c:if test="${prdct.spec ne '-1' && prdct.spec != '' && prdct.spec ne null && prdct.spec ne '0'}">
						(${prdct.spec })
					</c:if>
					<c:if test="${prdct.curve ne '-1' && prdct.curve != '' && prdct.curve ne null}">
						&nbsp;${prdct.curve }
					</c:if>
				</td>
				
				<td>
					<button data-role="none" style="font-size: 12px" onclick="showDetail('${prdct.id}')">비고</button>
				</td>
				<td onclick="getEditForm('${prdct.prdctId}')" class="td">${prdct.cnt } 
				
				</td>
				<c:set var="regtime" value='${prdct.updTime}'/>
				    <c:set var="time" value="${fn:substring(regtime, 0, 16)}" />
				    <td align="center" class="td">${time}</td>
				<td onclick="getEditForm('${prdct.prdctId}')" class="td">${prdct.comName }</td>
				<c:if test="${prdct.state ==0}">
					<c:choose>
						<c:when test="${prdct.comOrder==1}">
							<td><button onclick="allowComOrder('${prdct.id}','${prdct.prdctId}','${prdct.cnt}','${prdct.com}','${prdct.prdctTy}');">승인</button></td>
						</c:when>
						<c:otherwise>
							<td class="before" onclick="getEditForm('${prdct.prdctId}')" class="td">배송전</td>	
						</c:otherwise>
					</c:choose>
					
				</c:if>
				<c:if test="${prdct.state ==1}">
					<td class="after" onclick="getEditForm('${prdct.prdctId}')" class="td">배송중</td>
				</c:if>
				<c:if test="${prdct.state ==2}">
					<td class="complete" onclick="getEditForm('${prdct.prdctId}')" class="td">배송완료</td>
				</c:if>
				<c:if test="${prdct.state ==0 || prdct.state ==2}">
					<td></td>
				</c:if>
				<c:if test="${prdct.state ==1}">
					<td class="td"><button onclick="receivePrdct('${prdct.id}','${prdct.prdctId}','${prdct.cnt}','${prdct.com}','${prdct.prdctTy}')">수령</button> </td>
				</c:if>
				<c:if test="${prdct.state ==0}">
					<td class="td">
						<button onclick="cancelOrder('${prdct.id}')">취소</button>
					</td>
				</c:if>
				<c:if test="${prdct.state ==1}">
					<td class="td">
					</td>
				</c:if>
				<c:if test="${prdct.state ==2 && prdct.returnCd==0}">
					<td class="td">
						<c:if test="${prdct.cnt - prdct.totalRtnCnt !=0}">
							<button onclick="returnOrder('${prdct.id}','${prdct.cnt - prdct.totalRtnCnt}')">반품</button><br>
						</c:if>
						<c:if test="${prdct.totalRtnCnt !=0 }">
							(재고 ${prdct.cnt - prdct.totalRtnCnt })
						</c:if>
					</td>
				</c:if>
				<c:if test="${prdct.state ==2 && prdct.returnCd==1}">
						<td class="before"  class="td">확인중</td>
						<c:if test="${prdct.totalRtnCnt !=0 }">
							(재고 ${prdct.cnt - prdct.totalRtnCnt })
						</c:if>
				</c:if>
				<c:if test="${prdct.state ==2 && prdct.returnCd==2}">
						<td class="after"  class="td">
						<c:if test="${prdct.cnt - prdct.totalRtnCnt !=0}">
							<button onclick="returnOrder('${prdct.id}','${prdct.cnt - prdct.totalRtnCnt}')">반품</button><br>
						</c:if>
							<c:if test="${prdct.totalRtnCnt !=0 }">
								(재고 ${prdct.cnt - prdct.totalRtnCnt })
							</c:if>
						</td>
				</c:if>
			</tr>
		</c:forEach>
		
		<c:forEach var="prdct" items="${listNewLens }">
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
				<td><input type="checkbox" name="delChk" value="${prdct.id }" data-role="none"></td>
				<td onclick="getEditForm('${prdct.prdctId}')" class="td">${prdct.comName }</td>
				<td onclick="getEditForm('${prdct.prdctId}')"class="td">${prdct.prdctName }&nbsp;&nbsp;
				</td>
				<td>
					<button data-role="none" style="font-size: 12px" onclick="showDetail('${prdct.id}')">비고</button>
				</td>
				<td onclick="getEditForm('${prdct.prdctId}')" class="td">${prdct.cnt }</td>
				<c:set var="regtime" value='${prdct.updTime}'/>
				    <c:set var="time" value="${fn:substring(regtime, 0, 16)}" />
				    <td align="center" class="td">${time}</td>
				<td onclick="getEditForm('${prdct.prdctId}')" class="td">${prdct.comName }</td>
				<c:if test="${prdct.state ==0}">
					<td class="before" onclick="getEditForm('${prdct.prdctId}')" class="td">배송전</td>
				</c:if>
				<c:if test="${prdct.state ==1}">
					<td class="after" onclick="getEditForm('${prdct.prdctId}')" class="td">배송중</td>
				</c:if>
				<c:if test="${prdct.state ==2}">
					<td class="complete" onclick="getEditForm('${prdct.prdctId}')" class="td">배송완료</td>
				</c:if>
				<c:if test="${prdct.state ==0 || prdct.state ==2}">
					<td></td>
				</c:if>
				<c:if test="${prdct.state ==1}">
					<td class="td"><button onclick="receivePrdct('${prdct.id}','${prdct.prdctId}','${prdct.cnt}','${prdct.com}','${prdct.prdctTy}')">수령</button> </td>
				</c:if>
				<c:if test="${prdct.state ==0}">
					<td class="td">
						<button onclick="cancelOrder('${prdct.id}')">취소</button>
					</td>
				</c:if>
				<c:if test="${prdct.state ==1}">
					<td class="td">
					</td>
				</c:if>
				<c:if test="${prdct.state ==2 && prdct.returnCd==0}">
					<td class="td">
						<button onclick="returnOrder('${prdct.id}','${prdct.cnt }')">반품</button>
					</td>
				</c:if>
				<c:if test="${prdct.state ==2 && prdct.returnCd==1}">
						<td class="before"  class="td">확인중</td>
				</c:if>
				<c:if test="${prdct.state ==2 && prdct.returnCd==2}">
						<td class="after"  class="td">반품완료</td>
				</c:if>
			</tr>
		</c:forEach>
	</c:when>
	
	
	<c:otherwise>
		<tr>
			<td colspan="10" class="td">주문 내역이 없습니다.</td>
		</tr>
	</c:otherwise>
</c:choose>
</tbody>