<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/securityLib.jsp"%>

<script src="${ctxPath}/js/jq/jquery-1.8.3.min.js"></script>
<script src="${ctxPath}/js/jqMobile/jquery.mobile-1.2.1.min.js"></script>

<link rel="stylesheet" href="${ctxPath}/js/jqMobile/jquery.mobile-1.2.1.min.css" />
<link rel="stylesheet" type="text/css" href="${ctxPath}/css/staffTableForm.css">

<script>

	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function() {
		var n = 1000*60*10;
		setInterval(function(){
			var shopId = window.sessionStorage.getItem("gShopId");
			if(shopId==''||shopId=='"null"'){
				shopId=-1
			}
			$.ajax({
				url : "${ctxPath}/staff/sessionMaintain.do",
				data : "shopId=" + shopId,
				type : "post",
				success : function(){
					console.log("session reset - shopForm");
				}
			});
		},n);
		$("#chkPWd").bind({
			   popupafteropen: function(event, ui) {
				   console.log("popup AfterOpen");
					jQuery("#pwd").focus();
			   }
		});
		
		//document.getElementById("rst").innerHTML="인증 준비중입니다.";
		/* var OS = navigator.platform;
		//console.log('OS:'+OS);
		var SN ='${SN}';
		if(OS.match(/Win/)){
			//window Win
			fncSecu();
		}else if(OS.match(/Mac/)){
			fncDvcSecu(SN);
		}else if(OS.match(/iP/)){
		}else if(OS.match(/arm/)){
			fncDvcSecu(SN);
		}else{
			
		} */
		
		//GoogleAnalyticsObject
		(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

		ga('create', 'UA-46056835-1', 'auto');
		ga('send', 'pageview');
		
	});
	
	//----------------------
	
	//var listShop = '${listShop}';
	var mCstmrCd;
	function fncSelectCstmr(cstmrCd) {
		mCstmrCd = cstmrCd;
	};
	
	/* function goAuth(sn, mac, ip){
		
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
					alert("접근이 거부되었습니다.\n문의 전화 : 051-442-0335");
					//window.location.href="http://www.daum.net/";
					location.replace("http://www.daum.net/");
				}
			}
		});
	} */
	
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
		console.log('run goStaff');
		
		$("#chkPWd").popup( "open");

		
		loginShopId = shopId;

	};
	
	
	function goStaff(){
		
		var pwd = $("#pwd").val();
		var param = "shopId=" + loginShopId + 
					"&pwd=" + pwd;
		
		var url = "${ctxPath}/shop/getShopPwd.do";
		
		var OS = navigator.platform;
		var OS_type = '';
		if(OS.match(/Win/)){
			OS_type='Win';
		}else if(OS.match(/Mac/)){
			console.log('check MacOS.');
			//URL+="?SN=UNOMIC_AND";
			OS_type='MacOS';
		}else if(OS.match(/iP/)){
			console.log('check iOS.');
			OS_type='iOS';
		}else if(OS.match(/arm/)){
			console.log('check android.');
			OS_type='android';
		}else{
			
		}
		
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
					
					var input2 = document.createElement("input");
					input2.type = "hidden";
					input2.name = 'osType';
					input2.value = OS_type;
					
					$(form).append(input);
					$('body').append(form);
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
		param.setAttribute("value", jQuery('#cstmrSearchForm input[name=cstmrName]').val());
		$(form).append(param);
		$('body').append(form);
		form.submit();
	};
	
	/* function fncDvcSecu(sn)
	{
		alert('run fncDvcSecu');
		var url = "${ctxPath}/secu/dvc.do";
		
		var param = "sn=" + sn;// + "&ip=" + ip;
		alert('param:'+param);
		
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				alert("data:"+data);
				if(data.trim()!="success"){
					alert("접근이 거부되었습니다.\n문의 전화 : 051-442-0335");
					//document.getElementById("rst").innerHTML="인증되지 않은 기기 입니다";
					//window.location.href="http://www.daum.net/";
					location.replace("http://www.daum.net/");
				}else{
					//alert("인증된 PC 입니다.");
					console.log("인증된 PC 입니다.");
					
					//document.getElementById("rst").innerHTML="인증된 기기 입니다";
				}
			}
		});
	} */
	
	/* function fncSecu()
	{
		var url;
		var socket;

		url = "ws://localhost:10002";
		socket = new WebSocket(url, "echo-protocol");

		socket.addEventListener("open", function(event) {
		socket.send("g");
		});

		socket.addEventListener("message", function(event) {
		    obj = JSON.parse(event.data);

		    console.log("obj:"+obj);
			console.log("obj.sn:"+obj.sn);
			console.log("obj.mac:"+obj.mac);
			console.log("obj.ip:"+obj.ip);
			goAuth(obj.sn,obj.mac, obj.ip);
		});

		socket.addEventListener("error", function(event) {
			//message.textContent = "Error: " + event;
			console.log("error:"+event.data);
			alert("접근이 거부되었습니다.\n문의 전화 : 051-442-0335");
			//document.getElementById("rst").innerHTML="인증되지 않은 PC입니다";
			//window.location.href="http://www.daum.net/";
			location.replace("http://www.daum.net/");
		});

		socket.addEventListener("close", function(event) {
			//open.disabled = false;
			//status.textContent = "Not Connected";
			console.log("close:"+event.data);
		});
		
	} */
	//----------------------
	var mCstmrCd;
	function fncSelectCstmr(cstmrCd) {
		mCstmrCd = cstmrCd;
	};
	
	/* function goAuth(sn, mac, ip){
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
					alert("접근이 거부되었습니다.\n문의 전화 : 051-442-0335");
					location.replace("http://www.daum.net/");
				}else{
					//alert("인증된 PC 입니다.");
				}
			}
		});
	} */
	
	function fncCancel() {
		jQuery('#dialog').dialog('close');
		jQuery('#dialog').html('');
	};
	
</script>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>GalleryStaffWeb</title>
<style type="text/css">

</style>
</head>

<body>
	<center>
		<div class="transBoxTable" id='shopList'>
			<table class="listShop"  width="800" border="0.5">
				<tr>
					<td height="78" colspan="5"><div class="head_title">
							Gallery Eyewear Cloud System</div></td>
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
				<tr>
					<c:choose>
						<c:when test="${!empty listShop}">
							<c:forEach var="shop" items="${listShop}" varStatus="status">
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
					<td colspan="4"><div class="listShop">Copyright (c) 2013 UNOMIC All right reserved.</div></td>
				</tr>
				<tr>
			</table>
		</div>
	</center>

	<div data-role="popup" id="chkPWd" data-theme="a" class="ui-corner-all"">
		<a href="#" data-rel="back" data-role="button" data-theme="a"
			data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
		<form>
			<div style="padding: 10px 20px;">
				<center><h3>로그인</h3></center>
				<label for="pwd" class="ui-hidden-accessible">Password:</label>
				<input type="password" name="pwd" id="pwd" value="" placeholder="password"
					data-theme="a" />
				<button id="pwdBtn" onclick="goStaff()">확인</button>
			</div>
		</form>
	</div>
</body>
</html>
