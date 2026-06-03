<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script>
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function() {

	});
	//----------------------

	/*
	 * 데이타 리스트 보드 페이징
	 */
	function fncListPrdctData(no) {
		
		var itemTy = $("#itemTy").val();
		
		var url;
		
		if(itemTy=="2"){
			console.log("lens is selected")
			url = '${ctxPath}/prdct/listLensData.do';
		}else{
			url = '${ctxPath}/prdct/listPrdctData.do';
		}
		
		if (no) {
			jQuery('#listPrdctForm1 input[name=currentPage]').val(no);
		}
		var param = jQuery('#listPrdctForm1').serialize() + "&itemTy=" + itemTy;
		
		//javax
		$.ajax({
			url : url,
			type : "post",
			data : param,
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				console.log("data:"+data);
				jQuery('#listPrdctDiv').html(data);
			}
		});
	}

	var prdctName;
	var tradePrc;

	function addNewPrdct() {
		console.log("run addNewPrdct");
		var dateTile = window.sessionStorage.getItem("dateTile");
		console.log('dateTile:'+dateTile);
		
		var itemTy = $("#itemTy").val();
		
		prdctName = $("#prdctName_").val();
		tradePrc = $("#tradePrc_").val();
		if(itemTy == -1)
		{
			alert("제품 종류를 선택해 주세요.");
			document.getElementById("itemTy").focus();
			return;
		}
		
		 if(prdctName.length=="0"){
		 alert("모델명을 입력하세요.");
		 document.getElementById("prdctName_").focus();
		 return;
		 }
		
		 if(tradePrc.length=="0"){
		 alert("가격을 입력하세요.");
		 document.getElementById("tradePrc_").focus();
		 return;
		 }
		 prdctName = encodeURIComponent(prdctName);

		$.ajax({
			url : "addSalePrdctNew.do"
			,type : "post"
			,data : "prdctName=" + prdctName + "&prc=" + tradePrc
					+"&saleId="+fncGetSaleId() + "&prdctCnt=" + 1
					+ "&itemTy=" + itemTy +"&dateTile="+dateTile
			,dataType : "text"
			,beforeSend : function() {
			}
			,success : function(data) {
				getSelectedPrdctListData();
				mPrdctId = null;
				mTrdePrc = null;
				jQuery('#dialog').dialog('destroy');
				jQuery('#dialog').html('');
				location.replace(pageUrl);
			}
		});

		/* 		prdctName = $("#prdctName_").val();
		 tradePrc = $("#tradePrc_").val();
		
		 if(prdctName.length=="0"){
		 alert("모델명을 입력하세요.");
		 document.getElementById("prdctName_").focus();
		 return;
		 }
		
		 if(tradePrc.length=="0"){
		 alert("가격을 입력하세요.");
		 document.getElementById("tradePrc_").focus();
		 return;
		 }
		
		 jQuery('#listPrdctDiv').html('');
		
		 jQuery('#listPrdctDiv').html(
		 "<html><body><table border='0' width='100%'><tr><td align='center'><input id='prdctCnt' name='prdctCnt' size='1' style='height:50px; width : 60px; font-size:25px'></td></tr><tr><td align='center'><button onclick='fncAddPrdct();return false;' id='submit' style='height:50px; width : 60px'>확인</button></td></tr></table></body></html>"
		 );
		
		 jQuery('#listPrdctDiv').dialog({
		 //bgiframe: true
		 title: "수량 선택"
		 , modal: true
		 , width: 400 // 가로 크기
		 , height : 200
		 , background: "#000"
		 , close: function(event, ui){
		 }, success:  function(data) {
		 console.log($("#prdctCnt").val())
		 } 
		 });	 */
	}

function fncAddPrdct() {
	var cnt = 1;

	var dateTile = window.sessionStorage.getItem("dateTile");

	prdctName = encodeURIComponent(prdctName);
	$.ajax({
		url : "addPrdct.do",
		type : "post",
		data : "prdctName=" + prdctName + "&prc=" + tradePrc + "&saleId="
				+ fncGetSaleId() + "&prdctCnt=" + cnt + "&dateTile=" + dateTile,
		dataType : "text",
		beforeSend : function() {
		},
		success : function(data) {
			getSelectedPrdctListData();
			mPrdctId = null;
			mTrdePrc = null;
			jQuery('#dialog').dialog('destroy');
			jQuery('#dialog').html('');
			location.replace(pageUrl);
		}
	});
}

function setItem(){
	var item = $("#itemTy").val();
	window.sessionStorage.setItem("itemTy",item);
	
}
</script>
<style>
th {
	background-color: black;
	opacity: 0.5;
	color: #ffffff;
	border-color: #000000;
}
</style>
<html>
<head>
<title>Home</title>
</head>
<body>
	<div id="content">
		<form name="listPrdctForm1" id="listPrdctForm1" method="post"
			action="">
			<input type="hidden" name="currentPage" value="1" /> <input
				type="hidden" name="pageSize" value="5" />
			<table width="100%" border="0" class="search" style="" >
					<tr>
						<td><select id="itemTy" onchange="setItem();">
								<option value="1" selected="selected">프레임</option>
								<option value="2">렌즈</option>
								<option value="3">콘텍트렌즈</option>
								<option value="4">기타악세사리</option>
							</select> </td>
					</tr>
					<tr class="s1" >
						<td style="width: 20%" bgcolor="#FFFFFF">모델 명</th>
						<td width="30%">
							<input type="text" id="prdctName" name="prdctName">
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td width="10%" align="center">
							<button onclick="fncListPrdctData('1');return false;">조회</button>
						</td>
					</tr>
					<tr>
						<td height="3" colspan="5"><img
							src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
							width="600" height="1" /></td>
					</tr>
					<tr>
						<td height="3" colspan="5"><img
							src="<c:url value="/images/content/Whiteline.jpg" />" alt="line"
							width="600" height="1" /></td>
					</tr>
					<tr class="s1">
						<td style="width: 20%;" bgcolor="#FFFFFF"> 신규 등록</td>
						<td style="width: 30%"; >
							<input type="text" id="prdctName_">
						</td>
						<td style="width: 10%" bgcolor="#FFFFFF"> 가격</th>
						<td>
							<input type="text" id="tradePrc_">
						</td>
						<td width="10%" align="center"><button onclick="addNewPrdct(); return false;">추가</button></td>
					</tr>
				</table>
		</form>
	</div>

	<div id="listPrdctDiv" name="listPrdctDiv"></div>
</body>
</html>
