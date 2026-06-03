<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.css" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.js"></script> 

<script type="text/javascript" src="${ctxPath }/js/jq/jquery.tablesorter.js"></script> 
<script type="text/javascript" src="${ctxPath }/js/jq/jquery.tablesorter.widgets.js"></script>
<link rel="stylesheet" href="${ctxPath }/js/jq/theme.blue.css"/>
<link rel="stylesheet" href="${ctxPath }/js/jq/theme.dark.css"/>
<link rel="stylesheet" href="${ctxPath }/js/jq/theme.green.css"/>
<link rel="stylesheet" href="${ctxPath }/js/jq/theme.grey.css"/>
<link rel="stylesheet" href="${ctxPath }/js/jq/theme.ice.css"/>
<link rel="stylesheet" href="${ctxPath }/js/jq/theme.jui.css"/>

<!-- <script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->
<script>
	
	var shopLv = ${lv};
	var shopId = ${shopId};
	var shopName;
	var comName;
	var prdctName;
	$(function(){
		
		getShopName();
		getComOrderCnt();
		$("#order").val(prdctTy);
		getBrand();
		//checkCookie();
		if(prdctTy==1||prdctTy==3||prdctTy==4||prdctTy==5){
			$("#unRegItem").css("display","none");
		}else{
			$("#unRegItem").css("display","inline");
		}
		//getComPrdctList();
		getComList();
		getShopList();
		getCom();
		
		if(shopLv>=5){
			$("select[id='shopId']").removeAttr("disabled");
		}
		
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(String(date.getMonth() + 1));
		var day = addZero(String(date.getDate()));
	
		
		$("#sdate").val(year + "-" + month + "-" + day);
		$("#edate").val(year + "-" + month + "-" + day);
		
		
		
		getCntryList();
		getMtrlList();
		//getfunctionList();
		//getRate();
		//getLensList();
	});
	
	function getShopName(){
		var param = "shopId=" + shopId;
		var url = "${ctxPath}/prdct/getShopName.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : "json",
			type : "post",
			success : function(data){
				shopName = data.shopName;
			}
		});
	}
	
	function getComOrderCnt(){
		var param = "shopId=" + shopId;
		var url = "${ctxPath}/prdct/getComOrderCnt.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				if(data!="0"){
					var cnt = "승인되지 않은 매장주문 대행 건 : <span style='color:red'>" + data + "</span>건";	
				}
				
				$("#comOrderCnt").html(cnt);
			}
		});
	}
	
	var ORDERLIST = new Array();
	
	function addCnt(obj, spec){
		var cnt = $(obj).val();
		  
	   	console.log("도수 : " + spec);
	   	console.log("수량 : " + cnt);
	   if(chkArrayVal(spec,cnt)==true){
		   
	   }else{
		   var order = new Array();
		   order.push(spec, cnt);
		   ORDERLIST.push(order);   
	   } 
 	};
	
 	
 	function chkArrayVal(spec,cnt){
		var result = false;
		
 		for(var i = 0; i < ORDERLIST.length; i++){
				if(spec == ORDERLIST[i][0]){
					ORDERLIST[i][1] = cnt;
					result = true;
				}
 		}
				
 		return result;
 	}
 	
 	var totalOrder = 0;
 	function cntOrderList(){
 		for(var i = 0; i < ORDERLIST.length; i++){
			orderLens(ORDERLIST[i][0],ORDERLIST[i][1]);
			orderConfirm = false;	
 		}
 	}
 	
 	var orderConfirm = true;
	 	function orderLens(spec,cnt){
	 		if(orderConfirm){
	 			if(confirm("주문하시겠습니까?")==false){
		 			return;	
	 			}
	 		}
	 		
			var detail = nl2br($("#PrdctInfo3 textarea[id='detail']").val());
			var bc = $("#PrdctInfo3 input[id='BC']").val();
			var diam = $("#PrdctInfo3 input[id='diam']").val();
			var devide = $("#PrdctInfo3 select[id='devide']").val();
			if(devide=="-1" || typeof(devide)=="undefined"){
				devide = 0;
			}
			var dueMonth;
			
			var date = new Date();
			var month = date.getMonth() + 1;
			if(devide>=2){
				dueMonth = Number(month) + Number(devide)-1;
				if(dueMonth>12){
					dueMonth -= 12;
				}
			}
			
			if(typeof(dueMonth)=="undefined"){
				dueMonth = 0;
			}
			/* if(cnt==""){
				alert("수량을 입력하세요.");
				$("#PrdctInfo" + n +" input[id='cnt']").focus();
				return;
			} */
			
			if(bc==""){
				bc = null;
			};
			if(diam==""){
				diam = null;
			}
			
			/* if(confirm("주문하시겠습니까?\n수량 : " + cnt + "EA\n가격 : " + format(puchasPrc * cnt))==false){
				return;
			} */
			var url = "${ctxPath}/prdct/orderPrdct.do";
			var param = "id=" + comPrdctId + 
							"&shopId=" + shopId + 
							"&iNum=" + iNum + 
							"&PrdctId=" + prdctId +
							"&cnt=" + cnt +
							"&prdctTy=" + 3 + 
							"&detail=" + detail + 
							"&spec=" + spec + 
							"&BC=" + bc + 
							"&diam=" + diam +
							"&devide=" + devide + 
							"&dueMonth=" + dueMonth; 
			
			
	 		
	 		$.ajax({
	 			url : url,
	 			dataType : "text",
	 			data : param,
	 			type : "post",
	 			success : function(data){
	 				if(data=="success"){
	 					orderConfirm = false;
	 					totalOrder ++;
	 					if(totalOrder==ORDERLIST.length){
	 						orderConfirm = true;
	 						alert("주문이 완료되었습니다.");
	 						$(".detail").val("");
	 						$(".BC").val("");
	 						$(".diam").val("");
	 						$(".devide").val("-1").change();
	 						$("#dialog3").popup("close");
	 						totalOrder = 0;
	 						
	 						if(devide!=0){
	 							gcmToAdmin(devide);	
	 						}
	 						
	 						//CGM
	 						
	 						/* $.mobile.changePage("#orderDiv", {transition:"flow"}); */
		 					//var url = "http://jaguar.s4gallery.com/GalleryTalk/comm/sendMsg.do";
		 					var url = "http://106.240.234.114:8080/GalleryTalk/comm/sendMsg.do";
							var msg = shopName + "에서 " + prdctName + "을(를) " +  cnt + "개 주문하였습니다.";
							var param = "sendGid=S" + shopId + 
											"&sendName=" + shopName +
											"&rcvGid=C" + iNum + 
											"&msg=" + msg;
							
							$.ajax({
								url : encodeURI(url),
								data : param,
								dataType : "text",
								type : "post",
								success : function(){
									
								}
							});
							//$("#dialog" + n).dialog("close");
							$("#PrdctInfo3 input[id='cnt']").val("");
	 					}
	 				}
	 			}
	 		});
	 	}
	 	
	function getComOrderCnt(){
		var param = "shopId=" + shopId;
		var url = "${ctxPath}/prdct/getComOrderCnt.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				if(data!="0"){
					var cnt = "승인되지 않은 매장주문 대행 건 : <span style='color:red'>" + data + "</span>건";	
				}
				
				$("#comOrderCnt").html(cnt);
			}
		});
	}
	
	
	function checkCookie(){
		//쿠키값이 있으면 element를 가려준다

		console.log('IPaddr:'+'${myIP}');

		var strCookie = 'galleryNoticeShop'+'${myIP}';

		    console.log('strCookie:'+strCookie);



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

			var url = "${ctxPath}/admin/notice1.do";

			$.ajax({

				url : url,

				dataType : "html",

				type : "post",

				success : function(data) {
					//console.log(data);

					jQuery('#notice').html(data);
					jQuery("#popupNotice").popup('open');

					/* jQuery('#popupNotice').dialog({

						title : "공지사항"
						,modal : true
						,width : 450 // 가로 크기
						,height : 'auto'
						,background : "#000"
						,position : {
							my : "center",
							at : "center",
							of : window
						}
						,
						close : function(event, ui) {
						},
						success : function(data) {
						}
					}); */
				}
			});
		}
		
		

		function closeDlg(obj) {

			console.log('staffId:' + '${myIP}');

			if (obj == "1") {

				var strCookie = 'galleryNoticeShop'+'${myIP}';

				console.log('strCookie:' + strCookie);

				setCookie(strCookie, "done", 1);

			}

			$('#popupNotice').popup('close');

			//$('#popupNotice').dialog('destroy');

		}

		function setCookie(name, value, expiredays) {

			var todayDate = new Date();

			todayDate.setDate(todayDate.getDate() + expiredays);

			document.cookie = name + "=" + escape(value) + "; path=/; expires="
					+ todayDate.toGMTString() + ";"

		}
	function getUnPrdctList(){
		var mtrl = $("#unmtrl").val();
		var tyId = $("#unTyId1").val();
		var param = "mtrl=" + mtrl + 
						"&tyId=" +tyId + 
						"&shopTy=com";
		var url = "${ctxPath}/prdct/getLensList.do";
		
		console.log(param)
		$.ajax({
			url : url,
			data :param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#unprdctId").html(data);
			}
		});
	}
	
	var newPrdct = false;
	function getPrdctRate(){
		var mtrl = $("#unmtrl").val();
		var tyId = $("#unTyId1").val();
		var prdctId = $("#unprdctId").val();
		newPrdctId = prdctId;
		var prdctName= $("#unprdctId option:selected").text();
		var allPrdct = "false";
		if(prdctId=="-2"){
			$("#unnewPrdctName").css("display","inline");
			$("#unprdctId").css("display","none");
			newPrdct = true;
			allPrdct = "true";
		}else{
			$("#unnewRate").css("display","none");
			$("#unrate").css("display","inline");
		}
		
		var param = "mtrl=" + mtrl + "&tyId=" +tyId + "&prdctName=" + prdctName + "&allPrdct=" + allPrdct + 
						"&shopTy=com";
		var url = '${ctxPath}/prdct/getRate.do';
		 $.ajax({
				url: url,
				type : "post",
				data : param,
				dataType	: "html",
				beforeSend	: function(){
				},
				success		: function(data){
					$("#unrate").html(data);
				}
			});  
	}
	function getfunctionList(){
		var mtrl = $("#unmtrl").val();
		var param = "mtrl=" + mtrl + 
						"&shopTy=com";
		var url = '${ctxPath}/prdct/getFunction.do';
		
		
		$.ajax({
			url		: url,
			data : param,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#unTyId1").html(data);
			}	
		});  
		
	}
	
	
	function getMtrlList(){
		var url = '${ctxPath}/prdct/getMtrl.do';
		/* var brandId = $("#brandId").val();
		var param = "brandId=" + brandId; */
		
		$.ajax({
			url		: url,
			/* data : param, */
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#unmtrl").html(data);
			}	
		});  
	}
	
	function addZero(n){
		if(n.length=="1"){
			n = "0" + n;
		}
		return n;
	}
	
	
	function getCom(){
		var iNum = $("#srchCom").val();
		var url = "${ctxPath}/shop/getComListBySrch.do";
		var param = "iNum=" + iNum;
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#iNum_").html(data);
				$(".iNum").html(data);
			}
		});
		
	}
	//매장 리스트
	function getShopList(){
		var url = "${ctxPath}/shop/shopList.do";
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			success : function (data){
				$("#shopId").html(data);
				$("#shopId").val(shopId);
			}
		});
	}
	//거래처 리스트
	function getComList(){
		var url = '${ctxPath}/company/selectCompanyData.do';
	  	
		 $.ajax({
			url		: url,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#iNum").append(data);
				$("#iNumR").append(data);
				$("#uniNum").append(data);
			}	
		});  
	}
	
	var sort = "D";
	function getComPrdctList(ty){
		$("#prdctInfo").fadeOut(500);
		setTimeout(function(){
			
		
		var prdctTy = window.sessionStorage.getItem("prdct"); 
		if(prdctTy=="2"){
			$("#srchPrdct").css("display","none");
			$("#srchPrdct2").css("display","none");
			$("#lensDiv").css("display","inline");
			return;
		}
		var brandId = $("#brandId_").val();
		var prdctId = $("#prdctId_").val();
		var iNum = $("#iNum_").val();
		var puchasPrcF = $("#puchasPrcF").val();
		var puchasPrcT = $("#puchasPrcT").val();
		
		if(puchasPrcF==""){
			puchasPrcF = 0;
		}
		if(puchasPrcT==""){
			puchasPrcT = 0;
		}
		if(brandId=="-1" || brandId=="선택"){
			brandId = "";
		}
		if(prdctId=="-1" || prdctId=="선택" || prdctId==null){
			prdctId = "";
		}
		
		if(typeof(ty)=="undefined"){
			 ty = "updTime";
		}
	 	
		var param  = "sort=" + ty + sort + 
						 "&comTy=" + prdctTy +
						 "&brandId=" + brandId + 
						 "&prdctId=" + prdctId + 
						 "&iNum=" + iNum + 
						 "&puchasPrcF=" + puchasPrcF + 
						 "&puchasPrcT=" + puchasPrcT;
		
		
		var url = "${ctxPath}/prdct/getComPrdctList.do";
		if(sort=="D"){
			sort = "A";
		}else{
			sort = "D";
		}
		
		$.ajax({
			url : url,
			data : param,
			type : "post",
			dataType : "html",
			success :function(data){
				$("#prdctInfo").fadeIn(1000)
				$("#prdctInfo").html(data);
				$("#prdctInfo").tablesorter();
			}
		});
		},500)
	};
	
	
	function draw(){
		var output = "";
		var n = 0.00;
		var specTd_ = true;
		var textInput = false;
		var count = 0;
		var spec = 0.00;
		for(var i = 0; i < 10; i++){
				output += "<tr>";
			for(var j = 0; j < 20; j++){
				if(!textInput){
					if(count<=160){
						output += "<td class='specTd_'>" + Number(n).toFixed(2) +"</td>";	
					}else{
						output += "<td class='specTd_'></td>";
					}
						
					if(n<20 && specTd_){
						n += 0.25;
						count ++;
					}else{
						n = "";
						specTd_ = false;
						count ++;
					}
				}else{
					if(count<=180){
						output += "<td class='clensSpec' id='" + Number(spec).toFixed(2) + "'>&nbsp;</td>";	
						count ++;
						spec += 0.25;
					}else{
						output += "<td>&nbsp;</td>";
					}
				}
			}
				if(textInput){
					textInput = false;
				}else{
					textInput = true;
				}
				output += "</tr>";
		}
		$("#lensSpecTR").html(output);
		
		
		
		$(".clensSpec").click(function(){
			var lens = this.id;
			$(this).html("<input type='text' size=3 onBlur='addCnt(this,\"" + lens + "\")' class='specTd'>");
			$(this).children("input").focus();
		});
		
	};
	var puchasPrc;
	var iNum;
	function getEditForm(id){
		draw();
		
		ORDERLIST = new Array();
		$(".specTd").css("display","none");
		var prdctTy = window.sessionStorage.getItem("prdct");
		var param = "id=" + id + 
						"&comTy=" + prdctTy + 
						"&chkTy=show";
		var url = "${ctxPath}/invn/getComPrdctEditForm.do";
		
		$.ajax({
			url : url,
			dataType : "json",
			data : param,
			type : "post",
			success : function(data){
				console.log(data)
				iNum = data.inum;
				comName = data.comName;
				prdctName = data.prdctName;
				brandId = data.brandId;
				prdctId = data.prdctId;
				comPrdctId = data.id;
				$("#PrdctInfo" + prdctTy + " input[id='mnfCountry']").val(data.mnfCountry);
				$("#PrdctInfo" + prdctTy + " input[id='puchasPrc']").val(format(data.puchasPrc));
				puchasPrc = data.puchasPrc;
				$("#PrdctInfo" + prdctTy + " input[id='brandName']").val(data.brandName);
				$("#PrdctInfo" + prdctTy + " input[id='prdctName']").val(data.prdctName);
				$("#PrdctInfo" + prdctTy + " input[id='mtrlId']").val(data.mtrlName);
				$("#PrdctInfo" + prdctTy + " input[id='salePrc']").val(format(data.trdePrc));
				$("#PrdctInfo" + prdctTy + " input[id='prdctTy']").val(data.prdctTyName);
				$("#PrdctInfo" + prdctTy + " input[id='tyId']").val(data.tyId);
				$("#PrdctInfo" + prdctTy + " input[id='tyId1']").val(data.tyId1);
				$("#PrdctInfo" + prdctTy + " input[id='tyId2']").val(data.tyId2);
				$("#PrdctInfo" + prdctTy + " input[id='rate']").val(data.rate);
				$("#PrdctInfo" + prdctTy + " input[id='unit']").val(data.unit+"ml");
				$("#PrdctInfo" + prdctTy + " input[id='prdctShape']").val(data.prdctShapeName);
				$("#PrdctInfo" + prdctTy + " input[id='mtrl']").val(data.mtrl);
				$("#PrdctInfo" + prdctTy + " input[id='colorId']").val(data.colorName1);
				$("#PrdctInfo" + prdctTy + " input[id='colorId2']").val(data.colorName2);
				$("#PrdctInfo" + prdctTy + " input[id='url']").val(data.url);
				$("#PrdctInfo" + prdctTy + " textarea[id='memo']").val(data.memo);
				$("#img").html("<img src='" + data.urlStr + data.imgPath + "' class='prdctImg'>");
				
				/*  $('#dialog' + prdctTy).dialog({
						//bgiframe: true
						 title: "주문"
						 , modal: true
					     , width: 1100 // 가로 크기
					     , background: "#000"
					    	 , position:{my:"center",at:"top",of: window }
						 , close: function(event, ui){
							 $(".cnt").val("");
							 $(".detail").val("");
							 $(".spec").val("-1");
						}, success:  function(data) {
							
						} 
					}); */
					
				$("#dialog" + prdctTy).popup("open");
			}
		});
		
	}
	
	
	
	//nl2br
	function nl2br(str){  
   	 	return str.replace(/\n/g, "<br />");  
	} 
	
	function order(n){
		var cnt = $("#PrdctInfo" + n +" input[id='cnt']").val();
		var detail = nl2br($("#PrdctInfo" + n +" textarea[id='detail']").val());
		var spec = $("#PrdctInfo" + n +" select[id='spec']").val();
		var bc = $("#PrdctInfo" + n +" input[id='BC']").val();
		var diam = $("#PrdctInfo" + n +" input[id='diam']").val();
		var devide = $("#PrdctInfo" + n +" select[id='devide']").val();
		if(devide=="-1" || typeof(devide)=="undefined"){
			devide = 0;
		}
		var dueMonth;
		
		var date = new Date();
		var month = date.getMonth() + 1;
		if(devide>=2){
			dueMonth = Number(month) + Number(devide)-1;
			if(dueMonth>12){
				dueMonth -= 12;
			}
		}
		
		if(typeof(dueMonth)=="undefined"){
			dueMonth = 0;
		}
		if(cnt==""){
			alert("수량을 입력하세요.");
			$("#PrdctInfo" + n +" input[id='cnt']").focus();
			return;
		}
		
		if(bc==""){
			bc = null;
		};
		if(diam==""){
			diam = null;
		}
		
		if(confirm("주문하시겠습니까?\n수량 : " + cnt + "EA\n가격 : " + format(puchasPrc * cnt))==false){
			return;
		}
		var url = "${ctxPath}/prdct/orderPrdct.do";
		var param = "id=" + comPrdctId + 
						"&shopId=" + shopId + 
						"&iNum=" + iNum + 
						"&PrdctId=" + prdctId +
						"&cnt=" + cnt +
						"&prdctTy=" + n + 
						"&detail=" + detail + 
						"&spec=" + spec + 
						"&BC=" + bc + 
						"&diam=" + diam +
						"&devide=" + devide + 
						"&dueMonth=" + dueMonth; 
		$.ajax({
			url : url,
			data :param,
			type : "post",
			success : function(data){
				if(data.trim()=="success"){
					alert("주문이 완료되었습니다.");
					
					if(devide!=0){
						gcmToAdmin(devide);	
					}
					
						var url = "http://jaguar.s4gallery.com/GalleryTalk/comm/sendMsg.do";
						var msg = shopName + "에서 " + prdctName + "을(를) " +  cnt + "개 주문하였습니다.";
						var param = "sendGid=S" + shopId + 
										"&sendName=" + shopName +
										"&rcvGid=C" + iNum + 
										"&msg=" + msg;
						
						console.log(param)
					$.ajax({
						url : encodeURI(url),
						data : param,
						dataType : "text",
						type : "post",
						success : function(){
							
						}
					});
					//$("#dialog" + n).dialog("close");
					$("#PrdctInfo" + n +" input[id='cnt']").val("");
				}else{
					alert("오류가 발생하였습니다.");
				}
			}
		});
	}
	
	function orderPrdct(){
		var menu = $("#order").val();
		if(menu=="1"){
			window.sessionStorage.setItem("prdct",1);
		}else if(menu=="2"){
			$.mobile.changePage(($(document.location.href="${ctxPath}/prdct/goLensOrderPage.do")),{reloadPage:true,transition:"flip"});
			window.sessionStorage.setItem("prdct",2);
			console.log("lens")
			return;
		}else if(menu=="3"){
			window.sessionStorage.setItem("prdct",3);
		}else if(menu=="4"){
			window.sessionStorage.setItem("prdct",4);
		}else if(menu=="5"){
			window.sessionStorage.setItem("prdct",5);
		}
		getComPrdctList();
	}
	function orderCheck(){
		var menu = $("#orderChk").val();
		if(menu=="1"){
			window.sessionStorage.setItem("order",1);
		}else if(menu=="2"){
			window.sessionStorage.setItem("order",2);
		}else if(menu=="3"){
			window.sessionStorage.setItem("order",3);
		}else if(menu=="4"){
			window.sessionStorage.setItem("order",4);
		}
		else if(menu=="5"){
			window.sessionStorage.setItem("order",5);
		}
		window.sessionStorage.setItem("menu",-1);
		$.mobile.changePage(($(document.location.href="${ctxPath}/prdct/orderList.do")),{reloadPage:true});
		//location.href="${ctxPath}/prdct/orderList.do";
	}
	
	//브랜드 리스트 
	function getBrand(){
		var brandName = $("#srchBrand").val();
		var url = "${ctxPath}/invn/srchBrand.do";
		var param = "brandName=" + brandName;
		
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				$("#brandId_").html(data);
				
			}
		});
	}
	
	//모델 선택
	function getPrdctList(){
		var prdctTy = window.sessionStorage.getItem("prdct");
		var brandId = $("#brandId_").val();
		var param = "brandId=" + brandId + 
						"&comTy=" + prdctTy;

		var url = "${ctxPath}/prdct/getPrdctListByBrand.do";
	
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : param,
			success : function(data){
				$("#prdctId_").html(data);
			}
		})
	}
	
	function getPrdct(){
		var prdctTy = window.sessionStorage.getItem("prdct");
		var prdctName = $("#srchPrdct input[id='srchPrdct']").val();
		var brandId = $("#brandId").val(); 
		var url = "${ctxPath}/invn/srchingPrdct.do";
		var param = "PrdctName=" + prdctName + 
						"&shopTy=shop" + 
						"&brandId=" + brandId + 
						"&comTy=" + prdctTy;
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				$("#prdctId").html(data);
			}
		});
	}
	
	function getReceiptForm(){
		/* $("#receipt").dialog({
			//bgiframe: true
			 title: "명세서"
			 , modal: true
		     , width: 800 // 가로 크기
		     , background: "#000"
		     , position:{my:"center",at:"middle",of: window }
			 , close: function(event, ui){
			}, success:  function(data) {
				
			} 
		}); */
		$("#receipt").popup("open");
	}
	
	function removeHypen(str){
		var result = str.replace(/-/gi,"");
		
		return result;
	}
	
	function removeComma(str){
		var result = str.replace(/,/gi,"");
		
		return result;
	}
	
	function getReceiptHeader(){
		sum = 0;
		tax = 0;
		total = 0;
		cnt = 0;
		var sdate = removeHypen($("#sdate").val());
		var edate = removeHypen($("#edate").val());
		var iNum = $("#iNumR").val();
		console.log(iNum)
		var shopId = $("#shopId").val();
		
		if(sdate==""){
			alert("시작 날짜를 입력하세요.");
			$("#sdate").focus();
			return;
		}
		if(edate==""){
			alert("종료 날짜를 입력하세요.");
			$("#edate").focus();
			return;
		}
		
		if(iNum=="-1"){
			alert("거래처를 선택하세요.");
			$("#iNum").focus();
			return;
		}
		
		
		window.open("${ctxPath}/prdct/getReceiptHeader.do?shopId=" + shopId + 
																	  "&iNum=" + iNum + 
																	  "&sdate=" + sdate + 
																	  "&edate=" + edate,"거래 명세서")
		
		
	}
	
	
	
	function format(n) {
		  var reg = /(^[+-]?\d+)(\d{3})/;   
		  n += '';                          

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');

		  return n;
		}
	
	function getListCom(ty){
		
		if(typeof(ty)=="undefined"){
			ty = 1;
		}
		var comTy = ty;
		var url = "${ctxPath}/company/getListCom.do";
		
		$.ajax({
			url : url,
			dataType : "html",
			data : "comTy=" + comTy,
			type : "post",
			success : function(data){
				$("#comDiv").html(data);
				/* $("#comList").dialog({
					title : "거래처 목록",
					width : 1000,
					height : 800
				});*/
				
				$("#comList").popup('open');
			} 
			
				
		});
	};
	
	
	function unRegItemDiv(){
		/* $("#unRegItemDiv").dialog({
			title : "제품 주문"
			,width : 800
			,height : 600
			,close : function(){
				$("#uncnt").val("");
				$(".spec").val("-1");
				$("#uncnt").val("");
				$("#uniNum").val("-1");
				$("#undetail").val("");
				$("#unpuchasPrc").val("");
				$("#untrdePrc").val("");
				$("#unmtrl").val("-1");
				$("#unprdctId").val("-1");
				$("#unrate").html("<option value='-1'>선택</option>");
				$("#unTyId1").val("-1");
				$("#unmnfCountry").val("-1");
				$("#unnewPrdctName").css("display","none");
				$("#unprdctId").css("display","inline");
				$("#unspec").val("");
			}
		}); */
		
		$("#unRegItemDiv").popup('open');
	}
	
	function getCntryList(){
		$.ajax({
			url : "${ctxPath}/invn/getCountryList.do",
			dataType : "html",
			type : "post",
			success : function(data){
				$("#unmnfCountry").html(data);
			}
		});
	}
	
	function addNewLens(){
		var prdctName;
		var mtrl = $("#unmtrl"	).val();
		var tyId = $("#unTyId1").val();
		var puchasPrc = $("#unpuchasPrc").val();
		var mnfCountry = $("#unmnfCountry").val();
		var trdePrc = $("#untrdePrc").val();
		var rate;
		
		var prdctName;
		if(!newPrdct && newRate){ //새로운 rate
			prdctName = $("#unprdctId option:selected").text();
			rate = $("#unnewRate").val();
		}else if(newPrdct && newRate){
			prdctName = $("#unnewPrdctName").val();
			rate = $("#unnewRate").val();
		}
		else{ //새로운 prdctName
			prdctName = $("#unnewPrdctName").val();
			rate = $("#unrate").val();
		}
		
		
		var param = "brandId=-2" +
						"&mnfCountry=" +mnfCountry + 
						"&prdctName=" +prdctName + 
						"&mtrl=" + mtrl + 
						"&tyId=" + tyId + 
						"&rate=" +rate +
						"&puchasPrc=" + puchasPrc + 
						"&trdePrc=" + trdePrc;
		
		var url = "${ctxPath}/prdct/adNewLensData.do";
		
			$.ajax({
				url : url,
				data : param,
				type : "post",
				success : function(data){
					var result = data.trim().split("|");
					
					if(result[0]=="success"){
						newPrdctId = result[1];
						newPrdct = false;
						newRate = false;
						NewOrder();
					}
				}
			});
						
	}
	var newPrdct = false;
	var newPrdctId = "";
	function NewOrder(){
		if(newPrdct||newRate){
			addNewLens();
			return;
		}
		var cnt = $("#uncnt").val();
		var iNum = $("#uniNum").val();
		var prdctId = $("#unPrdctId").val();
		var detail = $("#undetail").val();
		var puchasPrc = removeComma($("#unpuchasPrc").val());
		if(iNum=="-1"){
			alert("거래처를 선택하세요.");
			$("#uniNum").focus();
			return;
		}
		var param = 	"prdctName=" + prdctId +  
						"&iNum=" + iNum + 
						"&puchasPrc=" + puchasPrc + 
						"&detail=" + detail + 
						"&shopId=" + shopId +
						"&cnt=" + cnt +
						"&prdctTy=2"; 
		var url = "${ctxPath}/prdct/newOrder.do";
		
		if(cnt==""){
			alert("수량을 입력하세요.");
			$("#uncnt").focus();
			return;
		}
		if(puchasPrc==""){
			alert("가격을 입력하세요.");
			$("#unpuchasPrc").focus();
			return;
		}
		
		
		if(confirm("주문하시겠습니까?\n수량 : " + cnt + "EA\n가격 : " + format(puchasPrc * cnt))==false){
			return;
		}
		
		
		$.ajax({
			url : url,
			type : "post",
			data : param,
			success :function(data){
				if(data=="success"){
					alert("주문이 완료되었습니다.");
					
				}
			}
		});
	};
	
	var newRate = false;
	function newRateData(){
		var rate = $("#unrate").val();
		if(rate=="-2"){
			$("#unnewRate").css("display","inline");
			$("#unrate").css("display","none");
			newRate = true;
		}
	}
	
	
	var newTy;
	var nTy = false;
	function addNewType(){
		if(!nTy){
			$("#newTy").css("display","inline");
			$("#unTyId1").css("display","none");
			$("#newType").html("확인");
			nTy = true;
		}else{
			var name = $("#newTy").val();
			if(name==""){
				alert("타입을 입력하세요.");
				$("#newTy").focus();
				return;
			}
			var param = "name=" + name; 
			var url = "${ctxPath}/prdct/addNewLensTy.do";
			
			$.ajax({
				url : url,
				type : "post",
				data : param,
				success : function(data){
					var result = data.trim().split("|");
					if(result[0]=="success"){
						newTy = result[1];
						showAllLensType(newTy);
						nTy = false;
						$("#newTy").css("display","none");
						$("#unTyId1").css("display","inline");
						$("#newType").html("직접입력");
						$("#newTy").val("");
					}
				}
			});
		}
	}
	
	
	
	function showAllLensType(newTy){
		var url = '${ctxPath}/prdct/showAllLensType.do';
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#unTyId1").html(data);
				$("#unTyId1").val(newTy);
			}
		});
	}
	
	
	function checkLensTy(){
		var type = $("#lensForm :radio[name='type']:checked").val();
		var iNum = $("#lensForm select[id='iNum']").val();
		
		var url = "${ctxPath}/prdct/getLensListByType.do";
		var param = "type=" + type + 
						"&iNum=" + iNum;
		
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				console.log(data)
			}
		});
	}
	
	
	function gcmToAdmin(devide){
		var url = "http://jaguar.s4gallery.com/GalleryTalk/comm/sendMsg.do";
		var msg = shopName + "에서  " + devide + "개월 할부 요청 하셨습니다.";
		var param = "sendGid=S" + shopId + 
						"&sendName=" + shopName +
						/* "&rcvGid=C70" + */  
						"&rcvGid=4686" +
						"&msg=" + msg;
		
		console.log(msg)
		$.ajax({
			url : encodeURI(url),
			data : param,
			dataType : "text",
			type  : "post",
			success : function(){
				
			}
		});
	}
