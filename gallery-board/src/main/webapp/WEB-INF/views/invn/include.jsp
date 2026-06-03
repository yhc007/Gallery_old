<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gallery Comunity</title>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<style>
	.title{
		font-size: 20px;
		margin-left: 20px;
		color : white;
	}
	#toDay{
		position : absolute;
		right : 20px;
		font-weight: bold;
		top : 10px;
		font-size: 12px;
	}
	#shopName{
		font-weight: bold;
		margin-top: 10px;
		margin-bottom: 0px;
	}
	#logout{
		position : absolute;
		right : 20px;
		font-size: 15px;
		top : 85px;
	}
	#time{
		float: right;
	}
</style>
<script type="text/javascript">
	var date = new Date();
	var year = date.getFullYear();
	var month = addZero(date.getMonth()+1);
	var day = addZero(date.getDate());
	var hour = date.getHours();
	if(hour>12){
		hour = "오후 " + addZero((hour - 12));
	}else{
		hour = "오전" + addZero(hour);
	}
	var minute = addZero(date.getMinutes());
	var date_ = year + "년 " + month + "월 " + day + "일";
	var time_ = hour + " : " + minute;
	function addZero(n){
		if(String(n).length=="1"){
			return "0" + n;
		}else{
			return n;
		}
	};
	
	window.onload = function(){
		var date = document.getElementById("date");
		date.innerHTML = date_;
		var time = document.getElementById("time");
		time.innerHTML = time_;
	};
	
	
</script>
</head>
<body>

<div id="today">
	<div id="date"></div>
	<div id="time"></div>
	
</div>
<span id="logout"><a href="${ctxPath }/invn/logOut.do">logOut</a></span>
<center>
	<img src="<c:url value="/images/top/top_menu_logo.png"/>" width="154" height="57"></img><br>
	<div id="shopName">${shopName }</div>	
</center> 
<br>
<b><a href="${ctxPath }/invn/srchPrdct.do"><span class="title">상품조회</span></a> <a href="${ctxPath }/invn/addPrdct.do"><span class="title">상품등록</span></a></b> 
</body>
</html>