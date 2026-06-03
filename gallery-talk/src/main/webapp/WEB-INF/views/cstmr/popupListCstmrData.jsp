<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${!empty listcstmr}">
   		<c:forEach var="cstmr" items="${listcstmr}" varStatus="status">
			<tr onclick="fncSelectCstmr('${cstmr.cstmrId}');return false;" class="listData">
			    <td>${cstmr.cstmrId }</td>		
				<td>${cstmr.profile }</td>
			</tr>			
		</c:forEach>
	</c:when>		
	<c:otherwise>
		<tr>					
			<td colspan="2" align="center">고객이 없습니다.</td>	
		</tr>
	</c:otherwise>
</c:choose>
<script type="text/javascript">
	$(".listData").click(function() {
		$("tr.selected").removeClass("selected");
		$(this).addClass("selected");
	});
</script>