</script>
<style>
	.dialog,  #receiptList{
		display: none;
	}
	.prdctImg{
		height : 150px;
		
	}
	.title{
		cursor: pointer;
		font-size: 13px;
	}
	.grayClass{
	background-color: #d3d3d3;
	}
	.whiteClass{
			background-color: white;
	}
	#unnewPrdctName,#mnfCountry_{
		display: none;
	}
	#result{
		color :white;
		display: none;
	}
	.clensTbl{
		display: none;
	}
	#unnewRate{
		display: none;
	}
	#unRegTable{
		width: 700px;
	}
	#newTy{
		display: none;
	}
	#newRate{
		display: none;
	}
	.hidden{
		display: none;
	}
	.td{
		font-size: 13px;
	}
	#lensDiv{
		display: none;
	}
	.clensSpec:hover{
		background-color: yellow;
	}
	.clensSpec{
		height :25px;
		width : 35px;
		font-size: 10px;
	}
	.specTd_{
		height : 20px;
		font-size: 12px;
		background-color : #d3d3d3;
		font-weight: bold;
	}
</style>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<center>
	<div data-role="controlgroup" data-type="horizontal">
		<select id="order" onchange="orderPrdct();" data-native-menu="false">
			<option value="-1">주문</option>
			<option value="1">프레임</option>
			<option value="2">렌즈</option>
			<option value="3">콘텍트렌즈</option>
			<option value="4">렌즈용액</option>
			<option value="5">기타</option>
		</select>
		
		 <select id="orderChk" onchange="orderCheck();" data-native-menu="false">
			<option value="-1">주문표</option>
			<option value="1">프레임</option>
			<option value="2">렌즈</option>
			<option value="3">콘텍트렌즈</option>
			<option value="4">렌즈용액</option>
			<option value="5">기타</option>
		</select>
		<button onclick="getReceiptForm()" data-role="none">거래 명세서</button>
		<button onclick="getListCom()" data-role="none">거래처 목록</button>
		</div>
		<span style="float: right;font-size: 12px" id="comOrderCnt"></span>
		<span style="font-weight: bold;">※렌즈 주문 페이지가 오픈되었습니다.</span>
		<br>
		<br>
		<table id="srchPrdct"  width="100%" border="1" style="border-collapse: collapse; text-align: center">
			<form id="srchForm">
				<tr>
					<th>협력사</th> 
					<td>
							<input type="text" id="srchCom" onkeyup="getCom()" size="10"  data-role="none">
							
							<select id="iNum_" data-inline="true" data-role="none">
								<option value="-1">선택</option>
							</select>
					</td>  
					<th>가격</th>
					<td>
							<input type="text" id="puchasPrcF" name="puchasPrcF"  data-role="none"> - 
							<input type="text" id="puchasPrcT" name="puchasPrcT"  data-role="none">
					</td>
					<td>
						<button onclick="getComPrdctList(); return false;"  data-role="none">검색</button>
					</td>
				</tr>
			</form>
		</table>
		<br>
		<table id="srchPrdct2"  width="100%" border="1" style="border-collapse: collapse; text-align: center">
			<Tr>
				<th>브랜드</th>
				<td>
					<input type="text" id="srchBrand" onkeypress="getBrand();" data-role="none">
					<select id="brandId_" onchange="getPrdctList()" data-role="none">
						<option value="-1" data-role="none">선택</option>
					</select>
				</td>
				<th>모델명</th>
				<td>
					<select id="prdctId_" data-role="none">
						<option value="-1">선택</option>
					</select>
				</td>		
				<td>
					<button  onclick="getComPrdctList(); return false;" data-role="none">검색</button>
				</td>	
			</Tr>
		</table>
		<br>
		<hr width="100%">
		<!-- 미등록 렌즈 --> 

		<button id="unRegItem" onclick="unRegItemDiv()" data-mini="true" data-inline="true">렌즈 미등록 제품 주문</button> 
		
		<table id="prdctInfo" class='tablesorter-ice' width="100%" border="1" style="border-collapse: collapse; text-align: center">
			
		</table>
	</center>
	
