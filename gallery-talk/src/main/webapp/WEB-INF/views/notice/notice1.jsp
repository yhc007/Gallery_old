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

<ul>
	<li>안녕하세요. 전산실 긴급 공지사항 입니다.</li>
	<li>보안상의 문제로 긴급 업데이트가 있었습니다. 이용에 불편을 드려 죄송합니다.
	아래 링크로 접속하여 보안 테스트 후에 안내되는 내용에 따라 주시면 감사하겠습니다.
	컴퓨터 에서만 하시면 되며 안드로이드, iOS 단말기에서는 진행하지 않으셔도 됩니다.</li>
	<li> <a href="${ctxPath}/secu/indexSecuTest.do" target="_blank"> 클릭</a></li>
</ul>
<ol>
	<li>업데이트 내용 공지 드립니다.</li>
	<li>메모가 처방별로 입력되도록 변경되었습니다.</li>
	<li>구매단계에서 가족이동이 보다 편리하게 변경 되었습니다. 고객 이름을 선택해 보세요.</li>
	<li>가족이 보이지 않을 경우 해당 회원으로 가셔서 결제단계에서 포인트 카드를 가족 카드로 등록해 주시면 됩니다.</li>
	<li>구매단계에서 사용자(안경사) 변경이 보다 편리하게 변경 되었습니다. 안경사 이름을 선택해 보세요.</li>
</ol>

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

