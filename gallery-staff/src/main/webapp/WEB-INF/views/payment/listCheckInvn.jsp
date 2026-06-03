<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>

<style>
.invn_cnt_number{
	width:50px;
}
input[type="image"]{
	display:table-cell;
	vertical-align:middle;
}

input[type="number"]{
	min:0;
}
#slct_cancel_info{
	font-size:40px;
	text-align:center;
}
select>option{
	text-align:center;
}
	

</style>
<script>

var arr_id = new Array();
var arr_ty = new Array();
var arr_shop = new Array();
var arr_cnt = new Array();

var g_prdctId='';
var g_prdctTy='';

function incCnt(id)
{
	console.log('id:'+id);
	var cnt = document.getElementById(id).value;
	cnt++;
	console.log('cnt:'+cnt);
	document.getElementById(id).value=cnt;
}

function decCnt(id)
{
	console.log('id:'+id);
	var cnt = document.getElementById(id).value;
	cnt--;
	if(cnt<0)
	{cnt = 0;}
	console.log('cnt:'+cnt);
	document.getElementById(id).value=cnt;
}

function chkValidation(){
	var dtr=0;
	var shp=0;
	var total_cnt = 0;
	for(var i = 0, size=arr_id.length;i<size;i++){
		dtr = document.getElementById(arr_id[i]+'dtr'+arr_ty[i]).value;
		dtr=Number(dtr);
		shp = document.getElementById(arr_id[i]+'shp'+arr_ty[i]).value;
		shp=Number(shp);
		total_cnt = document.getElementById(arr_id[i]+'cnt'+arr_ty[i]).innerHTML;
		
		if(total_cnt != dtr+shp)
		{
			console.log('total_cnt:'+total_cnt);
			console.log('dtr+shp:'+dtr+shp);
			console.log('dtr:'+dtr);
			console.log('shp:'+shp);
			return -1;
		}
	}
	return;
}


function getIdTy(id)
{
	var tmpArray;
	if(id.match('dtr')){
		tmpArray = id.split('dtr');
		g_prdctId = tmpArray[0];
		g_prdctTy = tmpArray[1];
	}else if(id.match('shp')){
		tmpArray = id.split('shp');
		g_prdctId = tmpArray[0];
		g_prdctTy = tmpArray[1];
	}else if(id.match('cnt')){
		tmpArray = id.split('cnt');
		g_prdctId = tmpArray[0];
		g_prdctTy = tmpArray[1];
	}
	console.log('id:'+g_prdctId);
	console.log('Ty:'+g_prdctTy);
}


function fncCancel() {
	console.log("run fcnCancel");
	console.log("g_cancelSaleId:"+g_cancelSaleId);
	var cancelMemo=$("#cancelReason").val();
	var cancelCd = document.getElementById('slct_cancel_info').value;
	if(cancelCd == -1){
		alert("반품 사유를 선택하세요.");
		return;
	}
	if( -1 == chkValidation())
	{
		alert('수량이 맞지 않습니다.');
		return;
	}

	//return;
	//var cancelUrl = "${ctxPath}/payment/cancelPayment.do";
	var cancelUrl = "${ctxPath}/payment/updatePrdctCancel.do";
	
	
	var listPrdctId='';
	var listPrdctTy='';
	var listPrdctDtr='';
	var listPrdctShp='';
	var listShop='';
	var listPrdctCnt='';
	
	for(var i = 0, size=arr_id.length;i<size;i++){
		listPrdctId+=arr_id[i]+',';
		listPrdctTy+=arr_ty[i]+',';
		listShop+=arr_shop[i]+',';
		listPrdctCnt+=arr_cnt[i]+',';
		dtr = document.getElementById(arr_id[i]+'dtr'+arr_ty[i]).value;
		listPrdctDtr+=dtr+',';
		shp = document.getElementById(arr_id[i]+'shp'+arr_ty[i]).value;
		listPrdctShp+=shp+',';
		
	}
	var cancelDate = $('#returnDatePicker').val();
	console.log('cancelDate:'+cancelDate);
	$.ajax({
		url : cancelUrl
		,type : "post"
		,data : "saleId=" + g_cancelSaleId + "&cancelMemo="+cancelMemo+"&cancelCd="+cancelCd
				+"&listPrdctId="+listPrdctId + "&listPrdctTy="+listPrdctTy + "&listShop="+listShop
				+"&listPrdctDtr="+listPrdctDtr + "&listPrdctShp="+listPrdctShp +'&listPrdctCnt='+listPrdctCnt
				+"&cancelDate="+cancelDate
		,dataType : "text"
		,success : function(data) {
			if(data=='success'){
				alert("반품이 성공하였습니다.");
				location.replace('${ctxPath}/shop/indexShopCstrmForm.do');
			}else{
				alert("반품에 실패하였습니다. 재로그인 후 다시 시도 바랍니다.");
	
				//location.replace('${ctxPath}/shop/indexShopCstrmForm.do');
			}
		}
	});
}

