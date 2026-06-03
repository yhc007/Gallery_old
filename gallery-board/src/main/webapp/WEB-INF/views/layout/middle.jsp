<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.gallery.web.common.domain.CommonCode"%>
<!-- 
<div style="position: relative; left: 0px; top:30px; width:160px;">
 -->
 <div>
<table width="100%" class="header" border="0" cellspacing="0" cellpadding="0">	
 <tr>
 	<td width="100%" height="4" style="background-color:#1f6fd0;">
 	<!-- 
 		<img src="<c:url value="/images/middle/blueline.png"/>" width="100%" height="4"></img>
 	 -->
 	</td>
 </tr>
 <tr>
 	<td align="center" valign="top" width="100%" height="48" background="${ctxPath}/images/middle/blue_box_1.png" style="background-repeat:no-repeat">
		<%
			String path0="dselected";
	 		String path1="dselected";
	 		String path2="dselected";
	 		String path3="dselected";
	 		String path4="dselected";
	 		String path5="dselected";
	 		String path6="dselected";
	 		String color0="#000000";
	 		String color1="#000000";
	 		String color2="#000000";
	 		String color3="#000000";
	 		String color4="#000000";
	 		String color5="#000000";
	 		String color6="#000000";
	 		Integer formnum=(Integer)request.getAttribute("formnum");
	 		if(formnum!=null){
	 			if(formnum==0){
		 			path0="selected";
		 			color0="#ffffff";
		 		}
	 			else if(formnum==1){
		 			path1="selected";
		 			color1="#ffffff";
		 		}else if(formnum==2){
		 			path2="selected";
		 			color2="#ffffff";
		 		}else if(formnum==3){
		 			path3="selected";
		 			color3="#ffffff";
		 		}else if(formnum==4){
		 			path4="selected";
		 			color4="#ffffff";
		 		}else if(formnum==5){
		 			path5="selected";
		 			color5="#ffffff";
		 		}else if(formnum==6){
		 			path6="selected";
		 			color6="#ffffff";
		 		}
	 		}
	 		
	 	%>
 		<table class="middlemenu" border="1">
          <tr>
            <td align="center" width="57px">
            	<img src="<c:url value="/images/middle/homeicon.png"/>" width="26px" height="31px"></img>
            </td>
            <c:choose>
				<c:when test="${!empty tlist}">
			   		<c:forEach var="texts" items="${tlist}" varStatus="status">
			   			<td class="middle_indicator" width="${texts.wi}px" align="${texts.align}" style="padding-left:${texts.lmrgn}px">
			   				${texts.text}
			   			</td>
			   		</c:forEach>
			   	</c:when>		
			</c:choose>
          </tr>
        </table>
 	</td>
 </tr>
 <tr>
 	<td height="38" align="left" valign="top" background="${ctxPath}/images/middle/blue_box_2.png" style="background-repeat:no-repeat" >
 		<table border="0" style="border-collapse:collapse" >
 		
 		
 		
 		
 		
 		
 		<c:if test='${topMenuId=="MSHOP"}'>
		 <tr align="left">
		 	<td width="107px" height="38">
		 	</td>
            <td class="middlemenu" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path1 %>.png" style="background-repeat:no-repeat"
             onclick="javascript:location.replace('${ctxPath}/shop/indexShopForm.do')">
            	<FONT class="middlemenu" color="<%=color1%>">매장등록/수정</FONT>
            </td>
            <td width="5px" height="38">
		 	</td>
		 	<td class="middlemenu" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path2 %>.png" style="background-repeat:no-repeat"
             onclick="javascript:location.replace('${ctxPath}/staff/indexStaffForm.do')">
            	<FONT class="middlemenu" color="<%=color2%>">점원 관리</FONT>
            </td>
          </tr>
		</c:if>
		
		<c:if test='${topMenuId=="MPRDCT"}'>
		 <tr align="left">
		 	<td width="107px" height="38">
		 	</td>
		 	<td class="middlemenu" align="center" valign="middle" width="119px" height="38" 
            background="${ctxPath}/images/middle/<%=path0 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/company/indexCompanyForm.do')">
            	<FONT class="middlemenu" color="<%=color0%>">거래처등록/수정</FONT>
            </td>
            <td width="5px" height="38">
            <td class="middlemenu" align="center" valign="middle" width="119px" height="38" 
            background="${ctxPath}/images/middle/<%=path1 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/brand/indexBrandForm.do')">
            	<FONT class="middlemenu" color="<%=color1%>">브랜드등록/수정</FONT>
            </td>
            <td width="5px" height="38">
            <td class="middlemenu" align="center" valign="middle" width="119px" height="38" 
            background="${ctxPath}/images/middle/<%=path2 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/prdct/indexPrdctForm.do')">
            	<FONT class="middlemenu" color="<%=color2%>">상품등록/수정</FONT>
            </td>
            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" align="center" valign="middle" width="119px" height="38" 
            background="${ctxPath}/images/middle/<%=path3 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/prdct/indexPrdctConfirmForm.do')">
            	<FONT class="middlemenu" color="<%=color3%>">상품관리</FONT>
            </td>
            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" align="center" valign="middle" width="119px" height="38" 
            background="${ctxPath}/images/middle/<%=path4 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/prdct/indexPrdctRemainForm.do')">
            	<FONT class="middlemenu" color="<%=color4%>">재고관리</FONT>
            </td>
            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" align="center" valign="middle" width="119px" height="38" 
            background="${ctxPath}/images/middle/<%=path5 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/event/indexEventForm.do')">
            	<FONT class="middlemenu" color="<%=color5%>">이벤트관리</FONT>
            </td>
             <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" align="center" valign="middle" width="119px" height="38" 
            background="${ctxPath}/images/middle/<%=path6 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/dlvr/indexDlvrForm.do')">
            	<FONT class="middlemenu" color="<%=color6%>">배송관리</FONT>
            </td>
          </tr>
		</c:if>
		
		<c:if test='${topMenuId=="MHIST"}'>
		  <tr align="left">
		 	<td width="107px" height="38">
		 	</td>
		 	
            <td class="middlemenu" align="center" valign="middle" width="119px" height="38" 
            background="${ctxPath}/images/middle/<%=path1 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/prdct/indexPrdctInvnHistForm.do')">
            	<FONT class="middlemenu" color="<%=color1%>">재고이력</FONT>
            </td>
            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" align="center" valign="middle" width="119px" height="38" 
            background="${ctxPath}/images/middle/<%=path2 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/sale/indexSaleHistForm.do')">
            	<FONT class="middlemenu" color="<%=color2%>">판매이력</FONT>
            </td>
             <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" align="center" valign="middle" width="119px" height="38" 
            background="${ctxPath}/images/middle/<%=path3 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/sale/indexSalesHistForm.do')">
            	<FONT class="middlemenu" color="<%=color3%>">매출 조회</FONT>
            </td>
          </tr>
            
		</c:if>
		
		<c:if test='${topMenuId=="MMEDIA"}'>
		 <tr align="left">
		 	<td width="107px" height="38">
		 	</td>
            <td class="middlemenu" id="mediamenu1" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path1 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:showTabMenu(1)">
            	<FONT class="middlemenu" id="mediafont1" color="<%=color1%>">스틸 이미지</FONT>
            </td>
            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" id="mediamenu2" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path2 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:showTabMenu(2)">
            	<FONT class="middlemenu" id="mediafont2" color="<%=color2%>">회전 이미지</FONT>
            </td>
            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" id="mediamenu3" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path3 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:showTabMenu(3)">
            	<FONT class="middlemenu" id="mediafont3" color="<%=color3%>">영상</FONT>
            </td>
          </tr>
		</c:if>
		
		<c:if test='${topMenuId=="MFS"}'>
		 <tr align="left">
		 	<td width="107px" height="38">
		 	</td>
            <td class="middlemenu" id="mediamenu1" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path1 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:showTabMenu(1)">
            	<FONT class="middlemenu" id="mediafont1" color="<%=color1%>">파일서버 관리</FONT>
            </td>
            <!-- 
            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" id="mediamenu2" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path2 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:showTabMenu(2)">
            	<FONT class="middlemenu" id="mediafont2" color="<%=color2%>">회전 이미지</FONT>
            </td>
            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" id="mediamenu3" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path2 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:showTabMenu(3)">
            	<FONT class="middlemenu" id="mediafont3" color="<%=color2%>">영상</FONT>
            </td>
             -->
          </tr>
		</c:if>
 		<!-- 
          <tr valign="top"  >
            <td class="middlemenu" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/selected.png" style="background-repeat:no-repeat">
            	<FONT class="middlemenu">매장등록/수정</FONT>
            </td>
            <td class="middlemenu" align="center" width="119px" height="38" background="${ctxPath}/images/middle/dselected.png" style="background-repeat:no-repeat">
            	안녕
            </td>
          </tr>
         -->
        </table>	
    </td>
 </tr>
</table>
</div>
