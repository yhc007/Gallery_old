<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" scope="request"/>
 <%
 	String shopName = (String)session.getAttribute("shopName");
 %>
<div align="center" >

<table class="header">
	<tr>
		<% if(shopName!=null){
			out.print("<td align='center' valign='bottom' width='160'><font style='font-size:13;font-weight: bold;'>" + shopName + "</font</td>");
		}
		%>
	</tr>
	<tr style="height:30px" >
		<td align="center" valign="bottom" width="160"><a class="topmenu" id="topMenu1" href="${ctxPath}/fileserver/indexFileServerForm.do" >시스템</a></td>
		<td id="tdMenu2" align="center" valign="bottom" width="160"><a class="topmenu" id="topMenu2" name='topMenu2' href="${ctxPath}/shop/indexShopForm.do" >매장 관리</a></td>
		<td><a href="${ctxPath}/chart/chart.do"><img src="<c:url value="/images/top/top_menu_logo.png"/>" width="154" height="57"></img></a></td>
		<td align="center" valign="bottom" width="160">
			<a class="topmenu" id="topMenu3" href="${ctxPath}/company/indexCompanyForm.do">
				<!-- <img src="<c:url value="/images/top_menu_brand.png"/>" width="140" height="80"></img>
				 -->
				 상품 관리
			</a></td>
		<td align="center" valign="bottom" width="160"><a class="topmenu" id="topMenu4" href="${ctxPath}/prdct/indexPrdctInvnHistForm.do" >이력 관리</a></td>
		<%-- <td align="center" valign="bottom" ><a href="${ctxPath }/admin/loginForm.do"><font style="font-size:11">로그인</font></a></td> --%>
		<td align="center" valign="bottom" ><a href="${ctxPath }/admin/logOut.do"><font style="font-size:11;font-weight: bold;">LogOut</font></a></td>
	</tr>
</table>
</div>
