<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" scope="request"/>
<div align="right">
<script type="text/javascript">
function goNewCstmr(){
	location.replace("${ctxPath}/cstmr/mNewCstmrForm.do");
};

function goCstmrMerge(){
	location.replace("${ctxPath}/cstmr/mCstmrMergeForm.do");
};
</script>
<table class="header" >
	<tr>
		<td><button class="webButton"  onclick="goNewCstmr();return false;">신규 등록</button></td>
	</tr>
	<tr>
		<td height="10px"></td>
	</tr>
	<tr>
		<td><button class="webButton" onclick="goCstmrMerge();return false;">계정 통합</button></td>
	</tr>
</table>
</div>