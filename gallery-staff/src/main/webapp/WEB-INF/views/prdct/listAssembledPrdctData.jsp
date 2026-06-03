<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>

<!-- <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
 -->
<script type="text/javascript">
$("input:checkbox").each(function(index) {
    $("<label>").text("")
                .attr("for", this.id = "checkbox" + index + 1)
                .insertAfter(this);
});

total = 0;
function fncSum(prc){
	total+=parseInt(prc);
	document.getElementById("total_txt").innerHTML=total;
}

var index = 0;

function checkSms(){
	alert('cstmrVo.cellphone'+'${cstmrVo.cellphone}');	
}

var asmChecked = true;
function fncSetAsmCheckAll(){
	var inputElements = document.getElementsByTagName('input');
	for ( var i = 0; i < inputElements.length; ++i) {
		if (inputElements[i].className == "assemblyCheckbox" || inputElements[i].className == "assemblyCheckboxNew"){
			inputElements[i].checked = asmChecked;
		}
	}
	if(asmChecked==true){
		asmChecked=false;
	}else{
		asmChecked=true;
	}	
}

var smsChecked = true;
function fncSetSmsCheckAll(){
	var inputElements = document.getElementsByTagName('input');
	for ( var i = 0; i < inputElements.length; ++i) {
		if (inputElements[i].className == "informCheckbox" || inputElements[i].className == "informCheckboxNew"){
			inputElements[i].checked = smsChecked;
		}
	}
	if(smsChecked==true){
		smsChecked=false;
	}else{
		smsChecked=true;
	}	
}

</script>
<style>
 input[type=checkbox] {
    display:none;
  }
 
  input[type=checkbox] + label
   {
       background-image : url("/GalleryStaff/images/checkbox.png");
       height: 32px;
       width: 32px;
       display:inline-block;
       padding: 0 0 0 0px;
   }

   input[type=checkbox]:checked + label
    {
        background-image : url("/GalleryStaff/images/checkbox_c.png");
        height: 32px;
        width: 32px;
        display:inline-block;
        padding: 0 0 0 0px;
    }
</style>

