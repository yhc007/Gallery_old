<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
<script type="text/javascript">
	var newPrdct = false;
	var prdctId;
	var prdctName;
	var newName = false;
	var mnfCountry;
	var brandId;
	var cnt = 999;
	var puchasPrc;
	var trdePrc;
	var shopId = ${shopId};
	var save = false;

	$(function() {
			window.sessionStorage.setItem("menu","frame");
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(date.getMonth()) + 1;
		var day = addZero(date.getDate());

		$("#datetime").val(year + "-" + month + "-" + day);
		$("#save").click(function (){addPrdct(prdctId);});
		$("#editPrdct button[id='save']").click(editInvnData);
		getCntryList();
		getComList();
		getColorList();
		getMtrlList();
		getBrand('add');
		$("#srch").click(srchBrand)
		getMobilePrdct();
		//getBrandByTy("00300001");
	});

	function getMobilePrdct(){
		var url = '${ctxPath}/prdct/getMobilePrdct.do';
		var param = $("#srchPrdct").serialize() + "&shopId=" + shopId;
		$.ajax({
			url : url,
			dataType : "html",
			data : param,
			type : "post",
			success : function(data){
				$("#prdctList").html(data)
			}
		});
	}

	function removeClr(name){
		var index = name.indexOf("(")-1;
		return name = name.substring(0,index);

	}
	//NFC write
	function NFC_(){
		prdctName = $("#prdctName_").val();
		if(!prdctName){
			prdctName = removeClr($("#prdctId option:selected").text());
		}

		console.log(shopId,prdctName,prdctId)
		NFC.write(shopId, prdctName, prdctId);
		setTimeout(function(){
			$("#result").text("NFC 입력이 완료되었습니다.");
			$("#result").css("color","white");
			$("#result").css("display","inline");
		},1000);
	}



	//색상 리스트
	function getColorList(){
		var url = '${ctxPath}/invn/getColorList.do';

		 $.ajax({
			url		: url,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#colorId").html(data);
				$("#colorId2").html(data);

				$("#editPrdct select[id='colorId']").html(data);
				$("#editPrdct select[id='colorId2']").html(data);
			}
		});
	}

	//재질 리스트
	function getMtrlList(){
		var url = '${ctxPath}/invn/getMtrlList.do';

		 $.ajax({
			url		: url,
			type 	: "post",
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				$("#mtrlId").html(data);
				$("#editPrdct select[id='mtrlId']").html(data);
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
				$("#editPrdct select[id='iNum']").append(data)
			}
		});
	}


	//국가 리스트
	function getCntryList(){
		$.ajax({
			url : "${ctxPath}/invn/getCountryList.do",
			dataType : "html",
			type : "post",
			success : function(data){
				$("#mnfCountry").html(data);
				$("#editPrdct select[id='mnfCountry']").html(data)
			}
		});
	}
	function addZero(n) {
		if (String(n).length == "1") {
			return "0" + n;
		} else {
			return n;
		}
	};

	function removeHypen(str){
		var result = str.replace(/-/gi,"");

		return result;
	}

	function removeComma(str){
		var result = str.replace(/,/gi,"");

		return result;
	}

	var oldC1 = "-1";
	var oldC2 = "-1";
	var colorId;
	var colorId2;
	//재고 추가
	function addPrdct(pId){
		$("#save").attr("disabled","disabled");
		$("#save").html("등록중");
		var prdctTy = $("#prdctTy").val();
		var mtrlId = $("#mtrlId").val();
		colorId = $("#colorId").val();
		colorId2 = $("#colorId2").val();
		var prdctShape = $("#prdctShape").val();
		var videoCd = $("#videoCd").val();
		var date = $("#datetime").val();
		var datetime = removeHypen(date);
		var dateParam;
		var prdct;
		var url;
		var ty_cd = "00300001";
		var iNum = $("#iNum").val();
		var puchasPrc = removeComma($("#puchasPrc").val());
		var trdePrc = removeComma($("#trdePrc").val());
		if(puchasPrc=="" || trdePrc==""){
			alert("가격을 입력하세요.");
			$("#save").removeAttr("disabled");
			$("#save").html("저장");
			return;
		}
		if(typeof(pId)=="undefined"){
			pId = $("#prdctId").val();
		}
		if(!newPrdct && oldC1==colorId && oldC2==colorId2 ){
			console.log("1")
			url = "${ctxPath}/invn/addInvn.do";
			dateParam = "&datetime=" + datetime;
			prdct = "&prdctId=" + pId;

		}else if(newPrdct==true || $("#prdctId").val()=="-2"){
			console.log("2")
			url = "${ctxPath}/prdct/addPrdctAction.do";
			dateParam = "&whDate=" + datetime;
			prdct = "&prdctName=" + $("#prdctName_").val();
			oldC1 = colorId;
			oldC2 = colorId2;
		}else if(oldC1!=colorId || oldC2!=colorId2 ){

			console.log("3")
			url = "${ctxPath}/prdct/addPrdctAction.do";
			dateParam = "&whDate=" + datetime;
			if(removeClr($("#prdctId option:selected").text())==""){
				prdct = "&prdctName=" + $("#prdctName_").val();
			}else{
				prdct = "&prdctName=" + removeClr($("#prdctId option:selected").text());
			}

			oldC1 = colorId;
			oldC2 = colorId2;

		}
		var param = "brandId=" + brandId + prdct + "&cnt=" + cnt + "&shopId=" +shopId + dateParam + "&invnTyCd=00900001" + "&prdctTyCd=" + ty_cd
		+ "&prdctTy=" + prdctTy + "&mtrlId=" + mtrlId + "&prdctShape=" + prdctShape
		+ "&mnfCountry=" + mnfCountry + "&colorId=" + colorId + "&colorId2=" + colorId2 +"&iNum=" + iNum + "&puchasPrc=" + puchasPrc + "&trdePrc=" + trdePrc + "&prdctVisibleCd=00500001" +
		 "&videoCd=" + videoCd+"&prdctStatTyCd=00100003";


		 $.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				if(data.trim()=="ok" ){
					save = true;
					alert("등록 되었습니다.");
					getMobilePrdct();
					$("#save").removeAttr("disabled");
					$("#save").html("저장");

					$("#result").text("등록되었습니다.");
					$("#result").css("color","white");
					$("#result").css("display","inline");
				}else if(data.trim()=="duple"){
					alert("동일한 상품이 있습니다.");
					$("#result").text("동일한 상품이 있습니다.");
					$("#save").removeAttr("disabled");
					$("#save").html("저장");
					$("#result").css("color","red");
					$("#result").css("display","inline");
					return;
				}else if(data.trim()=="addsuccess"){ //신규
					getPrdctId();

					return;
				}else{
					$("#save").removeAttr("disabled");
					$("#save").html("저장");
					alert("오류가 발생했습니다.");
				}
				//fncPrdctDetailClear();
			}
		});


	};


	//국가 선택
	function getCntry(){
		mnfCountry = $("#mnfCountry").val();
		if(mnfCountry=="-2"){
			$("#mnfCountry_").css("display","inline");
			$("#mnfCountry").css("display","none");
		}
	}


	//브랜드 선택
	function getPrdctList(){
		$("#result").css("display","none");
		$("#prdctName_").css("display","none");
		$("#prdctId").css("display","inline");
		$("#mnfCountry_").css("display","none");
		$("#mnfCountry").css("display","inline");
		brandId = $("#brandId").val();
		document.getElementById("prdctId").focus();


		$("#puchasPrc").val("");
		$("#trdePrc").val("");
		$("#prdctId").val("-1");
		$("#colorId").val("-1");
		$("#mtrlId").val("-1");

		var url = "${ctxPath}/prdct/getPrdctListByBrand.do";
		var param = "brandId=" + brandId +
						"&comTy=1";
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : param,
			success : function(data){
				$("#prdctId").html(data);
				$("#editPrdct select[id='prdctId']").html(data)
				newPrdct = false;
				//$("#puchasPrc").attr("readonly",true);
				//$("#trdePrc").attr("readonly",true);
			}
		})
	}

	//모델 선택
	function getPrdctPrc(){
		prdctId = $("#prdctId").val();
		$("#PrdctInfo input[name='prdctId']").val(prdctId);
		if(prdctId=="-2"){
			$("#prdctName_").css("display","inline");
			$("#prdctId").css("display","none");
			$("#puchasPrc").attr("readonly",false);
			$("#trdePrc").attr("readonly",false);
			newPrdct = true;
			return;
		}

		var url = '${ctxPath}/prdct/getPrdctData.do';

		 $.ajax({
				url: url,
				type : "post",
				data : "prdctId=" + prdctId,
				dataType	: "json",
				beforeSend	: function(){
				},
				success		: function(data){
					console.log(data)
					 $("#puchasPrc").val(format(data.puchasPrc));
					 $("#trdePrc").val(format(data.trdePrc));
					 $("#colorId").val(data.colorId);
					 $("#colorId2").val(data.colorId2);
					 oldC1 = data.colorId;
					 oldC2 = data.colorId2;
					 $("#prdctTy").val(data.prdctTy);
					 $("#prdctShape").val(data.prdctShape);
					 $("#mtrlId").val(data.mtrlId);
					 $("#videoCd").val(data.videoCd);

					 puchasPrc = data.puchasPrc;
					 trdePrc = data.trdePrc;
				}
			});
	}

	function fncPrdctDetailClear(){
		$("#brandId").val("-1");
		$("#puchasPrc").val("");
		$("#trdePrc").val("");
		$("#prdctId").val("-1");
		$("#mnfCountry").val("-1");
		$("#colorId").val("-1");
		$("#mtrlId").val("-1");
	}

	function format(n) {
		  var reg = /(^[+-]?\d+)(\d{3})/;
		  n += '';

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');

		  return n;
		}
	//제품 등록 후 Id 가져오기
	function getPrdctId(){
		var prdct;
		var color;
		var colorId = $("#colorId").val();
		var colorId2 = $("#colorId2").val();
		var brandId = $("#brandId").val();
	if(!newPrdct || oldC1!=colorId || oldC2!=colorId2){
		if(removeClr($("#prdctId option:selected").text())==""){
			prdct = $("#prdctName_").val();
			color = "&colorId=" + colorId + "&colorId2=" + colorId2;
		}else{
			prdct = removeClr($("#prdctId option:selected").text());
			color = "&colorId=" + colorId + "&colorId2=" + colorId2;
		}
	}else if(newPrdct){
		prdct = $("#prdctName_").val();
		color = "";
		$("#test").css("display","inline");
	}
		var url = "${ctxPath}/invn/getPrdctId.do";
		var param = "shopId=" + shopId + "&prdctName=" + prdct + color + "&brandId=" + brandId;
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				console.log("newId : " + data.trim())
				prdctId = data.trim();
				$("#PrdctInfo input[name='prdctId']").val(data.trim());
				newName = true;
				newPrdct = false;
				addPrdct(data.trim());
			}
		});
	}

	/* function getPrdctId_color(){
		var prdct;
		var color;
	if(!newPrdct){
		prdct = $("#prdctId").text();
		color = "&colorId=" + colorId + "&colorId2=" + colorId2;

	}else{
		prdct = $("#prdctName_").val();
		color = "";
		$("#test").css("display","inline");
	}
		var url = "${ctxPath}/invn/getPrdctId.do";
		var param = "shopId=${shopId}" + "&prdctName=" + prdct + color;
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				console.log("new Id : " + data)
				prdctId = data.trim();
				newName = true;
				newPrdct = false;
				addPrdct(data.trim());
			}
		});
	} */

	//브랜드 리스트
	function getBrand(ty){
		var brandName;
		if(ty=="add"){
			brandName = $("#srchBrand").val();
		}else if(ty=="srch"){
			brandName = $("#srchPrdct input[id=bName]").val();
		}
		var url = "${ctxPath}/invn/srchBrand.do";
		var param = "brandName=" + brandName;

		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				if(ty=="add"){
					$("#brandId").html(data);
				}else if(ty=="srch"){
					$("#srchPrdct select[name='brandId']").html(data);
				}


			}
		});
	}


	function fncSavePhotos(){
		if(!save){
			alert("제품 등록을 먼저 해주세요.");
			return;
		}

			var url = '${ctxPath}/prdct/modifyPrdctAction.do'; // 추가
			var puchasPrc = removeComma($("#puchasPrc").val());
			var trdePrc = removeComma($("#trdePrc").val());
			var prdctName = removeClr($("#prdctId option:selected").text());
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#PrdctInfo').serialize() + "&prdctName=" + prdctName +
							"&puchasPrc=" + puchasPrc +
							"&trdePrc=" + trdePrc,
			dataType	: "text",
			beforeSend	: function(){

			},
			success: function(data){
				if(data=="duple"){
					alert('<spring:message code="add.duple" arguments="상품"/>');
				}else if(data=="fail"){
					alert('<spring:message code="fail"/>');
				}else{
					if(jQuery('#PrdctInfo input[name=prdctId]').val() != ""){
						//data=jQuery('#listPrdctForm2 input[name=prdctId]').val();
					}else{
						jQuery('#PrdctInfo input[name=prdctId]').val(data);
					}

					jQuery('#PrdctInfo').attr('method', 'post');
					jQuery('#PrdctInfo').attr('action', '${ctxPath}/media/indexMediaForm.do');
					jQuery('#PrdctInfo').submit();
				}
				  //성공시....

			}

		});
	}

	function fncSavePhotos_edit(){
		//location.replace("/media/indexMediaForm.do");

		/*
		jQuery('#listPrdctForm2').attr('method', 'post');
		jQuery('#listPrdctForm2').attr('action', '${ctxPath}/media/indexMediaForm.do');
		jQuery('#listPrdctForm2').submit();
		*/


		var url;
		var msg;
		var no;
		/* if(jQuery('#listPrdctForm2 input[name=prdctId]').val() == ""){

			no = 1;
		} else{
			url = '${ctxPath}/prdct/modifyPrdctAction.do'; // 수정
			no = jQuery('#listCstmrForm1 input[name=currentPage]').val();
		} */
			var url = '${ctxPath}/prdct/modifyPrdctAction.do'; // 추가
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#editPrdct').serialize(),
			dataType	: "text",
			beforeSend	: function(){

			},
			success: function(data){
				if(data=="duple"){
					alert('<spring:message code="add.duple" arguments="상품"/>');
				}else if(data=="fail"){
					alert('<spring:message code="fail"/>');
				}else{
					if(jQuery('#PrdctInfo input[name=prdctId]').val() != ""){
						//data=jQuery('#listPrdctForm2 input[name=prdctId]').val();
					}else{
						jQuery('#PrdctInfo input[name=prdctId]').val(data);
					}
					jQuery('#editPrdct').attr('method', 'post');
					jQuery('#editPrdct').attr('action', '${ctxPath}/media/indexMediaForm.do');
					jQuery('#editPrdct').submit();
				}
				  //성공시....

			}

		});
	}

	var invnHistId;
	function getPrdctInfo(prdctId){
		var url = '${ctxPath}/prdct/getMobilePrdctInfo.do';
		var param = "shopId=" + shopId + "&prdctId=" +prdctId;
		$.ajax({
			url : url,
			dataType : "json",
			data : param,
			type : "post",
			success : function(data){
				console.log(data)
				$("#editPrdct input[id='brandName']").val(data.brandName);
				$("#editPrdct input[id='brandId']").val(data.brandId);
				$("#editPrdct select[id='mnfCountry']").val(data.mnfCountry);
				$("#editPrdct select[id='colorId']").val(data.colorId);
				oldColor1 = data.colorId;
				oldColor2 = data.colorId2;
				invnHistId = data.invnHistId;
				$("#editPrdct select[id='colorId2']").val(data.colorId2);
				$("#editPrdct input[id='prdctName']").val(data.prdctName);
				$("#editPrdct input[id='prdctId']").val(data.prdctId);
				$("#editPrdct input[id='puchasPrc']").val(data.puchasPrc);
				$("#editPrdct select[id='mtrlId']").val(data.mtrlId);
				$("#editPrdct input[id='trdePrc']").val(data.trdePrc);
				$("#editPrdct select[id='prdctTy']").val(data.prdctTy);
				$("#editPrdct select[id='prdctShape']").val(data.prdctShape);
				$("#editPrdct input[id='datetime']").val(dateFormat(String(data.datetime)));
				$("#editPrdct input[id='videoCd']").val(data.videoCd);
				$("#videoTd").html("<a href='http://www.youtube.com/watch?v=" + data.videoCd + "'>확인</a>");
				$("#img").html("<img src='" + data.imgPath + "' class='prdctImg'>");


			$("#dialog").css("display","inline");
			  $('#dialog').dialog({
				//bgiframe: true
				 title: "수정"
				 , modal: true
			     , width: "60%" // 가로 크기
			      ,height : "70%"
			     , background: "#000"
			     , position:{my:"center",at:"middle",of: window }
				 , close: function(event, ui){
				}, success:  function(data) {

				}
			});

			}
		});

	}

	//데이트 포맷
	function dateFormat(date){
		year = date.substr(0,4);
		month = date.substr(4,2);
		day = date.substr(6,2);
		return year + "-" +month + "-" + day;
	}

	//재고 정보 변경
	function editInvnData(){
		var colorId = $("#editPrdct select[id='colorId']").val();
		var colorId2 = $("#editPrdct select[id='colorId2']").val();

		if(oldColor1 != colorId || oldColor2 != colorId2){
			insertDiffClr();
			return;
		}
		var url = "${ctxPath}/invn/modifyInvn.do";
		var param = $("#editPrdct").serialize() +
						"&invnHistId=" + invnHistId +
						"&datetime=" + removeHypen($("#editPrdct input[id='datetime']").val()) +
						"&shopId=" +shopId;
		$.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				$('#edit').dialog('close');
				location.reload();
			}
		});

	}

	//다른 컬러로 변경
	function insertDiffClr(){
		var colorId = $("#editPrdct select[id='colorId']").val();
		var colorId2 = $("#editPrdct select[id='colorId2']").val();
		var url = "${ctxPath}/invn/insertDiffClr.do";
		var param = $("#editPrdct").serialize() + "&shopId=999" + "&invnHistId=" + invnHistId + "&datetime=" + removeHypen($("#editPrdct input[id='datetime']").val());

		$.ajax({
			url : url,
			type : "post",
			data : param,
			success : function(data){
				$('#edit').dialog('close');
				location.reload();
			}
		});

		oldColor1 = colorId;
		oldColor2 = colorId2;
	}
