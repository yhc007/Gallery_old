<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/securityLib.jsp"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" scope="request"/>
 <%
 	String shopName = (String)session.getAttribute("shopName");
	Integer shopId = (Integer)session.getAttribute("shopId");
 %>
 <script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
var shopId = <%=shopId%>
	function galleryCommunity(){
		var form = document.createElement("form");
		
		form.method = "post";
		form.action = "https://jaguar.s4g.kr/community/board/main.do";
		
		var input = document.createElement("input");
		input.type = "hidden";
		input.name = "shopTy";
		input.value = 1;
		
		var input2 = document.createElement("input");
		input2.type = "hidden";
		input2.name = "shopId";
		input2.value = shopId;
		
		$(form).append(input);
		$(form).append(input2);
		
		$("#body").append(form);
		document.body.appendChild(form);
		form.submit();
	}
	

	
	function fncGoStaffPage(){

		var form=document.createElement("form");

		  form.name='tempPost';

		  form.method='post';

		  form.action='https://jaguar.s4g.kr/GalleryStaff/staff/indexStaffForm.do';  

		 

		  var input=document.createElement("input");

		  input.type="hidden";

		  input.name='shopId';

		  input.value= shopId;

		  $(form).append(input);

		  $('#body').append(form); 

		  form.submit();

		};
</script>
<style>
	.span{
		background-color: black;
		color : white;
		font-weight: bold;
		padding : 8px;
		border-radius :5px;
		cursor: pointer;
	}
</style>
<div align="center" id='tileHeader'>

<table class="header">
	<tr>
		<% if(shopName!=null){
			out.print("<td align='center' valign='bottom' width='160'><font style='font-size:13;font-weight: bold;' >" + shopName + "</font></td>");
		}
		%>
		
		<% if(shopName!=null){
			out.print("<td align='center' valign='bottom' width='160; '><font style='font-size:13;font-weight: bold; ' class=span><a onclick='javascript:galleryCommunity();' style='color:white;'>공지사항</a></font></td>");
		}
		%>
		<td>
		</td>
		
		<% if(shopName!=null){
			out.print("<td id='staffTd'align='center' valign='bottom' width='160'  style='display:none'><font style='font-size:13;font-weight: bold;' class=span><a onclick='javascript:fncGoStaffPage();' style='color:white;'>판매관리</a></font></td>");
		}
		%>
	</tr>
	<tr style="height:30px" >
		<td id="systemBTN" align="center" valign="bottom" width="160"><a class="topmenu" id="topMenu1" href="${ctxPath}/fileserver/indexFileServerForm.do" rel="external">시스템</a></td>
		<td id="tdMenu2" align="center" valign="bottom" width="160"><a class="topmenu" id="topMenu2" name='topMenu2' href="${ctxPath}/shop/indexShopForm.do" rel="external">매장 관리</a></td>
		<td><a href="${ctxPath}/chart/chart.do" rel="external"><img src="<c:url value="/images/top/top_menu_logo.png"/>" width="154" height="57"></img></a></td>
		<td align="center" valign="bottom" width="160">
			<a class="topmenu" id="topMenu3" href="${ctxPath}/prdct/indexPrdctConfirmForm.do" rel="external">
				<!-- <img src="<c:url value="/images/top_menu_brand.png"/>" width="140" height="80"></img>
				 -->
				 상품 관리
			</a></td>
		<td align="center" valign="bottom" width="160"><a class="topmenu" id="topMenu4" href="${ctxPath}/prdct/indexPrdctInvnHistForm.do" rel="external">이력 관리</a></td>
		<%-- <td align="center" valign="bottom" ><a href="${ctxPath }/admin/loginForm.do"><font style="font-size:11">로그인</font></a></td> --%>
		<td align="center" valign="bottom" ><a href="${ctxPath }/admin/logOut.do" rel="external"><font style="font-size:11;font-weight: bold;">LogOut</font></a></td>
	</tr>
</table>
</div>
<script>
	var shopLv = ${lv};
	if(shopLv==3){
		$("#systemBTN").html("");
		$("#tdMenu2").html("");
	}
</script>
