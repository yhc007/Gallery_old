<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
	<c:when test="${!empty listLens || !empty listNewLens}">
		<thead>
			<tr>
				<th>선택</th>
				<th>거래처</th>
				<th>제품명</th>
				<th>품목</th>
				<th>수정</th>
				<th>구분</th> 
				<th onclick="getOrderList('SPH')" class="sort">SPH</th>
				<th onclick="getOrderList('CYL')" class="sort">CYL</th>
				<th>수량</th>
				<th>옵션</th>
				<th>단가</th>
				<th>금액</th>
				<th>주문 날짜</th>
				<th>상태</th>
				<th>수취확인</th>
				<th>구매취소</th>
			</tr>
		</thead>
	
	
		<c:forEach var="lens" items="${listLens }">
			<tbody>
				<tr>
					<td><input data-role="none"type="checkbox" name=delChk value="${lens.id }"> </td>
					<td >${lens.comName }</td>
					<td>${lens.prdctName } ${lens.curve }
					<c:if test="${lens.type1  eq 'plain'}">
						<td>여벌</td>
					</c:if>
					<c:if test="${lens.type1  eq 'spare'}">
						<td>여벌</td>
					</c:if>
					<c:if test="${lens.type1  eq 'spare_rx'}">
						<td>여벌</td>
					</c:if>
					<c:if test="${lens.type1  eq '일반 착색'}">
						<td>여벌</td>
					</c:if>
					<c:if test="${lens.type1  eq '여벌강도착색(-)'}">
						<td>여벌</td>
					</c:if>
					<c:if test="${lens.type1  eq '여벌강도일반착색'}">
						<td>여벌</td>
					</c:if>
					<c:if test="${lens.type1  eq '상도수WT'}">
						<td>여벌</td>
					</c:if>
					<c:if test="${lens.type1  eq '여벌강도난시'}">
						<td>여벌</td>
					</c:if>
					<c:if test="${lens.type1  eq 'spare_mt'}">
						<td>여벌</td>
					</c:if>
					<c:if test="${lens.type1  eq 'rx'}">
						<td>
							RX
							<c:if test="${lens.isr eq '1' }">
								(오)
							</c:if>
							<c:if test="${lens.isl eq '1' }">
								(왼)
							</c:if>
						</td>
					</c:if>
					<c:if test="${lens.type1  eq 'rx_mt'}">
						<td>
							RX
							<c:if test="${lens.isr eq '1' }">
								(오)
							</c:if>
							<c:if test="${lens.isl eq '1' }">
								(왼)
							</c:if>
						</td>
					</c:if>
					<c:if test="${lens.type1  eq '변색'}">
						<td>
							RX
							<c:if test="${lens.isr eq '1' }">
								(오)
							</c:if>
							<c:if test="${lens.isl eq '1' }">
								(왼)
							</c:if>
						</td>
					</c:if>
					<c:if test="${lens.type1  eq '편광'}">
						<td>
							RX
							<c:if test="${lens.isr eq '1' }">
								(오)
							</c:if>
							<c:if test="${lens.isl eq '1' }">
								(왼)
							</c:if>	
						</td>
					</c:if>
					<c:if test="${prdct.ty1  eq 'RX일반'}">
						<td>
							RX
							<c:if test="${lens.isr eq '1' }">
								(오)
							</c:if>
							<c:if test="${lens.isl eq '1' }">
								(왼)
							</c:if>
						</td>
					</c:if>
					<c:if test="${prdct.ty1  eq 'RX일반착색'}">
						<td>
							RX
							<c:if test="${lens.isr eq '1' }">
								(오)
							</c:if>
							<c:if test="${lens.isl eq '1' }">
								(왼)
							</c:if>
						</td>
					</c:if>
					
					
					<c:if test="${lens.type1  eq 'plain' or lens.type1  eq 'spare' or lens.type1  eq 'spare_rx' 
									or lens.type1 eq '일반 착색' or lens.type1 eq '여벌강도착색(-)'  or lens.type1 eq '여벌강도일반착색' or lens.type1 eq '상도수WT' or lens.type1 eq '여벌강도난시' }">
						<td><button class="orderBtn" data-mini="true" data-inline="true" onclick="modifySpecDiv('${lens.SPH}','${lens.CYL}','${lens.id }');">수정</button> </td>
					</c:if>

					<c:if test="${lens.type1  eq 'rx' or lens.type1  eq 'rx_mt' or lens.type1  eq '변색' or lens.type1  eq '편광'  or lens.type1  eq 'spare_mt' or lens.type1 eq 'RX일반' or lens.type1 eq 'RX일반착색'}">
						<td><button class="orderBtn"data-mini="true" data-inline="true" onclick="mofidyRXSingle('${lens.id}')">수정</button></td>
					</c:if>
					
					<td>${lens.type2 }</td>
					<td>${lens.SPH }</td>
					<td>${lens.CYL }</td>
					<td>${lens.cnt }</td>
					<td>
						<c:if test="${lens.optionId ==-1}">
							없음
							<br>
							<button data-mini="true" data-inline="true" onclick="modifyPrdctOption('${lens.id }','${lens.option}','${lens.puchasPrc }','${lens.optionId }','${lens.pair }')">추가</button>
						</c:if>
						<c:if test="${lens.optionId ==1}">
							하드
							<br>
							<button data-mini="true" data-inline="true" onclick="modifyPrdctOption('${lens.id }','${lens.option}','${lens.puchasPrc }','${lens.optionId }','${lens.pair }')">수정</button>
						</c:if>
						<c:if test="${lens.optionId ==2}">
							내면
							<br>
							<button data-mini="true" data-inline="true" onclick="modifyPrdctOption('${lens.id }','${lens.option}','${lens.puchasPrc }','${lens.optionId }','${lens.pair }')">수정</button>
						</c:if>
						<c:if test="${lens.optionId ==3}">
							HD 멀티
							<br>
							<button data-mini="true" data-inline="true" onclick="modifyPrdctOption('${lens.id }','${lens.option}','${lens.puchasPrc }','${lens.optionId }','${lens.pair }')">수정</button>
						</c:if>
						<c:if test="${lens.optionId ==4}">
							UV
							<br>
							<button data-mini="true" data-inline="true" onclick="modifyPrdctOption('${lens.id }','${lens.option}','${lens.puchasPrc }','${lens.optionId }','${lens.pair }')">수정</button>
						</c:if>
						<c:if test="${lens.optionId ==5}">
							초발수
							<br>
							<button data-mini="true" data-inline="true" onclick="modifyPrdctOption('${lens.id }','${lens.option}','${lens.puchasPrc }','${lens.optionId }','${lens.pair }')">수정</button>
						</c:if>
						<c:if test="${lens.optionId ==6}">
							반밀러
							<br>
							<button data-mini="true" data-inline="true" onclick="modifyPrdctOption('${lens.id }','${lens.option}','${lens.puchasPrc }','${lens.optionId }','${lens.pair }')">수정</button>
						</c:if>
						<c:if test="${lens.optionId ==7}">
							완전밀러
							<br>
							<button data-mini="true" data-inline="true" onclick="modifyPrdctOption('${lens.id }','${lens.option}','${lens.puchasPrc }','${lens.optionId }','${lens.pair }')">수정</button>
						</c:if>
						<c:if test="${lens.optionId ==8}">
							이중착색
							<br>
							<button data-mini="true" data-inline="true" onclick="modifyPrdctOption('${lens.id }','${lens.option}','${lens.puchasPrc }','${lens.optionId }','${lens.pair }')">수정</button> 
						</c:if>
						
					</td>
					<td style="text-align: right;"><fmt:formatNumber value="${lens.puchasPrc+lens.optionPrc}" pattern="#,###"/></td>
					<td style="text-align: right;"><fmt:formatNumber value="${(lens.puchasPrc+lens.optionPrc) * lens.cnt}" pattern="#,###"/></td>
					<c:set var="regtime" value='${lens.updTime}'/>
			       <c:set var="time" value="${fn:substring(regtime, 0, 16)}" />
			       <td align="center" class="td">${time}</td>
			       
				<c:if test="${lens.state ==0 && lens.comOrder==0}">
					<td class="before"  class="td">배송전</td>
				</c:if>
				<c:if test="${lens.state ==1 && lens.comOrder==0}">
					<td class="after" class="td">배송중</td>
				</c:if>
				<c:if test="${lens.state ==2 && lens.comOrder==0}">
					<td class="complete" class="td">배송완료</td>
				</c:if>
				<c:if test="${lens.comOrder==1 }">
					<Td><button onclick="allowComOrder('${lens.id }', '${lens.prdctId }','${lens.cnt }','${lens.com }', '${lens.prdctTy }')">승인</button></Td>
				</c:if>
				
				<c:if test="${lens.state ==0 || lens.state ==2}">
					<td></td>
				</c:if>
				<c:if test="${lens.state ==1}">
					<td class="td"><button onclick="receivePrdct('${lens.id}','${lens.prdctId}','${lens.cnt}','${lens.com}','${lens.puchasPrc}')" data-mini="true" data-inline="true">수령</button> </td>
				</c:if>
				<c:if test="${lens.state ==0}">
					<td class="td">
						<button onclick="cancelOrder('${lens.id}')" data-mini="true" data-inline="true" class="orderBtn">취소</button>
					</td>
				</c:if>
				<c:if test="${lens.state ==1}">
					<td class="td">
					</td>
				</c:if>
				<c:if test="${lens.state ==2 && lens.returnCd==0}">
					<td class="td">
						<c:if test="${lens.cnt - lens.totalRtnCnt !=0}">
							<button class="orderBtn" onclick="returnOrder('${lens.id}','${lens.cnt - lens.totalRtnCnt}')" data-mini="true" data-inline="true">반품</button><br>
						</c:if>
						<c:if test="${lens.totalRtnCnt !=0 }">
							(재고 ${lens.cnt - lens.totalRtnCnt })
						</c:if>
					</td>
				</c:if>
				<c:if test="${lens.state ==2 && lens.returnCd==1}">
						<td class="before"  class="td">확인중</td>
						<c:if test="${lens.totalRtnCnt !=0 }">
							(재고 ${lens.cnt - lens.totalRtnCnt })
						</c:if>
				</c:if>
				<c:if test="${lens.state ==2 && lens.returnCd==2}">
						<td class="after"  class="td">
						<c:if test="${lens.cnt - lens.totalRtnCnt !=0}">
							<button class="orderBtn" onclick="returnOrder('${lens.id}','${lens.cnt - lens.totalRtnCnt}')" data-mini="true" data-inline="true">반품</button><br>
						</c:if>
							<c:if test="${lens.totalRtnCnt !=0 }">
								(재고 ${lens.cnt - lens.totalRtnCnt })
							</c:if>
						</td>
				</c:if>
				</tr>
			</tbody>
		</c:forEach>
		
		
		<c:forEach var="lens" items="${listNewLens }">
			<tbody>
				<tr>
					<td><input data-role="none"type="checkbox" name=delChk value="${lens.id }"> </td>
					<td>${lens.comName }</td>
					<td>${lens.prdctName }</td>
					<Td></td>
					<td>미등록 렌즈</td>
					<td>${lens.SPH }</td>
					<td></td>
					<td>${lens.CYL }</td>
					<td>${lens.option }</td>
					<td style="text-align: right;"><fmt:formatNumber value="${lens.puchasPrc }" pattern="#,###"/></td>
					<td>${lens.cnt }</td>
					<td style="text-align: right;"><fmt:formatNumber value="${lens.puchasPrc * lens.cnt}" pattern="#,###"/></td>
					<td>${lens.updTime }</td>
						<c:if test="${lens.state ==0}">
					<td class="before"  class="td">배송전</td>
				</c:if>
				<c:if test="${lens.state ==1}">
					<td class="after"  class="td">배송중</td>
				</c:if>
				<c:if test="${lens.state ==2}">
					<td class="complete"  class="td">배송완료</td>
				</c:if>
				<c:if test="${lens.state ==0 || lens.state ==2}">
					<td></td>
				</c:if>
				<c:if test="${lens.state ==1}">
					<td class="td"><button onclick="receivePrdct('${lens.id}','${lens.prdctId}','${lens.cnt}','${lens.com}','${lens.puchasPrc}')">수령</button> </td>
				</c:if>
				<c:if test="${lens.state ==0}">
					<td class="td">
						<button onclick="cancelOrder('${lens.id}')">취소</button>
					</td>
				</c:if>
				<c:if test="${lens.state ==1}">
					<td class="td">
					</td>
				</c:if>
				<c:if test="${lens.state ==2 && lens.returnCd==0}">
					<td class="td">
						<c:if test="${lens.cnt - lens.totalRtnCnt !=0}">
							<button onclick="returnOrder('${lens.id}','${lens.cnt - lens.totalRtnCnt}')">반품</button><br>
						</c:if>
						<c:if test="${lens.totalRtnCnt !=0 }">
							(재고 ${lens.cnt - lens.totalRtnCnt })
						</c:if>
					</td>
				</c:if>
				<c:if test="${lens.state ==2 && lens.returnCd==1}">
						<td class="before"  class="td">확인중</td>
						<c:if test="${lens.totalRtnCnt !=0 }">
							(재고 ${lens.cnt - lens.totalRtnCnt })
						</c:if>
				</c:if>
				<c:if test="${lens.state ==2 && lens.returnCd==2}">
						<td class="after"  class="td">
						<c:if test="${lens.cnt - lens.totalRtnCnt !=0}">
							<button onclick="returnOrder('${lens.id}','${lens.cnt - lens.totalRtnCnt}')">반품</button><br>
						</c:if>
							<c:if test="${lens.totalRtnCnt !=0 }">
								(재고 ${lens.cnt - lens.totalRtnCnt })
							</c:if>
						</td>
				</c:if>
				</tr>
			</tbody>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="13">구매내역이 없습니다.</td>
		</tr>
	</c:otherwise>
</c:choose>

