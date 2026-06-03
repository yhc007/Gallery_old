<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
<meta name="viewport" content="target-densitydpi=low-dpi, width=device-width,initial-scale=1.0" />
	<title>Result Success</title>
<script>
function checkApplicationInstall() {
//단말 로컬에 있는 어플리케이션 실행
  document.checkframe.location = "bill://callgalleryapp?confirm=y";
  //1초 후에 다음 펑션을 수행
setTimeout("checkApplicationInstall_callback()", 1000);
 }
 function checkApplicationInstall_callback() {
  try {
   var s = document.checkframe.document.body.innerHTML;
   // 어플리케이션 설치되어있음
 //어플이 실행되고 난 뒤의 액션
  } catch (e) {
   // 어플리케이션 설치 안 되어있음
//어플이 설치 안되어 있는 상태이므로 마켓으로 연결한다.
//location.replace("intent://viewer?#Intent;scheme='bill';action='android.intent.action.VIEW';category='android.intent.category.BROWSABLE';package=bill;end");
   alert("비정상 종료되었습니다. 관리자에게 문의 바랍니다.");
   cls();
   return false;
  }
 }
 	
 function cls(){
  window.open('','_self','');
  window.close();
 }
 
 function blg(){
		window.android2.callAndroid('y');
}

</script> 
</head>

<body>
<h1>
	결제 성공
</h1>

<body>
<!-- <input type="button" value= onclick="checkApplicationInstall()"/><br/>
<iframe id="checkframe" name="checkframe" src="test.do" width="1" height="1"></iframe> -->
<input type="button" onclick="blg();return false;" value="${price}원 결제 완료.">
<h3>버튼이 동작하지 않을 경우 브라우저를 종료시켜 주십시오.</h3>
</body>
</html>
