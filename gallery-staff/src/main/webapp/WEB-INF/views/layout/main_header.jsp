<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"
	scope="request" />

<script type="text/javascript">


function goPrdctProcess(){
	location.replace("${ctxPath}/prdct/indexPrdctProcessForm.do");
};

function goCheckProcess(){
	location.replace("${ctxPath}/check/indexCheckEyesForm.do");
};

function goPrdctAssembly(){
	location.replace("${ctxPath}/prdct/indexPrdctAssemblyForm.do");
};

function goPrdctPayment(){
	location.replace("${ctxPath}/prdct/indexPrdctPaymentForm.do");
};

function aaa(){
	
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

function galleryCummunity(){
	var form = document.createElement("form");
	
	form.method = "post";
	form.action = "http://jaguar.s4gallery.com/community/board/main.do";
	
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

function galleryManager(){
	$.ajax({
		url : 'http://localhost:8080/Manager/admin/login.do',
		type : "post",
		dataType : "text",
		data : "id=" + "${shopVo.id}" + "&pwd=" + "${shopVo.pwd}" + "&shopTy="+"shop",
		success : function(data){
			if(data.trim()=="success"){
				location.href="http://localhost:8080/Manager/chart/chart.do";
			}else if(data.trim()=="fail"){
				alert("ID혹은 비밀번호를 확인해 주세요.");
			}
		}
	}); 

}

</script>
<style>
	#cmnt, #mng{
		cursor: pointer;
	}
</style>
<div align="center" id="tile">
	<!-- 
<table class="header">
	<tr style="height:30px" >
		<td><img src="<c:url value="/images/top/top_menu_logo.png"/>" width="154" height="57"></img></td>
	</tr>
	<tr>
	<td><a href="#" onclick="goPrdctProcess();return false;">상품 선택</a></td>
	<td><a href="#" onclick="goCheckProcess();return false;">검안</a></td>
	<td><a href="#" onclick="goPrdctAssembly();return false;">조립</a></td>
	<td><a href="#" onclick="goPrdctPayment();return false;">결제</a></td>
	</tr>
</table>
 -->
	<table width="800" border="0.5">
		<tr>
			<td height="26" onclick="staffLogin(${staffVo.staffId});return false;" >매장고객</td>
			<td width="160" height="26"><a onclick="galleryCummunity()" id='cmnt'>커뮤니티</a></td>
				<td width="160" height="26">&nbsp;</td>
				<td width="160" height="26"><a onclick="galleryManager()" id="mng"> 매장관리</td>
			<td height="26" onclick="fncGoStaffPage(${shopVo.shopId});return false;" >Log-out</td>
		</tr>
		<tr>
			<td height="44" colspan="5"><div class="header">Gallery
					Eyewear Customer System</div></td>
		</tr>
		<tr class="c1">
			<td width="135" height="24" bgcolor="#FFFFFF" class="c1">방문 일시</td>
			<td width="180" bgcolor="#FFFFFF" class="c1">${saleVo.datetime}</td>
			<td width="227" bgcolor="#FFFFFF">&nbsp;</td>
			<td width="156" bgcolor="#FFFFFF" class="c1">고객명</td>
			<td width="132" bgcolor="#FFFFFF" class="c1">${cstmrName}</td>
		</tr>
		<tr>
			<td height="24" colspan="5">&nbsp;</td>
		</tr>
	</table>

	<table width="800" border="0.5">
		<tr>
			<td width="155" height="53"><div class="box1"
					onclick="goPrdctProcess();return false;">선택</div></td>
			<td width="155" height="53"><div class="box2"
					onclick="goCheckProcess();return false;">검안</div></td>
			<td width="155" height="53"><div class="box2"
					onclick="goPrdctAssembly();return false;">조립</div></td>
			<td width="155" height="53"><div class="box2"
					onclick="goPrdctPayment();return false;">결제</div></td>
			<td width="158" height="53"><div class="box2">전달</div></td>
		</tr>

		<tr>
			<td height="26"><div class="box1">&nbsp;</div></td>
			<td height="26"><div class="box1">&nbsp;</div></td>
			<td height="26"><div class="box1">&nbsp;</div></td>
			<td height="26"><div class="box2">&nbsp;</div></td>
			<td height="26"><div class="box2">&nbsp;</div></td>
		</tr>
	</table>
</div>

