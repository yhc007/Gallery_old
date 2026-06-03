<%@ page language="java" pageEncoding="UTF-8"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" scope="request"/>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script>
//화면 초기 실행
window.onload = onLoadEvent;
function onLoadEvent() {
	var OS = navigator.platform;
	var SN ='${SN}';
	if(OS.match(/Win/)){
		console.log('check Win.');
		console.log('join to Security Routine.');
		//fncSecu();
	}else if(OS.match(/Mac/)){
		console.log('check MacOS.');
		console.log('join to Security Routine.');
	}else if(OS.match(/iP/)){
		console.log('check iOS.');
		console.log('join to Security Routine.');
		//fncDvcSecu(SN);
	}else if(OS.match(/arm/)){
		console.log('check android.');
		console.log('join to Security Routine.');
		fncDvcSecu(SN);
	}else{
		
	}
//});
}

function fncDvcSecu(sn)
{
	var url = "${ctxPath}/secu/dvc.do";
	var param = "sn=" + sn;// + "&ip=" + ip;
	
	$.ajax({
		url : url,
		dataType : "text",
		type : "post",
		data : param,
		success : function(data){
			if(data.trim()!="success"){
				console.log("인증되지 않은 기기 입니다.");
				//alert("접근이 거부되었습니다.\n문의 전화 : 051-442-0335");
			
				//document.getElementById("rst").innerHTML="인증되지 않은 PC입니다";
				//window.location.href="http://www.daum.net/";
				//window.location.replace("http://www.daum.net/");
			}else{
				console.log("인증된 PC 입니다.");
				//document.getElementById("rst").innerHTML="인증된 PC입니다";
			}
		}
	});
}

function fncSecu()
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
		
		//alert("접근이 거부되었습니다.\n문의 전화 : 051-442-0335");
		//window.location.replace("http://www.daum.net/");
	});

	socket.addEventListener("close", function(event) {
		//open.disabled = false;
		//status.textContent = "Not Connected";
		console.log("close:"+event.data);
		//alert("접근이 거부되었습니다.\n문의 전화 : 051-442-0335");
		//window.location.replace("http://www.daum.net/");

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
				
				//alert("접근이 거부되었습니다.\n문의 전화 : 051-442-0335");
				//window.location.replace("http://www.daum.net/");
			}else{
				console.log("인증된 PC 입니다.");
				//document.getElementById("rst").innerHTML="인증된 PC입니다";
			}
		}
	});
}

function fncCancel() {
	jQuery('#dialog').dialog('close');
	jQuery('#dialog').html('');
};	
</script>
