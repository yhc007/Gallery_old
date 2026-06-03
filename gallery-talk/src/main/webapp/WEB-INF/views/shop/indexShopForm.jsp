<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/dvcLib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<!-- 
<link rel="stylesheet" type="text/css" href="${ctxPath}/css/SpryAssets/SpryValidationTextarea.css" />
<script src="${ctxPath}/css/SpryAssets/SpryValidationTextarea.css" type="text/javascript"></script>
 -->

<script>

	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function() {
		//fncSecu();
	});
	
	
	function fncSecu()
	{
/* 		var status = document.getElementById("status");
		
		var open = document.getElementById("open");
		var close = document.getElementById("close");
		var send = document.getElementById("send");
		var text = document.getElementById("text");
		var message = document.getElementById("message");
 */		
		var url;
		var socket;

		//status.textContent = "Not Connected";
		url = "ws://localhost:10002";
		//close.disabled = true;
		//send.disabled = true;

		//open.disabled = true;
		socket = new WebSocket(url, "echo-protocol");

		socket.addEventListener("open", function(event) {
			//close.disabled = false;
			//send.disabled = false;
			//status.textContent = "Connected";

			socket.send("g");
			//text.value = "g";
		});

		socket.addEventListener("message", function(event) {
			//message.textContent = "Server Says: " + event.data;
			console.log("event.data:"+event.data);
			
			//var json = '{"result":true,"count":1}',
		    obj = JSON.parse(event.data);

		    console.log("obj:"+obj);
			console.log("obj.sn:"+obj.sn);
			console.log("obj.mac:"+obj.mac);
			console.log("obj.ip:"+obj.ip);
			goAuth(obj.sn,obj.mac, obj.ip);
		});

		socket.addEventListener("error", function(event) {
			//message.textContent = "Error: " + event;
		});

		socket.addEventListener("close", function(event) {
			//open.disabled = false;
			//status.textContent = "Not Connected";
		});
	}
	//----------------------
	var mCstmrCd;
	function fncSelectCstmr(cstmrCd) {
		mCstmrCd = cstmrCd;
	};
	
	function goAuth(sn, mac, ip){
		
		console.log("sn:"+sn);
		console.log("mac:"+mac);
		console.log("ip:"+ip);
		
		var url = "${ctxPath}/secu/auth.do";
		var param = "sn=" + sn + "&mac=" + mac;// + "&ip=" + ip;
		
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				if(data.trim()!="success"){
					alert("인증되지 않은 PC입니다.");
					window.location.href="http://www.daum.net/";
				}
			}
		});
	}
	
	function fncCancel() {
		jQuery('#dialog').dialog('close');
		jQuery('#dialog').html('');
		/*
		jQuery('#dialog').dialog( 'close' );
		jQuery('#dialog').html('');
		 */
	};

	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	var loginShopId;
	function fncGoStaffPage(shopId) {
		loginShopId = shopId;
		
		$("#chkPWd").dialog({
			title : "비밀번호",
			modal : true,
			width : 300,
			background : "#000",
			position : {my : "center", at : "middle", of : window},
			close : function(event, ui){
			}, success : function(data){
				
			}
		});

		
	};
	
	function goStaff(){
		var pwd = $("#pwd").val();
		var param = "shopId=" + loginShopId + 
					"&pwd=" + pwd;
		
		var url = "${ctxPath}/shop/getShopPwd.do";
		
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				if(data.trim()=="success"){
					var form = document.createElement("form");
					form.name = 'tempPost';
					form.method = 'post';
					form.action = '${ctxPath}/staff/indexStaffForm.do';

					var input = document.createElement("input");
					input.type = "hidden";
					input.name = 'shopId';
					input.value = loginShopId;
					$(form).append(input);
					$('#body').append(form);
					form.submit(); 
				}else{
					alert("비밀번호가 일치하지 않습니다.");
				}
			}
		});
	}

	function goCstmrListPage() {
		if (!fncCheckValidation()) {
			return;
		}

		var form = document.createElement("form");
		form.name = 'tempPost';
		form.method = 'post';
		form.action = '${ctxPath}/cstmr/cstmrListForm.do';

		var param = document.createElement("input");
		param.setAttribute("type", "hidden");
		param.setAttribute("name", "cstmrName");
		param.setAttribute("value", jQuery(
				'#cstmrSearchForm input[name=cstmrName]').val());
		$(form).append(param);
		$('#body').append(form);
		form.submit();
	};
</script>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>GalleryStaffWeb</title>
<style type="text/css">
	#chkPWd{
		display: none;
	}
</style>
</head>

<body>
	<center>
		<div class="transBoxTable">
			<table class="listShop" width="800" border="0.5">
				<tr>
					<td height="78" colspan="5"><div class="head_title">
					Gallery	Eyewear</br>
					Cloud System</div></td>
				</tr>
				<tr>
					<td height="24" colspan="5">&nbsp;</td>					
				</tr>
				<tr>
					<td height="3" colspan="5"><img
						src="<c:url value="/images/content/GrayLine.jpg" />" width="800"
						height="1" /></td>
				</tr>
				<tr>
					<td height="63" colspan="5" class="title">갤러리안경</td>
				</tr>
			</table>

			<table class="listShop" width="800" border="0.5">
				<tr>
					<td height="3" colspan="4"><img
						src="<c:url value="/images/content/GrayLine.jpg" />" width="800"
						height="1" /></td>
				</tr>
				<%-- <tr onclick="fncGoStaffPage('${shop.shopId}');return false;" class="listData"> --%>
				<tr>
					<c:choose>
						<c:when test="${!empty listShop}">
							<c:forEach var="shop" items="${listShop}" varStatus="status">

								<!-- 
				    <td>${pp.countItem - (pp.maxResults * (pp.currentPage - 1) + (status.count - 1))} </td>
				     -->
								<td onclick="fncGoStaffPage('${shop.shopId}');return false;"
									class="listData" height="66">${shop.shopName }</td>
								<c:if test="${0==((status.count)%4)}">
				</tr>
				<tr>
					</c:if>


					</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4" align="center">매장 데이터가 없습니다.</td>
						</tr>
					</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td height="3" colspan="4"><img
						src="<c:url value="/images/content/GrayLine.jpg" />" width="800"
						height="1" /></td>
				</tr>
				<tr>
					<td height="69" colspan="4">&nbsp;</td>
				</tr>
				<tr>
			</table>
		</div>

		<table width="800" border="0.5">

			<tr>
				<td width="206">&nbsp;</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td><div class="listShop">Copyright (c) 2013 UNOMIC All right reserved.</div></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>

	</center>

<div id="chkPWd">
	<center>
		<input type="password" id="pwd" onKeyPress="javascript:if(event.keyCode == 13) { goStaff() }"><br>
		<button id="pwdBtn" onclick="goStaff()">확인</button>
	</center>
</div>
</body>
</html>
