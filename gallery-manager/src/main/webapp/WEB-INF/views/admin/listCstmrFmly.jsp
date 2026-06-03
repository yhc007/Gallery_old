<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script>
	

jQuery(document).ready(function(){
	
});

function getCstmrPop(cstmrCd){
	console.log('cstmrCd:'+cstmrCd);
	$("#cstmrPop" + cstmrCd).css("display","inline");
	
	$( document ).mousemove(function( event ) {
		 $("#cstmrPop" + cstmrCd).css("left", event.clientX+10);
		 $("#cstmrPop" + cstmrCd).css("top", event.clientY+10);
		});
}

function getFmlyPop(fmlyCd){
	console.log('fmlyCd:'+fmlyCd);
	$("#fmlyPop" + fmlyCd).css("display","inline");
	
	$( document ).mousemove(function( event ) {
		 $("#fmlyPop" + fmlyCd).css("left", event.clientX+10);
		 $("#fmlyPop" + fmlyCd).css("top", event.clientY+10);
		});
}
function closeCstmrPop(cstmrCd){
	$("#cstmrPop" + cstmrCd).css("display","none");
}
function closeFmlyPop(fmlyCd){
	$("#fmlyPop" + fmlyCd).css("display","none");
}


function setPoint(cstmrCd,fmlyCd,ty){
	/* console.log('run setPoint cstmrCd:' + cstmrCd);
	console.log('run setPoint fmlyCd:' + fmlyCd); */
	var initTotal;
	var setTotal;
	//console.log('step1');
	var shopNum;
	if(ty=='cstmr'){
		initTotal = removeComma($('#initPTotal'+cstmrCd).text()); 
		setTotal = $('#setPTotal'+cstmrCd).val();
		setTotal = removeComma(setTotal);
		shopNum = $('#shopIdP'+cstmrCd).val();
		fmlyCd = cstmrCd;
	}else{
		initTotal = removeComma($('#initFTotal'+fmlyCd).text()); 
		setTotal = $('#setFTotal'+fmlyCd).val();
		setTotal = removeComma(setTotal);
		shopNum = $('#shopIdF'+cstmrCd).val();
	}
	
	if(initTotal==setTotal){
		alert('변경 사항이 없습니다.');
		return;
	}
	
	var date = new Date();
	var year = date.getFullYear();
	var month = addZero(String(date.getMonth()+1));
	var day = addZero(String(date.getDate()));
	
	var nPoint=0;
	var pointStatus;
	
	var datetime = year + "." + month + "." + day;
	
	setTotal = parseInt(setTotal);
	initTotal = parseInt(initTotal);
	/* console.log('setTotal:'+setTotal);
	console.log('initTotal:'+initTotal);
	console.log('shopNum:'+shopNum); */

	if(setTotal < initTotal){
		pointStatus = "M";
		nPoint = (initTotal - setTotal) / 100;
		nPoint = nPoint.toString();
	}else{
		pointStatus = "P";
		nPoint = (setTotal - initTotal) / 100;
		nPoint = nPoint.toString();
	}
	
	var param = "cstmrCd=" + cstmrCd + 
					"&fmlyCd=" + fmlyCd +
					"&point=" + nPoint + 
					"&pointStatus=" + pointStatus + 
					"&shopNum=" + shopNum + 
					"&dateTime=" + datetime;

	var url = "${ctxPath}/point/addPointHist.do";
	
	$.ajax({
		url : url,
		data :param,
		dataType : "text",
		type : "post",
		success :function(data){
			if(data=="success"){
				//getCstmrPoint();
				alert("수정되었습니다");
				getCstmrPoint();
			}
		}
	});
}

function setCommaValue(input){
	console.log('run setCommaValue');
	console.log('input.id:'+input.id);
	console.log('input.val:'+input.value);
	var tmpVal = input.value;
	tmpVal = removeComma(tmpVal);
	tmpVal = addComma(tmpVal);
	$('#'+input.id).val(tmpVal);
}
	

</script>
<style>
#cancel{
	position : absolute;
	width: 30px;
}

td>input[type="image"]{
	display:table-cell;
	vertical-align:middle;
}
.grayClass{
	background-color: #d3d3d3;
}
.whiteClass{
		background-color: white;
}

.cstmrPop{
	display : none;
	background-color : white;
	border-radius : 20px;
	position: absolute;
	padding :10px;
}


