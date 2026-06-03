<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
<script type="text/javascript" src="${ctxPath }/js/jq/jquery.mobile.datepicker.js"></script>
<link rel="stylesheet" href="${ctxPath }/js/jq/jquery.mobile.datepicker.css"/> 

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

<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<!-- <script src="http://code.jquery.com/jquery-1.10.2.js"></script> -->
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script> 

<script type="text/javascript">
	
	
	var shopId = ${shopId};
	$(function(){
		
		getComOrderCnt();
		$("#sdate_").datepicker({
			 dateFormat: 'yymmdd'
		});
		$("#edate_").datepicker({
			 dateFormat: 'yymmdd'
		});
		now_();
		$("#orderChk").val(prdctTy);
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(String(date.getMonth() + 1));
		var day = addZero(String(date.getDate()));
	
		$("#sdate_").val(year + month +  day);
		$("#edate_").val(year + month + day);
		
		getOrderList();
		getShopList();
		getComList();
		getRtnReasonList();
		getComOrderCnt();
		if(shopLv>=5){
			$("select[id='shopId']").removeAttr("disabled");
			
		}
	});
	
	function showDetail(id){
		var param = "id=" + id;
		var url = "${ctxPath}/prdct/showDetail.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				$("#detailDiv").html(data);
				$("#detailpopup").popup('open');
			}
		});
	};
	
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
					var cnt = "승인되지 않은 매장주문 대행 건 : <span style='color:red'><a href='javascript:getComOrderList();'>" + data + "</a></span>건";	
				}
				
				$("#comOrderCnt").html(cnt);
			}
		});
	}
	
	function getComOrderList(){
		var param = "shopId=" + shopId;
		var url = "${ctxPath}/prdct/getComOrderList.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#prdctInfo").fadeIn(500);
				$("#prdctInfo").html(data);
				$("#prdctInfo").tablesorter();
				
				$("#allReceivBtn").css("display","inline");
				$("#allAllowBtn").css("display","inline");
			}
		});
	}
	function getRtnReasonList(){
		var url = "${ctxPath}/prdct/getRtnReasonList.do";
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#returnReason").html(data)
			}
		});
	}
	
	function now_(){
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(String(date.getMonth() +1));
		var date_ = addZero(String(date.getDate()));
		
		$("#sdate").val(year + "-" + month + "-" + date_);
		$("#edate").val(year + "-" + month + "-" + date_);
	}
	
	function addZero(n){
		if(n.length=="1"){
			n = "0" + n;
		}
		return n;
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
				console.log(data)
				$("#iNum").append(data);
				$(".iNum").append(data);
				$("#iNumB").append(data);
			}	
		});  
	}
		
	function addZero(n){
		if(n.length="1"){
			n = "0" + n;
		}
		return n;
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
	
	
	var sort = "D";
	function getOrderList(ty){
		$("#allReceivBtn").css("display","none");
		$("#allAllowBtn").css("display","none");
		$("#prdctInfo").fadeOut(500);
		setTimeout(function(){
			
		
		var prdctTy = window.sessionStorage.getItem("order"); 
		if(typeof(ty)=="undefined"){
			 ty = "updTime";
		}
		
		var iNum = $("#iNumB").val();
		var sdate = removeHypen($("#sdate_").val());
		var edate = removeHypen($("#edate_").val());
		
		var url = "${ctxPath}/prdct/getOrderList.do";
		
		var param = "shopId=" + shopId +
						"&prdctTy=" + prdctTy +
						"&sdate=" + sdate +
						"&edate=" + edate +
						"&iNum=" + iNum + 
					 	"&sort=" + ty + sort;
		if(sort=="D"){
			sort = "A";
		}else{
			sort = "D";
		}
		
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#prdctInfo").fadeIn(500);
				$("#prdctInfo").html(data);
				$("#prdctInfo").tablesorter();
				
				$("#allReceivBtn").css("display","inline");
				$("#allAllowBtn").css("display","inline");
			}
		});
		
		},500)
	}
	
	function orderPrdct(){
		var menu = $("#order").val();
		if(menu=="1"){
			window.sessionStorage.setItem("prdct",1);
		}else if(menu=="2"){
			window.sessionStorage.setItem("prdct",2);
		}else if(menu=="3"){
			window.sessionStorage.setItem("prdct",3);
		}else if(menu=="4"){
			window.sessionStorage.setItem("prdct",4);
		}else if(menu=="5"){
			window.sessionStorage.setItem("prdct",5);
		}
		$.mobile.changePage(($(document.location.href="${ctxPath}/prdct/indexPrdctConfirmForm.do")),{reloadPage:true});
		//location.href="${ctxPath}/prdct/indexPrdctConfirmForm.do";
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
		}else if(menu=="5"){
			window.sessionStorage.setItem("order",5);
		}
		
		getOrderList();
	}
	
	var confirmChk = true;
	var receiveCnt = 0;
	function receivePrdct(id, prdctId,cnt,iNum, prdctTy){
		
		if(confirmChk){
			if(confirm("제품을 수령하셨습니까?")==false){
				return;
			}	
		}
		
		
		var param = "id=" + id;
		var url = "${ctxPath}/prdct/receivePrdct.do";
		
		$.ajax({
			url : url,
			data : param,
			type : "post",
			success : function(data){
				if(data.trim()=="success"	){
					if(sort=="D"){
						sort = "A";
					}else{
						sort = "D";
					}
					receiveCnt ++;
					confirmChk = false;
					addInvn(id, prdctId,cnt,iNum, prdctTy);
					if(chkboxLength == receiveCnt || chkboxLength=="0"){
						alert("재고에 추가되었습니다.");
						confirmChk = true;
						receiveCnt = 0;
						getOrderList();
					}
					
				}
			}
		}); 
	}
	
	
	function addZero(n){
		if(n.length=="1"){
			n  = "0" + n;
		}
		return n;
	}
	//해당 제품 제고 등록
	function addInvn(id, prdctId,cnt,iNum, prdctTy){
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(String(date.getMonth()+1));
		var day = addZero(String(date.getDate()));
		var today = "" + year + month + day;
		var param = "prdctId=" + prdctId + 
						"&shopId=" + shopId + 
						"&cnt=" + cnt + 
						"&iNum=" + iNum + 
						"&comTy=" + prdctTy + 
						"&datetime=" + today ;
		var url = "${ctxPath}/prdct/addShopInvn.do";
		
		$.ajax({
			url : url,
			data : param,
			type : "post",
			success : function(data){
				console.log(data);
			}
		});
	};
	
		var orderid;
		function getEditForm(id){
			var prdctTy = window.sessionStorage.getItem("order"); 
			orderId = id;
			var param = "id=" + id + 
							"&comTy=" + prdctTy + 
							"&chkTy=order";
			var url = "${ctxPath}/invn/getComPrdctEditForm.do";
			$.ajax({
				url : url,
				dataType : "json",
				data : param,
				type : "post",
				success : function(data){
					console.log(data)
					iNum = data.inum;
					brandId = data.brandId;
					prdctId = data.prdctId;
					comPrdctId = data.id;
					$("#PrdctInfo" + prdctTy + " input[id='mnfCountry']").val(data.mnfCountry);
					$("#PrdctInfo" + prdctTy + " input[id='puchasPrc']").val(format(data.puchasPrc));
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
					
					 /* $('#dialog' + prdctTy).dialog({
							//bgiframe: true
							 title: "확인"
							 , modal: true
						     , width: 1100 // 가로 크기
						     , background: "#000"
						    	 , position:{my:"center",at:"top",of: window }
							 , close: function(event, ui){
							}, success:  function(data) {
								
							} 
						}); */
						
						$("#dialog" + prdctTy).popup('open');
				},
				error : function(e1, e2, e3){
					console.log(e1,e2,e3)
				}
			});
			
		}
		
		
		var sum = 0;
		var total = 0;
		var cnt = 0;
		var tax = 0;
		function getSum(n, ty){
			console.log(n, ty)
			if(ty=="sum_"){
				sum += n;
				n = sum;
			}else if(ty=="total_"){
				total += n;
				n = total;
			}else if(ty=="cnt_"){
				cnt += n;
				n = cnt;
				console.log(cnt)
			}else if(ty=="tax_"){
				tax += n;
				n = tax;
			}
			$("#" + ty).html(format(parseInt(n)))
		}
			
		function format(n) {
			  var reg = /(^[+-]?\d+)(\d{3})/;   
			  n += '';                          

			  while (reg.test(n))
			    n = n.replace(reg, '$1' + ',' + '$2');

			  return n;
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
			
			$("#receipt").popup('open');
		}
		
		function removeHypen(str){
			var result = str.replace(/-/gi,"");
			
			return result;
		}
		
		
		function getReceiptHeader(){
			sum = 0;
			tax = 0;
			total = 0;
			cnt = 0;
			var sdate = removeHypen($("#sdate").val());
			var edate = removeHypen($("#edate").val());
			var iNum = $("#iNum").val();
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
																		  "&edate=" + edate,"거래 명세서");
			
			
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
					$("#comList").popup('open');
					/* $("#comList").dialog({
						title : "거래처 목록",
						width : 1000,
						height : 800
					}); */
				}
			});
		};
		
		function cancelOrder(id){
			var prdctTy = window.sessionStorage.getItem("order"); 
			if(confirm("구매를 취소하시겠습니까?")==false){
				return;
			}
			var param = "id=" + id + 
							"&comTy=" + prdctTy;
			var url = "${ctxPath}/prdct/cancelOrder.do";
			
			$.ajax({
				url : url,
				data : param,
				type : "post",
				success : function(data){
					if(data=="ok"){
						if(sort=="D"){
							sort = "A";
						}else{
							sort = "D";
						}
						alert("구매가 취소되었습니다.");
						getOrderList();
					}
				},
				error: function(e1, e2, e3){
					alert(e2)
				}
			});
		}
		
		var orderPrdctId;
		function returnOrder(prdctId, cnt){
			orderPrdctId = prdctId;
			returnCnt = cnt;
			
			$("#returnCnt").val(cnt)
			console.log(cnt)
			/* $("#returnCnt").val(cnt);
			$("#returnDiv").dialog({
				title : "반품",
				width : 300,
				height : 200
			}); */
			
			$("#returnDiv").popup("open");
		}
		
		
		function addNewRtnReason(){
			var returnReason = $("#returnMsg").val(); 
			var returnCnt = $("#returnCnt").val();
			var url = "${ctxPath}/prdct/addNewRtnReason.do";
			var param = "id=" + orderPrdctId + 
							"&returnCnt=" + returnCnt + 
							"&returnReason=" + returnReason;
			
			$.ajax({
				url :url,
				dataType : "text",
				type : "post",
				data : param,
				success : function(data){
					if(data=="success"){
						if(sort=="D"){
							sort = "A";
						}else{
							sort = "D";
						}
						alert("반품신청이 완료되었습니다.");
						getOrderList();
						$("#returnDiv").popup("close");
				}
			}
		})
	}
		function ReturnPrdct(){
			if(confirm("반품하시겠습니까?")==false){
				return;
			}
			var returnReason = $("#returnReason").val();
			if(returnReason=="-2"){
				addNewRtnReason();
				return;
			}
			var returnCnt = $("#returnCnt").val();
			var url = "${ctxPath}/prdct/ReturnPrdct.do";
			var param = "id=" + orderPrdctId + 
							"&returnCnt=" + returnCnt + 
							"&returnReason=" + returnReason;
			
			$.ajax({
				url : url,
				data : param,
				type : "post",
				success : function(data){
					if(data=="success"){
						if(sort=="D"){
							sort = "A";
						}else{
							sort = "D";
						}
						alert("반품신청이 완료되었습니다.");
						getOrderList();
						$("#returnDiv").popup("close");
					}
				}
			});
		}
		

		function chkRtnReason(){
			var rtn = $("#returnReason").val();
			if(rtn=="-2"){
				$("#returnReason_").css("display","none");
				$("#returnMsg").css("display","inline");
			}
		}
		
		var chkboxLength = 0;
		function receiveChk(){
			chkboxLength = 0;
			var length = $("input:checkbox[name='delChk']:checked").length;
			if(length=="0"){
				alert("선택된 항목이 없습니다.");
				return;
			}
			
			$("input[name=delChk]:checked").each(function() {
				
				var id = $(this).val();
				/* chkboxLength = $("input:checkbox[name='delChk']:checked").length; */
				
				var param = "id=" + id;
				var url = "${ctxPath}/prdct/getOrderPrdctProp.do";
				
				$.ajax({
					url : url,
					data : param,
					dataType : "json",
					type : "post",
					success : function(data){
						chkboxLength++;
						console.log(data)
						receivePrdct(data.id, data.prdctId, data.cnt, data.inum, data.prdctTy);
						
						confirmChk = false;
					}
				}); 
			});
		}
		
		function checkAll(){
			$("input[name=delChk]:checkbox").each(function() {
				$(this).prop("checked", true);
			})
		}
		
		function uncheckAll(){
			$("input[name=delChk]:checkbox").each(function() {
				$(this).prop("checked", false);
			});
		}
		
		
		function chkAdminAllow(id){
			var param = "id=" + id;
			var url = "${ctxPath}/prdct/chkAdminAllow.do";
			var result = false;
			
			$.ajax({
				url : url,
				data : param,
				dataType : "text",
				type : "post",
				success : function(data){
					if(data.trim()=="allow"){
						result = true;
						console.log("result=" + result)
					}else{
						result = false;
					}
				}
			});
			return result;
		}
		function allowComOrder(id, prdctId,cnt,iNum, prdctTy){
			var length = $("input:checkbox[name='delChk']:checked").length;
			
			

			if(confirmChk){
				if(confirm("확인과 동시에 배송완료, 재고추가가 됩니다.")==false){
					return;
				}	
			}
			
			if(length!="0"){
				confirmChk = false;
			}
			
			var param = "id=" + id;
			var url = "${ctxPath}/prdct/allowComOrder.do";
			
			$.ajax({
				url : url,
				data : param,
				dataType : "text",
				type : "post",
				success : function (data){
					confirmChk = false;
					console.log(data)
					if(data=="success"){
						addInvn(id, prdctId,cnt,iNum, prdctTy);
						getOrderList();
						getComOrderCnt();
					}else if(data=="reject"){
						alert("본사 승인 전입니다.");
						confirmChk = true;
					}
					
				}
			}); 
		}
		
		function allowChk(){
			chkboxLength = 0;
			var length = $("input:checkbox[name='delChk']:checked").length;
			if(length=="0"){
				alert("선택된 항목이 없습니다.");
				return;
			}
			
				$("input[name=delChk]:checked").each(function() {
				
					
				
				var id = $(this).val();
				/* chkboxLength = $("input:checkbox[name='delChk']:checked").length; */
				console.log(id)
				
				var param = "id=" + id;
				var url = "${ctxPath}/prdct/getOrderPrdctProp2.do";
				
				$.ajax({
					url : url,
					data : param,
					dataType : "json",
					type : "post",
					success : function(data){
						chkboxLength++;
						//console.log(data)
						allowComOrder(data.id, data.prdctId, data.cnt, data.inum, data.prdctTy);
						
					}
				}); 
			});
		}