<div data-role="popup" id="dialog1" data-theme="a" class="ui-corner-all">
<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<br>
<br>
<center>
	<form id="PrdctInfo1">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			<tr>
			
				<th>상품종류</th><td ><select id="prdctTyCd" name="prdctTyCd" onchange="getBrandByTy()" disabled="disabled">
									<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>" selected="selected">프레임 </option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>" >렌즈</option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>">콘텍트 렌즈 </option>
								</select> </td>
			<th>제조국</th><td><input id="mnfCountry" name="mnfCountry" onchange="getCntry();" readonly="readonly"></td>	
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><input id='brandName' name='brandName' title='브랜드 명' readonly="readonly"><input type="hidden" id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();">
				
							</td>
				<th width="20%">모델명</th><td width="30%">  <input id="prdctName" name="prdctName"readonly="readonly"><input type="hidden" id="prdctId" name="prdctId" onchange="getPrdctPrc()"> </td>
			</tr>
			<tr>
				<th>색상1</th><td><input id="colorId" name="colorId" readonly="readonly"></td>
				<th>색상2</th><td><input id="colorId2" name="colorId2" readonly="readonly"></td>
				
			</tr>
			<tr>
				<th>공급가</th><td><input type="text" id="puchasPrc" name="puchasPrc" readonly="readonly"></td>
				<th>매장 판매가</th><td><input type="text" id="salePrc" name="salePrc" readonly="readonly"></td>
			</tr>
			<tr>
				<th>용도</th><td><input id="prdctTy" name="prdctTy" readonly="readonly"></td>
				<th>재질</th><td><input id="mtrlId" name="mtrlId" readonly="readonly"></td>
			</tr>
			<tr>
				<th>모양</th><td><input id="prdctShape" name="prdctShape" readonly="readonly"></td>
				<th>URL</th><td><input type="text" id="url" name="url" readonly="readonly"> </td>
			</tr>
			<tr>
				<th>제품 설명</th><td colspan="4" align="left"> <textarea  rows="5" cols="80" id="memo"></textarea> </td>
			</tr>
			<tr>
				<td id="img" colspan="4"></td>
			</tr>
			
		</table>
		<br>
		<table  width="80%" border="1" style="border-collapse: collapse; text-align: center">
			<tr>
				<th>주문</th>
			</tr>
			<Tr>
				<td><textarea rows="4" cols="80" id="detail" name="detail" class="detail" placeholder="상세내용"></textarea></td>
			</Tr>
			<tr>
				<td><span style="display: none;"><input type="input" id="BC" size="3" class="BC" placeholder="B.C." style="width: 50px">&nbsp;<input type="input" id="diam" size="3" class="diam" placeholder="diam." style="width: 50px"><select id="spec">도수 : <option value="-1"></option selected="selected" ></select></span><select id="devide" class="devide" data-inline="true">
																																																																																																						<option value="-1">할부 </option>
																																																																																																						<!-- <option value="1">이월</option> -->
																																																																																																						<option value="2">2개월</option>
																																																																																																						<option value="3">3개월</option>
																																																																																																						<option value="4">4개월</option>
																																																																																																						<option value="5">5개월</option>
																																																																																																						<option value="6">6개월</option>
																																																																																																			</select>
																																																																																																			<input type="text" id="cnt" size="3" class="cnt" placeholder="수량" data-role="none"style="width: 50px"> <button onclick="order('1'); return false;" data-inline="true">주문</button></td>
			</tr>
		</table>
		
	</form>		
		
