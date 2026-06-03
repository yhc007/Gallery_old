<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script>
	
//----------------------
//화면 초기 실행 
jQuery(document).ready(function(){
	jQuery('#prdctDetailForm input[name=prdctId]').val('${prdctVo.prdctId}');
	document.getElementById("tbrandName").innerHTML='${prdctVo.brandName}';
	document.getElementById("tprdctName").innerHTML='${prdctVo.prdctName}';
	document.getElementById("tmnfCountry").innerHTML='${prdctVo.mnfCountry}';
	document.getElementById("ttrdePrc").innerHTML='${prdctVo.trdePrc}';
	
	if('${prdctVo.prdctStatTyCd}'=='00100001'||'${prdctVo.prdctStatTyCd}'=='00100004'){
		var href1 = document.getElementById("acpt");
		var href2 = document.getElementById("deny");
		href1.style.display="none";	
		href2.style.display="none";
	}
	
	if('${prdctVo.multiImgCnt}'=='0'){
		var hrefRoate = document.getElementById("a_rotate_img");
		hrefRoate.style.display="none";
	}
	
	if('${prdctVo.videoCd}'==''){
		var hrefVideo = document.getElementById("a_video");
		hrefVideo.style.display="none";
	}
	
});
//----------------------

function fncAcptReqAction(code){
	fncSavePrdctActpAction(code,jQuery('#prdctDetailForm input[name=prdctId]').val());
}
//닫기
function fncCancel(){
	jQuery('#dialog').dialog( 'close' );
}


</script> 
 
	 
		

<!-- <div id="content"> -->
<div id="popupCnts" >			
	<form name="prdctDetailForm"  id="prdctDetailForm" method="post" action="">
		<input type="hidden" id='prdctId' name='prdctId'/>
		<table>
			 <colgroup>
				<col width="50%">
				<col width="20%">
				<col width="30%">
			</colgroup>
		 <tr>
		 	<td rowspan="5"  align="center">
		 		<table>
		 		<tr>
		 			<td>
		 				<a href="#"><img src="${prdctVo.urlStr}${prdctVo.imgPath}" width=200/></a>
		 			</td>
		 		</tr>
		 		<tr>
		 			<td align="center">
		 				<a target='_blank' href='${ctxPath}/media/rotate.do?prdctId=${prdctVo.prdctId}' id='a_rotate_img'><font color="blue">회전 이미지 보기</font></a>
		 			</td>
		 		</tr>
		 		 
		 		<tr>
		 			<td align="center">
		 				<a target='_blank' href='http://www.youtube.com/embed/${prdctVo.videoCd}' id='a_video'><font color="blue">동영상 보기</font></a>
		 			</td>
		 		</tr>
		 		 
		 		</table>
		 	</td>
		 	<th align="left">
		 		브랜드
		 	</th>
		 	<td align="left">
		 		<p id="tbrandName"/>
		 	</td>
		 </tr>
		 <tr>
		 	<th align="left">
		 		모델
		 	</th>
		 	<td align="left">
		 		<p id="tprdctName"/>
		 	</td>
		 </tr>
		 <tr>
		 	<th align="left">
		 		제조 국가
		 	</th>
		 	<td>
		 		<p id="tmnfCountry"/>
		 	</td>
		 </tr>
		 <tr>
		 	<th align="left">
		 		가격
		 	</th>
		 	<td>
		 		<p id="ttrdePrc"/>
		 	</td>
		 </tr>
		</table>
		
		<div id="btn_sctn" align="right">
			<a href="#" class="btn1" id='acpt'  onclick="fncAcptReqAction('00100003');return false;">승인</a>
			<a href="#" class="btn1" id='deny' onclick="fncAcptReqAction('00100004');return false;">반려</a>
			<a href="#" class="btn1" id='cancel' onclick="fncCancel();return false;">취소</a>
		</div>
	</form>


</div><!--//content-->
