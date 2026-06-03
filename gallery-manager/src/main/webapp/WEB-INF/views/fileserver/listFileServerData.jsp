<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="list" width="100%" border="1">
	<colgroup>
		<col width="20%">
		<col width="80%">
	</colgroup>
	<thead>
	<tr>
		<th>NO</th>
		<th>서버 명</th>
	</tr>
	</thead>
	<c:choose>
		<c:when test="${!empty listFileServer}">
	   		<c:forEach var="fileserver" items="${listFileServer}" varStatus="status">
				<tr onclick="fncGetFileServerInfo('${fileserver.serverId}');return false;" class="listData">
					<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->
				    <td>${fileserver.rownum }</td>			
				    <td>${fileserver.serverName }</td>
				</tr>			
			</c:forEach>
			
			<script>
				makePagingButton("${pv.currentPage}","${pv.startPage}","${pv.endPage}","${pv.totalPage}","fncListFileServerData");
			</script>
		</c:when>		
		<c:otherwise>
			<tr>					
				<td colspan="9" align="center">서버 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<br>
	<div align="center" id="paging_button_div">
</div>
