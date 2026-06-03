<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<script>
	var mPrdctId;
	var mTrdePrc;

	function fncSaveEdit() {

		var checkStaffId = document.getElementById('staffId').innerHTML;
		if (checkStaffId != '${staffVo.staffId}') {
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
</script>

<table class="staffList" width="800" border="0.5">
	<tr>
		<td height="40" bgcolor="#FFFFFF" class="c1">매장</td>
		<td height="40" bgcolor="#FFFFFF" class="c1"><p id="shopName"
				name="shopName"></p></td>
		<td height="40" bgcolor="#FFFFFF" class="c1">직원</td>
		<td height="40" bgcolor="#FFFFFF" class="c1"><p id="staffName"></p>
			<p id="staffId" hidden></p></td>
		<td height="40" bgcolor="#FFFFFF" class="c1">검안일</td>
		<td height="40" bgcolor="#FFFFFF" class="c1"><select
			onchange="getCheckInfo(value)">
				<c:choose>
					<c:when test="${!empty listVisit}">
						<option value='-1'>선택</option>
						<c:forEach var="visit" items="${listVisit}" varStatus="status">
							<c:choose>
								<c:when test="${status.first}">
									<option selected="selected" value='${visit.histId}'>
										${visit.datetime}
										<script type="text/javascript">
											getCheckInfo('${visit.histId}');
										</script>

									</option>
								</c:when>
								<c:otherwise>
									<option value='${visit.histId}'>${visit.datetime}</option>
								</c:otherwise>

							</c:choose>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<option selected="selected" value=>방문 정보가 없습니다.</option>
					</c:otherwise>
				</c:choose>
		</select></td>
		<!-- 
			<input type="button" id="btnMode" onclick="fncCheckWrite();return false;" value="편집모드"></input>
			<button id="btnEdit" onclick="fncSaveEdit();return false;">수정하여저장</button>
			<button id="btnSave" onclick="fncSave();return false;">오늘날짜로저장</button> -->
		<!-- <td height="40" bgcolor="#FFFFFF" class="c1" align="right">
							<input id="Toggle" type="checkbox">
								<label for="Toggle" onclick="toggle()"><span>.</span></label>
							<a></a>
		</td> -->
	</tr>
</table>
<br>