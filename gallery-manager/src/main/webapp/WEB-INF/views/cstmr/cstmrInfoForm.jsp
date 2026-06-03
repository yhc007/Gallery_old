<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">
 var cstmrId = '${cstmrId}';
	$(function(){
		getCstmrInfo();
		var height = window.innerHeight;
		$("#edit").css("bottom",height-50);
		$("#edit").css("right",20);
		$("#pwd").css("bottom",50);
		$("#pwd").css("left",60);
	}); 
	
	
	function getCstmrInfo(){
		var url = "${ctxPath}/cstmr/cstmrInfo.do"; 
		var param = "cstmrId=" + cstmrId;
		$(".show").css("display","inline");
		$(".edit").css("display","none");	
		$("#blankDv").css("display","none");
		$.ajax({
			url : url,
			type:"post",
			dataType : "json",
			data : param,
			success : function(cstmr){
				console.log(cstmr)
				$("#coupon").text(cstmr.coupon);
				$("#cstmrName").text(cstmr.cstmrName);
				$("#cstmrCd").text(cstmr.cstmrCd);
				$("#birthDay").text(cstmr.birthDay + "　(" + cstmr.birthDayTyCd + ")");
				$("#cellphone").text(cstmr.cellphone);
				$("#cellphone_").val(cstmr.cellphone);
				$("#email").text(cstmr.email);
				$("#email_").val(cstmr.email);
				$("#addr").text(cstmr.addr);
				$("#addr_").val(cstmr.addr);
				if(cstmr.datetime==""){
					cstmr.datetime = "0";
				}
				var date = cstmr.datetime;
				var year = date.substring(0,4);
				var month = date.substring(4,6);
				var day = date.substring(6,8);
				$("#datetime").text(year + "." + month + "." + day);
				$("#sns").text(cstmr.sns);
				$("#email").text(cstmr.email);
				$("#buyCount").text(cstmr.buyCount);
				$("#point").text(cstmr.point);
				$("#shop").text(cstmr.shopName);
				if(cstmr.recheck>=6){
					$("#reCheck").text("6개월 초과 (재검사 필요함)");	
				}
				$("#staff").text(cstmr.staffName);
				
				$("#leftEye").text();
				$("#rightEye").text();
			}
		});
	}
	function showEdit(edit){
		$("#" + edit).css("display","none");	
		$("#" + edit + "_").css("display","inline");	
		$("#" + edit + "M").css("display","none");
	}
	
	function modify(){
		var email = $("#email_").val();
		var cellphone = $("#cellphone_").val();
		var addr = $("#addr_").val();
		var param = "email=" + email + "&cellphone=" + cellphone + "&addr=" + addr;
		var url = "${ctxPath}/cstmr/cstmrInfoUpdate.do";
		
		$.ajax({
			url : url,
			type:"post",
			data : param + "&cstmrId=" + cstmrId,
			success : function(data){
				getCstmrInfo();
			},
			error : function(e1,e2,e3){
				console.log(e2)
			}
		});
	}
	
	function modifyPwd(){
		location.href = "${ctxPath}/cstmr/modifyPwdForm.do?cstmrId=" + cstmrId;
	}
	
	function showMyCoupon(){
		location.href = "${ctxPath}/cstmr/myCoupon.do?cstmrId=" + cstmrId;
	}
	function showBuyList(){
		location.href = "${ctxPath}/cstmr/cstmrBuyList.do?cstmrId=" + cstmrId;
	}
	function showCheckResult(){
		location.href = "${ctxPath}/cstmr/cstmrEyes.do?cstmrId=" + cstmrId;
	}
	
	
	var edit = false;
	function editItem(){
		if(edit==false){
			$(".show").css("display","none");
			$(".edit").css("display","inline");	
			
			$("#blankDv").css("display","inline");
			edit = true;
		}else{
			modify();
			edit = false;
		}
		
	}
</script>
<style type="text/css">
body {
	background-image: url('../${ctxPat}/images/shop.jpg');
	background-size: 100% 100%;
}
.edit{
	display : none;
	height : 29px;
	font-size : 20px;
}
table {
	color: white;
	background-color: black;
	opacity: 0.7;
	font-weight : bold;
	border : 10px solid #696969;
	font-size : 25px;
}
#title{
	font-size : 50px;
	font-weight : bold;
}

td {
	padding: 5px;
	text-align : center;
}
#fTable{
	float : left;
	margin-left : 40px;
	
}
#sTable{
	float : right;
	margin-right : 40px;
}
#edit{
	float : right;
}
#cstmrName,#eyeCheck{
	font-size : 29px;
}

