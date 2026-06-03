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
		
		var menu = window.sessionStorage.getItem("menu")
		if(menu=="frame"){
			$("#frame").css("color","blue");
		}else if(menu=="lens"){
			$("#lens").css("color","blue");
		}else if(menu=="clens"){
			$("#clens").css("color","blue");
		}else if(menu=="clensacc"){
			$("#clensacc").css("color","blue");
		}else if(menu=="srch"){
			$("#srch").css("color","blue");
		}
		
		var option = window.sessionStorage.getItem("option");
		$("#item").val(option)
	};
	
	
	function srchItem(){
		var item = $("#item").val();
		console.log(item)
		if(item=="1"){
			location.href="${ctxPath}/invn/srchPrdctM.do";
		}else if(item=="2"){
			location.href="${ctxPath }/invn/lensInvnM.do";
		}else if(item=="3"){
			location.href="${ctxPath }/invn/cLensInvnM.do";
		}else if(item=="4"){
			location.href="${ctxPath }/invn/lensAccInvnM.do";
		}
	}
</script>
<style type="text/css">
</style>
</head>
<body>

<div id="today">
	<div id="date"></div>
	<div id="time"></div>
	
</div>
<span id="logout"><a href="${ctxPath }/invn/logOutM.do">logOut</a></span>
<center>
	<img src="<c:url value="/images/top/top_menu_logo.png"/>" width="154" height="57"></img>v.1227<br>
	<div id="shopName">${shopName }</div>	
</center> 
<br>
	<select id="item" onchange="srchItem();">
		<option value="-1">상품조회</option>
		<option value="1">프레임</option>
		<option value="2">렌즈</option>
		<option value="3">콘텍트렌즈</option>
		<option value="4">렌즈용액</option>
	</select>
<b><a href="${ctxPath }/invn/addPrdctM.do"><span class="title" id="frame">프레임 </span></a></b>
<b><a href="${ctxPath }/invn/lensFormM.do"><span class="title" id="lens">렌즈 </span></a></b>
<b><a href="${ctxPath }/invn/clensFormM.do"><span class="title" id="clens">콘텍트렌즈 </span></a></b>
<b><a href="${ctxPath }/invn/clensAccForm.do"><span class="title" id="clensacc">렌즈 용액 </span></a></b> 
</body>
</html>