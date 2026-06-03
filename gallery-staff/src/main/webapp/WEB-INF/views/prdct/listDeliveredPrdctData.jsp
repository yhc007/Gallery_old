<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<script>

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

var dlvChecked = true;
function fncSetAsmCheckAll(){
	var inputElements = document.getElementsByTagName('input');
	for ( var i = 0; i < inputElements.length; ++i) {
		if (inputElements[i].className == "dlvryCheckbox" || inputElements[i].className == "dlvryCheckboxNew"){
			inputElements[i].checked = dlvChecked;
		}
	}
	if(dlvChecked==true){
		dlvChecked=false;
	}else{
		dlvChecked=true;
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

<table class="staffList" width="800" border="0.5">
    <tr>
      <td height="3" colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="800" height="1" /></td>
    </tr>
    <tr class="tb" height="46">
      <td>모델 명</td>
      <td>색상</td>
      <td>수량</td>
      <td style="text-align: right;">가격</td>
      <td style="text-align: right;">합계</td>
      <td onclick='fncSetAsmCheckAll(); return false;' style="text-align: center;">전달여부</td>
    </tr>
    <tr>
      <td height="3" colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
    </tr>
    
    <c:choose>
		<c:when test="${ !empty listPrdct || !empty newPrdct || !empty listLens || !empty listClens || !empty listAcc}">
			<form id="listCheckBox" name="listCheckBox" method="post" action="">
	   		<c:forEach var="prdct" items="${listPrdct}" varStatus="status">
				<tr class="listData">
				<label>
				    <td height="66">${prdct.prdctName}</td>
				    <td height="66">${prdct.colorName}</td>
				    <td height="66">${prdct.prdctCnt}</td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${prdct.prc}" pattern="#,###"/></td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${prdct.prc*prdct.prdctCnt}" pattern="#,###"/></td>
				    <td height="66"  style="text-align: center;">
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${prdct.dlvry =='1'}">
				        	<input class="dlvryCheckbox" type="checkbox" name="chk[]" value='F${prdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="dlvryCheckbox" type="checkbox" name="chk[]" value='F${prdct.prdctId}'>
				        </c:otherwise>
				        </c:choose>
			      	</td>
			    </label>	    
				</tr>
				<tr>
			      <td height="3" colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			    <script>
			    	console.log('F:${prdct.prdctId}:Cnt:${prdct.prdctCnt}');
			    </script>
			</c:forEach>
			
			
			<!-- 렌즈 -->
			<c:forEach var="newPrdct" items="${listLens}" varStatus="status">
				<tr class="listData">
				<label>
				    <td height="66">${newPrdct.prdctName} - ${newPrdct.curve}</td>
				    <td height="66">&nbsp;</td>
				    <td height="66">${newPrdct.prdctCnt}</td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc}" pattern="#,###"/></td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc*newPrdct.prdctCnt}" pattern="#,###"/></td>
				    <td height="66"  style="text-align: center;">
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${newPrdct.dlvry =='1'}">
				        	<input class="dlvryCheckbox" type="checkbox" name="chk[]" value='L${newPrdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="dlvryCheckbox" type="checkbox" name="chk[]" value='L${newPrdct.prdctId}'>
				        </c:otherwise>
				    </c:choose>
			      	</td>
			    </label>	    
				</tr>
				<tr>
			      <td height="3" colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			    <script>
			    	console.log('L:${newPrdct.prdctId}:Cnt:${newPrdct.prdctCnt}');
			    </script>
			</c:forEach>
			
			
			<!-- 콘텍 -->
			<c:forEach var="newPrdct" items="${listClens}" varStatus="status">
				<tr class="listData">
				<label>
				    <td height="66">${newPrdct.prdctName}</td>
				    <td height="66">&nbsp;</td>
				    <td height="66">${newPrdct.prdctCnt}</td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc}" pattern="#,###"/></td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc*newPrdct.prdctCnt}" pattern="#,###"/></td>
				    <td height="66"  style="text-align: center;">
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${newPrdct.dlvry =='1'}">
				        	<input class="dlvryCheckbox" type="checkbox" name="chk[]" value='C${newPrdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="dlvryCheckbox" type="checkbox" name="chk[]" value='C${newPrdct.prdctId}'>
				        </c:otherwise>
				        </c:choose>
			      	</td>
			    </label>	    
				</tr>
				<tr>
			      <td height="3" colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			    <script>
			    	console.log('C:${newPrdct.prdctId}:Cnt:${newPrdct.prdctCnt}');
			    </script>
			</c:forEach>
			
			
			<!-- 용액 -->
			<c:forEach var="newPrdct" items="${listAcc}" varStatus="status">
				<tr class="listData">
				<label>
				    <td height="66">${newPrdct.prdctName}</td>
				    <td height="66">&nbsp;</td>
				    <td height="66">${newPrdct.prdctCnt}</td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc}" pattern="#,###"/></td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc*newPrdct.prdctCnt}" pattern="#,###"/></td>
				    <td height="66"  style="text-align: center;">
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${newPrdct.dlvry =='1'}">
				        	<input class="dlvryCheckbox" type="checkbox" name="chk[]" value='A${newPrdct.prdctId}' checked >
				        </c:when>
				        <c:otherwise>
				        	<input class="dlvryCheckbox" type="checkbox" name="chk[]" value='A${newPrdct.prdctId}'>
				        </c:otherwise>
				        </c:choose>
			      	</td>
			    </label>	    
				</tr>
				<tr>
			      <td height="3" colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			    <script>
			    	console.log('A:${newPrdct.prdctId}:Cnt:${newPrdct.prdctCnt}');
			    </script>
			</c:forEach>
			
			<!-- newPrdct -->
			<c:forEach var="newPrdct" items="${newPrdct}" varStatus="status">
				<tr class="listData">
				<label>
				    <td height="66">${newPrdct.prdctName}</td>
				    <td height="66">&nbsp;</td>
				    <td height="66">${newPrdct.prdctCnt}</td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc}" pattern="#,###"/></td>
				    <td height="66"  style="text-align: right;"><fmt:formatNumber value="${newPrdct.prc*newPrdct.prdctCnt}" pattern="#,###"/></td>
				    <td height="66"  style="text-align: center;">
				    <p><!-- 10월 21일 --></p>
			        <c:choose>
				        <c:when test="${newPrdct.dlvry =='1'}">
				        	<input class="dlvryCheckboxNew" type="checkbox" name="chk[]" value='${newPrdct.prdctId}' checked>
				        </c:when>
				        <c:otherwise>
				        	<input class="dlvryCheckboxNew" type="checkbox" name="chk[]" value='${newPrdct.prdctId}'>
				        </c:otherwise>
				    </c:choose>
			      	</td>
			    </label>	    
				</tr>
				<tr>
			      <td height="3" colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			    <script>
			    	console.log('N:${newPrdct.prdctId}:Cnt:${newPrdct.prdctCnt}');
			    </script>
			</c:forEach>		
			
			</form>
		</c:when>
		
		<c:otherwise>
			<tr>					
				<td colspan="6" align="center">상품 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
	<script>
		fncInitCheckValue();
	</script>
	
    <tr>
      <td height="3" colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
    </tr>
  </table>
 
<br>
