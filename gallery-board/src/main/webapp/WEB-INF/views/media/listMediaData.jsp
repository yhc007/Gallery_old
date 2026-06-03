<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${!empty listMedia}">
   		<c:forEach var="media" items="${listMedia}" varStatus="status">
   			<p id="p_img${media.mediaId}">${media.mediaName}<a href="#" onclick="removeMedia('${media.prdctId}','${media.mediaId}','${media.mediaTyCd}','${media.mediaName}','${media.color}')">삭제</a></p>		
		</c:forEach>
	</c:when>		
</c:choose>
<script>
	updateListSize('${listMedia.size()}');
</script>