</script>
<style type="text/css">
	.before{
		color: red;
	}
	.after, .complete{
		color: blue;
	}
	.title{
		font-size :13px;
		cursor: pointer;
	}
	.dialog,#receiptList{
		display: none;
	}
	.prdctImg{
		height : 150px;
	}
	.td{
		font-size: 13px;
	}
	.grayClass{
		background-color: #d3d3d3;
	}
	.whiteClass{
		background-color: white;
	}
	#returnMsg{
		display: none;
	}
	.redTr{
		background-color: #ffd700;
	}
	#allReceivBtn, #allAllowBtn{
		display: none;
	}
</style>
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
			<option value="1" >프레임</option>
			<option value="2">렌즈</option>
			<option value="3">콘텍트렌즈</option>
			<option value="4">렌즈용액</option>
			<option value="5">기타</option>
		</select>
		<button onclick="getReceiptForm()">거래 명세서</button>
		<button onclick="getListCom()">거래처 목록</button> 
		</div>
		
		<span style="float: right;font-size: 12px" id="comOrderCnt"></span>
		
		
		<center>
			<div data-role = "fieldcontain" >
			<label><select  id="iNumB"onchange="getOrderList();" data-inline="true">
						<option value="-1">선택</option>
					 </select> 
			</label>
			<label style="margin-left: 100px;"><input type="text" id="sdate_" class="sdate" onchange="getOrderList()" data-role="date"></label>
			
			<label><input type="text" id="edate_" class="edate" onchange="getOrderList()" data-role="date"></label>
			</div>
		</center>
		
		<button onclick="checkAll()" data-mini="true" data-inline="true" style="float:left;">전체선택</button>
		<button onclick="uncheckAll()" data-mini="true" data-inline="true" style="float:left;">전체해제</button>
		<br>
		<span style="color: #ffd700;font-weight: bold;background: black;float: left;">※노란 색 줄은 매장주문 대행 건입니다.</span>
		
		<table id="prdctInfo" class='tablesorter-ice' width="100%" border="1" style="border-collapse: collapse; text-align: center">
	
		</table>
			<button data-inline="true" data-mini="true" id="allReceivBtn" onclick="receiveChk();">배송확인</button>
			<button data-inline="true" data-mini="true" id="allAllowBtn" onclick="allowChk();">승인</button>
		
