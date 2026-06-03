<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>

<script>
	

jQuery(document).ready(function(){
	/* 	alert("Visiting start"); */
	window.sessionStorage.setItem("popup",1);
});

function delVisitData(saleId,result,cnt){

	//console.log("cnt:"+cnt);
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
      <td height="3" colspan="3"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
    </tr>
    <tr class="tb" >
      	<td>조회일</td>
      	<td>이름</td>
		<td>4자리</td>
    </tr>
    <tr>
      <td height="3" colspan="3"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
    </tr>
    
       <c:set var="flag" value="a">
	 	</c:set>
    <c:choose>
		<c:when test="${!empty listCstmrHstry}">
	   		<c:forEach var="cstmr" items="${listCstmrHstry}" varStatus="status">
	   		
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
			
	   			<c:if test="${!empty cstmr.cstmrName }">
				<tr class="listData ${cssClass }" >
				    <td ><a onclick="loadCstmrChart('${cstmr.cstmrId}');">${cstmr.dateTime}</a></td>
				    <td ><a onclick="loadCstmrChart('${cstmr.cstmrId}');">${cstmr.cstmrName}</a></td>
				    <td onclick="loadCstmrChart('${cstmr.cstmrId}');">				    
						<c:set var="cell_len" value="${fn:length(cstmr.cellphone)}"/>
						<c:set var="cell_4" value="${fn:substring(cstmr.cellphone,cell_len-4, cell_len)}" />
						<c:set var="tel_len" value="${fn:length(cstmr.telephone)}"/>
						<c:set var="tel_4" value="${fn:substring(cstmr.telephone,tel_len-4, tel_len)}" />
				    	<%-- <c:out value='${cell_4}'>
							<c:out value='${tel_4}' default="정보없음." />
						</c:out> --%>
						<c:out value='${cell_4}:${tel_4}'/>
				    </td>
				</tr>
				<tr>
			      <td height="3" colspan="3"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
			    </tr>
			    </c:if>
			</c:forEach>
			
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="3" align="center">고객 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
	
    <tr>
      <td height="3" colspan="3"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
    </tr>
    
</table> 
<br>
