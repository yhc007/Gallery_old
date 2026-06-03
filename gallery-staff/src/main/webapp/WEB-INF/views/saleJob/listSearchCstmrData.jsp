<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>

<script>
	

jQuery(document).ready(function(){
	/* 	alert("Visiting start"); */
	window.sessionStorage.setItem("popup",1);
});

function delVisitData(saleId,result,cnt){

	console.log("cnt:"+cnt);
	if(cnt > 0)
	{
		alert('<spring:message code="prdct.cannot.cancle"/>');
		return;
	}
	
	if(confirm("삭제하시겠습니까?")){
		var url = "${ctxPath}/saleJob/delVisitData.do"
		var param = "saleId=" + saleId;
		
		$.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				console.log("success data:"+data);
				location.reload();
			}
		});
	}else{
		return;
	}
}

function fncSelectCstmr(cstmrId,cstmrName){

	var form=document.createElement("form");
	  form.name='tempPost';
	  form.method='post';
	  form.action='${ctxPath}/sale/indexSaleForm.do';  
	  
	  var input=document.createElement("input");
	  input.type="hidden";
	  input.name='cstmrId';
	  input.value= cstmrId;
	  $(form).append(input);
	  
	  var input2=document.createElement("input");
	  input2.type="hidden";
	  input2.name='cstmrName';
	  input2.value= cstmrName;
	  $(form).append(input2);
	  
	  $('body').append(form); 
	  form.submit();
	  
};

function goRegistForm(){
	//location.replace("${ctxPath}/cstmr/mNewCstmrTabForm.do");
	var form=document.createElement("form");
	  form.name='tempPost';
	  form.method='post';
	  form.action='${ctxPath}/cstmr/mNewCstmrTabForm.do';  
	  
	  var input=document.createElement("input");
	  input.type="hidden";
	  input.name='cstmrName';
	  input.value= '${srchCstmr.cstmrName}';
	  $(form).append(input);
	  $('body').append(form); 
	  form.submit();
};


function getCstmrInfo(cstmrId){
	$("#cstmrPop" + cstmrId).css("display","inline");
	
	$( document ).mousemove(function( event ) {
		 $("#cstmrPop" + cstmrId).css("left", event.clientX + 20);
		 $("#cstmrPop" + cstmrId).css("top", event.clientY);
		});
}
function closeCstmrInfo(cstmrId){
	$("#cstmrPop" + cstmrId).css("display","none");
}
</script>
<style>
#cancel {
	position: absolute;
	width: 30px;
}

td>input[type="image"] {
	display: table-cell;
	vertical-align: middle;
}
.cstmrPop{
	display : none;
	background-color : white;
	border-radius : 20px;
	position: absolute;
	padding :10px;
}
</style>

<table class="listShop" width="100%" border="0.5">
	<tr>
      <td height="3" colspan="3"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
    </tr>
    <tr>
    	<td colspan="3" height="63px">검색고객</td>
    </tr>
	<tr>
		<td colspan="3"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" width="100%"
			height="1" /></td>
	</tr>
	<tr id="tr">
		<!-- <td onclick="findInFind('num')">고객코드번호</td> -->
		<!-- <td>고객코드번호</td> -->
		<td width="30%">이름</td>
		<!-- <td onclick="findInFind('addr')">주소</td> -->
		<!-- <td>주소</td> -->
		<!-- <td onclick="findInFind('tel')">전화번호</td> -->
		<td width="30%">4자리</td>
		<!-- <td onclick="findInFind('cel')">휴대폰</td> -->
		<!-- <td>휴대폰</td> -->
		<!-- <td onclick="findInFind('birth')">생년월일</td> -->
		<td width="40%">생년월일</td>
	</tr>
	<tr>
		<td colspan="3"><img
			src="<c:url value="/images/content/Whiteline.jpg" />" width="100%"
			height="1" /></td>
	</tr>
	<c:set var="flag" value="a">
	</c:set>
	<c:choose>
		<c:when test="${!empty listcstmr}">
			<c:forEach var="cstmr" items="${listcstmr}" varStatus="status">
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
			
				<tr onmouseover="getCstmrInfo('${cstmr.cstmrId}');return false;"
					 onclick="loadCstmrChart('${cstmr.cstmrId}');"
					onmouseout="closeCstmrInfo('${cstmr.cstmrId}')"
					class="listData ${cssClass }">
					<td width="10%">${cstmr.cstmrName }</td>
					<td >				    
						<c:set var="cell_len" value="${fn:length(cstmr.cellphone)}"/>
						<c:set var="cell_4" value="${fn:substring(cstmr.cellphone,cell_len-4, cell_len)}" />
						<c:set var="tel_len" value="${fn:length(cstmr.telephone)}"/>
						<c:set var="tel_4" value="${fn:substring(cstmr.telephone,tel_len-4, tel_len)}" />
				    	<c:out value='${cell_4}:${tel_4}'/>
				    </td>
