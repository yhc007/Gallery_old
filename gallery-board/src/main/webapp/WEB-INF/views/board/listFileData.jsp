<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:choose>
	<c:when test="${!empty fileList}">
   		<c:forEach var="file" items="${fileList}" varStatus="status">
			첨부파일 : <a href="#" data-role='none' onclick="downloadURI('${file.url }${file.fileName}', '${file.fileName}')">다운로드 <button onclick="editFile('${file.fileName}'); return false;" >수정</button> </a><br>
			<c:if test="${fn:indexOf(file.fileName, 'jpg') != -1 ||
						    fn:indexOf(file.fileName, 'png') != -1 ||
						    fn:indexOf(file.fileName, 'gif') != -1 ||
						    fn:indexOf(file.fileName, 'JPG') != -1 ||
						    fn:indexOf(file.fileName, 'PNG') != -1 ||
						    fn:indexOf(file.fileName, 'GIF') != -1}"> 
				<center><img src="${file.url }${file.fileName}" width='150%'><br><br></center>
			</c:if>
			
		</c:forEach>
	</c:when>		
	<c:otherwise>
				
	</c:otherwise>
</c:choose>