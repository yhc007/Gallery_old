<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%-- <%@ include file="/WEB-INF/views/include/lib.jsp"%> --%>

<script>

total = 0;
function fncSum(prc){
	total+=parseInt(prc);
	document.getElementById("total_txt").innerHTML=format(String(total));
}

function format(number) {
	var pattern = /(-?[0-9]+)([0-9]{3})/;
	 
	while(pattern.test(number)) {
		number = number.replace(pattern,"$1,$2");
	}
		return number;
	}
</script>


<table class="staffList" width="800" border="0.5">
    <tr>	
      <td height="3" colspan="9"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="800" height="1" /></td>
    </tr>
    <tr class="tb">
      <td height="46" width="60" > <a class="checkproccess" id="prdctSelect" href="#" onclick="getPrdct(); return false;"><img src="<c:url value="/images/button/Add_Button.png" />" width="40px;"></a></td>
      <td width="200">모델 명</td>
      <td width="100">색상</td>
      
      <td width="40" colspan="3" style="text-align: center;">수량</td>
      
      <td width="210" height="46" style="text-align: right;">가격</td>
      <td width="250" height="46" style="text-align: right;">합계</td>
      <td width="60" height="46" >제거</td>
    </tr>
    <tr>
      <td height="3" colspan="9"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
    </tr>
    		<script>
    			console.log("1${listPrdct}");
    			console.log("2${newPrdct}");
    			console.log("3${listLens}");
    			console.log("4${listClens}");
    			console.log("5${listAcc}");
    		</script>
    <c:choose>
		<%-- <c:when test="${ not empty listPrdct || not empty newPrdct || not empty listLens || not empty listClens || not empty listAcc} "> --%> 
		<c:when test="true">
	   		<c:forEach var="prdct" items="${listPrdct}" varStatus="status">
				<tr class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->		
				    <td height="66">&nbsp;</td>
				    <td height="66">${prdct.prdctName}</td>
				    <td height="66">${prdct.colorName}</td>
				    <td height="66">  <a class="checkproccess" href="#" onclick= "fncDecCnt('${prdct.prdctId}','${prdct.prdctCnt}','${prdct.prc}','${prdct.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_m.png" />" width="25px" height="25px" /></a></td>
				    <td height="66">${prdct.prdctCnt}</td>
				    <td height="66">  <a class="checkproccess" href="#" onclick= "fncIncCnt('${prdct.prdctId}','${prdct.prdctCnt}','${prdct.prc}','${prdct.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_p.png" />" width="25px" height="25px" /></a> </td>
				    <td height="66" style="text-align: right;"><fmt:formatNumber value="${prdct.prc}" pattern="#,###"/></td>
				    <td height="66" style="text-align: right;"><fmt:formatNumber value="${prdct.prc*prdct.prdctCnt}" pattern="#,###"/></td>	    
				    <td height="66"><a class="checkproccess" href="#" onclick="fncCancelSelect('${prdct.prdctId}','${prdct.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_c.png" />" width="25px" height="25px" /></a></td>	    
				</tr>
				<tr>
			      <td height="3" colspan="9"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			    <script>
			    	fncSum('${prdct.prc*prdct.prdctCnt}');
			    </script>
			</c:forEach>
			
			<!-- 렌즈@@@@@@@ -->
			
			<c:forEach var="lens" items="${listLens}" varStatus="status">
				<tr class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->		
				    <td height="66">&nbsp;</td>
				    <td height="66">${lens.prdctName} - ${lens.curve }</td>
				    <td height="66">${lens.colorName}</td>
				    <td height="66">  <a class="checkproccess" href="#" onclick= "fncDecCnt('${lens.prdctId}','${lens.prdctCnt}','${lens.prc}','${lens.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_m.png" />" width="25px" height="25px" /></a></td>
				    <td height="66">${lens.prdctCnt}</td>
				    <td height="66">  <a class="checkproccess" href="#" onclick= "fncIncCnt('${lens.prdctId}','${lens.prdctCnt}','${lens.prc}','${lens.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_p.png" />" width="25px" height="25px" /></a> </td>
				    <td height="66" style="text-align: right;"><fmt:formatNumber value="${lens.prc}" pattern="#,###"/></td>
				    <td height="66" style="text-align: right;"><fmt:formatNumber value="${lens.prc*lens.prdctCnt}" pattern="#,###"/></td>	    
				    <td height="66"><a class="checkproccess" href="#" onclick="fncCancelSelect('${lens.prdctId}','${lens.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_c.png" />" width="25px" height="25px" /></a></td>	    
				</tr>
				<tr>
			      <td height="3" colspan="9"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			    <script>
			    	fncSum('${lens.prc*lens.prdctCnt}');
			    </script>
			</c:forEach>
			
			<!-- 콘텍@@@@@@@ -->
			
			<c:forEach var="lens" items="${listClens}" varStatus="status">
				<tr class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->		
				    <td height="66">&nbsp;</td>
				    <td height="66">${lens.prdctName}</td>
				    <td height="66">${lens.colorName}</td>
				    <td height="66">  <a class="checkproccess" href="#" onclick= "fncDecCnt('${lens.prdctId}','${lens.prdctCnt}','${lens.prc}','${lens.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_m.png" />" width="25px" height="25px" /></a></td>
				    <td height="66">${lens.prdctCnt}</td>
				    <td height="66">  <a class="checkproccess" href="#" onclick= "fncIncCnt('${lens.prdctId}','${lens.prdctCnt}','${lens.prc}','${lens.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_p.png" />" width="25px" height="25px" /></a> </td>
				    <td height="66" style="text-align: right;"><fmt:formatNumber value="${lens.prc}" pattern="#,###"/></td>
				    <td height="66" style="text-align: right;"><fmt:formatNumber value="${lens.prc*lens.prdctCnt}" pattern="#,###"/></td>	    
				    <td height="66"><a class="checkproccess" href="#" onclick="fncCancelSelect('${lens.prdctId}','${lens.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_c.png" />" width="25px" height="25px" /></a></td>	    
				</tr>
				<tr>
			      <td height="3" colspan="9"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			    <script>
			    	fncSum('${lens.prc*lens.prdctCnt}');
			    </script>
			</c:forEach>
			
			<!-- 용액@@@@@@@ -->
			
			<c:forEach var="lens" items="${listAcc}" varStatus="status">
				<tr class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->		
				    <td height="66">&nbsp;</td>
				    <td height="66">${lens.prdctName}</td>
				    <td height="66">${lens.colorName}</td>
				    <td height="66">  <a class="checkproccess" href="#" onclick= "fncDecCnt('${lens.prdctId}','${lens.prdctCnt}','${lens.prc}','${lens.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_m.png" />" width="25px" height="25px" /></a></td>
				    <td height="66">${lens.prdctCnt}</td>
				    <td height="66">  <a class="checkproccess" href="#" onclick= "fncIncCnt('${lens.prdctId}','${lens.prdctCnt}','${lens.prc}','${lens.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_p.png" />" width="25px" height="25px" /></a> </td>
				    <td height="66" style="text-align: right;"><fmt:formatNumber value="${lens.prc}" pattern="#,###"/></td>
				    <td height="66" style="text-align: right;"><fmt:formatNumber value="${lens.prc*lens.prdctCnt}" pattern="#,###"/></td>	    
				    <td height="66"><a class="checkproccess" href="#" onclick="fncCancelSelect('${lens.prdctId}','${lens.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_c.png" />" width="25px" height="25px" /></a></td>	    
				</tr>
				<tr>
			      <td height="3" colspan="9"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			    <script>
			    	fncSum('${lens.prc*lens.prdctCnt}');
			    </script>
			</c:forEach>
			
			<!-- 신규등록 -->
			<c:forEach var="lens" items="${newPrdct}" varStatus="status">
				<tr class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->		
				    <td height="66">&nbsp;</td>
				    <td height="66">${lens.prdctName}</td>
				    <td height="66">&nbsp;</td>
				    <td height="66">  <a class="checkproccess" href="#" onclick= "fncDecCntNew('${lens.prdctId}','${lens.prdctCnt}','${lens.prc}','${lens.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_m.png" />" width="25px" height="25px" /></a></td>
				    <td height="66">${lens.prdctCnt}</td>
				    <td height="66">  <a class="checkproccess" href="#" onclick= "fncIncCntNew('${lens.prdctId}','${lens.prdctCnt}','${lens.prc}','${lens.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_p.png" />" width="25px" height="25px" /></a> </td>
				    <td height="66" style="text-align: right;"><fmt:formatNumber value="${lens.prc}" pattern="#,###"/></td>
				    <td height="66" style="text-align: right;"><fmt:formatNumber value="${lens.prc*lens.prdctCnt}" pattern="#,###"/></td>	    
				    <td height="66"><a class="checkproccess" href="#" onclick="fncCancelSelectNew('${lens.prdctId}','${lens.dlvry}'); return false;"><img src="<c:url value="/images/button/Select_c.png" />" width="25px" height="25px" /></a></td>	    
				</tr>
				<tr>
			      <td height="3" colspan="9"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
			    </tr>
			    <script>
			    	fncSum('${lens.prc*lens.prdctCnt}');
			    </script>
			</c:forEach>
			
			
			<tr>
		      <td height="66" colspan="2" style="text-align: center;">합계</td>
		      <td height="66" >&nbsp;</td>
		      <td height="66" >&nbsp;</td>
		      <td height="66" >&nbsp;</td>
		      <td height="66" >&nbsp;</td>
		      <td height="66" >&nbsp;</td>
		      <td height="66" style="text-align: right;"><p id="total_txt" ></p></td>
		      <td height="66" >&nbsp;</td>
		    </tr>			
		</c:when>
		<c:otherwise>
			<tr>					
				<td colspan="9" align="center">상품 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
    	<tr>
			<td height="3" colspan="9"><img src="<c:url value="/images/content/Whiteline.jpg" />" alt="line" width="800" height="1" /></td>
		</tr>

	</table>
  
 
<br>