<table class="staffList" border="0.5">
    <tr>
      <td height="3" colspan="8"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="800" height="1" /></td>
    </tr>
    <tr style="text-align: center;">
      <td>모델명</td>
      <td>색상</td>
      <td>수량</td>
      <td style="text-align: right;">가격</td>
      <td style="text-align: right;">합계</td>
      <td onclick="fncSetAsmCheckAll(); return false;">조립여부</td>
      <td onclick="fncSetSmsCheckAll(); return false;">알림</td>
    </tr>
    <tr>
      <td height="3" colspan="8"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
    </tr>
    
    <c:choose>
		<c:when test="${!empty listPrdct || !empty newPrdct || !empty listLens || !empty listClens || !empty listAcc }">
			<form id="listCheckBox" name="listCheckBox" method="post" action="">
	   		<c:forEach var="prdct" items="${listPrdct}" varStatus="status">
				<tr class="listData" tr style="text-align: center;">
				<label>
				    <td height="66">${prdct.prdctName}</td>
				    <td height="66">${prdct.colorName}</td>
				    <td height="66">${prdct.prdctCnt}</td>
				    <td height="66" style="text-align: right;"><fmt:formatNumber value="${prdct.prc}" pattern="#,###"/></td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${prdct.prc*prdct.prdctCnt}" pattern="#,###"/></td>
				    <td height="66" >
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${prdct.asmbly =='1'}">
				        	
				        	<input class="assemblyCheckbox" type="checkbox" name="chk[]" value='${prdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="assemblyCheckbox" type="checkbox" name="chk[]" value='${prdct.prdctId}' >
				        </c:otherwise>
				        </c:choose>
			      	</td>
			      	 <td height="66" >
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${prdct.inform =='1'}">
				        	
				        	<input class="informCheckbox" type="checkbox" name="chk[]" value='${prdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="informCheckbox" type="checkbox" name="chk[]" value='${prdct.prdctId}' >
				        </c:otherwise>
				        </c:choose>
			      	</td>
			    </label>	    
				</tr>
				<tr>
			      <td height="3" colspan="8"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			</c:forEach>
			
			<!-- 렌즈@@ -->
			
			<c:forEach var="newPrdct" items="${listLens}" varStatus="status">
				<tr class="listData"style="text-align: center;">
				<label>
				    <td height="66">${newPrdct.prdctName} - ${newPrdct.curve }</td>
				    <td height="66">&nbsp;</td>
				    <td height="66">${newPrdct.prdctCnt}</td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc }" pattern="#,###"/></td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc*newPrdct.prdctCnt}" pattern="#,###"/></td>
				    <td height="66">
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${newPrdct.asmbly =='1'}">
				        	<input class="assemblyCheckbox" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="assemblyCheckbox" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' >
				        </c:otherwise>
				        </c:choose>
			      	</td>
			      	 <td height="66" >
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${newPrdct.inform =='1'}">
				        	
				        	<input class="informCheckbox" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="informCheckbox" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' >
				        </c:otherwise>
				        </c:choose>
			      	</td>
			    </label>	    
				</tr>
				<tr>
			      <td height="3" colspan="8"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			</c:forEach>
			
			<!-- 컨텍렌즈@@ -->
			
			<c:forEach var="newPrdct" items="${listClens}" varStatus="status">
				<tr class="listData"style="text-align: center;">
				<label>
				    <td height="66">${newPrdct.prdctName}</td>
				    <td height="66">&nbsp;</td>
				    <td height="66">${newPrdct.prdctCnt}</td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc }" pattern="#,###"/></td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc*newPrdct.prdctCnt}" pattern="#,###"/></td>
				    <td height="66">
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${newPrdct.asmbly =='1'}">
				        	<input class="assemblyCheckbox" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="assemblyCheckbox" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' >
				        </c:otherwise>
				        </c:choose>
			      	</td>
			      	 <td height="66" >
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${newPrdct.inform =='1'}">
				        	
				        	<input class="informCheckbox" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="informCheckbox" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' >
				        </c:otherwise>
				        </c:choose>
			      	</td>
			    </label>	    
				</tr>
				<tr>
			      <td height="3" colspan="8"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			</c:forEach>
			
			<!--용액@@ -->
			
			<c:forEach var="newPrdct" items="${listAcc}" varStatus="status">
				<tr class="listData"style="text-align: center;">
				<label>
				    <td height="66">${newPrdct.prdctName}</td>
				    <td height="66">&nbsp;</td>
				    <td height="66">${newPrdct.prdctCnt}</td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc }" pattern="#,###"/></td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc*newPrdct.prdctCnt}" pattern="#,###"/></td>
				    <td height="66">
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${newPrdct.asmbly =='1'}">
				        	<input class="assemblyCheckbox" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="assemblyCheckbox" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' >
				        </c:otherwise>
				        </c:choose>
			      	</td>
			      	 <td height="66" >
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${newPrdct.inform =='1'}">
				        	
				        	<input class="informCheckbox" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="informCheckbox" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' >
				        </c:otherwise>
				        </c:choose>
			      	</td>
			    </label>	    
				</tr>
				<tr>
			      <td height="3" colspan="8"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			</c:forEach>
			
			<!-- newPrdct -->
			<c:forEach var="newPrdct" items="${newPrdct}" varStatus="status">
				<tr class="listData"style="text-align: center;">
				<label>
				    <td height="66">${newPrdct.prdctName}</td>
				    <td height="66">&nbsp;</td>
				    <td height="66">${newPrdct.prdctCnt}</td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc }" pattern="#,###"/></td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc*newPrdct.prdctCnt}" pattern="#,###"/></td>
				    <td height="66">
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${newPrdct.asmbly =='1'}">
				        	<input class="assemblyCheckboxNew" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="assemblyCheckboxNew" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' >
				        </c:otherwise>
				        </c:choose>
			      	</td>
			      	 <td height="66" >
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${newPrdct.inform =='1'}">
				        	
				        	<input class="informCheckboxNew" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="informCheckboxNew" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' >
				        </c:otherwise>
				        </c:choose>
			      	</td>
			    </label>	    
				</tr>
				<tr>
			      <td height="3" colspan="8"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			</c:forEach>
			<!-- End newPrdct -->
			
			</form>
		</c:when>
		<c:otherwise>
			<tr>					
				<td colspan="8" align="center">상품 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
	<script>
		fncInitCheckValue();
	</script>
	
   <%--  <tr>
      <td height="3" colspan="5"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
    </tr> --%>
  </table>
 
<br>
