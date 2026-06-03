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
		//for Popup Notice;
		
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
		  $('#body').append(form); 
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
		  $('#body').append(form); 
		  form.submit();
	};
	

	function goShopListPage() {

		var form = document.createElement("form");
		form.name = 'tempPost';
		form.method = 'post';
		form.action = '${ctxPath}/shop/indexShopForm.do';

		var param = document.createElement("input");
		param.setAttribute("type", "hidden");
		/* param.setAttribute("name", "cstmrName");
		param.setAttribute("value", jQuery('#cstmrSearchForm input[name=cstmrName]').val()); */
		$(form).append(param);
		$('#body').append(form);
		form.submit();
	};
</script>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>GalleryStaffWeb</title>

</head>

<body>
	<center>
		<div class="transStaffTable">
		<table width="800" border="0.5">
			<tr>
				<td height="78" colspan="5">
					<div class="head_title">
						Gallery Eyewear</br>
						Cloud System
					</div>
				</td>
			</tr>
			<tr>
				<!-- <td height="24" colspan="5">&nbsp;</td> -->
<!-- 					<td height="24" colspan="4">&nbsp;</td>
					
					<td width="150">
						<p onclick="href="http://jaguar.g-eyewear.com/wiki/projects" target="_blank">
							공지사항
						</p>
					</td>
 -->
			</tr>
			<tr>
				<td height="3" colspan="5"><img
					src="<c:url value="/images/content/GrayLine.jpg" />" width="800"
					height="1" /></td>
			</tr>
			<tr>
				<td height="63" colspan="5" class="head_title">${shopVo.shopName}</td>
			</tr>
		</table>
		

		<table class="staffList" width="800" border="0.5">
			<tr>
				<td height="3" colspan="4"><img
					src="<c:url value="/images/content/GrayLine.jpg" />" width="800"
					height="1" /></td>
			</tr>
			<%-- <tr onclick="goCstrmInfo('${shop.shopId}');return false;" class="listData"> --%>

			<c:choose>
				<c:when test="${!empty listStaffShop}">
					<c:forEach var="staff" items="${listStaffShop}" varStatus="status">

						<%-- <td onclick="goCstmrListPage('${staff.staffId}');return false;"> --%>
						<td onclick="staffLogin('${staff.staffId}');return false;">
							<a href='javascript:;'>
							<%-- <img src="http://106.240.234.114:8080/media${staff.imgPath}" width=200 /></a> --%>
							<img src="https://jaguar.s4g.kr/media${staff.imgPath}" width="180px", height="180px" /></a>
							<br/>${staff.staffName }
						</td>
						<c:if test="${0==((status.count)%4)}">
							</tr>
							<tr>
						</c:if>
					</c:forEach>

					<!-- <script>
				makePagingButton("${pv.currentPage}","${pv.startPage}","${pv.endPage}","${pv.totalPage}","fncListShopData");
			</script> -->
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

		</table>
		</div>
		<div class="btnSave" >
			<img  onclick="goShopListPage();return false;"
			src="<c:url value="/images/content/setting.png" />"
			onmousedown="this.src='<c:url value="/images/content/setting_push.png" />'"
			onmouseup="this.src='<c:url value="/images/content/setting.png" />'" />
		</div>
  
 	<div id = 'tableCstmrIssue'></div>

	
		<table class="staffList" width="800" border="0.5">

			<tr>
				<td width="206">&nbsp;</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<center><td>Copyright (c) 2013 UNOMIC All right reserved.</td></center>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
	</center>

</body>
</html>