</center>
</div>

<!-- 렌즈 -->

<div id="dialog2" class="dialog">


<center>
	<form id="PrdctInfo2">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			<tr>
				<th>상품종류</th><td ><select id="prdctTyCd" name="prdctTyCd" onchange="getBrandByTy()" disabled="disabled">
									<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>" >프레임 </option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>" selected="selected"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>">콘텍트 렌즈 </option>
								</select> </td>
			<th>제조국</th><td><input id="mnfCountry" name="mnfCountry" onchange="getCntry();" readonly="readonly"></td>	
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><input id='brandName' name='brandName' title='브랜드 명' readonly="readonly"><input type="hidden" id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();">
				
							</td>
				<th width="20%">모델명</th><td width="30%">  <input id="prdctName" name="prdctName"readonly="readonly" ><input type="hidden" id="prdctId" name="prdctId" onchange="getPrdctPrc()"> </td>
			</tr>
			<tr>
				<th>기능</th><td><input id="tyId" name="tyId" readonly="readonly"></td>
				<th>재질</th><td><input id="mtrl" name="mtrl" readonly="readonly"></td>
				
			</tr>
			<tr>
				<th>공급가</th><td><input type="text" id="puchasPrc" name="puchasPrc" readonly="readonly"></td>
				<th>매장 판매가</th><td><input type="text" id="salePrc" name="salePrc" readonly="readonly"></td>
			</tr>
			<tr>
				<th>굴절률</th><td><input id="rate" name="rate" readonly="readonly"></td>
				<th>URL</th><td><input type="text" id="url" name="url" readonly="readonly"> </td>
			</tr>
			<tr>
				<th>제품 설명</th><td colspan="4" align="left"><textarea  rows="5" cols="80" id="memo"></textarea> </td>
			</tr>
		</table>
		
		<br>
		<table  width="80%" border="1" style="border-collapse: collapse; text-align: center">
			<tr>
				<th>주문</th>
			</tr>
			<Tr>
				<td><textarea rows="5" cols="80" id="detail" name="detail" class="detail" placeholder="상세내용 (도수는 아래 메뉴에서 선택바랍니다.)                                                           *불이행시 제대로 된 주문이 되지 않습니다."></textarea></td>
			</Tr>
			<tr>
				<td>도수 : 
					<select id="spec" class="spec">
								<option value="-1" selected="selected">선택</option>
								<option value="-0.00">-0.00</option>
								<option value="-0.25">-0.25</option>
								<option value="-0.50">-0.50</option>
								<option value="-0.75">-0.75</option>
								<option value="-1.00">-1.00</option>
								<option value="-1.25">-1.25</option>
								<option value="-1.50">-1.50</option>
								<option value="-1.75">-1.75</option>
								<option value="-2.00">-2.00</option>
								<option value="-2.25">-2.25</option>
								<option value="-2.50">-2.50</option>
								<option value="-2.75">-2.75</option>
								<option value="-3.00">-3.00</option>
								<option value="-3.25">-3.25</option>
								<option value="-3.50">-3.50</option>
								<option value="-3.75">-3.75</option>
								<option value="-4.00">-4.00</option>
								<option value="-4.25">-4.25</option>
								<option value="-4.50">-4.50</option>
								<option value="-4.75">-4.75</option>
								<option value="-5.00">-5.00</option>
								<option value="-5.25">-5.25</option>
								<option value="-5.50">-5.50</option>
								<option value="-5.75">-5.75</option>
								<option value="-6.00">-6.00</option>
								<option value="-6.50">-6.50</option>
								<option value="-7.00">-7.00</option>
								<option value="-7.50">-7.50</option>
								<option value="-8.00">-8.00</option>
								<option value="-8.50">-8.50</option>
								<option value="-9.00">-9.00</option>
								<option value="-9.50">-9.50</option>
								<option value="-10.00">-10.00</option>
								<option value="-10.50">-10.50</option>
								<option value="-11.00">-11.00</option>
								<option value="-11.50">-11.50</option>
								<option value="-12.00">-12.00</option>
								<option value="-12.25">-12.25</option>
								<option value="-12.50">-12.50</option>
								<option value="-12.75">-12.75</option>
								<option value="-13.00">-13.00</option>
								<option value="-13.25">-13.25</option>
								<option value="-13.50">-13.50</option>
								<option value="-13.75">-13.75</option>
								<option value="-14.00">-14.00</option>
								<option value="-14.25">-14.25</option>
								<option value="-14.50">-14.50</option>
								<option value="-14.75">-14.75</option>
								<option value="-15.00">-15.00</option>
								<option value="-15.25">-15.25</option>
								<option value="-15.50">-15.50</option>
								<option value="-15.75">-15.75</option>
								<option value="-16.00">-16.00</option>
								<option value="-16.25">-16.25</option>
								<option value="-16.50">-16.50</option>
								<option value="-16.75">-16.75</option>
								<option value="-17.00">-17.00</option>
								<option value="-17.25">-17.25</option>
								<option value="-17.50">-17.50</option>
								<option value="-17.75">-17.75</option>
								<option value="-18.00">-18.00</option>
								<option value="-18.25">-18.25</option>
								<option value="-18.50">-18.50</option>
								<option value="-18.75">-18.75</option>
								<option value="-19.00">-19.00</option>
								<option value="-19.25">-19.25</option>
								<option value="-19.50">-19.50</option>
								<option value="-19.75">-19.75</option>
								<option value="-20.00">-20.00</option>
								
							</select>
					<input type="text" id="cnt" size="3" class="cnt" placeholder="수량"> <button onclick="order('2'); return false;">주문</button></td>
			</tr>
		</table>
	</form>		
		