<div data-role="popup" id="dialog1" data-theme="a" class="ui-corner-all">
<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<br>
<br>
<center>
	<form id="PrdctInfo1">
		<table class="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
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
				<th>제품 설명</th><td colspan="4" align="left"> <textarea  rows="5" cols="80" id="memo" readonly="readonly"> </textarea> </td>
			</tr>
			<tr>
				<td id="img" colspan="4"></td>
			</tr>
			
			
		</table>
		
	</form>		
		
</center>
</div>


<!-- 렌즈 -->

<div data-role="popup" id="dialog2" data-theme="a" class="ui-corner-all">
<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<br>
<br>
<center>
	<form id="PrdctInfo2">
		<table class="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
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
				<th>제품 설명</th><td colspan="4" align="left"><textarea  rows="5" cols="80" id="memo" readonly="readonly"></textarea> </td>
			</tr>
		</table>
	</form>		
		
</center>
</div>

<!--콘텍트-->

<div data-role="popup" id="dialog3" data-theme="a" class="ui-corner-all">
<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<br>
<br>
<center>
	<form id="PrdctInfo3">
		<table class="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
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
				<th>제품 설명</th><td colspan="4" align="left"><textarea  rows="5" cols="80" id="memo" readonly="readonly"></textarea> </td>
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
		<table class="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
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
				<th>제품 설명</th><td colspan="4" align="left"><textarea  rows="5" cols="80" id="memo" readonly="readonly"></textarea> </td>
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
					<th>거래처</th><td><select id="iNum" data-inline="true" data-mini="true"><option value="-1">목록</select></td><th width="10%">매장</th> <td><select id="shopId" disabled="disabled" data-inline="true" data-mini="true" data-role="none"><option value="-1">목록</select></td><td><button onclick="getReceiptHeader(); return false;" data-inline="true" data-mini="true">확인</button></td>
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
	</center>
	
		
<div data-role="popup" id="returnDiv" data-theme="a" class="ui-corner-all"style="padding: 20px;">
	<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<center>
	<div data-role="fieldcontain">
	<label>수량 </label>
	<label><input type="number" id="returnCnt" size="3" data-role="none"></label>
	<label>사유</label>	
	
	<label>
	<div id="returnReason_">
	<select id="returnReason" data-inline="true" id="returnCd" onchange="chkRtnReason();">
		   		<option value="-1">사유</option>
		  </select>
		  
	</div>
	<input type="text" id="returnMsg">
	</label>
	
	<button onclick="ReturnPrdct();" data-inline="true">확인</button>
	</div>
</center>
</div>


<div data-role="popup" id="detailpopup" data-theme="a" class="ui-corner-all"style="width: 300px">
	<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
	<br>
	<div id="detailDiv"></div>
	<br>
</div>

</body>
</html>