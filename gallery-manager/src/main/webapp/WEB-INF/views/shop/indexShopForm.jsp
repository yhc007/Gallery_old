<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<%-- <script type="text/javascript" src="${ctxPath}/js/swfu/swfupload.js"></script>
<script type="text/javascript" src="${ctxPath}/js/swfu/fileprogress.js"></script>
<script type="text/javascript" src="${ctxPath}/js/swfu/handlers.js"></script>
<script type="text/javascript" src="${ctxPath}/js/swfu/swfupload.queue.js"></script> --%>
<script>

	//----------------------
	//화면 초기 실행

	var swfu; // 파일업로드
	var settings;
	var uploadedCnt=0;
	var dbCnt=0;
	var allowCnt=1;
	var queueCnt=0;
	var tabNumber=0;
	var isFull=0;
	var deleteArr=[];
	var darrSize=0;
	jQuery(document).ready(function(){
		fncListShopData(1);

		/* var uploadedFileCnt = 0; // 현재 업로드된 파일 카운트는 글쓰기 폼이므로 없다.
		var allowFileCnt = 1;  //'${board.fileCnt}'; // 업로드 허용갯수
		var formName = 'excelDeviceInfoUploadForm'; // 폼이름

		settings = {
			flash_url : '${ctxPath}/js/swfu/swfupload.swf',
			//upload_url: '${ctxPath}/staff/addStaffPhotoAction.do',
			upload_url: '${ctxPath}/shop/addStampPhotoAction.do',
			file_post_name: 'files', // 파일 업로드 파라미터 이름
			post_params: { // 업로드시 추가적으로 보낼 파라미터
				mediaId : $('#shopId').val()
			},
			file_size_limit : "100MB", // 파일 업로드 사이즈 제한, B,KB,MB,GB 단위 가능
			file_types : "*.jpg;*.gif;*.png",  // *.jpg;*.gif
			file_types_description : "All Files", // 이미지 파일
			file_upload_limit : '0', // 한번에 업로드 가능한 갯수
			file_queue_limit : 0, // 전송 대기 갯수 0 은 무제한
			custom_settings : { // 추가적으로 사용할 변수
				uploadedFileCnt: uploadedFileCnt, // 이미 업로드된 파일 갯수
				allowFileCnt : allowFileCnt,
				formName : formName
			},
			debug: false,
			// 버튼 셋팅
			button_image_url : '${ctxPath}/js/swfu/SmallSpyGlassWithTransperancy_17x18.png',
			button_placeholder_id : "stampButtonPlaceholder",
			button_width: 17,
			button_height: 18,
			button_cursor : SWFUpload.CURSOR.HAND,
			button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,

			// 이벤트 핸들러 셋팅
			swfupload_loaded_handler : swfUploadLoaded,
			file_queued_handler : fileQueued, // 파일 탐색 창에서 파일들을 선택후 선택된 각각의  파일들이 큐에 준비가 될때 불려짐(파일을 5개 선택하면 5번 불려짐)
			file_queue_error_handler : fileQueueError, // 큐이 쌓다가 에러났을때
			upload_start_handler : uploadStart, // 단일 파일의 업로드가 시작될때
			upload_progress_handler : uploadProgress, // 단일 파일의 업로드 중일때
			upload_error_handler : uploadError, // 업로드중 에러가 발생 했을때
			upload_success_handler : uploadSuccess, // 단일 파일의 업로드가 성공 했을때
			queue_complete_handler : queueComplete,	// 큐에 들어있는 모든 파일 전송 처리가 끝났을때(에러와 상관없이)

			// SWFObject settings
			minimum_flash_version : "9.0.28",
			swfupload_load_failed_handler : swfUploadLoadFailed
		};
		swfu = new SWFUpload(settings); */
	});

	//----파일 업로드 콜백 함수--
	//----------------------
	function queueComplete(numFilesUploaded)
	{
		//uploadedCnt+=numFilesUploaded;
		alert('<spring:message code="add.success" />');

		 //성공시....
		//fncStaffDetailClear();
		//fncListStaffData(1);
		fncShopDetailClear();
		fncListShopData();

		jQuery('#queuedFiles li').remove();
		//getMedias($('#mediaTyCd').val());

		queueCnt=0;
		swfu.setButtonDisabled(false);

	}

	/*
	 * 업로드 준비중인 파일 업로드 취소
	 */
	function deleteQueueFile(fileId){
		//alert(fileId);
		swfu.cancelUpload(fileId);
		jQuery('#'+fileId).remove();

		queueCnt=queueCnt-1;
		isFull=0;
		swfu.setButtonDisabled(false);
	}

	function saveVodCd(){

	}
	function startSubmitFn(data){

		console.log('run startSubmitFn-data:'+data);


		swfu.removePostParam('shopId');
		swfu.addPostParam('shopId',data);

		var i=0;
		for(i=0;i<darrSize;i++){
			deleteQueueFile(deleteArr[i]);
		}
		deleteArr=[];
		darrSize=0;

		var cnt = jQuery('#queuedFiles li').length;
		if(cnt > 0){
			// 파일 선택을 못하도록 한다.
			swfu.setButtonDisabled(true);
			swfu.startUpload();
		} else{
			alert('파일을 선택하세요');
		}
	 }

	function updateListSize(size){
		dbCnt=size;
		queueCnt=0;
		if(tabNumber==1){

			swfu.cancelUpload(null,false);
			allowCnt = 1;
			var uploadedFileCnt = swfu.customSettings['uploadedFileCnt'];
			//alert("uploaded"+uploadedCnt);
			//swfu.customSettings['uploadedFileCnt'] = 0;
			swfu.customSettings['allowFileCnt'] = 1;
			swfu.setFileUploadLimit(0);
			swfu.setFileQueueLimit(0);
			swfu.setFileTypes("*.jpg;*.gif;*.png","img");
			//swfu.setFileUploadLimit(5);
		}else if(tabNumber==2){

			swfu.cancelUpload(null,false);
			allowCnt = 40;
			var uploadedFileCnt = swfu.customSettings['uploadedFileCnt'];
			//alert("uploaded"+uploadedCnt);
			//swfu.customSettings['uploadedFileCnt'] = 0;
			swfu.customSettings['allowFileCnt'] = 40;
			swfu.setFileUploadLimit(0);
			swfu.setFileQueueLimit(0);
			swfu.setFileTypes("*.jpg;*.gif;*.png","img");

		}else if(tabNumber==3){
			/*
			swfu.cancelUpload(null,false);
			allowCnt = 1;
			var uploadedFileCnt = swfu.customSettings['uploadedFileCnt'];
			//alert("uploaded"+uploadedCnt);
			//swfu.customSettings['uploadedFileCnt'] = 0;
			swfu.customSettings['allowFileCnt'] = 1;
			swfu.setFileUploadLimit(0);
			swfu.setFileQueueLimit(0);
			swfu.setFileTypes("*.avi;*.mp4;*.wmv;*.m4v","movie");
			*/
		}


	}

	/*
	 * 파일이 큐에 찰때
	 */


	function fileQueued(file) {
		if(isFull==1){
			deleteArr[darrSize]=file.id;
			darrSize++;
			return;
		}

		queueCnt=queueCnt+1;
		if(allowCnt<((dbCnt*1)+(queueCnt*1))){
			isFull=1;
			queueCnt=queueCnt-1;
			swfu.fileQueueError(null, SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED, null);
			swfu.setButtonDisabled(true);
			deleteArr[darrSize]=file.id;
			darrSize++;
			return;
		}
		try {

			__ATT_DEL_IMG__ = "${ctxPath}/images/icon_del.gif";
			//var ii=file.id;
			//var qq=__ATT_DEL_IMG__;
			var imgUrl = ' <a href="#" onclick="deleteQueueFile(\''+file.id+'\'); return false;" ><img src="'+__ATT_DEL_IMG__+'" width="12" height="12" border="0" align="middle"  alt="파일삭제"/></a>';
			jQuery('#queuedFiles').append('<li id="'+file.id+'" class="attFile">'+file.name+imgUrl+' <span></span><div style="height:3px; display:none" class="ui-widget-header"></div></li>');

		} catch (ex) {
			console.log(ex);
			this.debug(ex);
		}

	}

	function fncDelImg(){
		//alert(mediaId);

		var url = '${ctxPath}/shop/removeStampAction.do'; // 수정;
		var msg;

		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: "shopId="+$('#shopId').val(),
			dataType	: "text",
			beforeSend	: function(){

			},
			success: function(data){
				if(data=="fail"){
					alert("삭제 실패 하였습니다.");
				}else if(data=="success"){
					document.getElementById("img_div").style.display = 'none';
					$("#queuedFiles").attr("disabled",false);
					//swfu.setButtonDisabled(false);

					alert("삭제 성공하였습니다.");
				}
			}
		});
	}

	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncListShopData(no){
		var url = 'listShopData.do';
		if(no){
			jQuery('#listShopForm1 input[name=currentPage]').val(no);
		}
		var param = jQuery('#listShopForm1').serialize();

		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){

				jQuery('#listShopDiv').html(data);
			}

		});
		 fncShopDetailClear();

	}




	/*
	 * 고객 데이타 저장.
	 */
	function fncSaveShopAction(){

		var url;
		var msg;
		var no;

		if(jQuery('#listShopForm2 input[name=shopId]').val() == ""){
			url = '${ctxPath}/shop/addShopAction.do'; // 추가
			no = 1;
		} else{
			url = '${ctxPath}/shop/modifyShopAction.do'; // 수정
			no = jQuery('#listCstmrForm1 input[name=currentPage]').val();
		}
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#listShopForm2').serialize(),
			dataType	: "json",
			beforeSend	: function(){

			},
			success: function(data){
				if(data.result=="duple"){
					alert("동일한 매장 명이 등록되어있습니다.");
				}else if(data.result=="addsuccess"){
					alert("등록 하였습니다.");
					var chkShopId = data.shopId;
					$('#shopId').val(chkShopId);
					var form = new FormData(document.getElementById('listShopForm2'));
					$.ajax({ url: "${ctxPath}/shop/addStampPhotoAction.do",
							 data: form,
					    dataType: 'text',
					 processData: false,
					 contentType: false,
					        type: 'POST',
					     success: function () {location.reload();}
					 });
					//var cnt = jQuery('#queuedFiles li').length;
					//console.log("cnt:"+cnt);
					//if(cnt>0){
					//	startSubmitFn(data.shopId);
					//}
				}else if(data.result=="fail"){
					alert("실패하였습니다.");
				}else if(data.result=="upsuccess"){
					alert("수정 하였습니다.");
					var form = new FormData(document.getElementById('listShopForm2'));
					$.ajax({ url: "${ctxPath}/shop/addStampPhotoAction.do",
							 data: form,
					    dataType: 'text',
					 processData: false,
					 contentType: false,
					        type: 'POST',
					     success: function () {location.reload();}
					 });
					//var cnt = jQuery('#queuedFiles li').length;
					//if(cnt>0){
					//	startSubmitFn($('#shopId').val());
					//}
				}
				  //성공시....
				fncShopDetailClear();
				fncListShopData();
			}

		});

	}

	//삭제
	function fncDelShop(){

		if(jQuery('#listShopForm2 input[name=shopId]').val() == ""){
			return;
		}

		var url = '${ctxPath}/shop/removeShopAction.do';

		var param = jQuery('#listShopForm2').serialize();

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
					fncShopDetailClear();
					fncListShopData();
					$("#queuedFiles").attr("disabled",false);
				}else if(data == "fail"){
				}

				  //성공시....

			}

		});

	}



	/*
	 * html 클리어
	 */
	function fncShopDetailClear(){
		 //jQuery('#listCstmrForm2 input[name=cstmrId]').val('');

		 jQuery('#listShopForm2 input[name=shopId]').val('');
		 jQuery('#listShopForm2 input[name=shopName]').val('');
		 jQuery('#listShopForm2 input[name=telephone]').val('');
		 jQuery('#listShopForm2 select[name=shopStatTyCd]').val('00500001');
		 jQuery('#listShopForm2 input[name=lat]').val('');
		 jQuery('#listShopForm2 input[name=lot]').val('');
		 jQuery('#listShopForm2 input[name=addr]').val('');
		 jQuery('#listShopForm2 input[name=fax]').val('');
		 jQuery('#listShopForm2 input[name=cNum]').val('');
		 jQuery('#listShopForm2 input[name=cName]').val('');
		 document.getElementById("img_div").style.display = 'none';
		 $("#queuedFiles").attr("disabled",false)

		 /*
		 var viewForm = jQuery('#listShopForm2');
		 viewForm.find('span[id=shopIdSpan]').text('');
		 viewForm.find('span[id=updDttm]').text('');
		 viewForm.find('span[id=upderNm]').text('');
		 viewForm.find("*").removeClass('formError'); // validation CSS 제거
		 */
	}


	/*
	 * 신규시
	 */
	function fncNewShop(){

		fncShopDetailClear();

	}

	/*
	 * 고객 상세
	 */
	function fncGetShopInfo(shopId){
		 var url = '${ctxPath}/shop/getShopData.do';
		 //var userId = $('#userId').getValue();

		 jQuery.ajax({
				url: url,
				type : "post",
				data : "shopId=" + shopId,
				dataType	: "json",
				beforeSend	: function(){
				},
				success		: function(data){
					console.log(data)
					//clear
					 fncShopDetailClear();
					 //-----------------------------
					 //-----------------------------
					 var viewForm = jQuery('#listShopForm2');

					 //viewForm.deserialize(data);

					 jQuery('#listShopForm2 input[name=shopId]').val(data.shopId);
					 jQuery('#listShopForm2 input[name=shopName]').val(data.shopName);
					 jQuery('#listShopForm2 input[name=telephone]').val(data.telephone);
					 jQuery('#listShopForm2 select[name=shopStatTyCd]').val(data.shopStatTyCd);
					 jQuery('#listShopForm2 input[name=lat]').val(data.lat);
					 jQuery('#listShopForm2 input[name=lot]').val(data.lot);

					 jQuery('#listShopForm2 input[name=fax]').val(data.fax);
					 jQuery('#listShopForm2 input[name=addr]').val(data.addr);
					 jQuery('#listShopForm2 input[name=cName]').val(data.cname);
					 jQuery('#listShopForm2 input[name=cNum]').val(data.cnum);
					 if(data.stampImgPath!=null){
						 	document.listShopForm2.stampImg.src=data.stampImgPath;
			 				document.getElementById("img_div").style.display = 'inline';
			 				//swfu.setButtonDisabled(true);
			 				$("#queuedFiles").attr("disabled",true)
			 			}else{
			 				//swfu.setButtonDisabled(false);
			 				$("#queuedFiles").attr("disabled",false)
			 			}
					 /*
					 $('#shopId').val(data.shopId);
					 $('#shopName').val(data.shopName);
					 $('#shopId').val(data);
					 $('#shopName').val('');
					 $('#telephone').val('');
					 $('#shopstateCd').val('00500001');
					 $('#lat').val('');
					 $('#lot').val('');
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
	/*
	 *이미지확인
	 */
	function checkFile(text){
		var file = text.files;
		if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)) {
			alert('gif, jpg, png, gif 파일만 선택해 주세요.');
			text.outerHTML = text.outerHTML;
		}else {
			$('#queuedFiles').css('color','red');
			chkFileName=file[0].name;
		}

	}
</script>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<div id="content">

			<form name="listShopForm1"  id="listShopForm1" method="post" action="">

				<input type="hidden" name="currentPage" value="1"/>
				<input type="hidden" name="pageSize" value="5"/>


					<table width="100%" border="1" class="search">
						<tbody>
						<tr>
							<th style="width:20%"><label for="searchName">매장 명</label></th>
							<td style="width:80%">
								<input style="width:25%" type="text" id="shopName" name="shopName">
								<button onclick="fncListShopData('1');return false;">조회</button>
							</td>
						</tr>
						</tbody>
					</table>

 			</form>
			<form name="listShopForm2"  id="listShopForm2" method="post" action="">
					<input type="hidden" id='shopId' name='shopId'>

					 <div id=listShopDiv align="left"></div>


					<table>
					<tr>
					<td>
						<img src="<c:url value="/images/content/dot.png"/>" />
					</td>
					<td>
						<p>매장 정보</p>
					</td>
					</tr>
					</table>

					<table width="100%" border="1" class="detail">
						<br>
						<tbody>

						<tr>
							<th style="width:20%"><label for="">매장 명</label></th>
							<td style="width:30%">
								<input type="text" id='shopName' name='shopName' title='매장 명'>
							</td>
							<th style="width:20%"><label for="">운영 상태</label></th>
							<td style="width:30%">
								<select id="shopStatTyCd" name="shopStatTyCd">
									<option value="00500001">운영 중</option>
									<option value="00500002">운영 중지</option>
								</select>
							</td>
						</tr>
						<tr>
							<th><label for="">전화번호</label></th>
							<td>
								<input type="text" id='telephone' name='telephone' title='전화번호'>
							</td>
							<th>주소</th>
							<td>
								<input type="text" id="addr" name="addr">
							</td>
						</tr>
						<tr>
							<th>FAX</th>
							<td>
								<input type="text" id="fax" name="fax">
							</td>
							<th>사업자 등록번호</th>
							<td>
								<input type="text" id="cNum" name="cNum">
							</td>
						</tr>
						<tr>
							<th>사업주</th>
							<td>
								<input type="text" id="cNam" name="cName">
							</td>
							<th>도장등록</th>
							<td>
								<!-- <ul class="file" id="queuedFiles" style='color:red'></ul>
									<span id="stampButtonPlaceholder"></span> -->
								<input type="file" id="queuedFiles"  name="queuedFiles" onchange="checkFile(this)"  placeholder="파일 선택" /><br/>
							</td>
						</tr>
						<tr>
							<th><label for="">위도</label></th>
							<td>
								<input type="text" id='lat' name='lat' title='전화번호'>
							</td>
							<th><label for="">경도</label></th>
							<td>
								<input type="text" id='lot' name='lot' title='전화번호'>
							</td>
						</tr>
						<tr>
							<th>사진</th>
							<td colspan="3" align="center" valign="center">
								<div id="img_div">
									<img id="stampImg" width=200/> <a href="#" onclick="fncDelImg();return false;">삭제</a>
								</div>
							</td>
						</tr>
						</tbody>
					</table>

					<div id="btn_sctn" align="right">
						<button onclick="fncNewShop();return false;">신 규</button>
						<button onclick="fncSaveShopAction();return false;">저 장</button>
						<button onclick="fncDelShop();return false;">삭 제</button>
					</div>
			</form>


		</div>
</body>
</html>