</center>
</div>

<!--콘텍트-->

<div data-role="popup" id="dialog3"  data-theme="a" class="ui-corner-all" with="50%">
<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<br>
<br>
<center>
	<form id="PrdctInfo3">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			<tr>
				<th>상품종류</th><td ><select id="prdctTyCd" name="prdctTyCd" onchange="getBrandByTy()" disabled="disabled">
									<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>" >프레임 </option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>" selected="selected">콘텍트 렌즈 </option>
								</select> </td> 
			<th>제조국</th><td><input id="mnfCountry" name="mnfCountry" onchange="getCntry();" readonly="readonly"></td>	
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><input id='brandName' name='brandName' title='브랜드 명' readonly="readonly"><input type="hidden" id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();">
				
							</td>
				<th width="20%">모델명</th><td width="30%">  <input id="prdctName" name="prdctName" readonly="readonly"><input type="hidden" id="prdctId" name="prdctId" onchange="getPrdctPrc()"> </td>
			</tr>
			<tr>
				<th>타입</th><td><input id="tyId1" name="tyId2" readonly="readonly"></td>
				<th>기능</th><td><input id="tyId2" name="tyId2" readonly="readonly"></td>
				
			</tr>
			<tr>
				<th>공급가</th><td><input type="text" id="puchasPrc" name="puchasPrc"  readonly="readonly"></td>
				<th>매장 판매가</th><td><input type="text" id="salePrc" name="salePrc" readonly="readonly"></td>
			</tr>
			<tr>
				<th></th><td><input id="rate" name="rate"readonly="readonly"></td>
				<th>URL</th><td><input type="text" id="url" name="url" readonly="readonly"> </td>
			</tr>
			<tr>
				<th>제품 설명</th><td colspan="4" align="left"><textarea  rows="5" cols="80" id="memo"></textarea> </td>
			</tr>
		</table>
		<br>
		<table  border="1" style="border-collapse: collapse; text-align: center">
			<tr>
				<th>주문</th>
			</tr>
			<Tr>
				<td><textarea rows="5" cols="80" id="detail" name="detail" class="detail" placeholder="상세내용 (도수는 아래 메뉴에서 선택바랍니다.)                                                                         *불이행시 제대로 된 주문이 되지 않습니다."></textarea></td>
			</Tr>
			<tr>
				<td>
				
				<select id="devide" data-inline="true" class="devide">
																																																																								<option value="-1">할부 </option>
																																																																								<!-- <option value="1">이월</option> -->
																																																																								<option value="2">2개월</option>
																																																																								<option value="3">3개월</option>
																																																																								<option value="4">4개월</option>
																																																																								<option value="5">5개월</option>
																																																																								<option value="6">6개월</option>
																																																																					</select>
							<input type="input" id="BC" size="3" class="BC" placeholder="B.C." style="width: 50px">&nbsp;<input type="input" id="diam" size="3" class="diam" placeholder="diam." style="width: 50px">&nbsp;<!-- <input type="input" id="cnt" size="3" class="cnt" placeholder="수량" style="width: 50px">&nbsp; --><button onclick="cntOrderList(); return false;" data-inline="true">주문</button></td>
			</tr>
			<tr >
				<Th colspan="4">도수 선택</Th>
			</tr>
			<tr>
				<td colspan="4">
					<table border="1" style="text-align: center;" id="lensSpecTR">
						<!-- <tr>
							<td class="td1">0.00</td>
							<td class="td1">0.25</td>
							<td class="td1">0.50</td>
							<td class="td1">0.75</td>
							<td class="td1">1.00</td>
							<td class="td1">1.25</td>
							<td class="td1">1.50</td>
							<td class="td1">1.75</td>
							<td class="td1">2.00</td>
							<td class="td1">2.25</td>
							<td class="td1">2.50</td>
							<td class="td1">2.75</td>
							<td class="td1">3.00</td>
							<td class="td1">3.25</td>
							<td class="td1">3.50</td>
							<td class="td1">3.75</td>
							<td class="td1">4.00</td>
							<td class="td1">4.25</td>
							<td class="td1">4.50</td>
							<td class="td1">4.75</td>
						</tr>
						<tr>
							<td class="clensSpec">&nbsp;</td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
						</tr>
						<tr>
							<td class="td1">5.00</td>
							<td class="td1">5.25</td>
							<td class="td1">5.50</td>
							<td class="td1">5.75</td>
							<td class="td1">6.00</td>
							<td class="td1">6.25</td>
							<td class="td1">6.50</td>
							<td class="td1">6.75</td>
							<td class="td1">7.00</td>
							<td class="td1">7.25</td>
							<td class="td1">7.50</td>
							<td class="td1">7.75</td>
							<td class="td1">8.00</td>
							<td class="td1">8.25</td>
							<td class="td1">8.50</td>
							<td class="td1">8.75</td>
							<td class="td1">9.00</td>
							<td class="td1">9.25</td>
							<td class="td1">9.50</td>
							<td class="td1">9.75</td>
						</tr>
						<tr>
							<td class="clensSpec">&nbsp;</td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
						</trtd1>
						<tr>
							<td class="td1">10.00</td>
							<td class="td1">10.25</td>
							<td class="td1">10.50</td>
							<td class="td1">10.75</td>
							<td class="td1">11.00</td>
							<td class="td1">11.25</td>
							<td class="td1">11.50</td>
							<td class="td1">11.75</td>
							<td class="td1">12.00</td>
							<td class="td1">12.25</td>
							<td class="td1">12.50</td>
							<td class="td1">12.75</td>
							<td class="td1">13.00</td>
							<td class="td1">13.25</td>
							<td class="td1">13.50</td>
							<td class="td1">13.75</td>
							<td class="td1">14.00</td>
							<td class="td1">14.25</td>
							<td class="td1">14.50</td>
							<td class="td1">14.75</td>
						</tr>
						<tr>
							<td class="clensSpec">&nbsp;</td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
						</tr>
						<tr>
							<td class="td1">15.00</td>
							<td class="td1">15.25</td>
							<td class="td1">15.50</td>
							<td class="td1">15.75</td>
							<td class="td1">16.00</td>
							<td class="td1">16.25</td>
							<td class="td1">16.50</td>
							<td class="td1">16.75</td>
							<td class="td1">17.00</td>
							<td class="td1">17.25</td>
							<td class="td1">17.50</td>
							<td class="td1">17.75</td>
							<td class="td1">18.00</td>
							<td class="td1">18.25</td>
							<td class="td1">18.50</td>
							<td class="td1">18.75</td>
							<td class="td1">19.00</td>
							<td class="td1">19.25</td>
							<td class="td1">19.50</td>
							<td class="td1">19.75</td>
						</tr>
						<tr>
							<td class="clensSpec">&nbsp;</td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
							<td class="clensSpec"></td>
						</tr>
						<tr>
							<td class="td1">20.00</td>
						</tr>
						<tr>
							<td class="clensSpec">&nbsp;</td>
						</tr> -->
					</table>
				</td>
			</tr>
		</table>
	</form>		
		
