<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ include file="/WEB-INF/views/include/staffLib.jsp"%> --%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Error Page</title>
<script type="text/javascript">
	function back(){
		location.href="/GalleryStaff/shop/indexShopForm.do";
	}
	
	$('.input').keypress(function (e) {
		  if (e.which == 13) {
		    $('form#login').submit();
		    return false; back();    //<---- Add this line
		  
		  }
	});
</script>
</head>

<body>
<br>
<br>
<br>
<br>
<br>
<br>
	<center>
		<font style="font-size: 20px; font-weight: bold;">
		네트워크 연결이 불안정 하거나</br>
		시스템 오류가 발생하였습니다.</br>
		</br> 반복될 경우 관리자에게 연락 바랍니다.</br>
		
		<br>
		<button onclick="back();" style="height: 50px" tabindex=1>처음으로</button>
	</center>
</body>
</html>

