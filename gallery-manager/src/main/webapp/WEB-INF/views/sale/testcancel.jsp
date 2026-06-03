<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
<meta name="viewport" content="target-densitydpi=low-dpi, width=device-width,initial-scale=1.0" />
	<title>Result Success</title>
<script>
//----------------------
//화면 초기 실행 
jQuery(document).ready(function(){
	checkApplicationInstall();		
});
//----------------------

/*
 * 고객 데이타 리스트 보드 페이징
 */

function checkApplicationInstall() {
//단말 로컬에 있는 어플리케이션 실행
  document.checkframe.location = "bill://callgalleryapp?confirm=y";
  //1초 후에 다음 펑션을 수행

 }

 	
 function cls(){
  window.open('','_self','');
  window.close();
 }

</script> 
</head>

<body>
nonono
</body>
</html>