</center>
</div>


<!--용액-->

<div data-role="popup" id="dialog4" data-theme="a" class="ui-corner-all">
<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<br>
<br>
<center>
	<form id="PrdctInfo4">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			<tr>
				<th>상품종류</th><td ><select id="prdctTyCd" name="prdctTyCd" onchange="getBrandByTy()" disabled="disabled">
									<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>">프레임 </option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>">콘텍트 렌즈 </option>
								</select> </td>
			<th>제조국</th><td><input id="mnfCountry" name="mnfCountry" onchange="getCntry();" readonly="readonly"></td>	
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><input id='brandName' name='brandName' title='브랜드 명' readonly="readonly"><input type="hidden" id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();">
				
							</td>
				<th width="20%">모델명</th><td width="30%">  <input id="prdctName" name="prdctName" readonly="readonly"><input type="hidden" id="prdctId" name="prdctId" onchange="getPrdctPrc()"> </td>
			</tr>
			<tr>
				<th>공급가</th><td><input type="text" id="puchasPrc" name="puchasPrc"  readonly="readonly" readonly="readonly"></td>
				<th>매장 판매가</th><td><input type="text" id="salePrc" name="salePrc"  readonly="readonly" readonly="readonly"></td>
			</tr>
			<tr>
				<th>용량</th><td><input id="unit" name="unit" readonly="readonly"></td>
				<th>URL</th><td><input type="text" id="url" name="url" readonly="readonly"> </td>
			</tr>
			<tr>
				<th>제품 설명</th><td colspan="4" align="left"><textarea  rows="5" cols="80" id="memo"></textarea> </td>
			</tr>
		</table>
		<br>
		<table  width="80%" border="1" style="border-collapse: collapse; text-align: center">
			<tr>
				<th>주문</th>
			</tr>
			<Tr>
				<td><textarea rows="5" cols="80" id="detail" name="detail" class="detail" placeholder="상세내용"></textarea></td>
			</Tr>
			<tr>
				<td><span style="display: none"><input type="input" id="BC" size="3" class="BC" placeholder="B.C." style="width: 50px">&nbsp;<input type="input" id="diam" size="3" class="diam" placeholder="diam." style="width: 50px"><select id="spec" class="hidden" >도수 : <option value="-1"></option selected="selected"></select></span><select id="devide" data-inline="true" class="devide">
																																																																																																						<option value="-1">할부 </option>
																																																																																																						<!-- <option value="1">이월</option> -->
																																																																																																						<option value="2">2개월</option>
																																																																																																						<option value="3">3개월</option>
																																																																																																						<option value="4">4개월</option>
																																																																																																						<option value="5">5개월</option>
																																																																																																						<option value="6">6개월</option>
																																																																																																			</select><input type="text" id="cnt" size="3" class="cnt" placeholder="수량" data-role="none">  <button onclick="order('4'); return false;" data-inline="true">주문</button></td>
			</tr>
		</table>
	</form>		
	
