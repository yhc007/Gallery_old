<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>Gallery Comunity</title>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<style>
	#toDay{
		position : absolute;
		right : 20px;
		font-weight: bold;
		top : 10px;
		font-size: 12px;
	}
	#shopName{
		top : 20px;
		font-weight: bold;
	}
	#logout{
		position : absolute;
		right : 20px;
		font-size: 15px;
		top : 40px;
	}
	#time{
		float: right;
	}
	#title{
		font-weight: bold;
		font-size: 30px;
		margin-bottom: 10px;
		color : black;
		
	}
	#imgDiv{
		width: 100%;
		margin: 0px;
	}
	#blank{
		width: 100%;
		height :200px;
	}
	.prdctInfoBar{
		background-color: black;
		opacity : 0.4;
		position: absolute;
		width : 100%;
		padding-top :8px;
	}
	
	.prdctInfo, #colorSpan, #prdctNameSpan,#trdePrc{
		font-size : 20px;
		color : white;
	}
	#cntDiv{
		background-color: black;
		opacity : 0.5;
		position: absolute;
		width : 80px;
		height : 80px;
		position :absolute;
		
		
	}
	#cntSpan{
		color :white;
		font-weight: bold;
		font-size: 50px;
		line-height: 90px;
		
	}
	body{
		margin: 0px;
		padding : 0px;
	}
	#moreDiv{
		display: none;
	}
	#prdctNameSpan{
		position: absolute;
		right : 30px;
		
	}
	#trdePrc{
		position: absolute;
		right : 30px;
		
	}
	th{
		background-color: black;
		opacity : 0.5;
		color :white;
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
		/* var date = document.getElementById("date");
		date.innerHTML = date_;
		var time = document.getElementById("time");
		time.innerHTML = time_; */
		
		
		getMorePrdct();
		
		setInterval(boxPosition,500);
		setInterval(function(){
			img = $("#imgDiv");
			img_width = img.width();
		},500);	
	
	};
	
	var img;
	var img_width
	function boxPosition(){
		$(".img").css("width","100%");
		
		var img = $("#imgDiv");
		var img_width = img.width();
		var img_height = img.height();
		var offset = img.offset();
		
		
		$("#cntDiv").css("top",offset.top+img_height-80);
		$("#cntDiv").css("left",offset.left+img_width-80);		
	}
	function getInvnInfo(prdctId,shopId){
		var url = "${ctxPath}/invn/getInvnHist.do";
		var param = "prdctId=" + prdctId + "&shopId=" + shopId;
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : param,
			success : function(data){
				console.log("data :" +data)
				$('#dialog').html(data);		
			}
		});
		
		var width = window.innerWidth;
		  $('#dialog').dialog({
			//bgiframe: true
			 title: "거래 내역"
			 , modal: true
		     , width: width*0.9// 가로 크기
		     , background: "#000"
		     , position:{my:"center",at:"middle",of: window }
			 , close: function(event, ui){
			}, success:  function(data) {
				
			} 
		});
	}
	
	var more_btn = true;
	function more(){
		$("#moreDiv").slideToggle();
		if(more_btn){
			document.getElementById("moreBTN").src ="<c:url value="/images/Select_m.png" />";
			more_btn = false; 
		}else{
			document.getElementById("moreBTN").src ="<c:url value="/images/Select_p.png" />";
			more_btn = true;
		}
		
		
	}
	
	
	//같은 이름의 다른 색상 제품 리스트
	function getMorePrdct(){
		//var param = 
	};
	
	
	
	function getInvnInfo(prdctId,shopId){
		
		
		var url = "${ctxPath}/invn/getInvnHist.do";
		var param = "prdctId=" + prdctId + "&shopId=" + shopId;
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : param,
			success : function(data){
				$('#dialog').html(data);		
			}
		});
		
		  $('#dialog').dialog({
			//bgiframe: true
			 title: "거래 내역"
			 , modal: true
		     , width: img_width * 0.9 // 가로 크기
		     , background: "#000"
		     , position:{my:"center",at:"middle",of: window }
			 , close: function(event, ui){
			}, success:  function(data) {
				
			} 
		});
	}
</script>

</head>
<body>
	

<div id="today">
	<div id="date"></div>
	<div id="time"></div>
</div>

<center><%-- <img src="<c:url value="/images/top/top_menu_logo.png"/>" width="154" height="57"></img> --%>
	<img src='${ctxPath }/images/abc.jpg' width="100%">
	<div id="shopName">${shopName }</div>
</center> 
		<div id="imgDiv">
			<c:choose>
				<c:when test="${!empty invnList}">
				<c:forEach var="prdct" items="${invnList }">
					<div class="prdctInfoBar">
						<div id="info1">
							<span class="prdctInfo">&nbsp;&nbsp;&nbsp;${prdct.brandName }</span> <span id="prdctNameSpan"> ${prdct.prdctName }</span>  </div>	
						
						<div id="info2">
							<span id="colorSpan">&nbsp;&nbsp;&nbsp;${prdct.colorName }</span> <span id="colorSpan">&nbsp;&nbsp;&nbsp;${prdct.colorName2 }</span>
							<span id="trdePrc">&nbsp;&nbsp;&nbsp; <fmt:formatNumber value="${prdct.trdePrc }" pattern="#,###" /></span>
						</div>
					</div>
					<div id="cntDiv">
				<center><span id="cntSpan">${prdct.cnt }</span></center>
					</div>	
				</c:forEach>
				</c:when>
				<c:otherwise>
					<center>상품이 없습니다.</center>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${!empty img}">
					<img src='${img }' class="img">
		   		</c:when>	
		   		<c:otherwise>
					<img src='${ctxPath }/images/Logo.jpg' class="img">
				</c:otherwise>
			</c:choose>
		</div>
		
		
		
		<center><img src="${ctxPath }/images/Select_p.png" onclick="more()" width="30px" id="moreBTN"></center>
		
		<div id="moreDiv">
			<center>
			<table id="container" width="90%"border="1" style="border-collapse: collapse; text-align: center" >
				<th width="60%">제품명</th><th width="15%">색상1 </th><th width="15%">색상2 </th><th>수량</th>
				<c:choose>
					<c:when test="${!empty moreList }">
						<c:forEach var="more" items="#{moreList }">
							<tr onclick="getInvnInfo('${more.prdctId}','${more.shopId}')">
								<td>${more.prdctName }</td><td>${more.colorName }</td><td>${more.colorName2 }</td><td>${more.cnt }</td>
							</tr>						
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4">제품이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
				
			</table>
			</center>
		</div>
		
		<div id="dialog"></div>
	</body> 
</html>

