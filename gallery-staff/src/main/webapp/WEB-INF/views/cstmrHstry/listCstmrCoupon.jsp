<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>

<script>
	

jQuery(document).ready(function(){
	
});

function getCouponPop(cstmrCd){
	//console.log('cstmrCd:'+cstmrCd);
	$("#couponPop" + cstmrCd).css("display","inline");
	
	$( document ).mousemove(function( event ) {
		 $("#couponPop" + cstmrCd).css("left", event.clientX-430);
		 $("#couponPop" + cstmrCd).css("top", event.clientY-200);
		});
}


function closeCouponPop(cstmrCd){
	$("#couponPop" + cstmrCd).css("display","none");
}



</script>
<style>
#cancel{
	position : absolute;
	width: 30px;
}

td>input[type="image"]{
	display:table-cell;
	vertical-align:middle;
}
.grayClass{
	background-color: #d3d3d3;
	color : black;
}

.whiteClass{
	background-color: #2E2E2E;
	color : white;
}

.cstmrPop{
	display : none;
	background-color : white;
	border-radius : 20px;
	position: absolute;
	padding :10px;
}

</style>
<table class="listShop" id='tbCouponCd'width="100%" border="0.5" >
    <%-- <tr>
      <td height="3" colspan="3"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
    </tr>
    <tr>
    	<td colspan="2">최근조회고객</td>
    	
	    <td>
	    	<div data-role="fieldcontain" onclick="setToggle();return false;">
				<select name="flip_hstry" id="flip_hstry" data-role="slider" data-theme="a">
					<option value="today">오늘</option>
					<option value="yesday">어제</option>
				</select> 
			</div>
		</td>
    </tr> --%>
    <tr>
      <td height="3" colspan="4"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
    </tr>
    <tr class='whiteClass'>
      	<td>고객명</td>
		<td>쿠폰코드</td>
		<td>사용여부</td>
    </tr>
    <tr>
    <td height="3" colspan="4"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
    </tr>
    
       <c:set var="flag" value="a">
	 	</c:set>
    <c:choose>
		<c:when test="${!empty listCoupon}">
	   		<c:forEach var="coupon" items="${listCoupon}" varStatus="status">
	   		
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
			
			<tr onmouseover="getCouponPop('${coupon.cstmrCd}');return false;"
			    onmouseout="closeCouponPop('${coupon.cstmrCd}');return false;" 
			    class="listData ${cssClass }" >
				    <td>${coupon.cstmrName}</td>
				    <c:choose>
					<c:when test="${!empty coupon.couponCd}">
						
					    	<c:choose>
							<c:when test="${ coupon.shopNum eq '0' }">
							<td>
				    			<input onclick='checkBirth("${coupon.couponCd}");' type='button' value='${coupon.couponCd}' />
						    </td>
						    <td>
								사용 가능
							</td>
							</c:when>
							<c:otherwise>
							<td>
				    			<input disabled='disabled' onclick='checkBirth("${coupon.couponCd}");' type='button' value='${coupon.couponCd}' />
						    </td>
						    <td>
								${ coupon.shopName } 사용됨
							</td>
							</c:otherwise>
							</c:choose>
					    </td>	
					</c:when>
					<c:otherwise>
						<td colspan='3'>
			    			쿠폰이 없습니다.
			    		</td>
					</c:otherwise>
					</c:choose>
				    

				<div id='couponPop${coupon.cstmrCd}' class="cstmrPop">
						고객코드 : ${coupon.cstmrCd}<br>
						휴대전화 : ${coupon.cellphone}<br>
						</br>
						전화번호 : ${coupon.telephone}<br>
						주소 : ${coupon.addr}<br>
						생년월일 : ${coupon.birthDay}<br>
						</br>
						쿠폰사용일 : ${coupon.usingDate}<br>
						메모 : ${coupon.couponMemo}<br>
				</div>
				</tr>
				
				<tr>
			    	<td height="3" colspan="4">
			    		<img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" />
			    	</td>
			    </tr>
			</c:forEach>
			
		</c:when>
		<c:otherwise>
			<tr class='grayClass'>
				<td colspan="4" align="center">데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
	
    <tr>
      <td height="3" colspan="4"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
    </tr>
    
</table> 
<br>