.h{
	border-bottom : 1px solid white;
	padding-bottom :10px;
}
#blank{
	font-size : 10px;
}
#a{
	font-size : 15px;
}
 #blankDv{
	display: none;
} 
a:link{
	text-decoration : none;
	color : white;
}
#pwd{
	position : absolute;
	font-size: 25px;
	font-weight: bold;
}
</style>
</head>
<body>
				<Center><span id="title">갤러리 회원정보</span></Center> 
				<br>
	<!-- <table width="100%"> 	
		
			<tr>
				<Td colspan="4" align="right">보유쿠폰 <a href="javascript:showMyCoupon()"><span id="coupon"></span></a></Td>
			</tr>
			<Tr>
				<Td colspan="2" class="td1"><span id="cstmrName" ></span></Td><Td colspan="2"  align="right"><span id="cstmrCd"></span></Td>
			</Tr>
			<tr>
				<Td  class="td1" colspan="4" align="right">생년월일 <span id="birthDay"></span></td>
			</tr>
			<tr>
				<Td class="td1">전화 </td><td><span id="cellphone"></span> <a href="javascript:showEdit('cellphone')"><span id="cellphoneM">수정</span></a><span id="cellphone_" name="cellphone_"><input type="text" id="cellphone2" name="cellphone2"> <a href="javascript:modify('cellphone2')">확인</span></Td><td>e-mail</td><td><span id="email"></span> <a href="javascript:showEdit('email')"><span id="emailM">수정</span></a><span id="email_" name="email_"><input type="text" id="email2" name="email2"> <a href="javascript:modify('email2')">확인</span></td>
			</tr>
			<tr>
				<td class="td1">사는 곳</td><td colspan="3"><span id="addr"></span> <a href="javascript:showEdit('addr')"><span id="addrM">수정</span></a><span id="addr_" name="addr_"><input type="text" id="addr2" name="addr2"> <a href="javascript:modify('addr2')">확인</span></td>
			</tr>
			<Tr>
			<Td class="td1">시력검사</Td><Td colspan="3">마지막 검사일로 부터&nbsp;<span id="datetime"></span><font style="color: red">개월</font> 지났습니다.<br>
										   (시력검사는 6개월에 한번하시는 것이 좋습니다.)<td>
			<Tr>
				<Td calssd="td1">현재 이용중인 SNS</Td> <td><span id="sns"></span></td> <Td colspan="2" align="right"><a href="javascript:modifyPwd()">비밀번호 변경</a></Td>
			</Tr>
			<tr>
				<Td class="td1">G-Point &nbsp; <span id="point"></span></Td> <td colspan="3">갤러리 안경에서 총 <span id="buyCount"></span>회 제품을 구매하셨습니다. <a href="javascript:showBuyList()">(내역보기)</a></td>
			</tr>
	</table> -->
	
	
	<table width="40%" id="fTable"> 	
		<Tr>
			<td class='h'><img src="../${ctx }images/pen.png" id="edit" onclick="editItem();"><span id="cstmrName">&nbsp;	</span></td>
		</Tr>
		<Tr>
			<td  ><span id="blank">&nbsp;	</span></td>
		</Tr>
		<Tr>
			<td  ><span id="cstmrCd">&nbsp;	</span></td>
		</Tr>
		<Tr>
			<td><span id="birthDay">&nbsp;	</span></td>
		</Tr>
		<Tr>
			<td><span id="email" class='show'>&nbsp;	</span><input type="text" id="email_" class='edit'> </td>
		</Tr>
		<Tr>
			<td><span id="cellphone" class='show'>&nbsp;	</span><input type="text" id="cellphone_" class='edit'> </td>
		</Tr>
		
		<Tr>
			<td ><span id="addr" class='show'>&nbsp;	</span><input type="text" id="addr_" class='edit'> </td>
		</Tr>
		<Tr>
			<td  class='h'><span id="blank">&nbsp;	</span></td>
		</Tr>
		<Tr>
			<td>G-Point&nbsp;<span id="point">&nbsp;	</span>&nbsp; 쿠폰 &nbsp;<a href='javascript:showMyCoupon()' ><span id="coupon"> </span></a>장</td>
		</Tr>
	</table>
	
	
	<table width="40%" id="sTable"> 	
		<Tr>
			<td class='h'><span id="eyeCheck">Gallery Eyecare</span></td>
		</Tr>
		<Tr>
			<td  ><span id="blank">&nbsp;	</span></td>
		</Tr>
		<Tr>
			<td>최종검사&nbsp;&nbsp;<span id="datetime">&nbsp;	</span></td>
		</Tr>
		<Tr>
			<td><span id="shop">&nbsp;	</span></td>
		</Tr>
		<Tr>
			<td><span id="staff">&nbsp;	</span></td>
		</Tr>
		<Tr>
			<td><a href="javascript:showCheckResult()" id="eye">시력 측정 결과</a></td>
		</Tr>
		<Tr>
			<td><span id="reCheck">&nbsp;	</span></td>
		</Tr>
		<Tr>
			<td><span id="a">&nbsp;	</span></td>
		</Tr>
		<Tr>
			<td  class='h'><span id="blank">&nbsp;	</span></td>
		</Tr>
		<tr>
			<Td><span id="buyCount"></span>회 구매 <a href="javascript:showBuyList()" id='history'>(내역)</a></td>
		</tr>
	</table>
	<div id="blankDv">
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>	<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>	<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		
	</div>
	<a href="javascript:modifyPwd()" id="pwd">비밀번호 변경</a>
</body>
</html>