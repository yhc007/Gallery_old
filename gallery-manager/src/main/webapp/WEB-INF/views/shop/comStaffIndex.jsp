<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	$(function(){
		comList();
		fncListStaffData(1);
	});

	function comList(){
		var url = "${ctxPath}/company/selectCompanyData.do";

		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#listStaffForm2 select[id='iNum']").html(data);
				$("#iNumForm select[id='iNum']").append(data);
			}
		});
	};

	function fncListStaffData(no){
		var url = '${ctxPath}/staff/listComStaffData.do';
		if(no){
			jQuery('#listStaffForm1 input[name=currentPage]').val(no);
		}
		var param = jQuery('#listStaffForm1').serialize() + "&iNum=" + $("#iNumForm select[id='iNum']").val();

		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listStaffDiv').html(data);
			}

		});
		 fncStaffDetailClear();
	}




	/*
	 * 밸리데이션 체크
	 */

	function fncCheckValidation(){
		if(listStaffForm2.staffName.value==""){
			alert('<spring:message code="validation.put" arguments="이름을"/>');
			return false;
		}

		if(listStaffForm2.iNum.value=="-1"){
			alert('<spring:message code="validation.select" arguments="매장을"/>');
			return false;
		}
		return true;
	}

	/*
	 * 고객 데이타 저장.
	 */
	function fncSaveStaffAction(){
		if(!fncCheckValidation()){
			return;
		}
		var url;
		var msg;
		var no;
		console.log('jQuery staffId :'+jQuery('#listStaffForm2 input[name=staffId]').val());

		if(jQuery('#listStaffForm2 input[name=staffId]').val() == ""){
			url = '${ctxPath}/staff/addComStaffAction.do'; // 추가
			no = 1;
		}else{
			console.log("수정");
			url = '${ctxPath}/staff/modifyComStaffAction.do'; // 수정
			no = jQuery('#listCstmrForm1 input[name=currentPage]').val();
		}
		console.log('staffId:'+$('#staffId').val());
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#listStaffForm2').serialize(),
			dataType	: "text",
			beforeSend	: function(){

			},
			success: function(data){
				if(data=="fail"){
					alert('<spring:message code="fail" />');
				}else if(data=="upsuccess"){
					console.log("success");
					alert("등록하였습니다.")
					 //성공시....
					//fncStaffDetailClear();
					//fncListStaffData();

				}else if(data=="modified"){
				 alert("수정하였습니다.");
			}
			}
		});

	}

	//삭제
	function fncDelStaff(){
		if(!confirm('<spring:message code="del.confirm" />')){
			return;
		}
		if(jQuery('#listStaffForm2 input[name=staffId]').val() == ""){
			return;
		}

		var url = '${ctxPath}/staff/removeStaffAction.do';

		var param = jQuery('#listStaffForm2').serialize();

		//javax
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: param,
			dataType	: "text",
			beforeSend	: function(){
			},
			success: function(data){
				if(data == "success"){
					alert('<spring:message code="del.success" />');
					fncStaffDetailClear();
					fncListStaffData();
				}else if(data == "fail"){
					alert('<spring:message code="fail" />');
				}else if(data == "exist"){
					alert('<spring:message code="del.exist" arguments="브랜드,상품이"/>');
				}

				  //성공시....

			}

		});

	}



	/*
	 * html 클리어
	 */
	function fncStaffDetailClear(){
		 //jQuery('#listCstmrForm2 input[name=cstmrId]').val('');
		 jQuery('#listStaffForm2 input[name=staffId]').val('');
		 jQuery('#listStaffForm2 input[name=staffName]').val('');
		 jQuery('#listStaffForm2 select[name=shopId]').val('-1');
		 jQuery('#listStaffForm2 input[name=position]').val('');
		 jQuery('#listStaffForm2 input[name=phone]').val('');
		 jQuery('#listStaffForm2 input[name=email]').val('');

		 /*
		 var viewForm = jQuery('#listStaffForm2');
		 viewForm.find('span[id=staffIdSpan]').text('');
		 viewForm.find('span[id=updDttm]').text('');
		 viewForm.find('span[id=upderNm]').text('');
		 viewForm.find("*").removeClass('formError'); // validation CSS 제거
		 */
	}


	/*
	 * 신규시
	 */
	function fncNewStaff(){

		fncStaffDetailClear();

	}

	/*
	 * 고객 상세
	 */
	function fncGetStaffInfo(staffId){
		 var url = '${ctxPath}/staff/getComStaffData.do';

		 //var userId = $('#userId').getValue();

		 jQuery.ajax({
				url: url,
				type : "post",
				data : "staffId=" + staffId,
				dataType	: "json",
				beforeSend	: function(){
				},
				success		: function(data){
					 //clear
					 fncStaffDetailClear();
					 //-----------------------------
					 //-----------------------------
					 var viewForm = jQuery('#listStaffForm2');

					 //viewForm.deserialize(data);
					jQuery('#listStaffForm2 input[name=staffId]').val(data.staffId);
					jQuery('#listStaffForm2 select[name=iNum]').val(data.shopId);
		 			jQuery('#listStaffForm2 input[name=staffName]').val(data.staffName);
		 			jQuery('#listStaffForm2 input[name=position]').val(data.position);
		 			jQuery('#listStaffForm2 input[name=phone]').val(data.phone);
		 			jQuery('#listStaffForm2 input[name=email]').val(data.email);

					 /*
					 viewForm.find('span[id=cstmrIdSpan]').text(data.cstmrId);
					 viewForm.find('span[id=updDttm]').text(data.updDttm);
					 viewForm.find('span[id=upderNm]').text(data.upderNm);

					 $('#cstmrId').val(data.cstmrId);
					 $('#cstmrNm').val(data.cstmrNm);
					 $('#cstmrTyCd').val(data.cstmrTyCd);


					 if(data.zip==null){
					 }else{
				  	 	$('#zipCd1').val(data.zipCd1);
				 	 	$('#zipCd2').val(data.zipCd2);
					 }
					 $('#dtlAddr1').val(data.dtlAddr1);
					 $('#dtlAddr2').val(data.dtlAddr2);
					 $('#email').val(data.email);

					 $('#tel').val(data.tel);
					 $('#bigo').val(data.bigo);
					 $('#upderId').val(data.upderId);
					 */
					 //readOnly

				}

			});
	}
