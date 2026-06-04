<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ include file="/WEB-INF/views/include/unomiclib.jsp"%>
<%@ page import="com.gallery.common.CommonCode"%>

<%--  공통 context 부분  --%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />

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

<%

	String shopId = request.getParameter("shopId");
	String iNum = request.getParameter("iNum");

%>
<script type="text/javascript">
		var shopId;
		var iNumForOrd = "<%=iNum%>";
		var comOrder = 0;
		if(iNumForOrd.indexOf("null")==-1){
			comOrder = 1;
		}
		if('${shopId}'==''){
			shopId = <%=shopId%>;

		}else{
			shopId = '${shopId}';
		}
		var shopName;
		var mnfCountry = 1;
		var iNum;
		var prdctId;
		var ty1;
		var ty2;
		var ty3;
		var cnt = "";
		var cyl;
		var sph;
		var cnt;
		var colorCom;
		var colorCd;
		var colorOpacity;
	 	$(function(){
	 		getShopName();
	 		getRtnReasonList();
	 		$(".lensSpecVal").attr("disabled",true);
	 		$(".lensSpecValM").attr("disabled",true);
	 		$(".notUse").attr("disabled",true);
	 		$(".notUse").css("background-color","#dcdcdc");
	 		now();
	 		getOrderList();
	 	});

	 	function getShopName(){
	 		var url = "${ctxPath}/shop/getshopName.do";
	 		var param = "shopId=" + shopId;

	 		$.ajax({
	 			url : url,
	 			data : param,
	 			dataType : "text",
	 			type :"post",
	 			success : function(data){
	 				shopName = decodeURIComponent(data);
	 			}
	 		});
	 	};

	 	function comAllow(id){
			if(confirm("승인하시겠습니까?")==false){
				return;
			}
			var param = "id=" + id;
			var url = "${ctxPath}/prdct/comAllow.do";

			$.ajax({
				url : url,
				data : param,
				dataType : "text",
				type : "post",
				success : function(data){
					if(data=="success"){
						alert("승인되었습니다.");

						/* if(sort=="D"){
							sort = "A";
						}else{
							sort = "D";
						} */

						getOrderList();
					};
				}
			});
		}

	 	function now(){
	 		var date = new Date();
	 		var year = date.getFullYear();
	 		var month = addZero(String(date.getMonth() + 1));
	 		var day = addZero(String(date.getDate()));

	 		$("#sdate").val(year + "-" + month + "-" + day);
	 		$("#edate").val(year + "-" + month + "-" + day);
	 	}
	 	function inputDisabled(obj){
	 		if($(obj).is(":checked")==true){
	 			$(".lensSpecVal").attr("disabled",false);
	 			$(".lensSpecValM").attr("disabled",true);
	 			$(".lensSpecValM").val("");
	 		}else{
	 			$(".lensSpecVal").attr("disabled",true);
	 			$(".lensSpecVal").val("");
	 		}
	 	}

	 	function inputDisabled2(obj){
	 		if($(obj).is(":checked")==true){
	 			$(".lensSpecValM").attr("disabled",false);
	 			$(".lensSpecVal").attr("disabled",true);
	 			$(".lensSpecVal").val("");
	 			$("#lensSizeM").css("display","none");
	 		}else{
	 			$(".lensSpecValM").attr("disabled",true);
	 			$(".lensSpecValM").val("");
	 			$("#lensSizeM").css("display","inline");
	 		}
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

	 	var sort = "";
	 	var sortTy = "D";
	 	function getOrderList(ty){
	 		sort = ty;

	 		console.log(sort);
	 		if(typeof(sort)=="undefined"){
	 			sort = "dft";
	 		}

	 		var sdate = removeHypen($("#sdate").val());
	 		var edate = removeHypen($("#edate").val());
	 		var url = "${ctxPath}/prdct/getLensOrderList.do";

	 		var param = "shopId=" + shopId +
	 						"&sdate=" + sdate +
	 						"&edate=" + edate +
	 						"&sort=" +sort + sortTy;
	 		console.log(param);
	 		$.ajax({
	 			url : url,
	 			dataType : "html",
	 			type: "post",
	 			data : param,
	 			success : function(data){
	 				$(".orderBtn").buttonMarkup();
	 				$("#orderList").html(data);
	 				$("#orderList").tablesorter();

	 				if(sortTy=="D"){
						sortTy = "A";
	 				}else{
	 					sortTy = "D";
	 				}
	 			}
	 		});
	 	}

	 	function cancelOrder(id){
	 		if(confirm("삭제하시겠습니까?")==false){
	 			return;
	 		}
	 		var param = "id=" + id;
			var url = "${ctxPath}/prdct/cancelOrder.do";

				$.ajax({
				url : url,
				data : param,
				type : "post",
				success : function(data){
					if(data=="ok"){
						alert("구매가 취소되었습니다.");

						if(sortTy=="D"){
							sortTy = "A";
						}else{
							sortTy = "D";
						}

						getOrderList(sort);

					}
				},
				error: function(e1, e2, e3){
					alert(e2)
				}
			});

	 	}

	 	function addCnt(obj,obj2){

		   console.log(obj);
		   console.log(obj2);

		   var inputId = obj2.split("/");

		   var cyl = inputId[0];
		   var sph = inputId[1];

		   var cnt = $(obj).val();

		   console.log(sph + " / " + cyl + " / " + cnt );

		   if(chkArrayVal(cyl, sph, cnt)==true){
		   }else{
			   var order = new Array();
			   if(cnt!=""){
				   order.push(cyl, sph, cnt);
				   ORDERLIST.push(order);
			   };
		   }
	 	};

	 	function chkArrayVal(cyl, sph, cnt){
			var result = false;

	 		for(var i = 0; i < ORDERLIST.length; i++){
 				if(cyl == ORDERLIST[i][0] && sph == ORDERLIST[i][1]){
 					ORDERLIST[i][2] = cnt;
 					result = true;
 				}
	 		}

	 		return result;
	 	}

	 	function getComList(t,obj){
	 		$(".ty2Btn").removeClass('redBtn');
	 		$(obj).addClass('redBtn')

	 		if(t=="g"){
	 			t = "P.G.O";
	 		}else if(t=="p"){
	 			t = "Pascal";
	 		}
	 		ty2 = t;

	 		var param = "type1=" + ty1 +
	 					"&type2=" + ty2;
	 		var url = "${ctxPath}/prdct/getLensComList.do";

	 		$.ajax({
	 			url : url,
	 			data : param,
	 			dataType : "html",
	 			type : "post",
	 			success : function(data){
	 				$("#iNumList").html(data);
	 				$('[data-role=collapsible]').collapsible().trigger('create');
					$("#iNumList").listview('refresh');
					$(".comList").listview('refresh');
	 			}
	 		});
	 	}

	 	function getTy2(){
	 		var ty = $(":radio[name='ty1']:checked").val();
	 		ty1 = ty;
	 		$("#ty2Field").css("display","inline");
	 		$(".ty2Btn").removeClass('redBtn');
	 		$(".ty3Btn").removeClass('redBtn');
	 		/* var content = "<label for='pgo'>P.G.O</label><input type='radio'data-inline='true' data-mini='true' id='pgo' name='ty2' value='pgo' onclick='getComList(\"g\")'>" +
	 						 "<label for='pas'>파스칼</label><input type='radio' data-inline='true' data-mini='true' id='pas' name='ty2' value='pas'  onclick='getComList(\"p\")'>";

	 						 $("#ty2Field").html(content); */

	 						// $("input[type='radio']").checkboxradio();
	 						 //$("input[type='radio']").checkboxradio("refresh");
	 	}

	 	function getLensList(ty3_,obj){
	 		$(".SMBtn").removeClass('redBtn');
	 		$(obj).addClass('redBtn');

	 		ty3 = ty3_;
	 		var param = "mnfCountry=" + mnfCountry +
	 						"&iNum=" + iNum +
	 						"&type1=" + ty1 +
	 						"&type2=" + ty2 +
	 						"&type3=" + ty3;

	 		var url = "${ctxPath}/prdct/getLensListForOrder.do";

	 		$.ajax({
	 			url : url,
	 			dataType : "html",
	 			data : param,
	 			type : "post",
	 			success : function(data){
	 				$("#prdctList").html(data);
	 				$("#prdctList").listview("refresh");
	 				$("#popupMenu").popup('open',{transition:"flow",positionTo:"origin"});
	 			}
	 		});

	 	}

	 	function setOrigin(n){
	 		mnfCountry = n;
	 		$(".prdctNameSpan").html("");
	 		mnfCountry = n;

	 		var param = "";

	 		var url = "";

	 		if(iNumForOrd.indexOf("null")==0){
	 			url = "${ctxPath}/prdct/getComListByCntry.do";
	 			param = "mnfCountry=" + n;

	 		}else{
	 			url = "${ctxPath}/prdct/getComListForComOrd.do";
	 			param = "mnfCountry=" + n
	 					+ "&iNum=" +iNumForOrd;

	 		}

	 		console.log(param)
	 		$.ajax({
	 			url : url,
	 			data : param,
	 			dataType : "html",
	 			type : "post",
	 			success : function(data){
	 				$("#iNumGroup").html(data);
	 				$("#iNumGroupHr").css("display","block");
	 				$(".btn").buttonMarkup();
	 				$("#iNumGroup").trigger('create');
	 			}
	 		});
	 	}

	 	function getLensTyByCom(iNum_,obj){
	 		iNum = iNum_;
	 		$(".btn").removeClass("redBtn");
	 		$(".type3Btn").removeClass("redBtn");
	 		$(obj).addClass('redBtn');

	 		$("#ty3GroupHr").css("display","none");
	 		$("#ty3Group").css("display","none");
	 		$("#SMGroupHr").css("display","none");
	 		$("#SMGroup").css("display","none");
	 		$(".prdctNameSpan").html("");
			//여기

	 		var param = "iNum=" + iNum;

	 		var url = "${ctxPath}/prdct/getLensTyByCom.do";

	 		$.ajax({
	 			url : url,
	 			data : param,
	 			dataType : "html",
	 			type : "post",
	 			success : function(data){
	 				$("#lensTyGroup").html(data);
	 				$(".ty1Btn").buttonMarkup();
	 			}
	 		});
	 	}
	 	function formatPrc(n) {
			  var reg = /(^[+-]?\d+)(\d{3})/;
			  n += '';

			  while (reg.test(n))
			    n = n.replace(reg, '$1' + ',' + '$2');

			  return n;
			}

	 	var puchasPrc;
	 	var optionTy;
	 	var prdctSpec;
	 	var prdctName;
	 	function selectLens(id, name, curve, prc, option){
	 		prdctName = name + " " + curve;
	 		optionTy = option;
	 		prdctId = id;
	 		puchasPrc = prc;
	 		$(".SMGroupHr").css("display","block");
	 		$(".prdctNameSpan").html(name + " " + curve + " (" + formatPrc(prc) + "원)");
	 		prdctSpec = name + " " + curve + " (" + formatPrc(prc) + "원)";
	 		$("#popupMenu").popup("close");
	 		if(ty1=="spare" && ty3=="Single"){
	 			$("#eTypeDiv").css("display","inline");
	 			$("#detailBtnRXS").css("display","none");
	 			$("#detailBtnRXM").css("display","none");
	 			$("#optionBtnRXS").css("display","none");
	 			$("#optionBtnRXM").css("display","none");
	 			$("#eTypeDiv2").css("display","none");
	 			$(".rxPrdctSpecS").css("display","none");
	 			$(".rxPrdctSpecM").css("display","none");
	 			$("#rxSingForm input[id='colorCd']").val("");
				$("#rxMultiForm input[id='colorCd']").val("");
	 		}else if(ty1=="rx" && ty3=="Single"){
	 			$("#detailBtn").css("display","none");
	 			$("#optionBtn").css("display","none");
	 			$("#detailBtnRXS").css("display","inline");
	 			$("#detailBtnRXM").css("display","none");
	 			$("#optionBtnRXS").css("display","inline");
	 			$("#optionBtnRXM").css("display","none");
	 			$("#eTypeDiv").css("display","none");
	 			$("#eTypeDiv2").css("display","inline");
	 			$(".boundDiv").css("display","none");
	 			$("#orderBtn").css("display","none");
	 			$(".rxPrdctSpecS").css("display","inline");
	 			$(".rxPrdctSpecM").css("display","none");
	 			$("#rxSingForm input[id='colorCd']").val("");
				$("#rxMultiForm input[id='colorCd']").val("");
				getPrdctOption();
	 		}else if(ty1=="rx" && ty3=="Multi"){
	 			$("#detailBtnRXS").css("display","none");
	 			$("#detailBtnRXM").css("display","inline");
	 			$("#optionBtnRXS").css("display","none");
	 			$("#optionBtnRXM").css("display","inline");
	 			$("#detailBtn").css("display","none");
	 			$("#eTypeDiv").css("display","none");
	 			$("#eTypeDiv2").css("display","inline");
	 			$(".boundDiv").css("display","none");
	 			$("#orderBtn").css("display","none");
	 			$(".rxPrdctSpecS").css("display","none");
	 			$(".rxPrdctSpecM").css("display","inline");
	 			$("#rxSingForm input[id='colorCd']").val("");
				$("#rxMultiForm input[id='colorCd']").val("");
				getPrdctOption();
	 		}else if(ty1=="spare" && ty3=="Multi"){
	 			$("#detailBtnRXS").css("display","none");
	 			$("#detailBtnRXM").css("display","inline");
	 			$("#optionBtnRXS").css("display","none");
	 			$("#optionBtnRXM").css("display","inline");
	 			$("#detailBtn").css("display","none");
	 			$("#eTypeDiv").css("display","none");
	 			$("#eTypeDiv2").css("display","inline");
	 			$(".boundDiv").css("display","none");
	 			$("#orderBtn").css("display","none");
	 			$(".rxPrdctSpecS").css("display","none");
	 			$(".rxPrdctSpecM").css("display","inline");
	 			$("#rxSingForm input[id='colorCd']").val("");
				$("#rxMultiForm input[id='colorCd']").val("");
				getPrdctOption();
	 		}

	 	}

	 	var addPrc;
	 	function addOptionPrc(){
	 		var lensSpec;
	 		if(ty1=="spare" && ty3=="Single"){
	 			lensSpec = $("#optionBtnSlct option:selected	").text();
	 		}else if(ty1=="spare" && ty3=="Multi"){
	 			lensSpec = $("#optionBtnRXMSlct option:selected	").text();
	 		}else if(ty1=="rx" && ty3=="Single"){
	 			lensSpec = $("#optionBtnRXSSlct option:selected	").text();
	 		}else if(ty1=="rx" && ty3=="Multi"){
	 			lensSpec = $("#optionBtnRXMSlct option:selected	").text();
	 		}

	 		var prdctName = lensSpec.substr(0,lensSpec.lastIndexOf("(")-1);
	 		var prc = lensSpec.substring(lensSpec.lastIndexOf("+")+1,lensSpec.lastIndexOf("원"));
			addPrc = removeComma(prc);
	 		$(".prdctNameSpan").html(prdctSpec + " + "  + prdctName + "(" + prc + "원)");
	 	}

	 	function removeComma(str){
	 		str = str.replace(/,/gi,"");
	 		return str;
	 	}

	 	function removeHypen(str){
	 		str = str.replace(/-/gi,"");
	 		return str;
	 	}
	 	var totalOrder = 0;
	 	function orderLens(){
	 		if(confirm("주문하시겠습니까?")==false){
	 			return;
	 		}
	 		if(cnt==""){
	 			alert("수량을 입력하세요.");
	 			return;
	 		}
	 		var param = "iNum=" + iNum +
							"&shopId=" + shopId +
							"&prdctId=" + prdctId +
							"&cnt=" + cnt +
							"&CYL=" + cyl +
							"&SPH=" + sph +
							"&puchasPrc=" + puchasPrc;


	 		var url = "${ctxPath}/prdct/lensOrder.do";

	 		$.ajax({
	 			url : url,
	 			dataType : "text",
	 			data : param,
	 			type : "post",
	 			success : function(data){
	 				if(data=="success"){
 						alert("주문이 완료되었습니다.");
 						$("#detail").val("");
	 					getOrderList();
	 					/* $.mobile.changePage("#orderDiv", {transition:"flow"}); */
	 				}
	 			}
	 		});
	 	}

	 	function addTZero(n){
	 		if(n.length=="1"){
	 			n = "000" + n;
	 		}else if(n.length=="2"){
	 			n = "00" + n;
	 		}else if(n.length=="3"){
	 			n = "0" + n;
	 		}
	 		return n;
	 	}

	 	function addDZero(n){
	 		if(n.length=="1"){
	 			n = "00" + n;
	 		}else if(n.length=="2"){
	 			n = "0" + n;
	 		}
	 		return n;
	 	}


	 	function addZeroX(n){
	 			if(n.length=="1"){
	 				n = "00" + n;
	 			}else if(n.length=="2"){
	 				n = "0" + n;
	 			}
	 			return n;
	 	}

	 	function addZeroY(n){
 			if(n.length=="1"){
 				n = "000" + n;
 			}else if(n.length=="2"){
 				n = "00" + n;
	 		}else if(n.length=="3"){
				n = "0" + n;
			}
 			return n;
 		}

		 var ORDERLIST = new Array();

	 	function getLensBound(t){
	 		ORDERLIST = new Array();
	 		var param = "type=" + t;
	 		var url = "${ctxPath}/prdct/getLensBound.do";

	 		$.ajax({
	 			url : url,
	 			dataType : "json",
	 			data : param,
	 			type : "post",
	 			success : function(data){

	 				var xSign;
	 				var ySign;
	 				if(t=="g"){
	 					xSign = "-";
	 					ySign = "-";
	 				}else if(t=="w"){
	 					xSign = "+";
	 					ySign = "+";
	 				}else if(t=="b"){
	 					xSign = "-";
	 					ySign = "+";
	 				}

	 				var x1 = data.x1;
	 				var y1 = data.y1;
	 				var x2 = data.x2;
	 				var y2 = data.y2;
					var n = data.data;
					var index = 0;
					var head;
					var content = "";
					var xVal = 0;
					var yVal = -25;
						for(var i = y1-25; i <= y2; i+=25){
							content += "<tr>";
							for(var j = x1-25; j <= x2; j+=25){
								if(i<y1 && j<x1){
									content += "<td>S/C</td>";
								}else if(i<y1){
									content += "<td class='lensSpecTD'>" + xSign + addDZero(String(j)) + "</td>";
								}else if(j<x1){
									content += "<td class='lensSpecTD'>" + ySign  + addTZero(String(i)) + "</td>";
								}else{
									content += "<td class='A" + n.charAt(index) + "' id=" + xSign + addZeroX(String(xVal)) + "/" + ySign + addZeroY(String(yVal)) + ">&nbsp;</td>";
									index++;
									xVal+=25;
									if(xVal==425){
										xVal=000;
									}
								}
							}
							yVal+=25;
							if(yVal==2025){
								yVal = 0;
							}
							content += "</tr>";
						}

						getPrdctOption();

						$(".boundDiv").css("display","none");
						$("#" + t + "Div").css("display","inline");
						$("#orderBtn").css("display","inline");
						$("#detailBtn").css("display","inline");
						$("#optionBtn").css("display","inline");
						$("#gDiv").html("");
						$("#wDiv").html("");
						$("#bDiv").html("");
						$("#" + t + "Div").html(content);


						$("td").css("height","25");
						$("td").css("width","40");
						$(".boundDiv").css("font-size","10");
						$(".A1").click(function(){
							if($(this).html()=="&nbsp;"){
								var inputId = String(this.id);
								console.log(inputId)
								var input = "<input type='text' size='3' onBlur='addCnt(this,\"" + inputId + "\")' class='lensSpecFont'>";
								$(this).append(input);
								$(this).children('input').focus();
							}
						});
	 			}
	 		});
	 	}


	 	function cntOrderList(){
	 		for(var i = 0; i < ORDERLIST.length; i++){
 				orderPrdct(ORDERLIST[i][0],ORDERLIST[i][1],ORDERLIST[i][2]);
				orderConfirm = false;
	 		}
	 	}

	 	var orderConfirm = true;
	 	function orderPrdct(cyl, sph, cnt){

	 		if(orderConfirm){
	 			if(confirm("주문하시겠습니까?")==false){
		 			return;
	 			}
	 		}
		 	var optionId;
		 	if(ty1=="spare" && ty3=="Single"){
		 		optionId = $("#optionBtnSlct").val();
	 		}else if(ty1=="rx" && ty3=="Single"){
	 			optionId = $("#optionBtnRXSSlct").val();
	 		}else if(ty1=="rx" && ty3=="Multi"){
	 			optionId = $("#optionBtnRXMSlct").val();
	 		}else if(ty1=="spare" && ty3=="Multi"){
	 			optionId = $("#optionBtnRXMSlct").val();
	 		}

	 		var param = "iNum=" + iNum +
							"&shopId=" + shopId +
							"&prdctId=" + prdctId +
							"&cnt=" + cnt +
							"&CYL=" + cyl +
							"&SPH=" + sph +
							"&puchasPrc=" + Number(puchasPrc) +
							"&optionPrc=" + Number(addPrc) +
							"&detail=" + nl2br(encodeURIComponent($("#detail").val())) +
							"&optionId=" + optionId;

	 		var url = "";
	 		if(iNumForOrd.indexOf("null")==0){
	 			url = "${ctxPath}/prdct/lensOrder.do";
	 		}else{
	 			url = "${ctxPath}/prdct/lensComOrder.do";
	 		}


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
	 						$("#detail").val("");
	 						totalOrder = 0;
	 						addPrc= 0;
	 						gcm(cnt);
	 						getLensBound('g');
	 					}

	 					getOrderList();
	 					/* $.mobile.changePage("#orderDiv", {transition:"flow"}); */
	 				}
	 			}
	 		});
	 	}

	 	function gcm(cnt){
	 		var url = "https://jaguar.s4g.kr/GalleryTalk/comm/sendMsg.do";
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
				success : function(data){
					console.log("gcm result : " + data)
				}
			});
	 	};

	 	function receivePrdct(id, prdctId,cnt,iNum, puchasPrc){
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

						//alert("재고에 추가되었습니다.");

						if(sortTy=="D"){
							sortTy = "A";
						}else{
							sortTy = "D";
						}

						getOrderList(sort);
						addInvn(id, prdctId,cnt,iNum, puchasPrc);
					}
				}
			});
		}

	 	function addZero(n){
			if(n.length=="1"){
				n = "0" + n;
			}
			return n;
		}

	 	//해당 제품 제고 등록
		function addInvn(id, prdctId,cnt,iNum, puchasPrc){
			var date = new Date();
			var year = date.getFullYear();
			var month = addZero(String(date.getMonth()+1));
			var day = addZero(String(date.getDate()));
			var today = "" + year + month + day;
			var param = "prdctId=" + prdctId +
							"&shopId=" + shopId +
							"&cnt=" + cnt +
							"&iNum=" + iNum +
							"&datetime=" + today+
							"&puchasPrc=" + puchasPrc;
			var url = "${ctxPath}/prdct/addShopLensInvn.do";

			$.ajax({
				url : url,
				data : param,
				type : "post",
				success : function(data){
					console.log('invn');
				}
			});
		};


		var orderPrdctId;
		function returnOrder(prdctId, cnt){
			orderPrdctId = prdctId;
			returnCnt = cnt;

			$("#returnCnt").val(cnt);
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

						if(sortTy=="D"){
							sortTy = "A";
						}else{
							sortTy = "D";
						}

						getOrderList(sort);
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
						alert("반품신청이 완료되었습니다.");

						if(sortTy=="D"){
							sortTy = "A";
						}else{
							sortTy = "D";
						}

						getOrderList(sort);
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


		function format(id,type){
	 		if(type=="s"){
	 			type = "Sing";
	 		}else{
	 			type = "Multi";
	 		}
			var n = id.value;
	 		var number;

	 		if(n.charAt(0)=="+"){
	 			if(n.length==2){
	 				number = n + ".0";
	 			}else if(n.length==3){
	 				var n1 = n.substr(1,1);
	 				var n2 = n.substr(2,1);
	 				number = "+" + n1 + "." + n2;
	 			}else if(n.length==4){
	 				var n1 = n.substr(1,1);
	 				var n2 = n.substr(2,1);
	 				var n3 = n.substr(3,1);
	 				number ="+" + n1 + "." + n2 + n3;
	 			}else if(n.length==5){
	 				var n1 = n.substr(1,1);
	 				var n2 = n.substr(2,1);
	 				var n3 = n.substr(3,1);
	 				var n4 = n.substr(4,1);
	 				number = "+" + n1 +  n2 + "." + n3 + n4;
	 			}
	 			$("#rx" + type + "Form input[id='" + id.id + "']").val(number);
	 		}else if(n.charAt(0)=="-"){
	 			if(n.length==2){
	 				number = n + ".0";
	 			}else if(n.length==3){
	 				var n1 = n.substr(1,1);
	 				var n2 = n.substr(2,1);
	 				number = n1 + "." + n2;
	 			}else if(n.length==4){
	 				var n1 = n.substr(1,1);
	 				var n2 = n.substr(2,1);
	 				var n3 = n.substr(3,1);
	 				number = n1 + "." + n2 + n3;
	 			}else if(n.length==5){
	 				var n1 = n.substr(1,1);
	 				var n2 = n.substr(2,1);
	 				var n3 = n.substr(3,1);
	 				var n4 = n.substr(4,1);
	 				number =  n1 +  n2 + "." + n3 + n4;
	 			}
	 			$("#rx" + type + "Form input[id='" + id.id + "']").val(number);
	 	 	}else {
	 			if(n.length==1){
	 				number = "-" + n + ".0";
	 			}else if(n.length==2){
	 				var n1 = n.substr(0,1);
	 				var n2 = n.substr(1,1);
	 				number = "-" + n1 + "." + n2;
	 			}else if(n.length==3){
	 				var n1 = n.substr(0,1);
	 				var n2 = n.substr(1,1);
	 				var n3 = n.substr(2,1);
	 				number = "-" + n1 + "." + n2 + n3;
	 			}else if(n.length==4){
	 				var n1 = n.substr(0,1);
	 				var n2 = n.substr(1,1);
	 				var n3 = n.substr(2,1);
	 				var n4 = n.substr(3,1);
	 				number =  "-" + n1 +  n2 + "." + n3 + n4;
	 			}
	 			$("#rx" + type + "Form input[id='" + id.id + "']").val(number);
	 	 	}

	 	}

		function formatNoSign(id){
	 		var n = id.value;chkLensSize
	 		var number;
			if(n.length==1){
				number = n + ".0";
			}else if(n.length==2){
				var n1 = n.substr(0,1);
				var n2 = n.substr(1,1);
				number = n1 + "." + n2;
			}else if(n.length==3){
				var n1 = n.substr(0,1);
				var n2 = n.substr(1,1);
				var n3 = n.substr(2,1);
				number = n1 + "." + n2 + n3;
			}else if(n.length==4){
				var n1 = n.substr(0,1);
				var n2 = n.substr(1,1);
				var n3 = n.substr(2,1);
				var n4 = n.substr(3,1);
				number = n1 +  n2 + "." + n3 + n4;
			}
			$("#rx" + type + "Form input[id='" + id.id + "']").val(number);
	 	}

		function formatAdd(id){
 	 		var n = id.value;
 	 		var number;
 			if(n.length==1){
 				number = n + ".0";
 			}else if(n.length==2){
 				var n1 = n.substr(0,1);
 				var n2 = n.substr(1,1);
 				number = n1 + "." + n2;
 			}else if(n.length==3){
 				var n1 = n.substr(0,1);
 				var n2 = n.substr(1,1);
 				var n3 = n.substr(2,1);
 				number = n1 + "." + n2 + n3;
 			}else if(n.length==4){
 				var n1 = n.substr(0,1);chkLensSize
 				var n2 = n.substr(1,1);
 				var n3 = n.substr(2,1);
 				var n4 = n.substr(3,1);
 				number = n1 +  n2 + "." + n3 + n4;
 			}

 			$("#rx" + type + "Form input[id='" + id.id + "']").val(number);

 		}

		var orderLength;
		var orderChk = 1;
		function chkPair(){
			orderLength = 1;
			if($("#sphR").val()!=""){
				rxOrder("R");
				orderLength ++;
			};

			if($("#sphL").val()!=""){
				rxOrder("L");
				orderLength ++;
			};
		}

		function chkPairX(){
			orderLength = 1;

			if($("#rxMultiForm input[id='sphR']").val()!=""){
				rxOrderM("R");
				orderLength ++;
			};

			if($("#rxMultiForm input[id='sphL']").val()!=""){
				rxOrderM("L");
				orderLength ++;
			};
		}
		function rxOrder(lr){
			if(orderLength==1){
				if(confirm("주문하시겠습니까?")==false){
					return;
				}
			}

			var ar;
			if($("input:checkbox[id='AR']").is(":checked")==true){
				ar = "y";
			}


			var sphR = $("#rxSingForm input[id='sphR']").val();
			var sphL = $("#rxSingForm input[id='sphL']").val();
			var cylR = $("#rxSingForm input[id='cylR']").val();
			var cylL = $("#rxSingForm input[id='cylL']").val();
			var axisR = $("#rxSingForm input[id='axisR']").val();
			var axisL = $("#rxSingForm input[id='axisL']").val();
			var addR = $("#rxSingForm input[id='addR']").val();
			var addL = $("#rxSingForm input[id='addL']").val();
			var diaR = $("#rxSingForm input[id='diaR']").val();
			var diaL = $("#rxSingForm input[id='diaL']").val();
			var prsRIO = $("#rxSingForm input[name='prsRIO']:checked").val();
			var prsLIO = $("#rxSingForm input[name='prsLIO']:checked").val();
			var prsRUD = $("#rxSingForm input[name='prsRUD']:checked").val();
			var prsLUD = $("#rxSingForm input[name='prsLUD']:checked").val();
			var prsValRIO = $("#rxSingForm select[id='prsValRIO']").val();
			var prsValLIO = $("#rxSingForm select[id='prsValLIO']").val();
			var prsValRUD = $("#rxSingForm select[id='prsValRUD']").val();
			var prsValLUD = $("#rxSingForm select[id='prsValLUD']").val();


			if(typeof(prsRIO)=="undefined"){
				prsRIO = "";
			}
			if(typeof(prsLIO)=="undefined"){
				prsLIO = "";
			}
			if(typeof(prsRUD)=="undefined"){
				prsRUD = "";
			}
			if(typeof(prsLUD)=="undefined"){
				prsLUD = "";
			}
			var earR = $("#rxSingForm input[id='earR']").val();
			var earL = $("#rxSingForm input[id='earL']").val();
			var centerR = $("#rxSingForm input[id='centerR']").val();
			var centerL = $("#rxSingForm input[id='centerL']").val();
			var noseR = $("#rxSingForm input[id='noseR']").val();
			var noseL = $("#rxSingForm input[id='noseL']").val();
			var A = $("#rxSingForm input[id='A']").val();
			var DBL = $("#rxSingForm input[id='DBL']").val();
			var ED = $("#rxSingForm input[id='ED']").val();
			var B = $("#rxSingForm input[id='B']").val();
			var PDR = $("#rxSingForm input[id='PDR']").val();
			var PDL = $("#rxSingForm input[id='PDL']").val();

			var optionId;
			if(ty1=="spare" && ty3=="Single"){
		 		optionId = $("#optionBtnSlct").val();
	 		}else if(ty1=="rx" && ty3=="Single"){
	 			optionId = $("#optionBtnRXSSlct").val();
	 		}else if(ty1=="rx" && ty3=="Multi"){
	 			optionId = $("#optionBtnRXMSlct").val();
	 		}else if(ty1=="spare" && ty3=="Multi"){
	 			optionId = $("#optionBtnRXMSlct").val();
	 		}

			var RL = "";
			if(lr=="R"){
				  sphL = "";
				  cylL = "";
				  addL = "";
				  axisL = "";
				  diaL = "";
				  RL = "&isr=1";
			}else if(lr=="L"){
				  sphR = "";
				  cylR = "";
				  addR = "";
				  axisR = "";
				  diaR = "";
				  RL = "&isl=1";
			};

			var param = "sphR=" + sphR +
							"&sphL=" + sphL +
							"&cylR=" + cylR +
							"&cylL=" + cylL +
							"&axisR=" + axisR +
							"&axisL=" + axisL +
							"&addr=" + addR +
							"&addL=" + addL +
							"&diaR=" + diaR +
							"&diaL=" + diaL +
							"&prsRIO=" + prsRIO +
							"&prsLIO=" + prsLIO +
							"&prsRUD=" + prsRUD +
							"&prsLUD=" + prsLUD +
							"&prsValRIO=" + prsValRIO +
							"&prsValLIO=" + prsValLIO +
							"&prsValRUD=" + prsValRUD +
							"&prsValLUD=" + prsValLUD +
							"&A=" + A +
							"&DBL=" + DBL +
							"&ED=" + ED +
							"&B=" + B +
							"&PDR=" + PDR +
							"&PDL=" + PDL +
							"&earR=" + earR +
							"&earL=" + earL +
							"&noseR=" + noseR +
							"&noseL=" + noseL +
							"&centerR=" + centerR +
							"&centerL=" + centerL +
							"&colorCd=" + colorCd +
							"&colorCom=" + colorCom +
							"&colorOpacity=" + colorOpacity +
							"&shopId=" + shopId +
							"&iNum=" + iNum +
							"&puchasPrc=" + Number(puchasPrc) +
							"&prdctId=" + prdctId +
							"&detail=" + nl2br(encodeURIComponent($("#detail").val())) +
							"&ar=" + ar +
							"&isRx=1" +
							"&prdctTy=2" +
							"&optionId=" + optionId +
							"&optionPrc=" + addPrc +
							RL +
							"&comOrder=" + comOrder +
							"&cnt=1";

			console.log(param);
			var url = "${ctxPath}/prdct/OrderRX.do";

			$.ajax({
				url : url,
				data : param,
				dataType : "text",
				type : "post",
				success : function(data){
					orderChk++;
					if(data=="success"){
						if(orderChk==orderLength){
							alert("주문이 완료되었습니다.");
							$("#detail").val("");
							getOrderList();
							addPrc = 0;
							orderChk = 1;
							gcm("1");

							rxInputClean();
						}
					};
				}
			});
		};

		function rxInputClean(){
			$("#rxSingForm input[id='sphR']").val("");
			$("#rxSingForm input[id='cylR']").val("");
			$("#rxSingForm input[id='axisR']").val("");
			$("#rxSingForm input[id='diaR']").val("");

			$("#rxSingForm input[id='sphL']").val("");
			$("#rxSingForm input[id='cylL']").val("");
			$("#rxSingForm input[id='axisL']").val("");
			$("#rxSingForm input[id='diaL']").val("");

			$("#rxMultiForm input[id='sphR']").val("");
			$("#rxMultiForm input[id='cylR']").val("");
			$("#rxMultiForm input[id='axisR']").val("");
			$("#rxMultiForm input[id='diaR']").val("");
			$("#rxMultiForm input[id='addR']").val("");

			$("#rxMultiForm input[id='sphL']").val("");
			$("#rxMultiForm input[id='cylL']").val("");
			$("#rxMultiForm input[id='axisL']").val("");
			$("#rxMultiForm input[id='diaL']").val("");
			$("#rxMultiForm input[id='addL']").val("");

			$("#rxSingForm input[id='colorCd']").val("");
			$("#rxMultiForm input[id='colorCd']").val("");

			colorCom = "undefined";
			colorCd = "";
			colorOpacity = "";
		};

		function rxOrderM(lr){
			if(orderLength==1){
				if(confirm("주문하시겠습니까?")==false){
					return;
				}
			}
			var sphR = $("#rxMultiForm input[id='sphR']").val();
			var sphL = $("#rxMultiForm input[id='sphL']").val();
			var cylR = $("#rxMultiForm input[id='cylR']").val();
			var cylL = $("#rxMultiForm input[id='cylL']").val();
			var addR = $("#rxMultiForm input[id='addR']").val();
			var addL = $("#rxMultiForm input[id='addL']").val();
			var axisR = $("#rxMultiForm input[id='axisR']").val();
			var axisL = $("#rxMultiForm input[id='axisL']").val();
			var diaR = $("#rxMultiForm input[id='diaR']").val();
			var diaL = $("#rxMultiForm input[id='diaL']").val();
			var prsRIO = $("#rxMultiForm input[name='prsRIO']:checked").val();
			var prsLIO = $("#rxMultiForm input[name='prsLIO']:checked").val();
			var prsRUD = $("#rxMultiForm input[name='prsRUD']:checked").val();
			var prsLUD = $("#rxMultiForm input[name='prsLUD']:checked").val();

			if(typeof(prsRIO)=="undefined"){
				prsRIO = "";
			}
			if(typeof(prsLIO)=="undefined"){
				prsLIO = "";
			}
			if(typeof(prsRUD)=="undefined"){
				prsRUD = "";
			}
			if(typeof(prsLUD)=="undefined"){
				prsLUD = "";
			}

			var prsValRIO = $("#rxMultiForm select[id='prsValRIO']").val();
			var prsValLIO = $("#rxMultiForm select[id='prsValLIO']").val();
			var prsValRUD = $("#rxMultiForm select[id='prsValRUD']").val();
			var prsValLUD = $("#rxMultiForm select[id='prsValLUD']").val();
			var A = $("#rxMultiForm input[id='A']").val();
			var DBL = $("#rxMultiForm input[id='DBL']").val();
			var ED = $("#rxMultiForm input[id='ED']").val();
			var B = $("#rxMultiForm input[id='B']").val();
			var PDR = $("#rxMultiForm input[id='PDR']").val();
			var PDL = $("#rxMultiForm input[id='PDL']").val();
			var frameType = $("#rxMultiForm select[id='frameType']").val();
			var frameShape = $("#rxMultiForm select[id='frameShape']").val();

			if(frameType=="-1"){
				frameType = "";
			}
			if(frameShape=="-1"){
				frameShape = "";
			}
			var preA = $("#rxMultiForm input[id='preA']").val();
			var preB = $("#rxMultiForm input[id='preB']").val();
			var preDBL = $("#rxMultiForm input[id='preDBL']").val();
			var preOHR = $("#rxMultiForm input[id='preOHR']").val();
			var preOHL = $("#rxMultiForm input[id='preOHL']").val();
			var prePDR = $("#rxMultiForm input[id='prePDR']").val();
			var prePDL = $("#rxMultiForm input[id='prePDL']").val();
			var preET = $("#rxMultiForm input[id='preET']").val();

			var optionId;
			if(ty1=="spare" && ty3=="Single"){
		 		optionId = $("#optionBtnSlct").val();
	 		}else if(ty1=="spare" && ty3=="Multi"){
	 			optionId = $("#optionBtnRXMSlct").val();
	 		}else if(ty1=="rx" && ty3=="Single"){
	 			optionId = $("#optionBtnRXSSlct").val();
	 		}else if(ty1=="rx" && ty3=="Multi"){
	 			optionId = $("#optionBtnRXMSlct").val();
	 		}else if(ty1=="spare" && ty3=="Multi"){
	 			optionId = $("#optionBtnRXMSlct").val();
	 		}

			var RL = "";
			if(lr=="R"){
				  sphL = "";
				  cylL = "";
				  addL = "";
				  axisL = "";
				  diaL = "";
				  RL = "&isr=1";
			}else if(lr=="L"){
				  sphR = "";
				  cylR = "";
				  addR = "";
				  axisR = "";
				  diaR = "";
				  RL = "&isl=1";
			};

			var param = "sphR=" + sphR +
							"&sphL=" + sphL +
							"&cylR=" + cylR +
							"&cylL=" + cylL +
							"&addr=" + addR +
							"&addL=" + addL +
							"&axisR=" + axisR +
							"&axisL=" + axisL +
							"&diaR=" + diaR +
							"&diaL=" + diaL +
							"&prsRIO=" + prsRIO +
							"&prsLIO=" + prsLIO +
							"&prsRUD=" + prsRUD +
							"&prsLUD=" + prsLUD +
							"&prsValRIO=" + prsValRIO +
							"&prsValLIO=" + prsValLIO +
							"&prsValRUD=" + prsValRUD +
							"&prsValLUD=" + prsValLUD +
							"&A=" + A +
							"&DBL=" + DBL +
							"&ED=" + ED +
							"&B=" + B +
							"&PDR=" + PDR +
							"&PDL=" + PDL +
							"&frameType=" + frameType +
							"&frameShape=" + frameShape +
							"&preA=" + preA +
							"&preB=" + preB +
							"&preDBL=" + preDBL +
							"&preOHR=" + preOHR +
							"&preOHL=" + preOHL +
							"&prePDR=" + prePDR +
							"&prePDL=" + prePDL +
							"&preET=" + preET +
							"&colorCd=" + colorCd +
							"&colorCom=" + colorCom +
							"&colorOpacity=" + colorOpacity +
							"&shopId=" + shopId +
							"&iNum=" + iNum +
							"&puchasPrc=" + Number(puchasPrc) +
							"&prdctId=" + prdctId +
							"&detail=" + nl2br(encodeURIComponent($("#detail").val())) +
							"&isRx=1" +
							"&optionId=" + optionId +
							"&optionPrc=" + addPrc +
							"&prdctTy=2" +
							RL +
							"&comOrder=" + comOrder +
							"&cnt=1";

			console.log(param);
			var url = "${ctxPath}/prdct/OrderRX.do";

			$.ajax({
				url : url,
				data : param,
				dataType : "text",
				type : "post",
				success : function(data){
					orderChk++;
					if(data=="success"){
						if(orderChk==orderLength){
							alert("주문이 완료되었습니다.");
							$("#detail").val("");
							getOrderList();
							addPrc = 0;
							orderChk = 1;
							gcm("1");
							rxInputClean();
						}
					};
				}
			});

		}


		function allowComOrder(id, prdctId,cnt,iNum, prdctTy){
			//var length = $("input:checkbox[name='delChk']:checked").length;



			/*if(confirmChk){
				if(confirm("확인과 동시에 배송완료, 재고추가가 됩니다.")==false){
					return;
				}
			}*/

			if(confirm("확인과 동시에 배송완료, 재고추가가 됩니다!")==false){
				return;
			}

			/* if(length!="0"){
				confirmChk = false;
			} */

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

						if(sortTy=="D"){
							sortTy = "A";
						}else{
							sortTy = "D";
						}

						getOrderList(sort);
					}else if(data=="reject"){
						alert("본사 승인 전입니다.");
						confirmChk = true;
					}

				}
			});
		}

		function colorCdView(){
			var url = "${ctxPath}/prdct/getColorCom.do";

			$.ajax({
				url : url,
				dataType : "html",
				type : "post",
				success : function(data){
					$("#colorCdDiv").popup('open');
					$("#colorComList").html(data);
					$("#colorComList").listview();
					$("#colorComList").listview("refresh");
				}
			});

		}

		function chkLensSize(obj){
			if(obj.id == "earR" || obj.id == "earL"){
				$("#centerL").attr("disabled",true);
				$("#centerR").attr("disabled",true);
				$("#noseL").attr("disabled",true);
				$("#noseR").attr("disabled",true);
			}else if(obj.id == "centerR" || obj.id == "centerL"){
				$("#earL").attr("disabled",true);
				$("#earR").attr("disabled",true);
				$("#noseL").attr("disabled",true);
				$("#noseR").attr("disabled",true);
			}else if(obj.id == "noseR" || obj.id == "noseL"){
				$("#earL").attr("disabled",true);
				$("#earR").attr("disabled",true);
				$("#centerL").attr("disabled",true);
				$("#centerR").attr("disabled",true);
			}
		}

		function initInput(){
			$("#centerL").attr("disabled",false);
			$("#centerR").attr("disabled",false);
			$("#noseL").attr("disabled",false);
			$("#noseR").attr("disabled",false);
			$("#earL").attr("disabled",false);
			$("#earR").attr("disabled",false);

			$("#centerL").val("");
			$("#centerR").val("");
			$("#noseL").val("");
			$("#noseR").val("");
			$("#earL").val("");
			$("#earR").val("");
		}

		function showDetailDiv(){
			$("#detailDiv").popup("open");
		}

		function closeDetail(){
			$("#detailDiv").popup('close',{transition:"pop"});
		}
		function nl2br(str){
	   	 	return str.replace(/\n/g, "<br />");
		}

		var orderId;
		function mofidyRXSingle(id){
			getDetailForRX(id);
			var param = "id=" + id;
			orderId = id;
			var url = "${ctxPath}/prdct/editLensRX.do";
			clearInit();
			$.ajax({
				url : url,
				dataType : "json",
				data : param,
				type : "post",
				success : function(data){

					colorCd = data.colorCd;
					colorCom = data.colorCom;
					colorOpacity = data.colorOpacity;
					if(data.ar =="y"){
						$("#modifyRXs input[id='AR']").prop("checked", true);
					}else{
						$("#modifyRXs input[id='AR']").prop("checked", false);
					}


					if(data.colorCom!="undefined"){
						$("#modifyRXs input[id='colorCd']").val(data.colorCom + " - " + data.colorCd + "(" + data.colorOpacity + "%)");
						$("#modifyRXm input[id='colorCd']").val(data.colorCom + " - " + data.colorCd + "(" + data.colorOpacity + "%)");
					}else{
						$("#modifyRXs input[id='colorCd']").val("");
						$("#modifyRXm input[id='colorCd']").val("");
					}
					$(".MsphR").val(data.sphR);
					$(".MsphL").val(data.sphL);
					$(".McylR").val(data.cylR);
					$(".McylL").val(data.cylL );
					$(".MaxisR").val(data.axisR);
					$(".MaxisL").val(data.axisL );
					$(".Maddr").val(data.addr);
					$(".MaddL").val(data.addL);
					$(".MdiaR").val(data.diaR);
					$(".MdiaL").val(data.diaL );
					if(data.type3=="Single"){
						$("#modifyRXs input[value='" + data.prsRIO + "']").attr("checked", true);
						$("#modifyRXs input[value='" + data.prsLIO + "']").attr("checked", true);
						$("#modifyRXs input[value='" + data.prsRUD + "']").attr("checked", true);
						$("#modifyRXs input[value='" + data.prsLUD + "']").attr("checked", true);
					}else{
						$("#modifyRXm input[value='" + data.prsRIO + "']").attr("checked", true);
						$("#modifyRXm input[value='" + data.prsLIO + "']").attr("checked", true);
						$("#modifyRXm input[value='" + data.prsRUD + "']").attr("checked", true);
						$("#modifyRXm input[value='" + data.prsLUD + "']").attr("checked", true);
					}


					$(".MprsValRIO").val(data.prsValRIO);
					$(".MprsValLIO").val(data.prsValLIO);
					$(".MprsValRUD").val(data.prsValRUD);
					$(".MprsValLUD").val(data.prsValLUD);
					$(".MA").val(data.a);
					$(".MDBL").val(data.dbl);
					$(".MED").val(data.ed);
					$(".MB").val(data.b);
					$(".MPDR").val(data.pdr);
					$(".MPDL").val(data.pdl);
					$(".MearR").val(data.earR);
					$(".MearL").val(data.earL);
					$(".MnoseR").val(data.noseR);
					$(".MnoseL").val(data.noseL);
					$(".McenterR").val(data.centerR);
					$(".McenterL").val(data.centerL);
					$(".McolorCd").val(data.colorCd);
					$("#MframeType").val(data.frameType);
					$("#MframeShape").val(data.frameShape);
					$("#MpreA").val(data.preA);
					$("#MpreB").val(data.preB);
					$("#MpreDBL").val(data.preDBL);
					$("#MpreOHR").val(data.preOHR);
					$("#MpreOHL").val(data.preOHL);
					$("#MprePDR").val(data.prePDR);
					$("#MprePDL").val(data.prePDL);
					$("#MpreET").val(data.preET);

					if(data.type3=="Single"){
						$("#modifyRXs").popup("open");
					}else{
						$("#modifyRXm").popup("open");
						$(".lensSpecVal").attr("disabled",false);
				 		$(".lensSpecValM").attr("disabled",false);
					}
				}
			});



		}

		function clearInit(){
			$(".MsphR").val("");
			$(".MsphL").val("");
			$(".McylR").val("");
			$(".McylL").val("");
			$(".MaxisR").val("");
			$(".MaxisL").val("");
			$(".Maddr").val("");
			$(".MaddL").val("");
			$(".MdiaR").val("");
			$(".MdiaL").val("");
			$(".MprsValRIO").val("");
			$(".MprsValLIO").val("");
			$(".MprsValRUD").val("");
			$(".MprsValLUD").val("");
			$(".MA").val("");
			$(".MDBL").val("");
			$(".MED").val("");
			$(".MB").val("");
			$(".MPDR").val("");
			$(".MPDL").val("");
			$(".MearR").val("");
			$(".MearL").val("");
			$(".MnoseR").val("");
			$(".MnoseL").val("");
			$(".McenterR").val("");
			$(".McenterL").val("");
			$(".McolorCd").val("");
			$("#MframeType").val("");
			$("#MframeShape").val("");
			$("#MpreA").val("");
			$("#MpreB").val("");
			$("#MpreDBL").val("");
			$("#MpreOHR").val("");
			$("#MpreOHL").val("");
			$("#MprePDR").val("");
			$("#MprePDL").val("");
			$("#MpreET").val("");
		}

		function appendColorList(cName){
			var param ="cName=" + cName;
			var url = "${ctxPath}/prdct/getColorList.do";

			$.ajax({
				url : url,
				data : param,
				dataType : "html",
				type : "post",
				success : function(data){
					colorCom = cName;
					$("#rxSingForm input[id='colorCd']").val(colorCom);
					$("#rxMultiForm input[id='colorCd']").val(colorCom);
					$("#colorComList").html(data);
					$("#colorComList").listview("refresh");
				}
			});
		}

		function selectSampleColor(cName){
			colorCom = cName;
			$("#rxSingForm input[id='colorCd']").val(colorCom);
			$("#rxMultiForm input[id='colorCd']").val(colorCom);
			var contents = "<li onclick='colorCdView()'>뒤로</li>" +
								"<input text='input' placeholder='색상입력' id='sampleColor'>" +
								"<button id='sampleBtn'>확인</button>";

			$("#colorComList").html(contents);
			$("#sampleColor").textinput();
			$("#sampleBtn").buttonMarkup();
			$("#colorComList").listview("refresh");

			$("#sampleBtn").click(function(){
				selectColor($("#sampleColor").val());
			});
		};

		function selectColor(color){
			colorCd = color;
			$("#rxSingForm input[id='colorCd']").val(colorCom + " - " + colorCd);
			$("#rxMultiForm input[id='colorCd']").val(colorCom + " - " + colorCd);
			$("#colorComList").html("<div style='padding: 10px'>" +
											  "<li onclick='appendColorList(\"" + colorCom + "\")'>뒤로</li>" +
											  "<label><input type='text' id='opacity' class='opacity' placeholder='농도'>" +
											  "<button onclick='selectOpacity()' data-mini='true' id='opacityBtn'>확인</button></label>" +
										   "</div>");
			$("#opacityBtn").buttonMarkup();
			$("#opacity").textinput();
			$("#colorComList").listview("refresh");
		};

		function selectOpacity(n){
			var opacity = $(".opacity").val();
			colorOpacity = opacity;
			$("#rxSingForm input[id='colorCd']").val(colorCom + " - " + colorCd + "(" + opacity + "%)");
			$("#rxMultiForm input[id='colorCd']").val(colorCom + " - " + colorCd + "(" + opacity + "%)");
			$("#colorCdDiv").popup("close");
		};


		function modifyLensM(){
			var detail = $(".detailForMODRXM").val();
			modDetail(orderId, detail);
			var sphR = $("#modifyRXm input[id='sphR']").val();
			var sphL = $("#modifyRXm input[id='sphL']").val();
			var cylR = $("#modifyRXm input[id='cylR']").val();
			var cylL = $("#modifyRXm input[id='cylL']").val();
			var axisR = $("#modifyRXm input[id='axisR']").val();
			var axisL = $("#modifyRXm input[id='axisL']").val();
			var addR = $("#modifyRXm input[id='addR']").val();
			var addL = $("#modifyRXm input[id='addL']").val();
			var diaR = $("#modifyRXm input[id='diaR']").val();
			var diaL = $("#modifyRXm input[id='diaL']").val();
			var prsRIO = $("#modifyRXm input[name='MprsRIO']:checked").val();
			var prsLIO = $("#modifyRXm input[name='MprsLIO']:checked").val();
			var prsRUD = $("#modifyRXm input[name='MprsRUD']:checked").val();
			var prsLUD = $("#modifyRXm input[name='MprsLUD']:checked").val();
			var prsValRIO = $("#modifyRXm select[id='prsValRIO']").val();
			var prsValLIO = $("#modifyRXm select[id='prsValLIO']").val();
			var prsValRUD = $("#modifyRXm select[id='prsValRUD']").val();
			var prsValLUD = $("#modifyRXm select[id='prsValLUD']").val();
			var A = $("#modifyRXm input[id='A']").val();
			var DBL = $("#modifyRXm input[id='DBL']").val();
			var ED = $("#modifyRXm input[id='ED']").val();
			var B = $("#modifyRXm input[id='B']").val();
			var PDR = $("#modifyRXm input[id='PDR']").val();
			var PDL = $("#modifyRXm input[id='PDL']").val();
			var earR = $("#modifyRXm input[id='earR']").val();
			var earL = $("#modifyRXm input[id='earL']").val();
			var noseR = $("#modifyRXm input[id='noseR']").val();
			var noseL = $("#modifyRXm input[id='noseL']").val();
			var centerR = $("#modifyRXm input[id='centerR']").val();
			var centerL = $("#modifyRXm input[id='centerL']").val();
			var frameType = $("#modifyRXm select[id='MframeType']").val();
			var frameShape = $("#modifyRXm select[id='MframeShape']").val();
			var preA = $("#modifyRXm input[id='MpreA']").val();
			var preB = $("#modifyRXm input[id='MpreB']").val();
			var preDBL = $("#modifyRXm input[id='MpreDBL']").val();
			var preOHR = $("#modifyRXm input[id='MpreOHR']").val();
			var preOHL = $("#modifyRXm input[id='MpreOHL']").val();
			var prePDR = $("#modifyRXm input[id='MprePDR']").val();
			var prePDL = $("#modifyRXm input[id='MprePDL']").val();
			var preET = $("#modifyRXm input[id='MpreET']").val();

			var url = "${ctxPath}/prdct/modifyLens.do";

			var param = "id=" + orderId +
							"&colorCd=" + colorCd +
				      		"&colorCom=" + colorCom +
				      		"&colorOpacity=" + colorOpacity +
				      		"&sphR=" + sphR +
				      		"&sphL=" + sphL +
				      		"&cylR=" + cylR +
				      		"&cylL=" + cylL +
				      		"&addr=" + addR +
				      		"&addL=" + addL +
				      		"&axisR=" + axisR +
				      		"&axisL=" + axisL +
				      		"&diaR=" + diaR +
				      		"&diaL=" + diaL +
				      		"&prsRIO=" + prsRIO +
				      		"&prsLIO=" + prsLIO +
				      		"&prsRUD=" + prsRUD +
				      		"&prsLUD=" + prsLUD +
				      		"&prsValRIO=" + prsValRIO +
				      		"&prsValLIO=" + prsValLIO +
				      		"&prsValRUD=" + prsValRUD +
				      		"&prsValLUD=" + prsValLUD +
				      		"&earR=" + earR +
				      		"&earL=" + earL +
				      		"&centerR=" + centerR +
				      		"&centerL=" + centerL +
				      		"&noseR=" + noseR +
				      		"&noseL=" + noseL +
				      		"&A=" + A +
				      		"&DBL=" + DBL +
				      		"&ED=" + ED +
				      		"&B=" + B +
				      		"&PDR=" + PDR +
				      		"&PDL=" + PDL +
				      		"&frameType=" + frameType +
				      		"&frameShape=" + frameShape +
				      		"&preA=" + preA +
				      		"&preB=" + preB +
				      		"&preDBL=" + preDBL +
				      		"&preOHR=" + preOHR +
				      		"&preOHL=" + preOHL +
				      		"&prePDR=" + prePDR +
				      		"&prePDL=" + prePDL +
				      		"&preET=" + preET;


			$.ajax({
				url : url,
				data : param,
				dataType : "text",
				type : "post",
				success : function(data){
					if(data="success"){
						$("#modifyRXm").popup('close');
					}
				}
			});
		};

		function modDetail(orderId, detail){
			var url = "${ctxPath}/prdct/modDetail.do";
			var param = "id=" + orderId +
							"&detail=" + encodeURIComponent(detail);

			$.ajax({
				url : url,
				data : param,
				dataType : "text",
				type : "post",
				success : function(data){
					console.log(data);
				}
			});

		};

		function modifyLens(){
			var ar;
			if($("#modifyRXs input:checkbox[id='AR']").is(":checked")==true){
				ar = "y";
			}else{
				ar = null;
			};
			var detail = $(".detailForMODRX").val();
			modDetail(orderId, detail);
			var sphR = $("#modifyRXs input[id='MsphR']").val();
			var sphL = $("#modifyRXs input[id='MsphL']").val();
			var cylR = $("#modifyRXs input[id='McylR']").val();
			var cylL = $("#modifyRXs input[id='McylL']").val();
			var axisR = $("#modifyRXs input[id='MaxisR']").val();
			var axisL = $("#modifyRXs input[id='MaxisL']").val();
			var diaR = $("#modifyRXs input[id='MdiaR']").val();
			var diaL = $("#modifyRXs input[id='MdiaL']").val();
			var prsRIO = $("#modifyRXs input[name='MprsRIO']:checked").val();
			var prsLIO = $("#modifyRXs input[name='MprsLIO']:checked").val();
			var prsRUD = $("#modifyRXs input[name='MprsRUD']:checked").val();
			var prsLUD = $("#modifyRXs input[name='MprsLUD']:checked").val();
			var prsValRIO = $("#modifyRXs select[id='MprsValRIO']").val();
			var prsValLIO = $("#modifyRXs select[id='MprsValLIO']").val();
			var prsValRUD = $("#modifyRXs select[id='MprsValRUD']").val();
			var prsValLUD = $("#modifyRXs select[id='MprsValLUD']").val();
			var A = $("#modifyRXs input[id='MA']").val();
			var DBL = $("#modifyRXs input[id='MDBL']").val();
			var ED = $("#modifyRXs input[id='MED']").val();
			var B = $("#modifyRXs input[id='MB']").val();
			var PDR = $("#modifyRXs input[id='MPDR']").val();
			var PDL = $("#modifyRXs input[id='MPDL']").val();
			var earR = $("#modifyRXs input[id='MearR']").val();
			var earL = $("#modifyRXs input[id='MearL']").val();
			var noseR = $("#modifyRXs input[id='MnoseR']").val();
			var noseL = $("#modifyRXs input[id='MnoseL']").val();
			var centerR = $("#modifyRXs input[id='McenterR']").val();
			var centerL = $("#modifyRXs input[id='McenterL']").val();

			var url = "${ctxPath}/prdct/modifyLens.do";

			var param = "id=" + orderId +
							"&colorCd=" + colorCd +
				      		"&colorCom=" + colorCom +
				      		"&colorOpacity=" + colorOpacity +
				      		"&sphR=" + sphR +
				      		"&sphL=" + sphL +
				      		"&cylR=" + cylR +
				      		"&cylL=" + cylL +
				      		"&axisR=" + axisR +
				      		"&axisL=" + axisL +
				      		"&diaR=" + diaR +
				      		"&diaL=" + diaL +
				      		"&prsRIO=" + prsRIO +
				      		"&prsLIO=" + prsLIO +
				      		"&prsRUD=" + prsRUD +
				      		"&prsLUD=" + prsLUD +
				      		"&prsValRIO=" + prsValRIO +
				      		"&prsValLIO=" + prsValLIO +
				      		"&prsValRUD=" + prsValRUD +
				      		"&prsValLUD=" + prsValLUD +
				      		"&earR=" + earR +
				      		"&earL=" + earL +
				      		"&centerR=" + centerR +
				      		"&centerL=" + centerL +
				      		"&noseR=" + noseR +
				      		"&noseL=" + noseL +
				      		"&A=" + A +
				      		"&DBL=" + DBL +
				      		"&ED=" + ED +
				      		"&B=" + B +
				      		"&PDR=" + PDR +
				      		"&PDL=" + PDL +
				      		"&ar=" + ar;


			$.ajax({
				url : url,
				data : param,
				dataType : "text",
				type : "post",
				success : function(data){
					if(data="success"){
						$("#modifyRXs").popup('close');
					}
				}
			});
		};

		function modifySpecDiv(sph, cyl, id){
			console.log(sph + "/" + cyl);
			orderId = id;
			signS = sph.substr(0,1);
			signC = cyl.substr(0,1);
			newSph = sph.substr(1);
			newCyl = cyl.substr(1);

			$("#signS").val(signS);
			$("#signC").val(signC);
			$("#sphModi").val(newSph);
			$("#cylModi").val(newCyl);

			console.log(newSph);
			$("#modifySpareLens").popup("open");
			getDetail(id);
		};

		function getDetail(id){
			var orderId = id;
			var url = "${ctxPath}/prdct/getDetail.do";
			var param = "id=" + orderId;

			$.ajax({
				url : url,
				data : param,
				dataType : "text",
				type : "post",
				success : function(data){
					$("#detailForMod").val(decodeURIComponent(data));
				}
			});
		};

		function getDetailForRX(id){
			var orderId = id;
			var url = "${ctxPath}/prdct/getDetail.do";
			var param = "id=" + orderId;

			$.ajax({
				url : url,
				data : param,
				dataType : "text",
				type : "post",
				success : function(data){
					$(".detailForMODRX").val(decodeURIComponent(data));
					$(".detailForMODRXM").val(decodeURIComponent(data));
				}
			});
		};

		var orderId;
		var signS;
		var signC;
		var newSph;
		var newCyl;

		function modifySpareLensSpec(){
			var sph = signS + newSph;
			var cyl = signC + newCyl;
			var detail = $("#detailForMod").val();
			var param = "SPH=" + sph +
							"&CYL=" + cyl +
							"&id=" + orderId +
							"&detail=" + detail;

			var url = "${ctxPath}/prdct/modifySpareLensSpec.do";

			$.ajax({
				url : url,
				data : param,
				dataType : "text",
				type : "post",
				success : function(data){
					if(data=="success"){
						$("#modifySpareLens").popup("close");

						if(sortTy=="D"){
							sortTy = "A";
						}else{
							sortTy = "D";
						}
						getOrderList(sort);
					}
				}
			});
		}

		function modifySpec(t){
			if(t=="S"){
				newSph = $("#sphModi").val();
			}else if(t=="C"){
				newCyl = $("#cylModi").val();
			}else if(t=="SSign"){
				signS = $("#signS").val();
			}else if(t=="CSign"){
				signC = $("#signC").val();
			}

		}

		function getLensTy2(ty,obj){
			ty2 = ty;
			$(".ty1Btn").removeClass("redBtn");
			$(".type3Btn").removeClass("redBtn");
			$(".SMBtn").removeClass("redBtn");

			$(obj).addClass("redBtn");
			$("#ty3Group").css("display","inline");
			$("#SMGroup").css("display","none");
			$("#lensTyGroupHr").css("display","block");
			$(".prdctNameSpan").html("");
		}

		function getLensSM(ty, obj){
			ty1 = ty;
			$(".type1Btn").removeClass("redBtn");
			$(".type3Btn").removeClass("redBtn");
			$("#SMGroup").css("display","inline");
			$("#ty3GroupHr").css("display","block");
			$(obj).addClass("redBtn");
			$(".prdctNameSpan").html("");


			var param = "mnfCountry=" + mnfCountry +
							"&iNum=" + iNum +
							"&ty1=" + ty1 +
							"&ty2=" + ty2;

			var url = "${ctxPath}/prdct/getLensSM.do";

			$.ajax({
				url : url,
				data : param,
				dataType : "html",
				type : "post",
				success : function(data){
					var ty2_ = data.ty2;
					if(ty2_=="Single"){
						ty2_ = "단초점";
					}else{
						ty2_ = "다초점";
					}
					$("#SMGroup").css("display","inline");
					$("#SMGroup").html(data);
					$(".SMBtn").buttonMarkup();
				}
			});
		}

		function getPrdctOption(){
			var url = "${ctxPath}/prdct/getPrdctOption.do";
			var param = "option=" + optionTy;
			$.ajax({
				url : url,
				dataType : "html",
				type : "post",
				data : param,
				success : function(data){

					$("#optionBtnSlct").html(data);
					$("#optionBtnRXSSlct").html(data);
					$("#optionBtnRXMSlct").html(data);

					$("#optionBtnSlct").selectmenu();
					$("#optionBtnRXSSlct").selectmenu();
					$("#optionBtnRXMSlct").selectmenu();

					$("#optionBtnSlct").selectmenu("refresh", true);
					$("#optionBtnSlct").val(-1).change();
					$("#optionBtnRXSSlct").selectmenu("refresh", true);
					$("#optionBtnRXSSlct").val(-1).change();
					$("#optionBtnRXMSlct").selectmenu("refresh", true);
					$("#optionBtnRXMSlct").val(-1).change();

				}
			});
		}

		function getPrdctOptionM(){
			var url = "${ctxPath}/prdct/getPrdctOption.do";
			var param = "option=" + optionTy;
			$.ajax({
				url : url,
				dataType : "html",
				type : "post",
				data : param,
				success : function(data){

					$("#optionIdM").html(data);
					$("#optionIdM").selectmenu();
					$("#optionIdM").selectmenu("refresh", true);
					$("#optionIdM").val(selectedOption).change();
				}
			});
		}

		var idForOption;
		var originPrc;
		var selectedOption;
		var is_pair = "n";
		function modifyPrdctOption(id, option, prc,optionId, pair){
			originPrc = prc;
			idForOption = id;
			optionTy = option;
			selectedOption = optionId;
			is_pair = pair;
			console.log("IS_PAIR=" + is_pair);
			getPrdctOptionM();
			$("#optionPop").popup('open');
		}

		function modifyOption(){
			if(confirm("변경하시겠습니까?")==false){
				return;
			}
			var lensSpec = $("#optionIdM option:selected").text();
			var prc = removeComma(lensSpec.substring(lensSpec.lastIndexOf("+")+1,lensSpec.lastIndexOf("원")));

			if(is_pair=="y"){
				prc = prc*2;
			}

			var optionId = $("#optionIdM").val();
			var param = "id=" + idForOption +
							"&option=" + optionId +
							"&optionPrc=" + prc;
			var url = "${ctxPath}/prdct/modiftOption.do";

			$.ajax({
				url : url,
				data : param,
				dataType : "text",
				type : "post",
				success : function(data){
					console.log(data);
					if(data=="success"){
						$("#optionPop").popup('close');

						if(sortTy=="D"){
							sortTy = "A";
						}else{
							sortTy = "D";
						}

						getOrderList(sort);
					}
				}
			});
		}

		function checkAll(){
			$("input[name=delChk]:checkbox").each(function() {
				$(this).prop("checked", true);
			})
		};

		function uncheckAll(){
			$("input[name=delChk]:checkbox").each(function() {
				$(this).prop("checked", false);
			});
		};


		var chkboxLength = 0;
		function receiveChk(){
			chkboxLength = 0;
			confirmChk = true;
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
		};
