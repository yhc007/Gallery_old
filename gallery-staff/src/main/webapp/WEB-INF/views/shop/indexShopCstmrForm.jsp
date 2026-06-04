<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>
<head>

<link rel="stylesheet" type="text/css" href="${ctxPath}/css/staffTableForm.css">


<!-- <script src="http://code.jquery.com/jquery-1.8.3.min.js"></script> -->
<!-- <script src="http://code.jquery.com/mobile/1.2.1/jquery.mobile-1.2.1.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.2.1/jquery.mobile-1.2.1.min.css" /> -->

<script src="${ctxPath}/js/jq/jquery-1.8.3.min.js"></script>
<script src="${ctxPath}/js/jqMobile/jquery.mobile-1.2.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPath}/js/jqMobile/jquery.mobile-1.2.1.min.css">


<%@ include file="/WEB-INF/views/include/asLib.jsp"%>


<script>


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
					console.log("session reset - shopCstmr");
				}
			});
		},n);
		
		var width = window.innerWidth;
		var height = window.innerHeight;
		$("#loader").css("left",width/2-165);
		$("#loader").css("top",height/2-60);
		getVisitingCstmrListData();
		getHstryCstmrListData(1);
		//fncDateTile_init();	
		//checkCookie();
		getToday();
		
		initFlipHstry();
		
		goCstmrListPage2(); 
		$('input:radio[name="sexCd"]:input[value="00400001"]').attr("checked", true); 
		
		getNoticeInfo();
	});
	//----------------------
	var saleResult = '${saleVo.result}';
	var mCstmrCd;
	function fncSelectCstmr(cstmrCd) {
		mCstmrCd = cstmrCd;
	};
	
	function resetInputEye(param)
	{
		document.getElementById(param.id).value = '';
	}
	
	function fncCancel() {
		jQuery('#dialog').dialog('close');
		jQuery('#dialog').html('');
		/*
		jQuery('#dialog').dialog( 'close' );
		jQuery('#dialog').html('');
		 */
	};
	
	
	function checkCookie()
	{
	 //쿠키값이 있으면 element를 가려준다
	 //console.log('staffId:'+'${staffVo.staffId}');
	 var strCookie = 'galleryNotice1'+'${staffVo.staffId}';
	 //   	console.log('strCookie:'+strCookie);

	 	var val = getCookie(strCookie);
	 	console.log('cookie is :'+val);
	    if(val == "done"){
	    	console.log('cookie is done.');
	    }else{
	    	console.log("cookie isn't done.");
	    	runNotice();
	    }
	}
	
	function getCookie( name ) 
	{ 
	    var nameOfCookie = name + "="; 
	    var x = 0; 
	    while ( x <= document.cookie.length ) 
	    { 
	        var y = (x+nameOfCookie.length); 
	        if ( document.cookie.substring( x, y ) == nameOfCookie ) 
	        { 
	            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
	                endOfCookie = document.cookie.length;
	            return unescape( document.cookie.substring( y, endOfCookie ) ); 
	        } 
	        x = document.cookie.indexOf( " ", x ) + 1; 
	        if ( x == 0 ) 
	            break; 
	    } 
	    return ""; 
	}
	
	function runNotice()
	{
		console.log('runNotice()');
		var url = "${ctxPath}/notice/notice1.do";
	
		$.ajax({
		url : url,
		dataType : "html",
		type : "post",
		success : function(data){
			//console.log(data);
			jQuery('#popupNotice').html(data);
			jQuery('#popupNotice').dialog({
				//bgiframe: true
				 title: "공지사항"
				 , modal: true
			     , width: 450 // 가로 크기
			     , height : 'auto'
			     , background: "#000"
			     , position:{my:"center",at:"center",of:window }
				 , close: function(event, ui){
					
				}, success:  function(data) {
				} 
			});
			}
	});			
	}
	
	function getVisitingCstmrListData(){
		var url = '${ctxPath}/saleJob/listVisitingCstmrData.do';
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listVisitingCstmrDiv').html(data);
			}
		});  
	}
	
	function getHstryCstmrListData(today){
		var url = '${ctxPath}/shop/listHstryCstmrData.do';
		
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: "today="+today,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listHstryCstmrDiv').html(data);
			}
		});  
	}
	
	 function fncCheckValidation() {
			var searchText1 = document.getElementById("txtSearch1");
			var searchText2 = document.getElementById("txtSearch2");
			var searchText3 = document.getElementById("txtSearch3");
			var searchText4 = document.getElementById("txtSearch4");
			var searchText5 = document.getElementById("txtSearch5");
			var searchText6 = document.getElementById("txtSearch6");
			
			
			if (searchText1.value == "" && searchText2.value == "" && searchText3.value == ""
				&& searchText4.value == "" && searchText5.value == "" && searchText6.value == "") {
				alert('검색 조건을 1개 이상 입력 바랍니다.');
				return false;
			}else if(searchText1.value!="" && searchText1.value.length<2){
				alert('이름 검색시 2글자 이상 입력 바랍니다.');
				return false;
			}else if(searchText2.value!="" && ( searchText2.value.length != 4 && searchText2.value.length != 0)){
				alert('4자리 검색시 4글자만 입력해 주세요');
				return false;
			}else if(searchText3.value!="" && ( searchText3.value.length < 4 && searchText3.value.length != 0)){
				alert('전화번호 검색시 4글자 이상 입력 바랍니다.');
				return false;
			}else if(searchText4.value!="" && ( searchText4.value.length < 4 && searchText4.value.length != 0)){
				alert('전화번호 검색시 4글자 이상 입력 바랍니다.');
				return false;
			}
			if( searchText5.value!="" && ( searchText5.value.length < 5 && searchText5.value.length != 0)){
				alert('회원 번호는 5자리 이상 검색해 주세요.');
				return false;
			}
			if( searchText6.value!="" && ( searchText6.value.length < 5 && searchText6.value.length != 0)){
				alert('회원 번호는 5자리 이상 검색해 주세요.');
				return false;
			}
			return true;
		}
	
	function fncGoStaffPage(shopId){
		
		var form=document.createElement("form");
		  form.name='tempPost';
		  form.method='post';
		  form.action='${ctxPath}/staff/indexStaffForm.do';  
		  
		  var input=document.createElement("input");
		  input.type="hidden";
		  input.name='shopId';
		  input.value= shopId;
		  $(form).append(input);
		  $('body').append(form); 
		  form.submit();
	};
	
	function staffLogin(staffId) {
		
		var form = document.createElement("form");
		form.name = 'tempPost';
		form.method = 'post';
		form.action = '${ctxPath}/staff/staffLogin.do';

		var input=document.createElement("input");
		  input.type="hidden";
		  input.name='staffId';
		  input.value= staffId;
		  $(form).append(input);
		  $('body').append(form); 
		  form.submit();
	};

	
	/* function fncDateTile_init(){
		var date = new Date();
		var day = date.getDate();
		var month = date.getMonth() + 1;
		var year = date.getFullYear();

		if (month < 10) month = "0" + month;
		if (day < 10) day = "0" + day;

		var today = year + "." + month + "." + day;       
		window.sessionStorage.setItem("dateTile",today);
	} */	
	
	function galleryCummunity(){
		
		window.sessionStorage.setItem("back_flag","false");
		var form = document.createElement("form");
		document.body.appendChild(form);
		
		form.method = "post";
		
		
		form.action = "https://jaguar.s4g.kr/community/board/main.do";
		
		var input = document.createElement("input");
		input.type = "hidden";
		input.name = "shopTy";
		input.value = 1;
		
		var input2 = document.createElement("input");
		input2.type = "hidden";
		input2.name = "shopId";
		input2.value = ${shopVo.shopId};
		
		$(form).append(input);
		$(form).append(input2);
		
		$("#body").append(form);
		document.body.appendChild(form);
		form.submit();
	}
	
