<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<style>
	
	#staffList td[class='c1']	{
		padding: 5px;
	}
	
	#saveBigo{
		-webkit-appearance: none;
		width:48px;
		height:28px;
	}
	
</style>
<script>
	var mPrdctId;
	var mTrdePrc;

	function fncSaveEdit() {

		var checkStaffId = document.getElementById('staffId').innerHTML;
		if (checkStaffId != '${staffVoH.staffId}') {
			alert("다른 스태프의 작업을 수정할 수 없습니다.");
			return;
		}

		if (writable == false) {
			alert('<spring:message code="warn.check.writable"/>');
			return;
		}
		var url = 'updateVisitAction.do';

		param = jQuery('#checkForm').serialize();

		//alert(param);

		$.ajax({
			url : url,
			type : "post",
			data : param,
			dataType : "text",
			beforeSend : function() {
			},
			success : function(data) {
				if (data == "success") {
					alert("저장 완료.");
					writable = false;
				} else if (data == "fail") {
					alert('<spring:message code="fail"/>');
				}
			}
		});

		/*
		var url;
		var msg;
		var no;
		url = '${ctxPath}/cstmr/mAddCstmrAction.do'; // 추가
		no = 1;
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#cstmrInfoForm').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="success"){
					//alert('<spring:message code="add.success" />');
					document.getElementById("resultMsg").innerHTML='<spring:message code="add.success" />';
					fncCstmrClear();
				}else if(data=="fail"){
					//alert('<spring:message code="fail" />');
					document.getElementById("resultMsg").innerHTML='<spring:message code="fail" />';
				}
			}
			
		});  
		 */
	}
	
	function cstmrBigoUpdate(){
		var url = '${ctxPath}/cstmr/cstmrBigoUpdate.do';
		var bigo = $("#cstmrBigo").val();
		console.log("update bigo:"+bigo);
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data : "bigo=" + bigo + "&cstmrId=" + '${cstmrVo.cstmrId}',
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				alert('저장 완료');
			}
		}); 
	}
</script>



	
<table class="staffList" width="100%"  style="font-size: 13px;"  >
	<tr>
		<td colspan="6">
			<img src="${ctxPath	}/images/black2_line.jpg" width="100%">					
		</td>
	</tr>
	<tr >
		<td style="color: black;" class="c1" width="13%;">
			이름
		</td>
		<td bgcolor="white" style="color: black" class="c1" width="13%">
			<p id="cstmrName" name="cstmrName"></p>
		</td>
		
		<td  bgcolor="white" style="color: black" class="c1" width="13%">
			포인트
		</td>
		<td  bgcolor="white" style="color: black" class="c1" onclick= "fncGetPointHistory();"  width="24%">
			<span id=fmly_name_txt1></span><span id=fmly_cd_txt1 hidden></span>
			::
			<span id=total_point_txt1>
				<fmt:formatNumber value="" pattern="#,###" />
			</span>(점)
		</td>
		
		
		
		<td bgcolor="white" style="color: black" class="c1" width="13%">
			주소
		</td>
		<td bgcolor="white" style="color: black" class="c1" width="24%">
			<p id="cstmrAddr" name="cstmrAddr"></p>
		</td>
		<!-- 
			<input type="button" id="btnMode" onclick="fncCheckWrite();return false;" value="편집모드"></input>
			<button id="btnEdit" onclick="fncSaveEdit();return false;">수정하여저장</button>
			<button id="btnSave" onclick="fncSave();return false;">오늘날짜로저장</button> -->
		<!-- <td height="40" bgcolor="white" class="c1" align="right">
							<input id="Toggle" type="checkbox">
								<label for="Toggle" onclick="toggle()"><span>.</span></label>
							<a></a>
		</td> -->
	</tr>
	
	<tr>
		<td colspan="6">
			<img src="${ctxPath	}/images/black_line.jpg" width="100%" >					
		</td>
	</tr>
	<tr>
		<td bgcolor="white" style="color: black" class="c1">
			가입지점
		</td>
		<td bgcolor="white" style="color: black" class="c1">
			<p id="cstmrRegShop" name="cstmrCd"></p>
		</td>
		<td bgcolor="white" style="color: black" class="c1">
			전화번호
		</td>
		<td  bgcolor="white" style="color: black" class="c1">
			<p id="cstmrPhone" name="cstmrName"></p>
		</td>
		<td bgcolor="white" style="color: black" class="c1">
			고객코드
		</td>
		<td bgcolor="white" style="color: black" class="c1">
			<p id="cstmrCd" name="cstmrCd"></p>
		</td>
	</tr>
	
	<tr>
		<td colspan="6">
			<img src="${ctxPath	}/images/black_line.jpg" width="100%">					
		</td>
	</tr>
	
	<tr>
		<td bgcolor="white" style="color: black" class="c1">
			생일
		</td>
		<td bgcolor="white" style="color: black" class="c1">
			<p id="cstmrBirth" name="cstmrCd"></p>
		</td>
		<td  bgcolor="white" style="color: black" class="c1">
			휴대폰
		</td>
		<td  bgcolor="white" style="color: black"class="c1">
			<p id="cstmrCell" name="cstmrAddr"></p>
		</td>
		
		<td  bgcolor="white" style="color: black" class="c1">
			이메일
		</td>
		<td  bgcolor="white" style="color: black" class="c1">
			<p id="cstmrEmail" name="cstmrAddr"></p>
		</td>
	</tr>
	<tr>
		<td  bgcolor="white" style="color: black" class="c1">
			비고
		</td>
		<td bgcolor="white" style="color: black" class="c1" colspan="5">
			<input type="text" id="cstmrBigo" style="height:25px; width:90%"></input>
			<input type="button" id="saveBigo" onclick="cstmrBigoUpdate();return false;" value="저장"></input>
		</td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="${ctxPath	}/images/black2_line.jpg" width="100%">					
		</td>
	</tr>
</table>
<script>
	jQuery('#cstmrCd').text('${cstmr.cstmrCd}');
	jQuery('#cstmrName').text('${cstmr.cstmrName}');
	jQuery('#cstmrAddr').text('${cstmr.addr}');
	jQuery('#cstmrRegShop').text('${cstmr.strRegShop}');
	jQuery('#cstmrPhone').text('${cstmr.telephone}');
	jQuery('#cstmrCell').text('${cstmr.cellphone}');
	jQuery('#cstmrBirth').text('${cstmr.birthDay}');
	jQuery('#cstmrPoint').text('준비중');
	jQuery('#cstmrEmail').text('${cstmr.email}');
	jQuery('#cstmrBigo').val('${cstmr.bigo}');
	console.log('bigo:'+'${cstmr.bigo}');
	
</script>
