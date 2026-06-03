<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>

<script>

	//화면 초기 실행 
	jQuery(document).ready(function(){
	});
	
	function closeDlg(obj) {
		console.log('staffId:'+'${staffVo.staffId}');
	    if (obj == "1" )    {
	    	var strCookie = 'galleryNotice1'+'${staffVo.staffId}';
	    	console.log('strCookie:'+strCookie);
	        setCookie( strCookie, "done" , 1);
	    }
	 
	    $('#popupNotice').dialog('close');
	    //$('#popupNotice').dialog('destroy');
	}
	 
	function setCookie( name, value, expiredays ){
	    var todayDate = new Date();
	    todayDate.setDate( todayDate.getDate() + expiredays );
	    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	
	

</script> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>긴급 공지</title>
<style>

ol>li
{
	text-align:left;
}
</style>
</head>

<body onload="changeHashOnLoad(); ">
<center>

<h3>안녕하세요. 전산실 공지사항 입니다.</h3>
<ol>
	
	<li>처방 입력시 날짜로 인한 에러가 수정되었습니다.</li>
	<li>검안에서 빈칸이 있을경우 저장 안되던 문제가 수정되었습니다.</li>
	<li>처방 입력시 날짜를 한번 바꾸면 고정됩니다.</li>
	<li>처방 입력시 날짜가 오늘 날짜와 다를 경우 붉은 색으로 표시됩니다.</li>
	
</ol>
<h4>문의사항 전산실:051)442-0335</h4>

<center>

	<!-- <p>상세한 내용은 <a href="http://jaguar.g-eyewear.com/wiki/pages/g4U2B7q81/GECS__.html" target="_blank"> 커뮤니티</a>를 참고하셔서 이용에 불편함이 없으시길 바랍니다.</p> -->
</center>

<footer>
<input type="button" value='닫기' onclick="closeDlg('0');">
<input type="button" value='오늘 하루 다시 보지 않기.' onclick="closeDlg('1');">
</footer>
</center>
</body>
</html>

