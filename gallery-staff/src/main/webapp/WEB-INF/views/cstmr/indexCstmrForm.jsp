<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>


<link rel="stylesheet" type="text/css"
	href="${ctxPath}/css/SpryAssets/SpryValidationTextarea.css" />
<script src="${ctxPath}/css/SpryAssets/SpryValidationTextarea.css"
	type="text/javascript"></script>

<script>
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function() {
	});
	//----------------------
	var mCstmrCd;
	function fncSelectCstmr(cstmrCd) {
		mCstmrCd = cstmrCd;
	};
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
	function fncCheckValidation() {
		var searchText1 = document.getElementById("txtSearch1");
		var searchText2 = document.getElementById("txtSearch2");
		
		/* console.log("searchText1.value:"+searchText1.value);
		console.log("searchText2.value:"+searchText2.value);
		console.log("searchText1.value.length:"+searchText1.value.length);
		console.log("searchText2.value.length:"+searchText2.value.length); */
		
		if (searchText1.value == "" && searchText2.value == "") {
			alert('<spring:message code="validation.put" arguments="조건을 1개 이상 "/>');
			return false;
		}else if(searchText1.value!="" && searchText1.value.length<2){
			alert('검색어는 2글자 이상 입력 바랍니다.');
			return false;
		}else if(searchText2.value!="" && searchText2.value.length<2){
			alert('검색어는 2글자 이상 입력 바랍니다.');
			return false;
		}
		
		if((2==document.getElementById("slctSearch1").value || 3==document.getElementById("slctSearch1").value) && searchText1.value.length<4 &&searchText1.value.length!=0){
			alert('전화번호 검색시 4글자 이상 입력 바랍니다.');
			return false;
		}
		if((2==document.getElementById("slctSearch2").value || 3==document.getElementById("slctSearch2").value) && searchText2.value.length<4 && searchText2.value.length!=0){
			alert('전화번호 검색시 4글자 이상 입력 바랍니다.');
			return false;
		}
		if( 7==document.getElementById("slctSearch1").value
			&&( searchText1.value.length != 4 && searchText1.value.length != 0)){
			alert('4자리 검색시 4글자만 입력해 주세요');
			return false;
		}
		if( 7==document.getElementById("slctSearch2").value
			&&( searchText2.value.length != 4 && searchText2.value.length != 0)){
			alert('4자리 검색시 4글자만 입력해 주세요');
			return false;
		}
		
		return true;
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
		param.setAttribute("name", "searchText1");
		param.setAttribute("value", jQuery('#cstmrSearchForm input[name=searchText1]').val());
		//console.log("searchText1:"+jQuery('#cstmrSearchForm input[name=searchText1]').val());
		
		var param1 = document.createElement("input");
		param1.setAttribute("type", "hidden");
		param1.setAttribute("name", "searchTy1");
		param1.setAttribute("value", jQuery('#cstmrSearchForm select[name=searchTy1]').val());
		//console.log("searchTy1:"+jQuery('#cstmrSearchForm select[name=searchTy1]').val());
		
		
		var param2 = document.createElement("input");
		//var param2 = document.createElement("input");
		param2.setAttribute("type", "hidden");
		param2.setAttribute("name", "searchText2");
		param2.setAttribute("value", jQuery('#cstmrSearchForm input[name=searchText2]').val());
		//console.log("searchText2:"+jQuery('#cstmrSearchForm input[name=searchText2]').val());
		
		var param3 = document.createElement("input");
		//var param2 = document.createElement("input");
		param3.setAttribute("type", "hidden");
		param3.setAttribute("name", "searchTy2");
		param3.setAttribute("value", jQuery('#cstmrSearchForm select[name=searchTy2]').val());
		//console.log("searchTy2:"+jQuery('#cstmrSearchForm select[name=searchTy2]').val());
		
		//window.sessionStorage.setItem("cstmrName", $("#cstmrName").val());
		//window.sessionStorage.setItem("cstmrName", $("#cstmrName").val());
		/* param2.setAttribute("type", "hidden");
		param2.setAttribute("name", "cellphone");
		param2.setAttribute("value", jQuery('#cstmrPhone').val()); */
		
		$(form).append(param);
		$(form).append(param1);
		$(form).append(param2);
		$(form).append(param3);
		$('body').append(form);
		form.submit();
		
		//console.log(param)
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

</script>
<style>

.nameinput {
font-family: "Arial Black", Gadget, sans-serif;
font-size: 24px;
font-weight: bold;
width:240px;
}
.searchSlct {
   /* background: transparent; */
   width: 120px;
   height: 50px;
   padding: 5px;
   font-size: 24px;
   line-height: 1;
   border: 0;
   border-radius: 0;
}
</style>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Gallery Cloud</title>

</head>

<body class="Screen_Enter">
	<center>
		<form name="cstmrSearchForm" id="cstmrSearchForm" method="post"
			onsubmit="return false">
			<div class="transBoxTable" style="width:800px; height: 480;">
				<table class="listShop" width="800px" border="0.5">
					<tr>
						<td colspan='2' width="200" class="btnTop"  height="26"
							onclick="staffLogin(${staffVo.staffId}); return false;">매장고객</td>
						<td width="100" height="26">&nbsp;</td>
						<td width="100" height="26">&nbsp;</td>
						<td colspan='2' class="btnTop" width="200" height="26"
							onclick="fncGoStaffPage(${shopVo.shopId});return false;">Log-out</td>
					</tr>
				
			<tr>
				<td height="44" colspan="6">
					<div class="head_title">Gallery	Eyewear</br>Cloud System</div>
				</td>
			</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr height="63">
						<td>&nbsp;</td>
						<td width="15%">
							<select style="width: 100%" id='slctSearch1' class="searchSlct" name='searchTy1' ></select>
						</td>
						<td width="28%">
							<input style="width: 100%" type="text" class="nameinput" id="txtSearch1" name="searchText1"  placeholder="조건1"
								 onKeyPress="javascript:if(event.keyCode == 13) goCstmrListPage();"
							/>
						</td>
						<td width="15%">
							<select style="width: 100%" id='slctSearch2' class="searchSlct" name='searchTy2' ></select>
						</td>
						<td width="28%">
							<input style="width: 100%" type="text" class="nameinput" id="txtSearch2" name="searchText2"  placeholder="조건2"
								onKeyPress="javascript:if(event.keyCode == 13) goCstmrListPage();"
							/>
						</td>
						<td>&nbsp;</td>						
					</tr>
					<script>
						var selectMap = {
						    0 : '이름',
						    1 : '주소',
						    2 : '전화번호',
						   	3 : '휴대전화',
						    4 : '생일',
						    5 : '고객코드',
						    6 : '가족코드',
						    7 : '4자리'
						};
						var select1 = document.getElementById("slctSearch1");
						for(index in selectMap) {
							if(index==0)
						    {select1.options[select1.options.length] = new Option(selectMap[index], index);}
							else
							{select1.options[select1.options.length] = new Option(selectMap[index], index);}
						}
						var select2 = document.getElementById("slctSearch2");
						for(index in selectMap) {
						    select2.options[select2.options.length] = new Option(selectMap[index], index);
						}
						
						document.getElementById("slctSearch1").value=0;
						document.getElementById("slctSearch2").value=7;

					</script>
					<tr>
						<td colspan='6'></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td colspan="4"><center>
								<a href="#" onclick="goCstmrListPage();return false;"><img
									src="<c:url value="/images/content/ok.png" />"
									onmousedown="this.src='<c:url value="/images/content/okpush.png" />'"
									onmouseup="this.src='<c:url value="/images/content/ok.png" />'"
									width="72" height="72"></img></a>
							</center></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</div>
		</form>
	</center>
</body>


</html>