function push_prdct(id, ty, shop, cnt)
{
	arr_id.push(id);
	arr_ty.push(ty);
	arr_shop.push(shop);
	arr_cnt.push(cnt);
	
}


function selectReason()
{
	var selectValue = document.getElementById('slct_cancel_info').value;
	
	console.log("value :"+selectValue);
	
	if(selectValue == 6)
	{
		document.getElementById("cancelReason").style.visibility = "visible";
        document.getElementById("cancelReason").style.display = "block";
	}else{
        document.getElementById("cancelReason").style.visibility = "hidden";
        document.getElementById("cancelReason").style.display = "none";
	}
}

$(function() {
    $('#returnDatePicker').datepicker({ dateFormat: 'yy.mm.dd' });
    $('#returnDatePicker').datepicker('setDate', new Date());
  });
</script>
<html>
	<body>
	<table border='0.5' width='100%' align='center'>
		<tr>
			<td colspan='11' align='center'><label for='cancelReason'>
			<select id='slct_cancel_info' name='slctCardCom' onchange='selectReason();'>
				<option value='-1'>-----사유 선택-----</option>
				<option value='1'>프레임 디자인 불만</option>
				<option value='2'>안경렌즈 도수 안 맞음</option>
				<option value='3'>소프트렌즈 부적응</option>
				<option value='4'>하드렌즈 부적응</option>
				<option value='5'>기타 고객 요구사항 미반영</option>
				<option value='6'>그 외 사유</option>
			</select>
			<input type='text' id='returnDatePicker' placeholder='반품 날짜' >
			<input hidden id='cancelReason' size='1' style='height: 50px; width:50%; font-size: 25px;'>
			</td>
		</tr>
		<c:choose>
		<c:when test="${!empty listPrdct}">
		<tr align='center'>
			<td>이름</td>
			<td>수량</td>
			<td>제품종류</td>
			<td>매장이름</td>
			<td>단품가격</td>
			<td colspan='3'>폐기</td>
			<td colspan='3'>매장재고</td>
		</tr>
		<c:forEach var="prdct" items="${listPrdct }">
		<tr align='center'>
<%--
 			<td>${prdct.prdctId }</td>
			<td>${prdct.shopId }</td>
--%>
 			<td>${prdct.prdctName }</td>
			<td><span id='${prdct.prdctId}cnt${prdct.itemTy }' >${prdct.prdctCnt }</span></td>
			<td>${prdct.itemTy }</td>
			<td>${prdct.shopName}</td>
			<td>${prdct.prc}</td>
			<td>
				<input type="image"  onclick="decCnt('${prdct.prdctId}dtr${prdct.itemTy }'); return false;" src="<c:url value="/images/button/Select_m.png" /> "width="25px" height="25px">
			</td>
			<td>
				<input class='invn_cnt_number' max='${prdct.prdctCnt }' value='0' id='${prdct.prdctId}dtr${prdct.itemTy }' type="number">
			</td>
			<td>
				<input type="image"  onclick="incCnt('${prdct.prdctId}dtr${prdct.itemTy }'); return false;" src="<c:url value="/images/button/Select_p.png" /> "width="25px" height="25px">
			</td>
			<td>
				<input type="image"  onclick="decCnt('${prdct.prdctId}shp${prdct.itemTy }'); return false;" src="<c:url value="/images/button/Select_m.png" /> "width="25px" height="25px">
			</td>
			<td>
				<input class='invn_cnt_number' max='${prdct.prdctCnt }' value='0' id='${prdct.prdctId}shp${prdct.itemTy }' type="number">
			</td>
			
			<td>
				<input type="image"  onclick="incCnt('${prdct.prdctId}shp${prdct.itemTy }'); return false;" src="<c:url value="/images/button/Select_p.png" /> "width="25px" height="25px">
			</td>
		</tr>
		<script>
			push_prdct('${prdct.prdctId}','${prdct.itemTy}','${prdct.shopId}','${prdct.prdctCnt}');
		</script>
		</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="11" align="center">재고 관리 대상이 없습니다. 사유 선택 후 취소 바랍니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
	<tr>
			<td colspan='11' align='center'>
			<button onclick='fncCancel();return false;' id='submit'
					style='height: 50px; width: 60px'>확인</button></td>
	</tr>
	</table>
	</body>
</html>



