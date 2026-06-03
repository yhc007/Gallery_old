<%@ page language="java" pageEncoding="UTF-8"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" scope="request"/>

<script>
var header;
$(function() {
	header = $("#asBoardTbl").html();
	$("#asBoardDiv").popup();
});


function addZero(n){
	if(n.length=="1"){
		n = "0" + n;
	}
	return n;
}

function getAsBoard(){
	var date = new Date();
	var year = date.getFullYear();
	var month = addZero(String(date.getMonth()+1));
	var day = addZero(String(date.getDate()));
	
	var shopId=-1;
	if('${shopVo.shopId}'==''||'${shopVo.shopId}'=='"null"')
		shopId=window.sessionStorage.getItem("gShopId");
	else
		shopId=parseInt('${shopVo.shopId}')
		
	console.log('shopId:'+shopId);
	
	var url = "${ctxPath}/prdct/getAsBoard.do";
	var param = "shopId=" + shopId;
	
	$.ajax({
		url : url,
		data : param,
		dataType : "html",
		type : "post",
		success :function(data){
			$("#asBoardTbl").html(header);
			$("#asBoardTbl").append(data);
			
			$("#asBoardDiv").popup("open");
			
			$(".btn").button();
			
			/* $("#asBoardDiv").dialog({
				title : "A/S 관리",
				width : 800
			}); */
			
			$("#inputTime").val(year + "." + month + "." + day);
		}
	});
	
}

function regAs(){
	var shopId = "${shopVo.shopId}";
	if(confirm("등록하시겠습니까?")==false){
		return;
	}
	
	var cstmrName = $("#asForm input[id='cstmrNameAS']").val();
	var telephone = $("#asForm input[id='telephoneAS']").val();
	var prdctName = $("#asForm input[id='prdctNameAS']").val();
	var cName = $("#asForm input[id='cardComNameAS']").val();
	
	console.log("cstmrName" + cstmrName)
	if(cstmrName==""){
		alert("고객 이름을 입력하세요");
		$("#cstmrName").focus();
		return;
	}else if(telephone==""){
		alert("전화번호를 입력하세요");
		$("#telephone").focus();
		return;
	}else if(prdctName==""){
		alert("제품명을 입력하세요");
		$("#prdctName").focus();
		return;
	}else if(cName==""){
		alert("협력사를 입력하세요");
		$("#cardComName").focus();
		return;
	}
	var url = "${ctxPath}/prdct/regAs.do";
	var param = $("#asForm").serialize() + 
					"&shopId=" + shopId;
	$.ajax({
		url : url,
		data : param,
		dataType : "text",
		type : "post",
		success : function(data){
			if(data=="success"){
				alert("등록되었습니다.");
				getAsBoard();
			}
		}
	});
}

function completeAs(no){
	if(confirm("출고처리 하시겠습니까?")==false){
		return;
	}
	var url = "${ctxPath}/prdct/completeAs.do";
	var date = new Date();
	var year = date.getFullYear();
	var month = addZero(String(date.getMonth()+1));
	var day = addZero(String(date.getDate()));
	var param = "no=" + no + 
					"&outputTime=" + year + "." + month + "." + day;
	
	$.ajax({
		url : url,
		data : param,
		dataType : "text",
		type : "post",
		success : function(data){
			if(data=="success"){
				getAsBoard();	
			}
		}
	});
}


function delAs(no){
	if(confirm("삭제 하시겠습니까?")==false){
		return;
	}
	var param = "no=" + no;
	var url = "${ctxPath}/prdct/delAs.do";
	
	$.ajax({
		url : url,
		data : param,
		dataType : "text",
		type : "post",
		success :function(data){
			if(data=="success"){
				getAsBoard();	
			}
		}
	});
}
</script>



<div data-role="popup" id="asBoardDiv" style="width: 800px;" data-overlay-theme="a" data-theme="c" class="ui-corner-all" >
	<a href="#" data-rel="back" data-role="button" data-theme="a"
			data-icon="delete" data-iconpos="notext" class="ui-btn-right btn">Close</a>
	<div style="padding: 10px 20px;">
			<h3>A/S 정보</h3>
			
		<form action="" id="asForm">
		<table id="asBoardTbl" style="width: 750px; text-align: center;border-collapse: collapse;" border="1">
			<tr>
				<th style="background-color: #d6ebfe">이름</th>
				<th style="background-color: #d6ebfe">연락처</th>
				<th style="background-color: #d6ebfe">모델명</th>
				<th style="background-color: #d6ebfe">협력사</th>
				<th style="background-color: #d6ebfe">입고일</th>
				<th style="background-color: #d6ebfe">출고일</th>
			</tr>
			<tr>
				<td><input type="text" id="cstmrNameAS" name="cstmrName" size="10" ></td>
				<td><input type="text" id="telephoneAS" name="telephone" size="10" ></td>
				<td><input type="text" id="prdctNameAS" name="prdctName" size="10" ></td>
				<td><input type="text" id="cardComNameAS" name="cardComName" size="5" ></td>
				<td><input type="text" id="inputTime" name="inputTime" size="10" ></td>
				<td><input type="text" id="outTime" name="outTime" size="10" readonly="readonly"></td>
			</tr>
			<tr>
				<td colspan="5" valign="middle">
					<textarea style="height:100%" rows="1" cols="80" id="content" name="content"></textarea>
				</td>
				<td height="">
					<button  onclick="regAs(); return false" >등록</button>
				</td>
			</tr>		
			
		</table>
		</form>
	</div>
</div>