// 	function galleryManager(){
// 		$.ajax({
// 			url : 'https://jaguar.s4g.kr/Manager/admin/login.do',
// 			type : "post",
// 			dataType : "text",
// 			data : "id=" + "${shopVo.id}" + "&pwd=" + "${shopVo.pwd}" + "&shopTy="+"shop",
// 			success : function(data){
// 				if(data.trim()=="success"){
// 					location.href="https://jaguar.s4g.kr/Manager/chart/chart.do";
// 				}else if(data.trim()=="fail"){
// 					alert("ID혹은 비밀번호를 확인해 주세요.");
// 				}
// 			}
// 		}); 

// 	}
	
	function getToday()
	{
		var date = new Date();
		date.setHours(date.getHours() + 9);

		var day = date.getDate();
		var month = date.getMonth() + 1;
		var year = date.getFullYear();

		if (month < 10) month = "0" + month;
		if (day < 10) day = "0" + day;

		//var today = year + "." + month + "." + day;
		
		var totalSec = date.getTime() / 1000;
		var hours = parseInt( totalSec / 3600 ) % 24;
		var minutes = parseInt( totalSec / 60 ) % 60;
		var seconds = totalSec % 60;

		//var result = (hours < 10 ? "0" + hours : hours) + "-" + (minutes < 10 ? "0" + minutes : minutes) + "-" + (seconds  < 10 ? "0" + seconds : seconds);
		var result = (hours < 10 ? "0" + hours : hours) + "시" + (minutes < 10 ? "0" + minutes : minutes)+"분";
		
		var dateTime = year+'년 '+month+'월 '+day+'일 '+result;
		
		$("#crtTime").html(dateTime);  
		//console.log(year+'년 '+month+'월 '+day+'일 '+result);
	}
	
	
	function dlgSearchCstmr()
	{
		
		var url = '${ctxPath}/cstmr/cstmrListDlg.do';
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			//data 	: "cstmrId="+'${cstmrId}',
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				//jQuery('#dlgSearchResult').html('');
				jQuery('#dlgSearchResult').html(data);
			},error : function (e1,e2,e3){
				//console.log(e2)
			}
		});
		
		jQuery('#dlgSearchResult').dialog({
			title: '최근 검색',
			modal: true,
			width: "auto",
			height : "auto",
			background: "#000",
			position:{
				my:"left top",
				at:"left top",
				of:window },
			
		});
	}
	
	function goCstmrListPage() {
		console.log("goCstmrListPage");
		if (!fncCheckValidation()) {
			return;
		}
		
		console.log("pass Validation()");

		var cstmrName = document.getElementById("txtSearch1").value;
		var digit4 = document.getElementById("txtSearch2").value;
		var telephone = document.getElementById("txtSearch3").value;
		var cellphone = document.getElementById("txtSearch4").value;
		var cstmrCd = document.getElementById("txtSearch5").value;
		var fmlyCd = document.getElementById("txtSearch6").value;
		
		window.sessionStorage.setItem("textSearch1","");
		window.sessionStorage.setItem("textSearch2","");
		window.sessionStorage.setItem("textSearch3","");
		window.sessionStorage.setItem("textSearch4","");
		window.sessionStorage.setItem("textSearch5","");
		window.sessionStorage.setItem("textSearch6","");
		
		window.sessionStorage.setItem("textSearch1",cstmrName);
		window.sessionStorage.setItem("textSearch2",digit4);
		window.sessionStorage.setItem("textSearch3",telephone);
		window.sessionStorage.setItem("textSearch4",cellphone);
		window.sessionStorage.setItem("textSearch5",cstmrCd);
		window.sessionStorage.setItem("textSearch6",fmlyCd);
		
// 		console.log("cstmrName=" + cstmrName + "&digit4="+digit4+"&telephone="+telephone
// 			+"&cellphone=" + cellphone + "&cstmrCd="+cstmrCd+"&fmlyCd="+fmlyCd);
		var url = '${ctxPath}/cstmr/tableCstmrSearch.do';
		 
		//javax
		 $.ajax({
			url		: url,
			data : "cstmrName=" + cstmrName + "&digit4="+digit4+"&telephone="+telephone
					+"&cellphone=" + cellphone + "&cstmrCd="+cstmrCd+"&fmlyCd="+fmlyCd,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listSearchCstmrDiv').html(data);
			}
		});  


	};
	
	
	function goCstmrListPage2() {

		var cstmrName = window.sessionStorage.getItem("textSearch1");
		var digit4 = window.sessionStorage.getItem("textSearch2");
		var telephone = window.sessionStorage.getItem("textSearch3");
		var cellphone = window.sessionStorage.getItem("textSearch4");
		var cstmrCd = window.sessionStorage.getItem("textSearch5");
		var fmlyCd = window.sessionStorage.getItem("textSearch6");
		
		console.log("cstmrName=" + cstmrName + "&digit4="+digit4+"&telephone="+telephone
			+"&cellphone=" + cellphone + "&cstmrCd="+cstmrCd+"&fmlyCd="+fmlyCd);
		var url = '${ctxPath}/cstmr/tableCstmrSearch.do';
		 
		//javax
		 $.ajax({
			url		: url,
			data : "cstmrName=" + cstmrName + "&digit4="+digit4+"&telephone="+telephone
					+"&cellphone=" + cellphone + "&cstmrCd="+cstmrCd+"&fmlyCd="+fmlyCd,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listSearchCstmrDiv').html(data);
			}
		});  


	};
	
	function initFlipHstry(){
		$('#flip_hstry').slider();
		var val = window.sessionStorage.getItem("flip_hstry");
		if(val=='today'){
			$("#flip_hstry").val("today").slider("refresh");
			getHstryCstmrListData(1);
			window.sessionStorage.setItem("flip_hstry",val);
		}else{
			$("#flip_hstry").val("yesday").slider("refresh");
			getHstryCstmrListData(2);
			window.sessionStorage.setItem("flip_hstry",val);
		}
	}
	
	function setToggle(){
		
		var val = $( "#flip_hstry option:selected" ).val();
		console.log("run setToggle val:"+val);
		
		if(val=='today'){
			getHstryCstmrListData(1);
			window.sessionStorage.setItem("flip_hstry",val);
		//'yesday'
		}else{
			getHstryCstmrListData(2);
			window.sessionStorage.setItem("flip_hstry",val);
		}
		
	}
	function reload(){
		var val = $( "#flip_hstry option:selected" ).val();
		console.log("run reload val:"+val);
		if(val=='today'){
			getHstryCstmrListData(1);
			window.sessionStorage.setItem("flip_hstry",val);
		//'yesday'
		}else{
			getHstryCstmrListData(2);
			window.sessionStorage.setItem("flip_hstry",val);
		}
	}
	

	function loadCstmrChart(cstmrId) {
		$("#loader").css("display","block");
		window.sessionStorage.setItem("cstmrId", cstmrId);
		var cstmrChartId = window.sessionStorage.getItem("cstmrChart");
		console.log("session cstmrChart:" + cstmrChartId);
		//$.mobile.changePage('${ctxPath}/sale/indexSaleForm.do?cstmrId='+cstmrId,{transition:"slide"});

		/* if(cstmrChartId!=cstmrId){ */
			console.log("get cstmrChart");
			var url = '${ctxPath}/sale/indexSaleForm.do';
			$.ajax({
				url : url,
				type : "post",
				data : "cstmrId=" + cstmrId,
				dataType : "html",
				success : function(data) {
					//console.log("getChartData : " + data)
					$("#loader").css("display","none");
					jQuery('#cstmrChart').html('');
					jQuery('#cstmrChart').html(data);
					window.sessionStorage.setItem("cstmrChart",cstmrId);
					console.log("success indexSaleForm");
					$.mobile.changePage("#cstmrPage",{transition:"none"});
				},
				error:function(request,status,error){
					$("#loader").css("display","none");
			        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			        alert('실패. 재시도 바랍니다.');
			    }
			     
			});
		/* }else{
			console.log("didn't get cstmrChart");
			$.mobile.changePage("#cstmrPage",{transition:"slide"});
		} */
		
			var rmvUrl = '${ctxPath}/shop/removeCstmrShopHstry.do';
			var shopId=-1;
			
			if('${shopVo.shopId}'==''||'${shopVo.shopId}'=='"null"')
				shopId=window.sessionStorage.getItem("gShopId");
			else
				shopId=parseInt('${shopVo.shopId}')
				
			$.ajax({
				url : rmvUrl,
				type : "post",
				data : "shopId=" + shopId,
				dataType : "text",
				success : function(data) {
					if(data=="success"){
						console.log('방문 기록 삭제 성공');
					}else{
						console.log('방문 기록 삭제 실패');
					}
				}
			});

	};
	
	function getJoinForm(){
		$("#joinForm").popup("open");
		$("#joinForm input[id='cstmrNameJoin']").val($('#txtSearch1').val());
		$("#joinForm input[id='cellJoin3']").val($('#txtSearch2').val());
		
	}
	
	function addZero(str){
		if(str.length=="1"){
			str = "0" + str;
		}
		return str;
	}
	
	function join(){

		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
		if(regExp.test($("#joinForm input[id='cstmrNameJoin']").val())){
			alert("이름에는 특수문자를 사용할 수 없습니다.")	
			return;
		}
		$("#submit").button("disable");
		var cstmrName = $("#joinForm input[id='cstmrNameJoin']").val();
		var tel1 = $("#joinForm input[id='telJoin1']").val();
		var tel2 = $("#joinForm input[id='telJoin2']").val();
		var tel3 = $("#joinForm input[id='telJoin3']").val();
		var cell1 = $("#joinForm input[id='cellJoin1']").val();
		var cell2 = $("#joinForm input[id='cellJoin2']").val();
		var cell3 = $("#joinForm input[id='cellJoin3']").val();
		var email = $("#joinForm input[id='emailJoin']").val();
		var birthDayTyCd = $("#joinForm select[id='birthDayTyCdJoin']").val();
		var byear = $("#joinForm select[id='byearJoin']").val();
		var bmonth = $("#joinForm select[id='bmonthJoin']").val();
		var bday = $("#joinForm select[id='bdayJoin']").val();
		var addr = $("#joinForm input[id='addrJoin']").val();
		var sexCd =  $('input:radio[name="sexCd"]:checked').val();
		var birthDay = byear + "." + addZero(bmonth) + "." + addZero(bday);
		var telephone = tel1 + "-" + tel2 + "-" + tel3;
		var cellphone = cell1 + "-" + cell2 + "-" + cell3;
		var digit4 = cell3;
		if(telephone=="--"){
			telephone = "";
		}
		if(cellphone=="--"){
			cellphone = "";
		}
		if(birthDay==".."){
			birthDay = "";
		}
		
		
		var param = "cstmrName=" + cstmrName +
					"&telephone=" + telephone + 
					"&cellphone=" + cellphone + 
					"&birthDayTyCd=" + birthDayTyCd +
					"&birthDay=" + birthDay +
					"&addr=" + addr + 
					"&sexCd=" + sexCd + 
					"&email=" + email + 
					"&digit4=" + digit4;
					
		
		var url = "${ctxPath}/cstmr/joinChk.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				if(data.trim()!="0"){
					if(confirm("이미 가입되어있습니다. 진행하시겠습니까?")==false){
						$("#submit").button("enable");
						return;
					}
					addCstmr();
				}else{
					addCstmr();
				}
			}
		});
	}
	
	function addCstmr(){
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
		if(regExp.test($("#joinForm input[id='cstmrNameJoin']").val())){
			alert("이름에는 특수문자를 사용할 수 없습니다.")	
			return;
		}
		var cstmrName = $("#joinForm input[id='cstmrNameJoin']").val();
		var tel1 = $("#joinForm input[id='telJoin1']").val();
		var tel2 = $("#joinForm input[id='telJoin2']").val();
		var tel3 = $("#joinForm input[id='telJoin3']").val();
		var cell1 = $("#joinForm input[id='cellJoin1']").val();
		var cell2 = $("#joinForm input[id='cellJoin2']").val();
		var cell3 = $("#joinForm input[id='cellJoin3']").val();
		var email = $("#joinForm input[id='emailJoin']").val();
		var birthDayTyCd = $("#joinForm select[id='birthDayTyCdJoin']").val();
		var byear = $("#joinForm select[id='byearJoin']").val();
		var bmonth = $("#joinForm select[id='bmonthJoin']").val();
		var bday = $("#joinForm select[id='bdayJoin']").val();
		var addr = $("#joinForm input[id='addrJoin']").val();
		var sexCd =  $('input:radio[name="sexCd"]:checked').val();
		var birthDay = byear + "." + addZero(bmonth) + "." + addZero(bday);
		var telephone = tel1 + "-" + tel2 + "-" + tel3;
		var cellphone = cell1 + "-" + cell2 + "-" + cell3;
		var digit4 = cell3;
		if(telephone=="--"){
			telephone = "";
		}
		if(cellphone=="--"){
			cellphone = "";
		}
		if(birthDay==".."){
			birthDay = "";
		}
		
		var getSmsJoin;
		var getEmailJoin;
		var getCouponJoin;
		var getDmJoin;
		if($('#getSmsJoin').prop('checked')){
			getSmsJoin='Y';
		}else{
			getSmsJoin='N';
		}
		if($('#getEmailJoin').prop('checked')){
			getEmailJoin = 'Y';
		}else{
			getEmailJoin = 'N';
		}
		/* if($('#getCouponJoin').prop('checked')){
			getCouponJoin ='Y';
		}else{
			getCouponJoin ='N';
		} */
		if($('#getDmJoin').prop('checked')){
			getDmJoin ='Y';
		}else{
			getDmJoin ='N';
		}
		var param = "cstmrName=" + cstmrName +
						"&telephone=" + telephone + 
						"&cellphone=" + cellphone + 
						"&birthDayTyCd=" + birthDayTyCd +
						"&birthDay=" + birthDay +
						"&addr=" + addr + 
						"&sexCd=" + sexCd + 
						"&email=" + email + 
						"&digit4=" + digit4 +
						"&getSmsYn=" + getSmsJoin +
						"&getEmailYn=" + getEmailJoin +
						"&getDmYn=" + getDmJoin;
		
		var url = "${ctxPath}/cstmr/mAddCstmrAction.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : 'post',
			success : function(data){
				//console.log(data);
				var item = data.split(",");
				loadCstmrChart(item[2]);
				clearForm();
				$("#submit").button("enable");
			}
		});
		
	}
	function clearForm(){
		$("#joinForm input[id='cstmrNameJoin']").val("");
		$("#joinForm input[id='telJoin1']").val("");
		$("#joinForm input[id='telJoin2']").val("");
		$("#joinForm input[id='telJoin3']").val("");
		$("#joinForm input[id='cellJoin1']").val("");
		$("#joinForm input[id='cellJoin2']").val("");
		$("#joinForm input[id='cellJoin3']").val("");
		$("#joinForm input[id='emailJoin']").val("");
		$("#joinForm select[id='birthDayTyCdJoin']").val();
		$("#joinForm select[id='byearJoin']").val("").change();
		$("#joinForm select[id='bmonthJoin']").val("").change();
		$("#joinForm select[id='bdayJoin']").val("").change();
		$("#joinForm input[id='addrJoin']").val("");
		$('input:radio[name="sexCd"]:checked').val();
	}
	
	function closePopup(){
		$("#joinForm").popup("close");
	}
	
	
	function chkPrePage(){
		var url = location.href;
		var refresh = window.sessionStorage.getItem("refresh");
		if(url.indexOf("cstmrPage")=="-1"){
			if(refresh=="false"){
				window.sessionStorage.setItem("refresh", "true");
			}
		}else{
			if(refresh=="false"){
				window.sessionStorage.setItem("refresh", "true");
			}else{
				var cstmrId = window.sessionStorage.getItem("cstmrId");
				loadCstmrChart(cstmrId);
			}
		}
	}
	
	/* get latest notice title to show */
	function getNoticeInfo(){
		var url = "${ctxPath}/board/getTitle.do";
		var contents = '<공지>';
		$.ajax({
			url : url,
			dataType : "json",
			type : "GET",
			success : function(title){
				for(var i=0; i<title.length; i++){
					contents += (i+1) + ". " + title[i] +"&nbsp;&nbsp;&nbsp;&nbsp;";
				}
				$('#noticeInfoShop').html(contents);
			}
		});
	}
