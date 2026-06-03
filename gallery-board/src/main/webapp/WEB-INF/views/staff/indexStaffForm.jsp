
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>


<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script type="text/javascript" src="${ctxPath}/js/swfu/swfupload.js"></script>
<script type="text/javascript" src="${ctxPath}/js/swfu/fileprogress.js"></script>
<script type="text/javascript" src="${ctxPath}/js/swfu/handlers.js"></script>
<script type="text/javascript" src="${ctxPath}/js/swfu/swfupload.queue.js"></script>
<script>

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
	

	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		
		
		var uploadedFileCnt = 0; // 현재 업로드된 파일 카운트는 글쓰기 폼이므로 없다.
		var allowFileCnt = 1;  //'${board.fileCnt}'; // 업로드 허용갯수
		var formName = 'excelDeviceInfoUploadForm'; // 폼이름
		settings = {
			flash_url : '${ctxPath}/js/swfu/swfupload.swf',
			upload_url: '${ctxPath}/staff/addStaffPhotoAction.do',
			file_post_name: 'files', // 파일 업로드 파라미터 이름
			post_params: { // 업로드시 추가적으로 보낼 파라미터
				mediaId : $('#staffId').val()
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
			button_placeholder_id : "spanButtonPlaceholder",
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
		swfu = new SWFUpload(settings);
		
		
		fncListStaffData(1);
	});
	//----------------------
	
	/*
	 * 큐에 있는 모든 파일의 업로드가 끝날때
	 */
	function queueComplete(numFilesUploaded) 
	{
		//uploadedCnt+=numFilesUploaded;
		alert('<spring:message code="add.success" />');
				
		 //성공시....
		fncStaffDetailClear();
		fncListStaffData(1);
		
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
		
		if(data=='-1'){
			data=jQuery('#listStaffForm2 input[name=staffId]').val();
		}
		swfu.removePostParam('staffId');
		swfu.addPostParam('staffId',data);
		
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
		
		var url = '${ctxPath}/staff/removePhotoAction.do'; // 수정;
		var msg;
		
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: "staffId="+jQuery('#listStaffForm2 input[name=staffId]').val(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="fail"){
					alert("삭제 실패 하였습니다.");
				}else if(data=="success"){
					img_div.style.display='none';
					swfu.setButtonDisabled(false);
					
					alert("삭제 성공하였습니다.");				
				}
			}
			
		});
	}
	function goPrdctScreen(){
		
		jQuery('#listMediaForm1').attr('method', 'post');
		jQuery('#listMediaForm1').attr('action', '${ctxPath}/prdct/indexPrdctForm.do');
		jQuery('#listMediaForm1').submit(); 
	}
	
	function getMedias(mediaTy){
		var url = '${ctxPath}/media/listMediaData.do';
		$.ajax({
			url		: url,
			type 	: "post",
			data 	: "prdctId="+$('#prdctId').val()+"&mediaTyCd="+mediaTy+"&color="+jQuery('#listMediaForm1 input[name=colorCd]').val(),
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listMediaBody').html(data);
			}
			
		});  
	}
	
	
	
	function showTabMenu(n){
		var conId; 
		isFull=0;
		tabNumber=n;
		if(n==1){
			tab_media.style.display='';
			if('${prdct.prdctTyCd}'=='00300001'){
				frame_still.style.display='';	
			}			
			tab_vod_code.style.display='none';
			document.getElementById("img_title").innerHTML='이미지 등록';
			$('#mediamenu1').css("background", "url(${ctxPath}/images/middle/selected.png)");
			$('#mediamenu1').css("background-repeat", "no-repeat");
			$('#mediafont1').css("color", "white");
			
			$('#mediamenu2').css("background", "url(${ctxPath}/images/middle/dselected.png)");
			$('#mediamenu2').css("background-repeat", "no-repeat");
			$('#mediafont2').css("color", "black");
			$('#mediamenu3').css("background", "url(${ctxPath}/images/middle/dselected.png)");
			$('#mediamenu3').css("background-repeat", "no-repeat");
			$('#mediafont3').css("color", "black");
			
			
			$('#mediaTyCd').val('00200001');
			getMedias('00200001');
			
			swfu.removePostParam('mediaTyCd');
			swfu.addPostParam('mediaTyCd',$('#mediaTyCd').val());
			jQuery('#queuedFiles li').remove();
			swfu.setButtonDisabled(false);
		}else if(n==2){
			tab_media.style.display='';
			if('${prdct.prdctTyCd}'=='00300001'){
				frame_still.style.display='none';	
			}			
			tab_vod_code.style.display='none';
			document.getElementById("img_title").innerHTML='이미지 등록';
			
			$('#mediamenu2').css("background", "url(${ctxPath}/images/middle/selected.png)");
			$('#mediamenu2').css("background-repeat", "no-repeat");
			$('#mediafont2').css("color", "white");
			
			$('#mediamenu1').css("background", "url(${ctxPath}/images/middle/dselected.png)");
			$('#mediamenu1').css("background-repeat", "no-repeat");
			$('#mediafont1').css("color", "black");
			$('#mediamenu3').css("background", "url(${ctxPath}/images/middle/dselected.png)");
			$('#mediamenu3').css("background-repeat", "no-repeat");
			$('#mediafont3').css("color", "black");
			
			$('#mediaTyCd').val('00200002');
			getMedias('00200002');
			
			swfu.removePostParam('mediaTyCd');
			swfu.addPostParam('mediaTyCd',$('#mediaTyCd').val());
			jQuery('#queuedFiles li').remove();
			swfu.setButtonDisabled(false);
		}else if(n==3){
			
			document.getElementById("img_title").innerHTML='유튜브 코드';
			
			$('#mediamenu3').css("background", "url(${ctxPath}/images/middle/selected.png)");
			$('#mediamenu3').css("background-repeat", "no-repeat");
			$('#mediafont3').css("color", "white");
			
			$('#mediamenu1').css("background", "url(${ctxPath}/images/middle/dselected.png)");
			$('#mediamenu1').css("background-repeat", "no-repeat");
			$('#mediafont1').css("color", "black");
			$('#mediamenu2').css("background", "url(${ctxPath}/images/middle/dselected.png)");
			$('#mediamenu2').css("background-repeat", "no-repeat");
			$('#mediafont2').css("color", "black");
			
			
			tab_media.style.display='none';
			if('${prdct.prdctTyCd}'=='00300001'){
				frame_still.style.display='none';	
			}
			tab_vod_code.style.display='';
			$('#mediaTyCd').val('00200003');
			//getMedias('00200003');
			getVideoCode();
		}
		
		
	} 
	
	
	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncListStaffData(no){
		var url = 'listStaffData.do';
		if(no){
			jQuery('#listStaffForm1 input[name=currentPage]').val(no);
		}					  	
		var param = jQuery('#listStaffForm1').serialize();
		 
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
		
		if(listStaffForm2.shopId.value=="-1"){
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
		if(jQuery('#listStaffForm2 input[name=staffId]').val() == ""){
			url = '${ctxPath}/staff/addStaffAction.do'; // 추가
			no = 1;
		} else{
			url = '${ctxPath}/staff/modifyStaffAction.do'; // 수정
			no = jQuery('#listCstmrForm1 input[name=currentPage]').val();
		}
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
					console.log("success")
					alert('<spring:message code="update.success" />');
					 //성공시....
					fncStaffDetailClear();
					fncListStaffData();
					
					var cnt = jQuery('#queuedFiles li').length;
					if(cnt>0){
						startSubmitFn('-1');
					}
				}else{
					var cnt = jQuery('#queuedFiles li').length;
					if(cnt>0){
						startSubmitFn(data);
					}
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
		 document.listStaffForm2.staffImg.src='';
		 img_div.style.display='none';
		 
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
		 var url = '${ctxPath}/staff/getStaffData.do';
		 
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
					 jQuery('#listStaffForm2 select[name=shopId]').val(data.shopId);
		 			 jQuery('#listStaffForm2 input[name=staffName]').val(data.staffName);
		 			jQuery('#listStaffForm2 input[name=position]').val(data.position);
		 			jQuery('#listStaffForm2 input[name=phone]').val(data.phone);
		 			jQuery('#listStaffForm2 input[name=email]').val(data.email);
					
		 			if(data.imgPath!=null){
		 				document.listStaffForm2.staffImg.src=data.urlStr+data.imgPath;
		 				img_div.style.display='';
		 				swfu.setButtonDisabled(true);
		 			}else{
		 				swfu.setButtonDisabled(false);
		 			}
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
						<th style="width:20%" class="header"><label for="searchName">점원 명</label></th>
						<td style="width:80%">
							<input type="text" id="staffName" name="staffName">
							<button onclick="fncListStaffData('1');return false;">조회</button>
						</td>
					</tr>
					</tbody>
				</table>

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
				<p>점원 정보</p>
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
					<th style="width:20%"><label for="">소속 지점*</label></th>
					<td style="width:30%">
						<select id='shopId' name='shopId' title='타입'>
							<option value="-1">선택</option>
							<c:forEach items="${listShop}" var="item" varStatus="status">
								<option value="${item.shopId}">${item.shopName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th style="width:20%"><label for="">직급</label></th>
					<td style="width:30%">
						<input type="text" id='position' name='position' title='직급' onkeydown="if (event.keyCode == 13){return false;}">
					</td>
					<th style="width:20%"><label for="">전화번호</label></th>
					<td style="width:30%">
						<input type="text" id='phone' name='phone' title='전화번호' onkeydown="if (event.keyCode == 13){return false;}">
					</td>
				</tr>
				<tr>
					
					<th><label for="">메일 주소</label></th>
					<td>
						<input type="text" id='email' name='email' title='메일 주소' onkeydown="if (event.keyCode == 13){return false;}">
					</td>
					<th><label for="">이미지 등록</label></th>
					<td>
						<ul class="file" id="queuedFiles" style='color:red'></ul> 
									<span id="spanButtonPlaceholder"></span>
					</td>
				</tr>
				<tr>
					
					<th>사진</th>
					<td colspan="3" align="center" valign="center">
						<div id="img_div">
							<img id="staffImg" width=200/> <a href="#" onclick="fncDelImg();return false;">삭제</a>
						</div>
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
