<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.gallery.common.CommonCode"%>
<!--
<div style="position: relative; left: 0px; top:30px; width:160px;">
 -->
<div id='tileMiddle'>
<table width="100%" class="header" border="0" cellspacing="0" cellpadding="0">
 <tr>
 	<td width="100%" height="4" style="background-color:#1f6fd0;">
 	<!--
 		<img src="<c:url value="/images/middle/blueline.png"/>" width="100%" height="4"></img>
 	 -->
 	</td>
 </tr>
 <tr>
 	<td align="center" valign="top" width="100%" height="48" background="${ctxPath}/images/middle/blue_box_1.png" style="">
		<%
			String path0="dselected";
	 		String path1="dselected";
	 		String path2="dselected";
	 		String path3="dselected";
	 		String path4="dselected";
	 		String path5="dselected";
	 		String path6="dselected";
	 		String path7="dselected";
	 		String path8="dselected";
	 		String color0="#000000";
	 		String color1="#000000";
	 		String color2="#000000";
	 		String color3="#000000";
	 		String color4="#000000";
	 		String color5="#000000";
	 		String color6="#000000";
	 		String color7="#000000";
	 		String color8="#000000";
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
		 		}else if(formnum==7){
		 			path7="selected";
		 			color7="#ffffff";
		 		}else if(formnum==8){
		 			path8="selected";
		 			color8="#ffffff";
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
 	<td id="bluebox"  height="38" align="left" valign="top" background="${ctxPath}/images/middle/blue_box_2.png" style="background-repeat:repeat-x;padding:0;" >
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
            	<FONT class="middlemenu" color="<%=color2%>">직원 관리</FONT>
            </td>
             <td width="5px" height="38">
		 	</td>
		 	<td class="middlemenu" id="comMENU" align="center" valign="middle" width="100px" height="38"
            background="${ctxPath}/images/middle/<%=path0 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/company/indexCompanyForm.do')">
            	<FONT class="middlemenu" color="<%=color0%>">거래처</FONT>
            </td>
             <td width="5px" height="38">
		 	</td>
		 	<td class="middlemenu" id="comStaffMENU" align="center" valign="middle" width="100px" height="38"
            background="${ctxPath}/images/middle/<%=path4 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/company/indexComStaff.do')">
            	<FONT class="middlemenu" color="<%=color4%>">거래처 직원</FONT>
            </td>
          </tr>
		</c:if>

		<c:if test='${topMenuId=="MPRDCT"}'>
		 <tr align="left">
		 	<td width="107px" height="38">
		 	</td>

            <td width="5px" height="38">
            <td class="middlemenu" id="brandMENU" align="center" valign="middle" width="100px" height="38"
            background="${ctxPath}/images/middle/<%=path1 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/brand/indexBrandForm.do')">
            	<FONT class="middlemenu" color="<%=color1%>">브랜드</FONT>
            </td>
            <td width="5px" height="38">
            <%-- <td class="middlemenu" align="center" id="prdctMENU" valign="middle" width="100px" height="38"
            background="${ctxPath}/images/middle/<%=path2 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/prdct/indexPrdctForm.do')">
            	<FONT class="middlemenu" color="<%=color2%>">상품등록/수정</FONT>
            </td> --%>
            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" align="center" id="trdeMENU" valign="middle" width="100px" height="38"
            background="${ctxPath}/images/middle/<%=path8 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/prdct/indexTradeForm.do')">
            	<FONT class="middlemenu" color="<%=color8%>" id="tradeMenu">거래내역</FONT>
            </td>
            <td width="5px" height="38">
		 	</td>
		 	</td>
            <td class="middlemenu" align="center" valign="middle" width="100px" height="38"
            background="${ctxPath}/images/middle/<%=path3 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/prdct/indexPrdctConfirmForm.do')">
            	<FONT class="middlemenu" color="<%=color3%>">주문</FONT>
            </td>
            <td width="5px" height="38">
		 	</td>
           <%--  <td class="middlemenu" align="center" id="cntMENU" valign="middle" width="100px" height="38"
            background="${ctxPath}/images/middle/<%=path4 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/prdct/indexPrdctRemainForm.do')">
            	<FONT class="middlemenu" color="<%=color4%>">재고</FONT>
            </td> --%>
            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" align="center" valign="middle"id="evtMENU" width="100px" height="38"
            background="${ctxPath}/images/middle/<%=path5 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/event/indexEventForm.do')">
            	<FONT class="middlemenu" color="<%=color5%>">이벤트</FONT>
            </td>
             <td width="5px" height="38">
		 	</td>
            <td class="middlemenu"id="deliverMENU" align="center" valign="middle" width="100px" height="38"
            background="${ctxPath}/images/middle/<%=path6 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/dlvr/indexDlvrForm.do')">
            	<FONT class="middlemenu" color="<%=color6%>" >배송</FONT>
            </td>
            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" id="onlineMENU" align="center" valign="middle" width="100px" height="38"
            background="${ctxPath}/images/middle/<%=path7 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/prdct/mobilePrdct.do')">
            	<FONT class="middlemenu" color="<%=color7%>">온라인제품</FONT>
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
          <td class="middlemenu" id="saleMENU" align="center" valign="middle" width="119px" height="38"
            background="${ctxPath}/images/middle/<%=path2 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/sale/indexSaleHistForm.do')">
            	<FONT class="middlemenu" color="<%=color2%>">판매이력</FONT>
            </td>
          <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" align="center" valign="middle" width="119px" height="38"
            background="${ctxPath}/images/middle/<%=path3 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:chkManager();">
            	<FONT class="middlemenu" color="<%=color3%>">매출 조회</FONT>
            </td>

          <td width="5px" height="38">
		 	</td>
           <td class="middlemenu" align="center" id="rankingMENU" valign="middle" width="119px" height="38"
            background="${ctxPath}/images/middle/<%=path4 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/admin/prdctRankingForm.do')">
            	<FONT class="middlemenu" color="<%=color4%>">제품판매순위</FONT>
            </td>

             <td width="5px" height="38">
		 	</td>
           <td class="middlemenu" align="center" id="ComtradeMENU" valign="middle" width="119px" height="38"
            background="${ctxPath}/images/middle/<%=path5 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/admin/comTradeForm.do')">
            	<FONT class="middlemenu" color="<%=color5%>">업체별 거래내역</FONT>
            </td>

            <td width="5px" height="38">
		 	</td>
           <td class="middlemenu" align="center" id="modifyDateMENU" valign="middle" width="119px" height="38"
            background="${ctxPath}/images/middle/<%=path6 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/admin/modifyDateForm.do')">
            	<FONT class="middlemenu" color="<%=color6%>">거래 날짜 변경</FONT>
            </td>

            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" align="center" id="cstmrTaxMENU" valign="middle" width="119px" height="38"
            	background="${ctxPath}/images/middle/<%=path7 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.replace('${ctxPath}/tax/indexTaxForm.do')">
            	<FONT class="middlemenu" color="<%=color7%>">연말정산</FONT>
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
            	onclick="javascript:location.href='${ctxPath}/fileserver/indexFileServerForm.do'">
            	<FONT class="middlemenu" id="mediafont1" color="<%=color1%>">파일서버 관리</FONT>
            </td>

            <td width="5px" height="38">
		 	</td>
            <td class="middlemenu" id="mediamenu2" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path2 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.href='${ctxPath}/fileserver/createCouponPage.do'">
            	<FONT class="middlemenu" id="mediafont2" color="<%=color2%>">쿠폰생성</FONT>
            </td>

            <td width="5px" height="38"></td>
             <td class="middlemenu" id="mediamenu3" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path3 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.href='${ctxPath}/admin/pointManager.do'">
            	<FONT class="middlemenu" id="mediafont3" color="<%=color3%>">매장포인트관리</FONT>
            </td>

             <td width="5px" height="38"></td>
             <td class="middlemenu" id="mediamenu4" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path4 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.href='${ctxPath}/admin/chkEyesManager.do'">
            	<FONT class="middlemenu" id="mediafont4" color="<%=color4%>">검안 대상자</FONT>
            </td>
            <td width="5px" height="38"></td>
             <td class="middlemenu" id="mediamenu5" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path5 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.href='${ctxPath}/admin/mergeCstmr.do'">
            	<FONT class="middlemenu" id="mediafont5" color="<%=color5%>">고객관리</FONT>
            </td>

            <td width="5px" height="38"></td>
            <td class="middlemenu" id="mediamenu6" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path6 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.href='${ctxPath}/admin/listCstmrInfo.do'">
            	<FONT class="middlemenu" id="mediafont6" color="<%=color6%>">고객정보</FONT>
            </td>

            <%-- <td width="5px" height="38"></td>
             <td class="middlemenu" id="mediamenu6" align="center" valign="middle" width="119px" height="38" background="${ctxPath}/images/middle/<%=path6 %>.png" style="background-repeat:no-repeat"
            	onclick="javascript:location.href='${ctxPath}/admin/pointManager2.do'">
            	<FONT class="middlemenu" id="mediafont6" color="<%=color6%>">고객 포인트관리</FONT>
            </td> --%>
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

<script>
var shopLv = ${lv};
if(shopLv==3){
	$("#comMENU").css("display","none");
	$("#brandMENU").css("display","none");
	$("#prdctMENU").css("display","none");
	$("#cntMENU").css("display","none");
	$("#evtMENU").css("display","none");
	$("#deliverMENU").css("display","none");
	$("#onlineMENU").css("display","none");
	$("#saleMENU").css("display","none");
	$("#tradeMenu").css("display","none");
	$("#trdeMENU").css("display","none");
	$("#rankingMENU").css("display","none");
	$("#ComtradeMENU").css("display","none");
	$("#modifyDateMENU").css("display","none");

}
</script>

<style>
</style>
