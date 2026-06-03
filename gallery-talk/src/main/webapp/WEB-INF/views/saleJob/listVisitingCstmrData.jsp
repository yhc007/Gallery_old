<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<script>
	window.sessionStorage.setItem("popup",1);

jQuery(document).ready(function(){
	/* 	alert("Visiting start"); */		
	
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
	  
	  $('#body').append(form); 
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

<table class="listCstmr" width="100%" border="0.5" >
    <tr>
      <td height="3" colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
    </tr>
    <tr class="tb" >
      <td height="66" colspan="2" >방문일</td>
      <td height="66" >이름</td>
      <td height="66" >상태</td>
      <td height="66" >담당스탭</td>
      <td height="66"  style="text-align:left">삭제</td>
    </tr>
    <tr>
      <td height="3" colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
    </tr>
    
    <c:choose>
		<c:when test="${!empty listCstmr}">
	   		<c:forEach var="cstmr" items="${listCstmr}" varStatus="status">
				<tr class="listData" >
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->		
				    <td height="66" onclick="fncSelectCstmr('${cstmr.cstmrId}','${cstmr.cstmrName }');return false;"colspan="2">${cstmr.startTime}</td>
				    <td height="66" onclick="fncSelectCstmr('${cstmr.cstmrId}','${cstmr.cstmrName }');return false;">${cstmr.cstmrName}</td>
				    <td height="66" onclick="fncSelectCstmr('${cstmr.cstmrId}','${cstmr.cstmrName }');return false;">${cstmr.tyCd}</td>
				    <td height="66" >${cstmr.staffName}</td>
				    <%-- <td><input type=image src="${ctxPath }/images/button/Select_c.png" id='cancel' onclick="delVisitData('${cstmr.saleId}','${cstmr.result}','${cstmr.dlvryCnt}');"></td> --%>
				    <td style="text-align:center">
						<input type="image"  onclick="delVisitData('${cstmr.saleId}','${cstmr.result}','${cstmr.dlvryCnt}'); return false;" src="<c:url value="/images/button/Select_c.png" /> "width="40px" height="40px">
					</td>
				        
				</tr>
				<tr>
			      <td height="3" colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
			    </tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>					
				<td colspan="6" align="center">고객 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
	
    <tr>
      <td height="3" colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="100%" height="1" /></td>
    </tr>
    <!-- <tr>
      <td width="123">&nbsp;</td>
      <td width="132">&nbsp;</td>
      <td width="146">&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr> -->
  </table>
 
<br>