</center>
</div>


<!--기타-->

<div data-role="popup" id="dialog5" data-theme="a" class="ui-corner-all">
<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<br>
<br>
<center>
	<form id="PrdctInfo5">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			<tr>
				<th>상품종류</th><td ><select id="prdctTyCd" name="prdctTyCd" onchange="getBrandByTy()" disabled="disabled">
									<option value="<%=CommonCode.CODE_PRDCT_TY_FRAME%>">프레임 </option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_LENS%>"><%=CommonCode.MSG_PRDCT_TY_LENS%></option>
								<option value="<%=CommonCode.CODE_PRDCT_TY_CLENS%>">콘텍트 렌즈 </option>
								</select> </td>
			<th>제조국</th><td><input id="mnfCountry" name="mnfCountry" onchange="getCntry();" readonly="readonly"></td>	
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><input id='brandName' name='brandName' title='브랜드 명' readonly="readonly"><input type="hidden" id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();">
				
							</td>
				<th width="20%">모델명</th><td width="30%">  <input id="prdctName" name="prdctName" readonly="readonly"><input type="hidden" id="prdctId" name="prdctId" onchange="getPrdctPrc()"> </td>
			</tr>
			<tr>
				<th>공급가</th><td><input type="text" id="puchasPrc" name="puchasPrc"  readonly="readonly" readonly="readonly"></td>
				<th>매장 판매가</th><td><input type="text" id="salePrc" name="salePrc"  readonly="readonly" readonly="readonly"></td>
			</tr>
			<tr>
				<th></th><td></td>
				<th>URL</th><td><input type="text" id="url" name="url" readonly="readonly"> </td>
			</tr>
			<tr>
				<th>제품 설명</th><td colspan="4" align="left"><textarea  rows="5" cols="80" id="memo"></textarea> </td>
			</tr>
		</table>
		<br>
		<table  width="80%" border="1" style="border-collapse: collapse; text-align: center">
			<tr>
				<th>주문</th>
			</tr>
			<Tr>
				<td><textarea rows="5" cols="80" id="detail" name="detail" class="detail" placeholder="상세내용"></textarea></td>
			</Tr>
			<tr>
				<td><span style="display: none"><input type="input" id="BC" size="3" class="BC" placeholder="B.C." style="width: 50px">&nbsp;<input type="input" id="diam" size="3" class="diam" placeholder="diam." style="width: 50px"><select id="spec" class="hidden" >도수 : <option value="-1"></option selected="selected"></select></span><select id="devide" data-inline="true" class="devide">
																																																																																																						<option value="-1">할부 </option>
																																																																																																						<!-- <option value="1">이월</option> -->
																																																																																																						<option value="2">2개월</option>
																																																																																																						<option value="3">3개월</option>
																																																																																																						<option value="4">4개월</option>
																																																																																																						<option value="5">5개월</option>
																																																																																																						<option value="6">6개월</option>
																																																																																																			</select><input type="text" id="cnt" size="3" class="cnt" placeholder="수량" data-role="none"> <button onclick="order('5'); return false;" data-inline="true">주문</button></td>
			</tr>
		</table>
	</form>		
	
