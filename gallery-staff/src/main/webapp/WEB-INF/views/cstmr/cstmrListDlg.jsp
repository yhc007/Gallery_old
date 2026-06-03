<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script type="text/javascript">
function goIndexForm(){
	location.replace("${ctxPath}/cstmr/indexCstmrForm.do");
};

jQuery(document).ready(function(){

});


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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="format-detection" content="telephone=no, address=no, email=no" />
<title>Gallery Cloud</title>
<style type="text/css">
	#tr{
    	background: rgba(255, 255, 255, 0.5);
		}
</style>
</head>

<body>
<center>
<table class="listShop transBoxTable" width="800px" border="0.5" style="font-size: 16px" >
	<colgroup>
		<col width="200">
		<col width="100">
		<col width="250">
		<col width="100">
		<col width="100">
		<col width="100">
	</colgroup>
	
	
  <tr>
    <td colspan="7"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
  </tr>
  
  <tr id="tr">
		<!-- <td onclick="findInFind('num')">고객코드번호</td> -->
		<td>고객코드번호</td>
		<td>이름</td>
		<!-- <td onclick="findInFind('addr')">주소</td> -->
		<td>주소</td>
		<!-- <td onclick="findInFind('tel')">전화번호</td> -->
		<td>전화번호</td>
		<!-- <td onclick="findInFind('cel')">휴대폰</td> -->
		<td>휴대폰</td>
		<!-- <td onclick="findInFind('birth')">생년월일</td> -->
		<td>생년월일</td>
	</tr>
	<tr>
    <td colspan="7"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
  </tr>
  <c:choose>
		<c:when test="${!empty listcstmr}">
	   		<c:forEach var="cstmr" items="${listcstmr}" varStatus="status">
				<tr height="40px" class="listData">		
					<td onclick="fncSelectCstmr('${cstmr.cstmrId}','${cstmr.cstmrName }');return false;" width="10%">${cstmr.cstmrCd }</td>
					<td onclick="fncSelectCstmr('${cstmr.cstmrId}','${cstmr.cstmrName }');return false;" width="10%">${cstmr.cstmrName }</td>
					<td onclick="fncSelectCstmr('${cstmr.cstmrId}','${cstmr.cstmrName }');return false;" width="30%">${cstmr.addr }</td>

					<td onclick="fncSelectCstmr('${cstmr.cstmrId}','${cstmr.cstmrName }');return false;" width="15%">${cstmr.telephone}</td>
					<td onclick="fncSelectCstmr('${cstmr.cstmrId}','${cstmr.cstmrName }');return false;" width="15%">${cstmr.cellphone }</td>
					

					<td onclick="fncSelectCstmr('${cstmr.cstmrId}','${cstmr.cstmrName }');return false;" width="10%">${cstmr.birthDay }</td>
					<script>
						console.log('cstmrCd : '+'${cstmr.cstmrCd }');
					</script>
				</tr>
				<tr>
			     <td colspan="7"><img src="<c:url value="/images/content/Whiteline.jpg" />"  width="100%" height="1" /></td>
			    </tr>		
			</c:forEach>
		</c:when>		
		<c:otherwise>
			<tr>					
				<td colspan="7" align="center">최근 검색하신 고객이 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
</center>

</body>
</html>