</script>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<div id="content">

		<form name="listStaffForm1"  id="listStaffForm1" method="post" action="">

			<input type="hidden" name="currentPage" value="1"/>
			<input type="hidden" name="pageSize" value="5"/>


				<table width="100%" class="search" id="listTable" border="1">
					<tbody>
					<tr id="listTr" >
						<th style="width:20%" class="header"><label for="searchName">직원 명</label></th>
						<td style="width:80%">
							<input type="text" id="staffName" name="staffName">
							<button onclick="fncListStaffData('1');return false;">조회</button>
						</td>
					</tr>
					</tbody>
				</table>
			</form>

			<form action="" id="iNumForm">
				<select id="iNum" onclick='fncListStaffData(1)'>
					<option value="-1">전체</option>
				</select>
			</form>
		<form name="listStaffForm2"  id="listStaffForm2" method="post" action="" enctype="multipart/form-data">
			<input type="hidden" id='staffId' name='staffId'>

			<div id="listStaffDiv">
			</div>

			<table>
			<tr>
			<td>
				<img src="<c:url value="/images/content/dot.png"/>" />
			</td>
			<td>
				<p>직원 정보</p>
			</td>
			</tr>
			</table>

			<table width="100%" border="1" class="detail">
				<br>
				<tbody>

				<tr>
					<th style="width:20%"><label for="">이름*</label></th>
					<td style="width:30%">
						<input type="text" id='staffName' name='staffName' title='이름' onkeydown="if (event.keyCode == 13){return false;}">
					</td>
					<th style="width:20%"><label for="">소속 매장*</label></th>
					<td style="width:30%">
						<select id='iNum' name='iNum' title='타입'>
							<option value="-1">선택</option>
						</select>
					</td>
				</tr>
				<tr>
					<th style="width:20%"><label for="">전화번호</label></th>
					<td style="width:30%">
						<input type="text" id='phone' name='phone' title='전화번호' onkeydown="if (event.keyCode == 13){return false;}">
					</td>
					<th style="width:20%"><label for=""></label></th>
					<td style="width:30%">

					</td>
				</tr>
			</table>


			<br>
			<div id="btn_sctn" align="right">
				<button onclick="fncNewStaff();return false;">신규</button>
				<button onclick="fncSaveStaffAction();return false;">저장</button>
				<button onclick="fncDelStaff();return false;">삭제</button>
			</div>

	</form>
	</div>
</body>
</html>