</style>
<table class="listShop" id='tbFmlyCd' width="100%" border="0.5" >
    <tr class='whiteClass'>
      	<th width='10%'>고객명</th>
		<th colspan = 2 width='25%'>포인트</th>
		<th width='15%'>변경</th>
		<th width='10%'>가족명</th>
		<th colspan = 2 width='25%'>포인트</th>
		<th width='15%'>변경</th>
    </tr>
    
       <c:set var="flag" value="a">
	 	</c:set>
    <c:choose>
		<c:when test="${!empty listCstmrPoint}">
	   		<c:forEach var="cstmr" items="${listCstmrPoint}" varStatus="status">
	   		
	   		<c:choose>
			<c:when test="${flag eq 'a'}">
				<c:set value="grayClass" var="cssClass"></c:set>
				
				<c:set var="flag" value='b'></c:set>
			</c:when>
			<c:otherwise>
				<c:set value="whiteClass" var="cssClass">
				</c:set>
				<c:set var="flag" value="a">
				</c:set>
			</c:otherwise>
			</c:choose>

				<tr class="listData ${cssClass }" style='text-align:center;'>
				    <td>${cstmr.cstmrName}</td>
				    <td>
				    	<span id='initPTotal${cstmr.cstmrCd}'
				    			style='width:50%;text-align:right;'></span>
				   	</td>
				    <td>
				    	<input id='setPTotal${cstmr.cstmrCd}'
				    			onkeyup='setCommaValue(this);'
				    			type='text' size='10' style='text-align:right;' />
				    </td>
				    	<script>
				    		console.log('pointTotal:${cstmr.pointTotal*100}');
				    		$('#initPTotal${cstmr.cstmrCd}').text(format('${cstmr.pointTotal*100}'));
				    		$('#setPTotal${cstmr.cstmrCd}').val(format('${cstmr.pointTotal*100}'));
				    	</script>
				    <td>
					    <select data-mini="true" id="shopIdP${cstmr.cstmrCd}" name="shopId" data-inline="true">
							<option value="-1">매장선택</option>
							<c:choose>
							<c:when test="${!empty listShopPoint}">
		   						<c:forEach var="shop" items="${listShopPoint}" varStatus="status">
		   						<option value="${shop.shopId}">${shop.shopName}</option>
		   						</c:forEach>
	   						</c:when>
	   						<c:otherwise>
	   							<option value="-2">매장정보 없음</option>
	   						</c:otherwise>
	   					</c:choose>
						</select>
				    		
				    	<input type='button' onclick='setPoint("${cstmr.cstmrCd}","${cstmr.fmlyCd}","cstmr");' value='변경' />
				    </td>

					<div id='cstmrPop${cstmr.cstmrCd}' class="cstmrPop">
						고객이름 : ${cstmr.cstmrName}<br>
						고객코드 : ${cstmr.cstmrCd}<br>
						휴대전화 : ${cstmr.cellphone}<br>
						<br/>
						전화번호 : ${cstmr.telephone}<br>
						주소 : ${cstmr.addr}<br>
						생년월일 : ${cstmr.birthDay}<br>
					</div>

				    <c:choose>
					<c:when test="${!empty cstmr.fmlyName}">
				    <td>${cstmr.fmlyName}</td>
				    <td>
				    	<span id='initFTotal${cstmr.fmlyCd}'
				    			style='text-align:right;'></span>
				    </td>
					<td>
				    	<input id='setFTotal${cstmr.fmlyCd}'
				    			onkeyup='setCommaValue(this);'
				    			type='text' size='10' style='text-align:right;' />
				    </td>
			    	<script>
			    		$('#initFTotal${cstmr.fmlyCd}').text(format('${cstmr.fmlyTotal*100}'));
			    		$('#setFTotal${cstmr.fmlyCd}').val(format('${cstmr.fmlyTotal*100}'));
			    	</script>
				    <td>
				    	 <select data-mini="true" id="shopIdF${cstmr.cstmrCd}" name="shopId" data-inline="true">
							<option value="-1">매장선택</option>
							<c:choose>
							<c:when test="${!empty listShopPoint}">
		   						<c:forEach var="shop" items="${listShopPoint}" varStatus="status">
		   						<option value="${shop.shopId}">${shop.shopName}</option>
		   						</c:forEach>
	   						</c:when>
	   						<c:otherwise>
	   							<option value="-2">매장정보 없음</option>
	   						</c:otherwise>
	   					</c:choose>
						</select>
				    	<input type='button' onclick='setPoint("${cstmr.cstmrCd}","${cstmr.fmlyCd}","fmly");'  value='변경'/>
				    </td>
					<div id='fmlyPop${cstmr.fmlyCd}' class="cstmrPop">
						가족이름 : ${cstmr.fmlyName}<br>
						고객코드 : ${cstmr.fmlyCd}<br>
						휴대전화 : ${cstmr.fmlyCell}<br>
						<br/>
						전화번호 : ${cstmr.fmlyTel}<br>
						주소 : ${cstmr.fmlyAddr}<br>
						생년월일 : ${cstmr.fmlyBirth}<br>
					</div>
					
				    </c:when>
				    <c:otherwise>
				    	<td colspan='3'>가족 코드가 없습니다.</td>
				    </c:otherwise>
				    </c:choose>				    
				</tr>
			</c:forEach>
			
		</c:when>
		<c:otherwise>
			<tr class='grayClass'>
				<td colspan="6" align="center">고객 데이터가 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
	    
</table> 
<br>
