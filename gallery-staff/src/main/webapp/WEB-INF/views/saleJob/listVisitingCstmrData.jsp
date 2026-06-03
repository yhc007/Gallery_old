<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
</style>

<table class="listShop" width="100%" border="0.5" >
    <tr>
      <td height="3" colspan="4"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
    </tr>
    <tr>
    	<td colspan="4" height="63px">구매고객</td>
    </tr>
    <tr>
      <td height="3" colspan="4"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
    </tr>
    <tr class="tb" >
      <td>구매일</td>
      <td>이름</td>
      <td>담당</td>
      <!-- <td style="text-align:left">삭제</td> -->
    </tr>
    <tr>
      <td height="3" colspan="4"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
    </tr>
   
    <c:set var="flag" value="a">
	 </c:set>
			
    <c:choose>
		<c:when test="${!empty listCstmr}">
		
			
	   		<c:forEach var="cstmr" items="${listCstmr}" varStatus="status">
	   		
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
			
				<tr class="listData ${cssClass }">
				    <td ><a onclick="loadCstmrChart('${cstmr.cstmrId}');">${cstmr.startTime}</a></td>
				    <td ><a onclick="loadCstmrChart('${cstmr.cstmrId}');">${cstmr.cstmrName}</a></td>
				    <td ><a onclick="loadCstmrChart('${cstmr.cstmrId}');">${cstmr.staffName}</a></td>
				    <%-- <td style="text-align:center">
						<input type="image"  onclick="delVisitData('${cstmr.saleId}','${cstmr.result}','${cstmr.dlvryCnt}'); return false;" src="<c:url value="/images/button/Select_c.png" /> "width="30px" height="30px">
					</td> --%>
				</tr>
				<tr>
			      <td height="3" colspan="4"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
			    </tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="4" align="center">고객 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
	
    <tr>
      <td height="3" colspan="4"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
    </tr>
    
</table>
   
<br>