</center>
</div>





<div data-role="popup" id="receipt" data-theme="a" class="ui-corner-all"style="width: 800px">
	<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
	<center>
	<br>
	<br>
		<form id="receiptForm">
			<table width="80%"border="1" style="border-collapse: collapse; text-align: center">
				<tr>
					<th width="20%">일자</th><td colspan="4"><input type="date" id="sdate" data-role="none"> - <input type="date" id="edate" data-role="none"> </td>
				</tr>
				<tr>
					<th>거래처</th><td><select id="iNumR" data-inline="true" data-mini="true"><option value="-1">목록</select></td><th width="10%">매장</th> <td><select id="shopId" disabled="disabled" data-inline="true" data-mini="true" data-role="none"><option value="-1">목록</select></td><td><button onclick="getReceiptHeader(); return false;" data-inline="true" data-mini="true">확인</button></td>
				</tr> 
			</table>
		</form>
	</center>
</div>

<div id="receiptList">
</div>

<div data-role="popup" id="comList" data-theme="a" class="ui-corner-all"style="width: 800px">
	<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
	<br>
	<div id="comDiv"></div>
	<br>
</div>

<div data-role="popup" id="unRegItemDiv" data-theme="a" class="ui-corner-all"style="width: 800px">
<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<br>
<br>
	<center>
		<form>
			<table id="unRegTable" border="1" style="border-collapse: collapse; text-align: center" >
				<tr>
					<th width="20%">거래처</th><td width="30%"><select id="uniNum"><option value="-1">목록</select></td>
					<th width="20%">제품명</th><td width="30%"><input type="text" id="unPrdctId"> </td>
				</tr>
				<tr>
					<th>공급가</th><td><input type="text" id="unpuchasPrc"> <br> <span style="color: red; font-size: 13px" >부가세 별도<br> (원가 ÷ 1.1 소수점 이하 반올림)</span></td>
					<th></th><td></td>
				</tr>	
				<Tr>
					<td colspan="4"><textarea rows="5" cols="80" id="undetail" name="undetail" class="detail" placeholder="상세내용 "></textarea></td>
				</Tr>
				<tr>
					<td colspan="4">
						
					<input type="text" id="uncnt" size="3" class="cnt" placeholder="수량" data-role="none"> <button onclick="NewOrder(); return false;" data-inline="true" data-mini="true">주문</button></td>
				</tr>		
			</table>
		</form>
	</center>		
</div>


<div data-role="popup" id="popupNotice" data-theme="a" class="ui-corner-all"style="width: 300px">
	<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
	<div id="notice">123</div>
</div>
<!-- 렌즈 주문 -->
<!-- <div id="lensDiv" >
	<form action="" id="lensForm">
		<table border="1" style="border-collapse: collapse;text-align: center" width="100%">
			<tr>
				<th width="30%">거래처</th>
				<td width="70%">
					<select class="iNum" id="iNum"></select>
				</td>
			</tr>
			<tr>
				<td id="leftSide">
					<input type="radio" id="type" name="type" value="N" onchange="checkLensTy();">여벌
					<input type="radio" id="type" name="type" value="R" onchange="checkLensTy();">RX
				</td>
				
				<td></td>
			</tr>
		</table>
	</form>
</div> -->

</body>
</html>
