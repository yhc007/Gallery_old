<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>

<script>
	

jQuery(document).ready(function(){
	
});

function getCstmrPop(cstmrCd){
	//console.log('cstmrCd:'+cstmrCd);
	$("#cstmrPop" + cstmrCd).css("display","inline");
	
	$( document ).mousemove(function( event ) {
		 $("#cstmrPop" + cstmrCd).css("left", event.clientX-430);
		 $("#cstmrPop" + cstmrCd).css("top", event.clientY-200);
		});
}

function getFmlyPop(fmlyCd){
	//console.log('fmlyCd:'+fmlyCd);
	$("#fmlyPop" + fmlyCd).css("display","inline");
	
	$( document ).mousemove(function( event ) {
		 $("#fmlyPop" + fmlyCd).css("left", event.clientX-430);
		 $("#fmlyPop" + fmlyCd).css("top", event.clientY-200);
		});
}
function closeCstmrPop(cstmrCd){
	$("#cstmrPop" + cstmrCd).css("display","none");
}
function closeFmlyPop(fmlyCd){
	$("#fmlyPop" + fmlyCd).css("display","none");
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
<table class="listShop" id='tbFmlyCd'width="100%" border="0.5" >
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
		<td>고객코드입력</td>
		<td>가족명</td>
		<td>가족코드입력</td>
    </tr>
    <tr>
    <td height="3" colspan="4"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
    </tr>
    
       <c:set var="flag" value="a">
	 	</c:set>
    <c:choose>
		<c:when test="${!empty listCstmr4Fmly}">
	   		<c:forEach var="cstmr" items="${listCstmr4Fmly}" varStatus="status">
	   		
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
			

				<tr class="listData ${cssClass }" >
				    <td onmouseover="getCstmrPop('${cstmr.cstmrCd}');return false;"
				    	onmouseout="closeCstmrPop('${cstmr.cstmrCd}');return false;" >${cstmr.cstmrName}</td>
				    <td onmouseover="getCstmrPop('${cstmr.cstmrCd}');return false;"
				    	onmouseout="closeCstmrPop('${cstmr.cstmrCd}');return false;" >
				    	<input onclick='fncSetFmlyCd("${cstmr.cstmrCd}");' type='button' value='${cstmr.cstmrCd}' /> </td>

				<div id='cstmrPop${cstmr.cstmrCd}' class="cstmrPop">
						고객이름 : ${cstmr.cstmrName}<br>
						고객코드 : ${cstmr.cstmrCd}<br>
						휴대전화 : ${cstmr.cellphone}<br>
						</br>
						전화번호 : ${cstmr.telephone}<br>
						주소 : ${cstmr.addr}<br>
						생년월일 : ${cstmr.birthDay}<br>
				</div>

				    <c:choose>
					<c:when test="${!empty cstmr.fmlyName}">
				    <td onmouseover="getFmlyPop('${cstmr.fmlyCd}');return false;"
				    	onmouseout="closeFmlyPop('${cstmr.fmlyCd}');return false;">${cstmr.fmlyName}</td>
				    <td onmouseover="getFmlyPop('${cstmr.fmlyCd}');return false;"
				    	onmouseout="closeFmlyPop('${cstmr.fmlyCd}');return false;">
				    <input onclick='fncSetFmlyCd("${cstmr.fmlyCd}");' type='button' value='${cstmr.fmlyCd}'/> </td>
					<div id='fmlyPop${cstmr.fmlyCd}' class="cstmrPop">
						가족이름 : ${cstmr.fmlyName}<br>
						고객코드 : ${cstmr.fmlyCd}<br>
						휴대전화 : ${cstmr.fmlyCell}<br>
						</br>
						전화번호 : ${cstmr.fmlyTel}<br>
						주소 : ${cstmr.fmlyAddr}<br>
						생년월일 : ${cstmr.fmlyBirth}<br>
					</div>
					
				    </c:when>
				    <c:otherwise>
				    	<td colspan='2'>가족 코드가 없습니다.</td>
				    </c:otherwise>
				    </c:choose>				    
				</tr>
				<tr>
			      <td height="3" colspan="4"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
			    </tr>
			</c:forEach>
			
		</c:when>
		<c:otherwise>
			<tr class='grayClass'>
				<td colspan="4" align="center">고객 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
	
    <tr>
      <td height="3" colspan="4"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
    </tr>
    
</table> 
<br>