</script>


<style>
	.prdctImg{
		width : 200px;
		height : 200px;
	}
	#nfc{
		margin-left : 100px;
		margin-right: 200px;
		float: left;
	}
	#save{
		width:100px;
		height : 50px;
		margin-top: 20px;
	}
	#prdctName_,#mnfCountry_{
		display: none;
	}
	body{
	}

	#result{
		color :white;
		display: none;
	}
	#dialog{
		display: none;
	}
</style>
</head>
<body>
<center>
	<form id="srchPrdct" >
		<table width="80%" border="1" style="border-collapse: collapse; text-align: center">
			<tr>
				<th>모델명</th> <td><input type="text" name="prdctName"> </td>
				<th>브랜드</th> <td><input type="text" id="bName" onkeyup="getBrand('srch'); return false;"><select name="brandId"></select></td>
				<td><button onclick="getMobilePrdct(); return false;">검색</button> </td>
			</tr>

		</table>
	</form>
	<table id="prdctList" width="80%" border="1" style="border-collapse: collapse; text-align: center">

	</table>
<hr>

	<form id="PrdctInfo" class="frameTbl">
		<table id="container" width="80%"border="1" style="border-collapse: collapse; text-align: center" >
			<tr>
				<th>브랜드검색</th>
				<td><input type="text" id="srchBrand" onkeyup="getBrand('add'); return false;"></td>
			<th>제조국</th><td><select id="mnfCountry" name="mnfCountry" onchange="getCntry();"><option value="-1">선택</select><input type="text" id="mnfCountry_"></td>
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><select id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();">
								<option value="-1">선택</option>
								<c:forEach items="${listBrand}" var="item" varStatus="status">
									<option value="${item.brandId}">${item.brandName}</option>
								</c:forEach>
							</select> </td>
				<th width="20%">모델명</th><td width="30%"> <select id="prdctId" name="prdct" onchange="getPrdctPrc()"><option value="-1">선택</option></select><input type="text" id="prdctName_" class="test">
					<input type="hidden" name="prdctId">
				</td>
			</tr>
			<tr>

				<th>색상1</th><td><select id="colorId" name="colorId"><option value="-1">선택</select></td>
				<th>색상2</th><td><select id="colorId2" name="colorId2"><option value="-1">선택</select></td>

			</tr>
			<tr>
				<th>매입가</th><td><input type="text" id="puchasPrc"  readonly="readonly"></td>
				<th>판매가</th><td><input type="text" id="trdePrc" readonly="readonly"></td>
			</tr>
			<tr>
				<th>용도</th><td><select id="prdctTy" name="prdctTy" >
										<option value="-1">선택</option>
										<option value="G">도수용</option>
										<option value="S">선글라스</option>
										<option value="O">고글 </option>
										<option value="W">수경 </option>
										<option value="Z">돋보기 </option>
									</select></td>
				<th>재질</th><td><select id="mtrlId" name="mtrlId"><option value="-1">선택</option></select></td>
			</tr>
			<tr>
				<th>모양</th><td><select id="prdctShape" name="prdctShape" >
										<option value="-1">선택</option>
										<option value="1">온테</option>
										<option value="2">반무테</option>
										<option value="3">무테</option>
									</select></td>
				<th>거래처</th><td><select id="iNum" name="iNum"><option value="-1">선택</option></select></td>
			</tr>
			<tr>
				<th>영상</th><td><input type="text" id="videoCd" name="videoCd"> </td>

			<th>
			</th>
			<td></td>
			</tr>
			<tr>
				<th>날짜</th><td><input type="date" id="datetime"> </td>
				<th>이미지</th><td><a href="#" id="imgSaveHref" onclick="fncSavePhotos();return false;">이미지 등록</a>
				<input type="hidden" id="prdctType" value="1" name="prdctType">
				</td>
			</tr>

		</table>
	</form>




		<center>
			<div id="result">등록되었습니다.</div>
		</center>
		<button id="save">저장</button>