</script>
<style type="text/css">
	.ui-li-static.ui-collapsible {
    padding: 0;
}
.ui-li-static.ui-collapsible > .ui-collapsible-content > .ui-listview,
.ui-li-static.ui-collapsible > .ui-collapsible-heading {
    margin: 0;
}
.ui-li-static.ui-collapsible > .ui-collapsible-content {
    padding-top: 0;
    padding-bottom: 0;
    padding-right: 0;
    border-bottom-width: 0;
}
#eTypeDiv,#eTypeDiv2{
	position: absolute;
	left : 700px;
	display: none;
}
th{
	background-color: #f0ffff;
}
#gDiv, #wDiv, #bDiv{
	position: absolute;
	left : 400px;
	top: 100px;
}
#colorTbl{
	position: absolute;
	left : 500px;
	top: 100px;
}
#eyeSpec{
	position: absolute;
	left : 500;
	top: 200px;
}
.lensSpecTD{
	font-size: 15px;
	font-weight: bold;
}
.lensSpecFont{
	font-size: 12px;
}
#lensSpec{
	position: absolute;
	left : 500;
	top: 350px;
}
#rxOrderBtn{
	position: absolute;
	left : 800;
	top: 630px;
}
#rxOrderBtnM{
	position: absolute;
	left : 820;
	top: 1270px;
}
.A1{
	background-color: white;
}
.A1:HOVER{
	background-color: yellow;
	cursor: pointer;
}
.A0{
	background-color: #d3d3d3;
}
.boundDiv{
	display: none;
}
#orderListBTN{
	left : 550px;
	position: absolute;
}
#orderBtn{
	position: absolute;
	top: 50px;
	left : 960px;
	display: none;
}
#detailBtn{
	position: absolute;
	top: 50px;
	left : 1010px;
	display: none;
}
#optionBtn{
	position: absolute;
	top: 50px;
	left : 1110px;
	display: none;
}
#detailBtnRXS{
	position: absolute;
	top: 630px;
	left : 900px;
	display: none;
}#detailBtnRXM{
	position: absolute;
	top: 1269px;
	left : 920px;
	display: none;
}

