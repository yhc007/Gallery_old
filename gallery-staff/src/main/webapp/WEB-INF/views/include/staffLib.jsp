<%@ page language="java" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" scope="request"/>

<c:set var="ctxDomain" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}" scope="request"/>
 
<c:set var="newline" value="<%= \"\n\" %>" />

<%--  공통 context 부분  --%>

<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"> -->
<script>

var gShopId;
var gShopPwd;
var gId;	
var gShopName;

function galleryManager(){
	
	/* alert('테스트 기간동안 연결되지 않습니다. 기존 경로를 이용해 주세요.');
	return; */
	if(!gId){
		gId = window.sessionStorage.getItem("gId");
	}
	if(!gShopPwd){
		gShopPwd = window.sessionStorage.getItem("gShopPwd");
	}
	console.log('gId:'+gId);
	console.log('gShopPwd:'+gShopPwd);
		$.ajax({
			/* url : 'https://jaguar.s4g.kr/Manager/admin/login.do', */
			url : '${ctxDomain}/Manager/admin/login.do',
			
			type : "post",
			dataType : "text",
			data : "id=" + gId + "&pwd=" + gShopPwd + "&shopTy="+"shop",
			success : function(data){
				if(data.trim()=="success"){
					/* location.href="https://jaguar.s4g.kr/Manager/chart/chart.do"; */
					location.href="${ctxDomain}/Manager/chart/chart.do";
				}else if(data.trim()=="fail"){
					alert("ID혹은 비밀번호를 확인해 주세요.");
				}
			}
		}); 

	}

	
</script>