</center>

<div id="dialog">
<center>

<form action="" id="editPrdct">

<table width="80%"border="1" style="border-collapse: collapse; text-align: center" >

			<tr>
			<td id="img" rowspan="7"></td>
			<th>제조국</th><td><select id="mnfCountry" name="mnfCountry" onchange="getCntry();"><option value="-1">선택</select><input type="text" id="mnfCountry_"></td>
			<th>영상</th>
			<td ><input type="hidden" id="cnt" name="cnt" value="999"> <input type="text" id="videoCd" name="videoCd" size="15"> <span id="videoTd"></span></td>
			</tr>
			<tr>
				<th width="20%">브랜드</th><td width="30%"><input id='brandName' name='brandName' title='브랜드 명' onchange="getPrdctList();"><input type="hidden" id='brandId' name='brandId' title='브랜드 명' onchange="getPrdctList();">

							</td>
				<th width="20%">모델명</th><td width="30%">  <input id="prdctName" name="prdctName" onchange="getPrdctPrc()"><input type="hidden" id="prdctId" name="prdctId" onchange="getPrdctPrc()"></td>
			</tr>
			<tr>

				<th>색상1</th><td><select id="colorId" name="colorId"><option value="-1">선택</select></td>
				<th>색상2</th><td><select id="colorId2" name="colorId2"><option value="-1">선택</select></td>

			</tr>
			<tr>
				<th>매입가</th><td><input type="text" id="puchasPrc" name="puchasPrc" readonly="readonly"></td>
				<th>판매가</th><td><input type="text" id="trdePrc" name="trdePrc" readonly="readonly"></td>
			</tr>
			<tr>
				<th>용도</th><td><select id="prdctTy" name="prdctTy" >
										<option value="-1">선택</option>
										<option value="G">도수용</option>
										<option value="S">선글라스</option>
										<option value="O">고글 </option>
										<option value="W">수경 </option>
										<option value="Z">돋보기 </option>
									</select></td>
				<th>재질</th><td><select id="mtrlId" name="mtrlId"><option value="-1">선택</option></select></td>
			</tr>
			<tr>
				<th>모양</th><td><select id="prdctShape" name="prdctShape" >
										<option value="-1">선택</option>
										<option value="1">온테</option>
										<option value="2">반무테</option>
										<option value="3">무테</option>
									</select></td>
				<th>거래처</th><td><select id="iNum" name="iNum"><option value="-1">선택</option></select></td>
			</tr>

			<tr>
				<th>날짜</th><td><input type="date" id="datetime"> </td>
				<th>이미지</th><td><a href="#" id="imgSaveHref" onclick="fncSavePhotos_edit();return false;">이미지 등록</a></td>
			</tr>

		</table>
			<button id="save">저장</button>
			<input type="hidden" id="prdctType" name="prdctType" value="1">
		</form>
		</center>
</div>

</body>
</html>