#optionBtnRXS{
	position: absolute;
	top: 630px;
	left : 1000px;
	display: none;
}#optionBtnRXM{
	position: absolute;
	top: 1269px;
	left : 1020px;
	display: none;
}

.redBtn{
    background-color : #4682b4 !important;
    color: white !important;
}
.lensSpecVal​{
	background-color: gray;
}
.rxPrdctSpecS,.rxPrdctSpecM{
	display: none;
}
.boundDiv { border-collapse: separate; }
.boundDiv tr:first-child td:first-child { border-top-left-radius: 10px; }
.boundDiv tr:first-child td:last-child { border-top-right-radius: 10px; }
.boundDiv tr:last-child td:first-child { border-bottom-left-radius: 10px; }
.boundDiv tr:last-child td:last-child { border-bottom-right-radius: 10px; }

#returnMsg{
	display: none;
}
#ty2Field{
	display: none;
}
#ty3Group{
	display: none;
}
hr{
	display: none;
}
#orderList{
	font-size:13px;
}
.sort{
	cursor : pointer;
}
</style>
</head>
<body>
	<div data-role="page" id="mainDiv" style="overflow-x: auto;">
		<div data-role="content" >
			<div data-role="controlgroup" data-type="horizontal" id="eTypeDiv">
				<label for="g">근난시</label><input type="radio" id="g" name="eType" value="g" onclick="getLensBound('g');">
	  	   		<label for="w">원난시</label><input type="radio" id="w" name="eType" value="w" onclick="getLensBound('w');">
	  	   		<label for="b">복난시</label><input type="radio" id="b" name="eType" value="b" onclick="getLensBound('b');">
	  	    </div>
	  	    <!-- <div data-role="controlgroup" data-type="horizontal" id="eTypeDiv2">
				<label for="rl">R/L동일</label><input type="radio" id="rl" name="eType2" value="rl" onclick="">
	  	   		<label for="r">R</label><input type="radio" id="r" name="eType2" value="r" onclick="">
	  	   		<label for="l">L</label><input type="radio" id="l" name="eType2" value="l" onclick="">
	  	    </div> -->
	  	    <a href="${ctxPath }/prdct/indexPrdctConfirmForm.do" rel="external" data-role="button" data-mini="true" data-inline="true" id="homeBTN" data-icon="arrow-l" >뒤로</a>
	  	    <a href="#orderDiv" data-transition="flow" data-role="button" data-mini="true" data-inline="true" id="orderListBTN">주문내역</a>


	  	    	<table border="1" style="text-align: center; border-color: #c0c0c0;border-spacing:0px;" id="gDiv" class="boundDiv">

	  	    	</table>

	  	    	<table border="1" style="text-align: center; border-color: #c0c0c0;border-spacing:0px;"  id="wDiv" class="boundDiv"  >

	  	    	</table>

	  	    	<table border="1" style="text-align: center; border-color: #c0c0c0;border-spacing:0px;"  id="bDiv" class="boundDiv">

	  	    	</table>

	  	    	<a href="#" data-role="button" data-mini="true" data-inline="true" id="orderBtn" onclick="cntOrderList();">구매</a>
	  	    	<a href="#" data-role="button" data-mini="true" data-inline="true" id="detailBtn" onclick="showDetailDiv();">상세내용</a>
				<span id="optionBtn">
					<select id="optionBtnSlct" data-inline="true" data-mini="true" data-native-menu='false' onchange="addOptionPrc()"></select>
	  	    	</span>

	  	    	<!-- RX제품 정보 Single-->
	  	    	<form id="rxSingForm">
	  	    	<table id="rxPrdctSpecS" class="rxPrdctSpecS">
	  	    		<tr>
		  	    		<table id="colorTbl" border="1" style="text-align: center;font-size:12px; width:700px; border-color: #c0c0c0;" class="rxPrdctSpecS">
		  	    			<tr>
		  	    				<td width="10%" >COLOR</td><td style="padding-left: 10px;padding-right: 250px;"><input type="text" id="colorCd" size="5" readonly="readonly" onclick="colorCdView();"></td><td width="30%"><input type="checkbox" id="AR" value="y" data-role="none"> 내면만 AR</td>
		  	    			</tr>
		  	    		</table>

		  	    		<table style="width: 700px;text-align: center" id="eyeSpec" class="rxPrdctSpecS">
		  	    			<tr>
								<td ></td>
								<td >SPH</td>
								<td >CYL</td>
								<td >AXIS</td>
								<td >ADD</td>
								<td >CDIA</td>
								<td >DIA</td>
								<td >IOBASE</td>
								<td >IOPRI</td>
								<td >UDBASE</td>
								<td >UDPRI</td>
							</tr>
							<tr>
								<td >R</td>
								<td><input type="text"    id="sphR" tabindex=1 size="3"
									name="sphR" style="font-size: 12px" onchange="format(sphR,'s');"></input></td>
								<td><input type="text" size="3"   id="cylR" tabindex=2
									name="cylR" style="font-size: 12px"  onchange="format(cylR,'s')"></input></td>
								<td><input type="text" size="3"  tabindex=3
									id="axisR" name="axisR" style="font-size: 12px" > </input></td>
								<td><input type="text" size="3" tabindex=4
									style="font-size: 12px"
									id="addR" name="addR" class="notUse"></input></td>
								<td><input type="text" size="3" tabindex=5
											id="cdiaR" name="cdiaR" style="font-size: 12px"    class="notUse"></input></td>

								<td ><input type="text" size="3" tabindex=6 style="font-size: 12px"
									id="diaR" name="diaR"  ></input></td>
								<td ><input type="text" size="3" tabindex=12 style="font-size: 12px"   class="notUse"
									id="iobaseR" name="iobaseR" onchange></input></td>
								<td ><input type="text" size="3" tabindex=13 style="font-size: 12px"  class="notUse"
									id="iopriR" name="iopriR" ></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="udbaseR" name="udbaseR" ></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="udpriR" name="udpriR"></input></td>
							</tr>
							<tr>
								<td>L</td>
								<td><input type="text"    id="sphL" tabindex=7 size="3"
									name="sphL" style="font-size: 12px" onchange="format(sphL,'s');"></input></td>
								<td><input type="text" size="3"   id="cylL" tabindex=8
									name="cylL" style="font-size: 12px"  onchange="format(cylL,'s')"></input></td>
								<td><input type="text" size="3"  tabindex=9
									id="axisL" name="axisL" style="font-size: 12px" > </input></td>
								<td><input type="text" size="3" tabindex=10
									style="font-size: 12px"
									id="addL" name="addL" class="notUse"></input></td>
								<td><input type="text" size="3" tabindex=5
											id="cdiaL" name="cdiaL" style="font-size: 12px" class="notUse"></input></td>

								<td ><input type="text" size="3" tabindex=11 style="font-size: 12px"
									id="diaL" name="diaL"></input></td>
								<td ><input type="text" size="3" tabindex=12 style="font-size: 12px"   class="notUse"
									id="iobaseL" name="iobaseL" onchange></input></td>
								<td ><input type="text" size="3" tabindex=13 style="font-size: 12px"  class="notUse"
									id="iopriL" name="iopriL" ></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="udbaseL" name="udbaseL" ></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="udpriL" name="udpriL"></input></td>

							</tr>
		  	    		</table>

		  	    		<table id="lensSpec" border="1"class="rxPrdctSpecS"  style="text-align: center;font-size:12px; width:700px;">
							<tr>
								<Td>프리즘</Td><td colspan="5">
								<div data-role="controlgroup" data-type="horizontal">
									오른쪽 : <input type="radio" name="prsRIO" value="inR" data-role="none">IN<input type="radio" name="prsRIO" value="outR" data-role="none">OUT
									<select id="prsValRIO" data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism

									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									<input type="radio" name="prsRUD" value="upR" data-role="none">UP<input type="radio" name="prsRUD" value="downR" data-role="none">DOWN
									<select id="prsValRUD" data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism
									<br>

									왼쪽 &nbsp;&nbsp;&nbsp;: <input type="radio" name="prsLIO" value="inL" data-role="none">IN<input type="radio" name="prsLIO" value="outL" data-role="none">OUT
									<select id="prsValLIO" data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism

									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									<input type="radio" name="prsLUD" value="upL" data-role="none">UP<input type="radio" name="prsLUD" value="downL" data-role="none">DOWN
									<select id="prsValLUD" data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism

								</div>
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" data-role="none" onclick="inputDisabled(this)">외경지정</td>
								<td>가로(A)<br>
									<input type="text" id="A" class="lensSpecVal" data-role="none" size="8">mm
								</td>
								<td>브릿지(DBL)<br>
									<input type="text" id="DBL" class="lensSpecVal" data-role="none" size="8">mm
								</td>
								<td>대각(ED)<br>
									<input type="text" id="ED" class="lensSpecVal" data-role="none" size="8">mm
								</td>
								<td>높이(B)<br>
									<input type="text" id="B" class="lensSpecVal" data-role="none" size="8">mm
								</td>
								<td>단안 원용(PD)<br>
									R : <input type="text" id="PDR" class="lensSpecVal" data-role="none" size="8">mm<br>
									L : <input type="text" id="PDL" class="lensSpecVal" data-role="none" size="8">mm
								</td>
							</tr>
							<tr>
								<td>두께</td><td colspan="5">
									<span style="font-weight: bold;margin-right: 230px">왼쪽 렌즈</span><span style="font-weight: bold;">오른쪽 렌즈</span><br><br>
									귀<input type="text" size="5" data-role="none" id="earL" onblur="chkLensSize(this)">&nbsp;
									중심<input type="text" size="5" data-role="none" id="centerL" onblur="chkLensSize(this)">&nbsp;
								    코<input type="text" size="5" data-role="none" id="noseL" style="margin-right: 80px" onblur="chkLensSize(this)">&nbsp;

								    귀<input type="text" size="5" data-role="none" id="earR" onblur="chkLensSize(this)">&nbsp;
									중심<input type="text" size="5" data-role="none" id="centerR" onblur="chkLensSize(this)">&nbsp;
								    코<input type="text" size="5" data-role="none" id="noseR" onblur="chkLensSize(this)">&nbsp;<br><br>

								    <div style="color: red">[주의]원알렌즈상의 도면입니다.(컷팅시 아님.)</div>
									 <span style="color: red">[주의]두께는 귀쪽,코쪽,중심 한곳만 지정가능합니다.한곳을 지정하면 나머지는 지워집니다.</span><a href="javascript:initInput();">초기화</a>

								</td>
							</tr>
		  	    		</table>
	  	    		</tr>
	  	    		<button data-mini="true" data-inline="true" class="rxPrdctSpecS" id="rxOrderBtn" onclick="chkPair(); return false;">주문</button>
	  	    		<a href="#" data-role="button" data-mini="true" data-inline="true" id="detailBtnRXS" onclick="showDetailDiv();">상세내용</a>
	  	    		<span id="optionBtnRXS">
	  	    			<select onchange="addOptionPrc()" id="optionBtnRXSSlct" data-inline="true" data-mini="true" data-native-menu='false'></select>
	  	    		</span>
	  	    	</table>
	  	    	</form>

	  	    	<!-- RX제품 정보 Multi-->

	  	    	<form id="rxMultiForm">
	  	    	<table id="rxPrdctSpecM" class="rxPrdctSpecM">
	  	    		<tr>
		  	    		<table id="colorTbl" border="1" style="text-align: center;font-size:12px; width:700px; border-color: #c0c0c0;" class="rxPrdctSpecM">
		  	    			<tr>
		  	    				<td width="10%" >COLOR</td><td style="padding-left: 10px;padding-right: 250px;"><input type="text" id="colorCd" size="5" readonly="readonly" onclick="colorCdView();"> </td><td width="25%"></td>
		  	    			</tr>
		  	    		</table>

		  	    		<table style="width: 700px;text-align: center" id="eyeSpec" class="rxPrdctSpecM">
		  	    			<tr>
								<td ></td>
								<td >SPH</td>
								<td >CYL</td>
								<td >AXIS</td>
								<td >ADD</td>
								<td >CDIA</td>
								<td >DIA</td>
								<td >IOBASE</td>
								<td >IOPRI</td>
								<td >UDBASE</td>
								<td >UDPRI</td>
							</tr>
							<tr>
								<td >R</td>
								<td><input type="text"    id="sphR" tabindex=1 size="3"
									name="sphR" style="font-size: 12px" onchange="format(sphR,'m');"></input></td>
								<td><input type="text" size="3"   id="cylR" tabindex=2
									name="cylR" style="font-size: 12px"  onchange="format(cylR,'m')"></input></td>
								<td><input type="text" size="3"  tabindex=3
									id="axisR" name="axisR" style="font-size: 12px" > </input></td>
								<td><input type="text" size="3" tabindex=4
									style="font-size: 12px" id="addR" name="addR" ></input></td>
								<td><input type="text" size="3" tabindex=
											id="cdiaR" name="cdiaR" style="font-size: 12px"    class="notUse"></input></td>

								<td ><input type="text" size="3" tabindex=5 style="font-size: 12px"
									id="diaR" name="diaR"  ></input></td>
								<td ><input type="text" size="3" tabindex=12 style="font-size: 12px"   class="notUse"
									id="iobaseR" name="iobaseR" onchange></input></td>
								<td ><input type="text" size="3" tabindex=13 style="font-size: 12px"  class="notUse"
									id="iopriR" name="iopriR" ></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="udbaseR" name="udbaseR" ></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="udpriR" name="udpriR"></input></td>
							</tr>
							<tr>
								<td>L</td>
								<td><input type="text"    id="sphL" tabindex=6 size="3"
									name="sphL" style="font-size: 12px" onchange="format(sphL,'m');"></input></td>
								<td><input type="text" size="3"   id="cylL" tabindex=7
									name="cylL" style="font-size: 12px"  onchange="format(cylL,'m')"></input></td>
								<td><input type="text" size="3"  tabindex=8
									id="axisL" name="axisL" style="font-size: 12px" > </input></td>
								<td><input type="text" size="3" tabindex=9
									style="font-size: 12px"id="addL" name="addL" ></input></td>
								<td><input type="text" size="3" tabindex=11
											id="cdiaL" name="cdiaL" style="font-size: 12px" class="notUse"></input></td>

								<td ><input type="text" size="3" tabindex=10 style="font-size: 12px"
									id="diaL" name="diaL"></input></td>
								<td ><input type="text" size="3" tabindex=12 style="font-size: 12px"   class="notUse"
									id="iobaseL" name="iobaseL" onchange></input></td>
								<td ><input type="text" size="3" tabindex=13 style="font-size: 12px"  class="notUse"
									id="iopriL" name="iopriL" ></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="udbaseL" name="udbaseL" ></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="udpriL" name="udpriL"></input></td>

							</tr>
		  	    		</table>

		  	    		<table id="lensSpec" border="1"class="rxPrdctSpecM"  style="text-align: center;font-size:12px; width:700px;">
							<tr>
								<Td>프리즘</Td><td colspan="5">
								<div data-role="controlgroup" data-type="horizontal">
									오른쪽 : <input type="radio" name="prsRIO" value="inR" data-role="none">IN<input type="radio" name="prsRIO" value="outR" data-role="none">OUT
									<select id="prsValRIO" data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism

									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									<input type="radio" name="prsRUD" value="upR" data-role="none">UP<input type="radio" name="prsRUD" value="downR" data-role="none">DOWN
									<select id="prsValRUD" data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism
									<br>

									왼쪽 &nbsp;&nbsp;&nbsp;: <input type="radio" name="prsLIO" value="inL" data-role="none">IN<input type="radio" name="prsLIO" value="outL" data-role="none">OUT
									<select id="prsValLIO" data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism

									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									<input type="radio" name="prsLUD" value="upL" data-role="none">UP<input type="radio" name="prsLUD" value="downL" data-role="none">DOWN
									<select id="prsValLUD" data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism

								</div>
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" data-role="none" onclick="inputDisabled(this)" id="lensSizeM">외경지정</td>
								<td>가로(A)<br>
									<input type="text" id="A" class="lensSpecVal" data-role="none" size="8">mm
								</td>
								<td>브릿지(DBL)<br>
									<input type="text" id="DBL" class="lensSpecVal" data-role="none" size="8">mm
								</td>
								<td>대각(ED)<br>
									<input type="text" id="ED" class="lensSpecVal" data-role="none" size="8">mm
								</td>
								<td>높이(B)<br>
									<input type="text" id="B" class="lensSpecVal" data-role="none" size="8">mm
								</td>
								<td>단안 원용(PD)<br>
									R : <input type="text" id="PDR" class="lensSpecVal" data-role="none" size="8">mm<br>
									L : <input type="text" id="PDL" class="lensSpecVal" data-role="none" size="8">mm
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" data-role="none" onclick="inputDisabled2(this)">PreCal</td>
								<td colspan="5" style="padding-left: 30px;padding-right: 30px">
								<center>
									<table border="1"class="rxPrdctSpecM"  style="text-align: left;font-size:12px; width:100%;">
										<tr>
											<td>프레임타입</td>
											<td>
												<select id="frameType" data-role="none" class="lensSpecValM">
													<option value="-1">선택</option>
													<option value="0">(기본 가두께)</option>
													<option value="1.0">메탈/플라스틱 (1.0mm)</option>
													<option value="1.5">무테/뿔테 (1.5mm)</option>
													<option value="1.7">반무테 (1.7mm)</option>
													<option value="2.0">기타 (2.0mm)</option>
													<option value="2.5">기타 (2.5mm)</option>
												</select>
											</td>
										</tr>
										<tr>
											<td>프레임모양</td>
											<td>
											<select id="frameShape" data-role="none" class="lensSpecValM">
													<option value="-1">선택</option>
													<option value="1">1.오각형</option>
													<option value="2">2.다각형</option>
													<option value="3">3.잠자리형</option>
													<option value="4">4.여우형</option>
													<option value="5">5.타원형</option>
													<option value="6">6.역사다리형</option>
													<option value="7">7.직사각형</option>
													<option value="8">8.캣어웨이</option>
												</select>
											</td>
										</tr>
										<tr>
											<td>가로길이(A) <span style="color: red">(※)</span></td>
											<td><input type="text" size="5" id="preA" class="lensSpecValM" data-role="none">mm</td>
										</tr>
										<tr>
											<td>세로길이(B)</td>
											<td><input type="text" size="5" id="preB" class="lensSpecValM" data-role="none">mm</td>
										</tr>
										<tr>
											<td>브릿지길이(DBL)</td>
											<td><input type="text" size="5" id="preDBL" class="lensSpecValM" data-role="none">mm</td>
										</tr>
										<tr>
											<td>피팅높이(OH)</td>
											<td>R :<input type="text" size="5" id="preOHR" class="lensSpecValM" data-role="none">mm<br>
												 L : <input type="text" size="5" id="preOHL"class="lensSpecValM"  data-role="none">mm
											</td>
										</tr>
										<tr>
											<td>단안(PD)</td>
											<td>R : <input type="text" size="5" id="prePDR" class="lensSpecValM" data-role="none">mm<br>
												 L : <input type="text" size="5" id="prePDL" class="lensSpecValM" data-role="none">mm
											</td>
										</tr>
										<tr>
											<td>별도가두께지정(ET)</td>
											<td><input type="text" size="5" id="preET" class="lensSpecValM" data-role="none">mm</td>
										</tr>
									</table>
									<br>
									<span style="color: red">※ 보다 정확한 계산을 위해, 가로(A)와 대각(ED) 중 큰 사이즈의 값을 입력해주시길 바랍니다.</span>
								</center>
								<hr>
								- A : 데이텀 시스템에서 가로 길이<br>
								- B : 데이텀 시스템에서 세로 길이<br>
								- DBL : 브릿지 사이즈<br><br>
								<img src="${ctxPath }/images/rx_img.png"><br>
								모양이 확실하지 않을 경우, 프레임 모양의 중앙에서 가장 긴 부분의 위치가 일치하는 모양의
								번호를 불러 주시거나 아래의 사항을 참조하세요.
								<br>
								가장 많은 여유분이 지정되는 번호는 7번 입니다.<br>
								<span style="color: red">(만약, 당신이 프레임 모양에 확신이 없을 시 사용) </span><br>
								가장 적은 여유분이 지정되는 번호는 2번과 5번 입니다.<br>
								<span style="color: red">(2번과 5번을 주문하실 때, 프레임 모양 확인 요망) </span><br>
								</td>
							</tr>
		  	    		</table>
	  	    		</tr>
	  	    		<button data-mini="true" data-inline="true" class="rxPrdctSpecM" id="rxOrderBtnM" onclick="chkPairX(); return false">주문</button>
	  	    		<a href="#" data-role="button" data-mini="true" data-inline="true" id="detailBtnRXM" onclick="showDetailDiv();">상세내용</a>
	  	    		<span id="optionBtnRXM">
	  	    			<select onchange="addOptionPrc()" id="optionBtnRXMSlct" data-inline="true" data-mini="true" data-native-menu='false'></select>
	  	    		</span>

	  	    	</table>
	  	    	</form>
			<div data-role="tabs" id="tabs"  style="width: 300px;">
  				<div data-role="navbar">
    				<ul>
				      <li><a href="#k" data-ajax="false" onclick="setOrigin('1');" class="ui-btn-active">국산</a></li>
				      <li><a href="#f" data-ajax="false" onclick="setOrigin('2');">수입</a></li>
				    </ul>
  				</div>

	  		<div id="k" class="ui-body-d ui-content">
	  			<div data-role="controlgroup" data-type="horizontal" id="iNumGroup">
	  			</div>
	  			<hr id="iNumGroupHr">

	  			<div data-role="controlgroup" data-type="horizontal" id="lensTyGroup">
	  			</div>

	  			<hr id="lensTyGroupHr">

	  			<div data-role="controlgroup" data-type="horizontal" id="ty3Group">
	  				<button onclick="getLensSM('spare',this);" class="type3Btn">여벌</button>
	  				<button onclick="getLensSM('rx',this);" class="type3Btn">RX</button>
	  			</div>

	  			<hr id="ty3GroupHr">

	  			<div data-role="controlgroup" data-type="horizontal" id="SMGroup">

	  			</div>
	  			<hr id="SMGroupHr">
	  			<div>
	  				<ul id="iNumList" data-role="listview" data-inset='true' class="ui-listview-outer" id="iNumList">

	  				</ul>
	  			</div>

			<span class="prdctNameSpan" style="font-weight: bold;"></span>
	  		</div>

	  		<div id="f">

	  		<span class="prdctNameSpan" style="font-weight: bold;"></span>
	  	   </div>


		 </div>





		 <div data-role="popup" id="detailDiv" data-theme="a" class="ui-corner-all"style="padding: 20px;" data-transition="pop">
			<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right" data-transition="pop">Close</a>
			<textarea rows="30" cols="60" id="detail" style="height: 100px;"></textarea>
			<Center>
				<button data-inline="true" data-mini="true" onclick="closeDetail()">확인</button>
			</Center>
	  	 </div>

		</div>
		<div data-role="popup" id="popupMenu" data-theme="a">
	        <ul data-role="listview" data-inset="true" style="min-width:210px;" id="prdctList">
	        </ul>
		</div>

		<div data-role="popup" id="colorCdDiv" data-theme="a"  data-transition="pop">
			 <ul id="colorComList"  data-role="listview" data-collapsed-icon="arrow-r" data-expanded-icon="arrow-d" style="margin:0; width:250px;">

			</div>
		</div>


	</div>


	<!-- 주문정보 -->
	<div data-role="page" id="orderDiv">
		<div data-role="content">
			<a href="#mainDiv"  data-transition="flow" data-direction="reverse" data-role="button" data-inline="true" data-mini="true" data-icon="arrow-l">뒤로</a>

			<center>
			<div style="width: 90%">
			<input type="date" id="sdate" data-role="none" onchange="getOrderList();"> - <input type="date" id="edate" data-role="none" onchange="getOrderList();">
					<button onclick="checkAll()" data-mini="true" data-inline="true" style="float:left;">전체선택</button>
					<button onclick="uncheckAll()" data-mini="true" data-inline="true" style="float:left;">전체해제</button>
					<table id="orderList" class='tablesorter-ice' border="1" style="border-collapse: collapse; text-align: center">

					</table>
					<button data-inline="true" data-mini="true" id="allReceivBtn" onclick="receiveChk();">배송확인</button>
			</div>
			</center>
		</div>

		 <div data-role="popup" id="modifySpareLens" data-theme="a" class="ui-corner-all"style="padding: 20px;">
			<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
			 	SPH<select id="signS" data-role="none" onchange="modifySpec('SSign')">
			 		<option value="+" >+</option>
			 		<option value="-">-</option>
			 	</select>
			 	<select id="sphModi" data-role="none" onchange="modifySpec('S')">
			 			<option value="0000">0000</option>
				 		<option value="0025">0025</option>
				 		<option value="0050">0050</option>
				 		<option value="0075">0075</option>
				 		<option value="0100">0100</option>
				 		<option value="0125">0125</option>
				 		<option value="0150">0150</option>
				 		<option value="0175">0175</option>
				 		<option value="0200">0200</option>
				 		<option value="0225">0225</option>
				 		<option value="0250">0250</option>
				 		<option value="0275">0275</option>
				 		<option value="0300">0300</option>
				 		<option value="0325">0325</option>
				 		<option value="0350">0350</option>
				 		<option value="0375">0375</option>
				 		<option value="0400">0400</option>
				 		<option value="0425">0425</option>
				 		<option value="0450">0450</option>
				 		<option value="0475">04075</option>
				 		<option value="0500">0500</option>
				 		<option value="0525">0525</option>
				 		<option value="0550">0550</option>
				 		<option value="0575">0575</option>
				 		<option value="0600">0600</option>
				 		<option value="0625">0625</option>
				 		<option value="0650">0650</option>
				 		<option value="0675">0675</option>
				 		<option value="0700">0700</option>
				 		<option value="0725">0725</option>
				 		<option value="0750">0750</option>
				 		<option value="0775">0775</option>
				 		<option value="0800">0800</option>
				 		<option value="0825">0825</option>
				 		<option value="0850">0850</option>
				 		<option value="0875">0875</option>
				 		<option value="0900">0900</option>
				 		<option value="0925">0925</option>
				 		<option value="0950">0950</option>
				 		<option value="0975">0975</option>
				 		<option value="1000">1000</option>
				 		<option value="1025">1025</option>
				 		<option value="1050">1050</option>
				 		<option value="1075">1075</option>
				 		<option value="1100">1100</option>
				 		<option value="1125">1125</option>
				 		<option value="1150">1150</option>
				 		<option value="1175">1175</option>
				 		<option value="1200">1200</option>
				 		<option value="1225">1225</option>
				 		<option value="1250">1250</option>
				 		<option value="1275">1275</option>
				 		<option value="1300">1300</option>
				 		<option value="1325">1325</option>
				 		<option value="1350">1350</option>
				 		<option value="1375">1375</option>
				 		<option value="1400">1400</option>
				 		<option value="1425">1425</option>
				 		<option value="1450">1450</option>
				 		<option value="1475">1475</option>
				 		<option value="1500">1500</option>
				 		<option value="1525">1525</option>
				 		<option value="1550">1550</option>
				 		<option value="1575">1575</option>
				 		<option value="1600">1600</option>
				 		<option value="1625">1625</option>
				 		<option value="1650">1650</option>
				 		<option value="1675">1675</option>
				 		<option value="1700">1700</option>
				 		<option value="1725">1725</option>
				 		<option value="1750">1750</option>
				 		<option value="1775">1775</option>
				 		<option value="1800">1800</option>
				 		<option value="1825">1825</option>
				 		<option value="1850">1850</option>
				 		<option value="1875">1875</option>
				 		<option value="1900">1900</option>
				 		<option value="1925">1925</option>
				 		<option value="1950">1950</option>
				 		<option value="1975">1975</option>
				 		<option value="2000">2000</option>
			 	</select>
			 	<br>

			 	CYL<select id="signC" data-role="none" onchange="modifySpec('CSign')">
				 		<option value="+" >+</option>
				 		<option value="-">-</option>
				 	</select>

				 	<select id="cylModi" data-role="none" onchange="modifySpec('C')">
				 		<option value="000">000</option>
				 		<option value="025">025</option>
				 		<option value="050">050</option>
				 		<option value="075">075</option>
				 		<option value="100">100</option>
				 		<option value="125">125</option>
				 		<option value="150">150</option>
				 		<option value="175">175</option>
				 		<option value="200">200</option>
				 		<option value="225">225</option>
				 		<option value="250">250</option>
				 		<option value="275">275</option>
				 		<option value="300">300</option>
				 		<option value="325">325</option>
				 		<option value="350">350</option>
				 		<option value="375">375</option>
				 		<option value="400">400</option>
				 	</select>

				 	<textarea rows="2" cols="10" id="detailForMod"></textarea>
				 	<center><button onclick="modifySpareLensSpec()" data-mini="true" data-inline="">변경</button></center>
	  	 </div>

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



		<div data-role="popup" id="modifyRXs" data-theme="a" class="ui-corner-all"style="padding: 20px; width: 100%">
		<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
		<form action="" id="modifyRXsForm">
		<table id="modifySpecS" class="modifySpecS">
	  	    		<tr>
		  	    		<table border="1" style="text-align: center;font-size:12px; width:700px; border-color: #c0c0c0;" class="modifySpecS">
		  	    			<tr>
		  	    				<td width="10%" >COLOR</td><td style="padding-left: 10px;padding-right: 250px;"><input type="text" id="colorCd" size="5" readonly="readonly" onclick="colorCdView();"> </td><td width="30%"><input type="checkbox" id="AR" value="y" data-role="none"> 내면만 AR</td>
		  	    			</tr>
		  	    		</table>

		  	    		<table style="width: 700px;text-align: center" class="modifySpecS">
		  	    			<tr>
								<td ></td>
								<td >SPH</td>
								<td >CYL</td>
								<td >AXIS</td>
								<td >ADD</td>
								<td >CDIA</td>
								<td >DIA</td>
								<td >IOBASE</td>
								<td >IOPRI</td>
								<td >UDBASE</td>
								<td >UDPRI</td>
							</tr>
							<tr>
								<td >R</td>
								<td><input type="text"    id="MsphR" class="MsphR" tabindex=1 size="3"
									name="sphR" style="font-size: 12px" onchange="format(sphR,'s');"></input></td>
								<td><input type="text" size="3"   id="McylR" class="McylR" tabindex=2
									name="cylR" style="font-size: 12px"  onchange="format(cylR,'s')"></input></td>
								<td><input type="text" size="3"  tabindex=3
									id="MaxisR" name="axisR" class="MaxisR" style="font-size: 12px" > </input></td>
								<td><input type="text" size="3" tabindex=4
									style="font-size: 12px"
									id="MaddR" name="addR" class="notUse MaddR"></input></td>
								<td><input type="text" size="3" tabindex=5
											id="McdiaR" name="cdiaR" style="font-size: 12px"    class="notUse McdiaR"></input></td>

								<td ><input type="text" size="3" tabindex=11 style="font-size: 12px"
									id="MdiaR" name="diaR" class="MdiaR" ></input></td>
								<td ><input type="text" size="3" tabindex=12 style="font-size: 12px"   class="notUse"
									id="MiobaseR" name="iobaseR" class="MiobaseR" onchange></input></td>
								<td ><input type="text" size="3" tabindex=13 style="font-size: 12px"  class="notUse"
									id="MiopriR" name="iopriR" class="MiopriR"></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="MudbaseR" name="udbaseR" class="MudbaseR" ></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="MudpriR" name="udpriR" class="MudpriR"></input></td>
							</tr>
							<tr>
								<td>L</td>
								<td><input type="text"    id="MsphL"  class="MsphL" tabindex=1 size="3"
									name="sphL" style="font-size: 12px" onchange="format(sphL,'s');"></input></td>
								<td><input type="text" size="3"   id="McylL" class="McylL" tabindex=2
									name="cylL" style="font-size: 12px"  onchange="format(cylL,'s')"></input></td>
								<td><input type="text" size="3"  tabindex=3 class="MaxisL"
									id="MaxisL" name="axisL" style="font-size: 12px" > </input></td>
								<td><input type="text" size="3" tabindex=4
									style="font-size: 12px"
									id="MaddL" name="addL" class="notUse MaddL"></input></td>
								<td><input type="text" size="3" tabindex=5
											id="McdiaL" name="cdiaL" style="font-size: 12px" class="notUse McdiaL"></input></td>

								<td ><input type="text" size="3" tabindex=11 style="font-size: 12px"
									id="MdiaL" name="diaL" class="MdiaL"></input></td>
								<td ><input type="text" size="3" tabindex=12 style="font-size: 12px"   class="notUse"
									id="MiobaseL" name="iobaseL" class="MiobaseL" onchange></input></td>
								<td ><input type="text" size="3" tabindex=13 style="font-size: 12px"  class="notUse"
									id="MiopriL" name="iopriL"  class="MiopriL"></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="MudbaseL" name="udbaseL" class="MudbaseL"></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="MudpriL" name="udpriL" class="MudpriL"></input></td>

							</tr>
		  	    		</table>

		  	    		<table  border="1"class="modifySpecS"  style="text-align: center;font-size:12px; width:700px;">
							<tr>
								<Td>프리즘</Td><td colspan="5">
								<div data-role="controlgroup" data-type="horizontal">
									오른쪽 : <input type="radio" name="MprsRIO" value="inR" data-role="none">IN<input type="radio" name="MprsRIO" value="outR" data-role="none">OUT
									<select id="MprsValRIO" data-role="none" class="MprsValRIO">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism

									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									<input type="radio" name="MprsRUD" value="upR" data-role="none">UP<input type="radio" name="MprsRUD" value="downR" data-role="none">DOWN
									<select id="MprsValRUD" class="MprsValRUD"data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism
									<br>

									왼쪽 &nbsp;&nbsp;&nbsp;: <input type="radio" name="MprsLIO" value="inL" data-role="none">IN<input type="radio" name="MprsLIO" value="outL" data-role="none">OUT
									<select id="MprsValLIO"class="MprsValLIO" data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism

									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									<input type="radio" name="MprsLUD" value="upL" data-role="none">UP<input type="radio" name="MprsLUD" value="downL" data-role="none">DOWN
									<select id="MprsValLUD" class="MprsValLUD"data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism

								</div>
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" data-role="none" onclick="inputDisabled(this)" checked="checked">외경지정</td>
								<td>가로(A)<br>
									<input type="text" id="MA"  class="MA" data-role="none" size="8">mm
								</td>
								<td>브릿지(DBL)<br>
									<input type="text" id="MDBL" class="MDBL" data-role="none" size="8">mm
								</td>
								<td>대각(ED)<br>
									<input type="text" id="MED" class="MED" data-role="none" size="8">mm
								</td>
								<td>높이(B)<br>
									<input type="text" id="MB" class="MB" data-role="none" size="8">mm
								</td>
								<td>단안 원용(PD)<br>
									R : <input type="text" id="MPDR" class="MPDR" data-role="none" size="8">mm<br>
									L : <input type="text" id="MPDL" class="MPDL" data-role="none" size="8">mm
								</td>
							</tr>
							<tr>
								<td>두께</td><td colspan="5">
									<span style="font-weight: bold;margin-right: 230px">왼쪽 렌즈</span><span style="font-weight: bold;">오른쪽 렌즈</span><br><br>
									귀<input type="text" size="5" data-role="none" id="MearL" class="MearL" onblur="chkLensSize(this)">&nbsp;
									중심<input type="text" size="5" data-role="none" id="McenterL" class="McenterL" onblur="chkLensSize(this)">&nbsp;
								    코<input type="text" size="5" data-role="none" id="MnoseL"class="MnoseL" style="margin-right: 80px" onblur="chkLensSize(this)">&nbsp;

								    귀<input type="text" size="5" data-role="none" id="MearR" class="MearR" onblur="chkLensSize(this)">&nbsp;
									중심<input type="text" size="5" data-role="none" id="McenterR" class="McenterR" onblur="chkLensSize(this)">&nbsp;
								    코<input type="text" size="5" data-role="none" id="MnoseR" class="MnoseR" onblur="chkLensSize(this)">&nbsp;<br><br>

								    <div style="color: red">[주의]원알렌즈상의 도면입니다.(컷팅시 아님.)</div>
									 <span style="color: red">[주의]두께는 귀쪽,코쪽,중심 한곳만 지정가능합니다.한곳을 지정하면 나머지는 지워집니다.</span><a href="javascript:initInput();">초기화</a>

								</td>
							</tr>
		  	    		</table>
	  	    		</tr>
	  	    		<tr>
	  	    			<td colspan="6">
	  	    				<textarea rows="3" cols="8" class="detailForMODRX"></textarea>
	  	    			</td>
	  	    		</tr>
	  	    		<center><button data-inline="true" class="modifySpecS"  onclick="modifyLens(); return false;">확인</button></center>
	  	    	</table>
	  	    	</form>
	</div>





	<!-- 주문수정 -->
	<div data-role="popup" id="modifyRXm" data-theme="a" class="ui-corner-all"style="padding: 20px; width: 100%">
		<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
		<form action="" id="modifyRXsForm">
	  	    	<table id="modifySpecM" class="modifySpecM">
	  	    		<tr>
		  	    		<table border="1" style="text-align: center;font-size:12px; width:700px; border-color: #c0c0c0;" class="modifySpecM">
		  	    			<tr>
		  	    				<td width="10%" >COLOR</td><td style="padding-left: 10px;padding-right: 250px;"><input type="text" id="colorCd" size="5" readonly="readonly" onclick="colorCdView();"> </td><td width="25%"></td>
		  	    			</tr>
		  	    		</table>

		  	    		<table style="width: 700px;text-align: center" class="modifySpecS">
		  	    			<tr>
								<td ></td>
								<td >SPH</td>
								<td >CYL</td>
								<td >AXIS</td>
								<td >ADD</td>
								<td >CDIA</td>
								<td >DIA</td>
								<td >IOBASE</td>
								<td >IOPRI</td>
								<td >UDBASE</td>
								<td >UDPRI</td>
							</tr>
							<tr>
								<td >R</td>
								<td><input type="text"    id="sphR" class="MsphR" tabindex=1 size="3"
									name="sphR" style="font-size: 12px" onchange="format(sphR,'s');"></input></td>
								<td><input type="text" size="3"   id="cylR" class="McylR" tabindex=2
									name="cylR" style="font-size: 12px"  onchange="format(cylR,'s')"></input></td>
								<td><input type="text" size="3"  tabindex=3
									id="axisR" name="axisR" class="MaxisR" style="font-size: 12px" > </input></td>
								<td><input type="text" size="3" tabindex=4
									style="font-size: 12px"
									id="addR" name="addR" class="MaddR"></input></td>
								<td><input type="text" size="3" tabindex=5
											id="cdiaR" name="cdiaR" style="font-size: 12px"    class="notUse McdiaR"></input></td>

								<td ><input type="text" size="3" tabindex=11 style="font-size: 12px"
									id="diaR" name="diaR" class="MdiaR" ></input></td>
								<td ><input type="text" size="3" tabindex=12 style="font-size: 12px"   class="notUse"
									id="iobaseR" name="iobaseR" class="MiobaseR" onchange></input></td>
								<td ><input type="text" size="3" tabindex=13 style="font-size: 12px"  class="notUse"
									id="iopriR" name="iopriR" class="MiopriR"></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="udbaseR" name="udbaseR" class="MudbaseR" ></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="udpriR" name="udpriR" class="MudpriR"></input></td>
							</tr>
							<tr>
								<td>L</td>
								<td><input type="text"    id="sphL"  class="MsphL" tabindex=1 size="3"
									name="sphL" style="font-size: 12px" onchange="format(sphL,'s');"></input></td>
								<td><input type="text" size="3"   id="cylL" class="McylL" tabindex=2
									name="cylL" style="font-size: 12px"  onchange="format(cylL,'s')"></input></td>
								<td><input type="text" size="3"  tabindex=3 class="MaxisL"
									id="axisL" name="axisL" style="font-size: 12px" > </input></td>
								<td><input type="text" size="3" tabindex=4
									style="font-size: 12px"
									id="addL" name="addL" class="MaddL"></input></td>
								<td><input type="text" size="3" tabindex=5
											id="cdiaL" name="cdiaL" style="font-size: 12px" class="notUse McdiaL"></input></td>

								<td ><input type="text" size="3" tabindex=11 style="font-size: 12px"
									id="diaL" name="diaL" class="MdiaL"></input></td>
								<td ><input type="text" size="3" tabindex=12 style="font-size: 12px"   class="notUse"
									id="iobaseL" name="iobaseL" class="MiobaseL" onchange></input></td>
								<td ><input type="text" size="3" tabindex=13 style="font-size: 12px"  class="notUse"
									id="iopriL" name="iopriL"  class="MiopriL"></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="udbaseL" name="udbaseL" class="MudbaseL"></input></td>
								<td ><input type="text" size="3" tabindex=14 style="font-size: 12px"  class="notUse"
									id="udpriL" name="udpriL" class="MudpriL"></input></td>

							</tr>
		  	    		</table>

		  	    		<table  border="1"class="modifySpecS"  style="text-align: center;font-size:12px; width:700px;">
							<tr>
								<Td>프리즘</Td><td colspan="5">
								<div data-role="controlgroup" data-type="horizontal">
									오른쪽 : <input type="radio" name="MprsRIO" value="inR" data-role="none">IN<input type="radio" name="MprsRIO" value="outR" data-role="none">OUT
									<select id="prsValRIO" data-role="none" class="MprsValRIO">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism

									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									<input type="radio" name="MprsRUD" value="upR" data-role="none">UP<input type="radio" name="MprsRUD" value="downR" data-role="none">DOWN
									<select id="prsValRUD" class="MprsValRUD"data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism
									<br>

									왼쪽 &nbsp;&nbsp;&nbsp;: <input type="radio" name="MprsLIO" value="inL" data-role="none">IN<input type="radio" name="MprsLIO" value="outL" data-role="none">OUT
									<select id="prsValLIO"class="MprsValLIO" data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism

									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									&nbsp;
									<input type="radio" name="MprsLUD" value="upL" data-role="none">UP<input type="radio" name="MprsLUD" value="downL" data-role="none">DOWN
									<select id="prsValLUD" class="MprsValLUD" data-role="none">
										<option></option>
										<option value="0.25">0.25</option>
										<option value="0.5">0.5</option>
										<option value="0.75">0.75</option>
										<option value="1.0">1.0</option>
										<option value="1.25">1.25</option>
										<option value="1.5">1.5</option>
										<option value="1.75">1.75</option>
										<option value="2.0">2.0</option>
										<option value="2.25">2.25</option>
										<option value="2.5">2.5</option>
										<option value="2.75">2.75</option>
										<option value="3.0">3.0</option>
									</select>Prism

								</div>
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" data-role="none" onclick="inputDisabled(this)" id="lensSizeM">외경지정</td>
								<td>가로(A)<br>
									<input type="text" id="A" class="lensSpecVal MA" data-role="none" size="8">mm
								</td>
								<td>브릿지(DBL)<br>
									<input type="text" id="DBL" class="lensSpecVal MDBL" data-role="none" size="8">mm
								</td>
								<td>대각(ED)<br>
									<input type="text" id="ED" class="lensSpecVal MED" data-role="none" size="8">mm
								</td>
								<td>높이(B)<br>
									<input type="text" id="B" class="lensSpecVal" data-role="none" size="8">mm
								</td>
								<td>단안 원용(PD)<br>
									R : <input type="text" id="PDR" class="lensSpecVal MPDR" data-role="none" size="8">mm<br>
									L : <input type="text" id="PDL" class="lensSpecVal MPDL" data-role="none" size="8">mm
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" data-role="none" onclick="inputDisabled2(this)">PreCal</td>
								<td colspan="5" style="padding-left: 30px;padding-right: 30px">
								<center>
									<table border="1"class="modifySpecM"  style="text-align: left;font-size:12px; width:100%;">
										<tr>
											<td>프레임타입</td>
											<td>
												<select id="MframeType" data-role="none" class="lensSpecValM">
													<option value="-1">선택</option>
													<option value="0">(기본 가두께)</option>
													<option value="1.0">메탈/플라스틱 (1.0mm)</option>
													<option value="1.5">무테/뿔테 (1.5mm)</option>
													<option value="1.7">반무테 (1.7mm)</option>
													<option value="2.0">기타 (2.0mm)</option>
													<option value="2.5">기타 (2.5mm)</option>
												</select>
											</td>
										</tr>
										<tr>
											<td>프레임모양</td>
											<td>
											<select id="MframeShape" data-role="none" class="lensSpecValM">
													<option value="-1">선택</option>
													<option value="1">1.오각형</option>
													<option value="2">2.다각형</option>
													<option value="3">3.잠자리형</option>
													<option value="4">4.여우형</option>
													<option value="5">5.타원형</option>
													<option value="6">6.역사다리형</option>
													<option value="7">7.직사각형</option>
													<option value="8">8.캣어웨이</option>
												</select>
											</td>
										</tr>
										<tr>
											<td>가로길이(A) <span style="color: red">(※)</span></td>
											<td><input type="text" size="5" id="MpreA" class="lensSpecValM" data-role="none">mm</td>
										</tr>
										<tr>
											<td>세로길이(B)</td>
											<td><input type="text" size="5" id="MpreB" class="lensSpecValM" data-role="none">mm</td>
										</tr>
										<tr>
											<td>브릿지길이(DBL)</td>
											<td><input type="text" size="5" id="MpreDBL" class="lensSpecValM" data-role="none">mm</td>
										</tr>
										<tr>
											<td>피팅높이(OH)</td>
											<td>R :<input type="text" size="5" id="MpreOHR" class="lensSpecValM" data-role="none">mm<br>
												 L : <input type="text" size="5" id="MpreOHL"class="lensSpecValM"  data-role="none">mm
											</td>
										</tr>
										<tr>
											<td>단안(PD)</td>
											<td>R : <input type="text" size="5" id="MprePDR" class="lensSpecValM" data-role="none">mm<br>
												 L : <input type="text" size="5" id="MprePDL" class="lensSpecValM" data-role="none">mm
											</td>
										</tr>
										<tr>
											<td>별도가두께지정(ET)</td>
											<td><input type="text" size="5" id="MpreET" class="lensSpecValM" data-role="none">mm</td>
										</tr>
									</table>
									<br>
									<span style="color: red">※ 보다 정확한 계산을 위해, 가로(A)와 대각(ED) 중 큰 사이즈의 값을 입력해주시길 바랍니다.</span>
								</center>
								<hr>
								- A : 데이텀 시스템에서 가로 길이<br>
								- B : 데이텀 시스템에서 세로 길이<br>
								- DBL : 브릿지 사이즈<br><br>
								<img src="${ctxPath }/images/rx_img.png"><br>
								모양이 확실하지 않을 경우, 프레임 모양의 중앙에서 가장 긴 부분의 위치가 일치하는 모양의
								번호를 불러 주시거나 아래의 사항을 참조하세요.
								<br>
								가장 많은 여유분이 지정되는 번호는 7번 입니다.<br>
								<span style="color: red">(만약, 당신이 프레임 모양에 확신이 없을 시 사용) </span><br>
								가장 적은 여유분이 지정되는 번호는 2번과 5번 입니다.<br>
								<span style="color: red">(2번과 5번을 주문하실 때, 프레임 모양 확인 요망) </span><br>
								</td>
							</tr>
		  	    		</table>
	  	    		</tr>
	  	    		<tr>
	  	    				<textarea rows="3" cols="8" class="detailForMODRXM"></textarea>
	  	    		<center><button data-inline="true" class="modifySpecM"  onclick="modifyLensM(); return false">확인</button></center>
	  	    	</table>
	  	    	</form>
	</div>

	<div data-role="popup" id="optionPop" data-theme="a" class="ui-corner-all"style="padding: 20px; width: 100%">
		<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
		<h2>옵션 변경</h2>
			<select id="optionIdM" >


			</select>
			<Center>
				<button onclick="modifyOption();" data-mini="true" data-inline="true">변경</button>
			</Center>
	</div>
</div>
</body>
</html>