<%-- 					<td onclick="fncSelectCstmr('${cstmr.cstmrId}','${cstmr.cstmrName }');return false;"
						width="30%">${cstmr.addr }</td>
					<td onclick="fncSelectCstmr('${cstmr.cstmrId}','${cstmr.cstmrName }');return false;"
						width="15%">${cstmr.telephone}</td>
					<td onclick="fncSelectCstmr('${cstmr.cstmrId}','${cstmr.cstmrName }');return false;"
						width="15%">${cstmr.cellphone }</td>
--%>				
					<div id='cstmrPop${cstmr.cstmrId}' class="cstmrPop">
						이름 : ${cstmr.cstmrName}<br>
						고객코드 : ${cstmr.cstmrCd}<br>
						휴대전화 : ${cstmr.clearCell}<br>
						최근방문 : ${cstmr.lastDate}<br>
						방문매장 : ${cstmr.lastShop}<br>
<%-- 						휴대전화 : ${cstmr.cellphone}<br> --%>
						</br>
<%-- 						전화번호 : ${cstmr.telephone}<br> --%>
						전화번호 : ${cstmr.clearTel}<br>
						주소 : ${cstmr.addr}<br>
						생년월일 : ${cstmr.birthDay}<br>
					</div>
					
					<td onclick="loadCstmrChart('${cstmr.cstmrId}');return false;">${cstmr.birthDay }</td>

					<script>
 						/* console.log('cstmrCd : '+'${cstmr.cstmrCd },'+'cell : '+'${cstmr.cellphone},'+'tel:'+'${cstmr.telephone}'); */
 						console.log('cstmrId : '+'${cstmr.cstmrId },'+'cstmrCd : '+'${cstmr.cstmrCd },'+'cell : '+'${cstmr.cellphone},'+'tel:'+'${cstmr.telephone}');
 						//console.log('${cstmr.cstmrName}'+'cell_4 : '+'${cell_4},'+'tel_4:'+'${tel_4}');
					</script>
					<%-- <td width="10%"><img
						src="<c:url value="/images/content/edit.png" />"
						onclick="fncEditCstmrInfo('${cstmr.cstmrId}','${cstmr.cstmrName }');"
						width="50px" height="50px">
					</button></td> --%>
				</tr>
				<tr>
					<td colspan="3"><img
						src="<c:url value="/images/content/Whiteline.jpg" />" width="100%"
						height="1" /></td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="3" align="center">고객이 없습니다.</td>
			</tr>
		</c:otherwise>
	</c:choose>
<%-- 	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>

		<td colspan="3">
			<center>
				<a href="#" onclick="goRegistForm();return false;"> <img
					src="<c:url value="/images/content/new.png" />" width="72"
					height="72"></img>
				</a>
			</center>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr> --%>
</table>
</center>

<script>
function popCstmrInfo(cstmrId)
{
// 	console.log("pop");
	$( "#cstmrPop"+cstmrId ).popup( "open" );
}

function unPopCstmrInfo(cstmrId){
// 	console.log("unPop");
	$( "#cstmrPop"+cstmrId ).popup( "close" );
}
</script>

<br>