</script>


<link rel="shortcut icon" href="${ctxPath }/images/dulink_favicon.ico">
<title>Gallery Cloud</title>

<style type="text/css">

#cmnt, #mng, #as{
		cursor: pointer;
}		

.transTable{
	border: 1px solid black;
	background: rgba(0, 0, 0, 0.8);
	width:100%;

}

.inputSearch {
	font-family: "Arial Black", Gadget, sans-serif;
	font-size: 1em;
	font-weight: bold;
	width:100px;
}

.listShop tr {
 	line-height: 28px;
 }
 
 .divShop{
 	min-height : 500px;
 	height:75vh;
 	overflow-y : scroll;
 }
.telInput{
	width : 100px !important;
}
.grayClass{
	background-color: #d3d3d3;
	color : black;
}
.whiteClass{
	background-color: #2E2E2E;
}
#loader{
	position : absolute;
	left :100px;
	display : none; 
	height : 25px;
	z-index:9;
}

</style>
</head>

<body onload="chkPrePage();">
	<center>
		<div data-role="page" id="shopPage">
			<div class="transBoxTable" width="800px">
				<table class="listShop" width="800px" border="0.5">
					<tr>
						<td width="20%" height="26" onclick="staffLogin(${staffVo.staffId}); return false;">매장고객</td>
						<td width="20%" height="26" onclick="galleryCummunity()" id='cmnt'>커뮤니티</td>
						<!-- <td width="114" height="26" onclick="dlgSearchCstmr()" id='srch'>최근검색</td>
						<td width="114">&nbsp;</td> -->
						<td width="20%" height="26" onclick="galleryManager()" id="mng"> 매장관리</td>
						<td width="20%" height="26" onclick="getAsBoard()" id="as"> A/S 관리</td>
						<td width="20%" height="26" onclick="fncGoStaffPage(${shopVo.shopId});return false;">Log-out</td>
					</tr>
					<tr>
						<td height="44" colspan="5">
							<div style="font-size:30px;">
									Gallery Eyewear Cloud System
								<!-- <p id='crtTime' style="color:yellow"></p> -->
							</div>
						</td>
					</tr>
					<tr> 
						<td height="24" colspan="5">
						<marquee id='noticeInfoShop' width="800px" style="cursor: pointer;" behavior="scroll" direction="left" scrollamount="6" onmouseover="this.stop()" onmouseout="this.start()" onclick="galleryCummunity()"></marquee>
						<!-- <marquee id='noticeInfoShop' width="800px" style="cursor: pointer;" behavior="scroll" direction="left" scrollamount="4" onmouseover="this.stop()" onmouseout="this.start()" onclick="galleryCummunity()"></marquee> -->
						</td>
					</tr>
				</table>				
				<div id=shopManager>
				<table class="listShop" width="800px" border="0.5">
					<tr>
						<td>
						<input type="text" class="inputSearch" id="txtSearch1" name="txtSearch"  placeholder="이름" autocomplete="off"
								style='font-size:1em;'
								onKeyPress="javascript:if(event.keyCode == 13) goCstmrListPage();"/>
						</td>
						<td>
						<input  type="text" class="inputSearch" id="txtSearch2" name="txtSearch"  placeholder="4자리" autocomplete="off"
								style='font-size:1em;'
								onKeyPress="if(event.keyCode == 13) goCstmrListPage();if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;"
						/>
						</td>
						<td>
						<input  type="text" class="inputSearch" id="txtSearch3" name="txtSearch"  placeholder="전화번호" autocomplete="off"
								style='font-size:1em;'
								onKeyPress="if(event.keyCode == 13) goCstmrListPage();if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;"
						/>
						<td>
						<input  type="text" class="inputSearch" id="txtSearch4" name="txtSearch"  placeholder="핸드폰" autocomplete="off"
								style='font-size:1em;'
								onKeyPress="if(event.keyCode == 13) goCstmrListPage();if (event.keyCode<48|| event.keyCode>57)  event.returnValue=false;"
						/>
						<td>
						<input  type="text" class="inputSearch" id="txtSearch5" name="txtSearch"  placeholder="회원코드" autocomplete="off"
								style='font-size:1em;'
								onKeyPress="javascript:if(event.keyCode == 13) goCstmrListPage();"/>
						</td>
						<td>
						<input  type="text" class="inputSearch" id="txtSearch6" name="txtSearch"  placeholder="가족코드" autocomplete="off"
								style='font-size:1em;'							
								onclick='resetInputEye(this);'
								onKeyPress="javascript:if(event.keyCode == 13) goCstmrListPage();"/>
						</td>
						<td>
						<input type="button" value="검색" class="inputSearch" onclick="goCstmrListPage();">
						</td>
						<td>
						<input type="button" value="가입" class="inputSearch" onclick="getJoinForm();">
						</td>
					</tr>
				</table>
				
				<img src="${ctxPath }/images/loader2.gif" id="loader">
					<!-- <div class="transTable" style="width:33%; float:left;" id="listHstryCstmrDiv"> -->
					<div class="transTable divShop" style="width:33%; float:left;">
						<table class="listShop" width="100%" border="0.5" >
						    <tr>
						      <td height="3" colspan="3"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
						    </tr>
						    <tr>
						    	<td height = "36px">최근조회고객
							    	<a href="#" onclick="reload(); return false;" data-role="button" data-icon="refresh" data-iconpos="notext" data-theme="a" data-inline="true"  data-mini="true">reload</a>
						    	</td>
							    <td colspan ='2'>
							    	
							    	<div data-role="fieldcontain" onchange="setToggle();return false;">
										<select name="flip_hstry" id="flip_hstry" data-role="slider" data-theme="a"  data-mini="true">
											<option value="today">오늘</option>
											<option value="yesday">어제</option>
										</select> 
									</div>
								</td>
						    </tr>
						</table>
						<div id="listHstryCstmrDiv">
						</div>
					</div>
					<div class="transTable divShop" style="width:33%; float:left;" id="listSearchCstmrDiv">
					<table class="listShop" width="100%" border="0.5">
						<tr>
					      <td height="3" colspan="3"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
					    </tr>
					    <tr>
					    	<td colspan="3" height="63px">검색고객</td>
					    </tr>
						<tr>
							<td colspan="3"><img
								src="<c:url value="/images/content/Whiteline.jpg" />" width="100%"
								height="1" /></td>
						</tr>
						<tr id="tr">
							<td width="30%">이름</td>
							<td width="30%">4자리</td>
							<td width="40%">생년월일</td>
						</tr>
						<tr>
							<td colspan="3"><img
								src="<c:url value="/images/content/Whiteline.jpg" />" width="100%"
								height="1" /></td>
						</tr>
						<tr>
							<td colspan="3"><img
								src="<c:url value="/images/content/Whiteline.jpg" />" width="100%"
								height="1" /></td>
						</tr>
						<tr>
							<td colspan="3" align="center">검색대기중..</td>
						</tr>
					</table>
					</div>
					
					<div class="transTable divShop" style="width:33%; float:left;" id="listVisitingCstmrDiv">
					</div>
				</div>
				<div id=regCstmr>
				
				</div>
			</div>
			
			<div data-role="popup" id="joinForm" class="ui-content" data-overlay-theme="b" data-theme="b" data-corners="false" style="padding:20px; width:'500px'">
			   <a href="#" data-rel="back" data-role="button" data-theme="a"
			data-icon="delete" data-iconpos="notext" class="ui-btn-right btn">Close</a>
			    <form action="" id="joinForm">
				    <table width='500px'>
				     	<tr>
				     		<tD>이름</tD><tD colspan="3" style="padding-left:5px;"><input id="cstmrNameJoin"> </tD>
				     	</tr>
				     	<tr>
				     		<tD>전화번호</tD>
				     		<tD style='padding-left:5px;'><input id='telJoin1'  class='telInput'></tD>
				     		<td><input id='telJoin2' class='telInput'></td>
				     		<td><input id='telJoin3' class='telInput'></tD>
				     	</tr>
				     	<tr>
				     		<tD>휴대전화</tD>
				     		<tD style='padding-left:5px;'><input id='cellJoin1'  class='telInput'></tD>
				     		<td><input id='cellJoin2' class='telInput'></td>
				     		<td><input id='cellJoin3' class='telInput'></tD>
				     	</tr>
				     	<tr>
				     		<td>이메일</td>
				     		<td colspan='3' style='padding-left:5px;'><input type='email' id='emailJoin'> </td>
				     	</tr>
				     	<tr>
				     		<tD>생일</tD>
				     		<td>
					     		<select id='birthDayTyCdJoin' data-mini='true' data-inline='true' data-native-menu='false' data-role="none">
					     			<option value='00600001'>양력</option>
					     			<option value='00600002'>음력</option>
					     		</select>
					     	</td>
					     	<td colspan='2'>	
					     		<div data-role='controlgroup' data-type='horizontal'>
					     			<select id='byearJoin' data-mini='true' data-inline='true' data-role="none">
					     				<option value=''>년</option>
										<c:forEach var='i' begin='0' end='${cyear}'>
											<option value='${cyear-i+1900}'>${cyear-i+1900}</option>
										</c:forEach>
<%-- 					     				<c:forEach var='year' begin='1900' end='2014' step='1'>
						     				<option value='${year }'>${year }</option>
						     			</c:forEach> --%>
						     		</select>
						     		<select id='bmonthJoin' data-mini='true' data-inline='true' data-role="none">
						     			<option value=''>월</option>
						     			<c:forEach var='month' begin='1' end='12' step='1'>
						     				<option value='${month }'>${month }</option>
						     			</c:forEach>
						     		</select>
						     		<select id='bdayJoin' data-mini='true' data-inline='true' data-role="none">
						     		<option value=''>일</option>
						     			<c:forEach var='day' begin='1' end='31' step='1'>
						     				<option value='${day }'>${day }</option>
						     			</c:forEach>
					     			</select>
					     		</div>
					     	</td>
				     	</tr>
				     	<tr>
				     		<td>주소</td>
				     		<td colspan='3' style='padding-left:5px;'><input type='text' id='addrJoin'></td>
				     	</tr>
				     	<tr>
				     		<td>성별</td>
				     		<td colspan='3' style='padding-left:5px;'>
				     			<div data-role='controlgroup' data-type='horizontal'>
				     				<label for='maleJoin'>남</label> <input type='radio' name='sexCd' value='00400001' id='maleJoin'>
				     				<label for='femaleJoin'>여</label> <input type='radio' name='sexCd' value='00400002' id='femaleJoin'>
				     			</div>
				     		</td>
				     		</tr>
						<tr>
				     		<td>정보수신</td>
				     		<td style='padding-left:5px;'>
				     				<label for='getSmsJoin'>sms</label> <input type='checkBox' name='getSmsJoin' id='getSmsJoin'>
				     		</td>
				     		<td style='padding-left:5px;'>
				     				<label for='getEmailJoin'>email</label> <input type='checkBox' name='getEmailJoin' id='getEmailJoin'>
				     		</td>
				     		<!-- <td style='padding-left:5px;'>
				     				<label for='getCouponJoin'>쿠폰</label> <input type='checkBox' name='getCouponJoin' id='getCouponJoin'>
				     		</td> -->
				     		<td style='padding-left:5px;'>
				     				<label for='getDmJoin'>DM</label> <input type='checkBox' name='getDmJoin' id='getDmJoin'>
				     		</td>
				     	</tr>
				     	<tr>
				     		<td colspan='2' align='center'>
				     			<button data-inline='true' id="submit" onclick='join(); return false;'>확인</button>
				     		</td>
				     		<td colspan='2' align='center'>
				     			<button data-inline='true' onclick='closePopup(); return false;'>취소</button> 
								<button data-inline='true' onclick='clearForm(); return false;'>초기화</button> 
				     		</td>
				     	</tr>
				    </table>
			    </form>
			</div>
		</div>
		
		<div data-role="page" id="cstmrPage">
			
			<div data-role="content" id="cstmrChart">
			</div>
		</div>

	</center>
	<div id='popupNotice'></div>	
	</body>
	<!-- <div id = "dlgSearchResult" hidden></div> -->
</html>