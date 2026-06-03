<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>



<html>
<head>
	<title>Home</title>
	
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
		// 파일업로드 설정	
		// 파일업로드 설정	
		
		 $('#prdctId').val("${prdct.prdctId}");
		
		if('${prdct.prdctTyCd}'!='00300001'){
			frame_still.style.display='none';	
			jQuery('#listMediaForm1 input[name=colorCd]').val('basic');
		}
		 
		var uploadedFileCnt = 0; // 현재 업로드된 파일 카운트는 글쓰기 폼이므로 없다.
		var allowFileCnt = 1;  //'${board.fileCnt}'; // 업로드 허용갯수
		var formName = 'excelDeviceInfoUploadForm'; // 폼이름
		settings = {
			flash_url : '${ctxPath}/js/swfu/swfupload.swf',
			upload_url: '${ctxPath}/media/addMediaAction.do',
			file_post_name: 'files', // 파일 업로드 파라미터 이름
			post_params: { // 업로드시 추가적으로 보낼 파라미터
				
				mediaId : $('#mediaId').val(),
				prdctId : $('#prdctId').val(),
				prdctCd : $('#colorCd').val(),
				mediaTyCd : $('#mediaTyCd').val()
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
		
		//getMedias('00200001');
		if('${prdct.prdctTyCd}'=="<%=CommonCode.CODE_PRDCT_TY_FRAME%>"){
			loadColorItem();
		}else{
			getMedias('00200001');
		}
	});
	//----------------------
	
	/*
	 * 큐에 있는 모든 파일의 업로드가 끝날때
	 */
	function queueComplete(numFilesUploaded) 
	{
		uploadedCnt+=numFilesUploaded;
		alert("파일을 업로드 하였습니다.");
		jQuery('#queuedFiles li').remove();
		getMedias($('#mediaTyCd').val());
		
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
	function startSubmitFn(){
		if($('#colorCd').val()==''){
			if($('#mediaTyCd').val()=='00200001'){
				alert('<spring:message code="validation.select" arguments="색상을"/>');
				return false;
			}
		}
		swfu.removePostParam('color');
		swfu.addPostParam('color',$('#colorCd').val());
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
	
	/*
	 * 고객 데이타 저장.
	 */
	function fncSaveMediaAction(){
		
		var url;
		var msg;
		var no;
		
		if(jQuery('#listMediaForm1 input[name=mediaId]').val() == ""){
			url = '${ctxPath}/media/addMediaAction.do'; // 추가
			no = 1;
		} else{
			url = '${ctxPath}/media/modifyMediaAction.do'; // 수정
			no = jQuery('#listMediaForm1 input[name=currentPage]').val();
		}
		
		$('#listMediaForm1').ajaxSubmit({
			url : url,
			type : 'post',
			data : jQuery('#listMediaForm1').serialize(),
			dataType : "text",
			success : function(msg){
			 
			}, error : function(){
			}
		});
	}
	
	/*
	 * 동영상 코드.
	 */
	function fncSaveMediaCodeAction(){
		
		var url = '${ctxPath}/media/modifyMediaCodeAction.do'; // 수정
		
		$('#listMediaForm1').ajaxSubmit({
			url : url,
			type : 'post',
			data : jQuery('#listMediaForm1').serialize(),
			dataType : "text",
			success : function(data){
				if(data=="success"){
					alert('<spring:message code="success" />');	
				}else if(data == "fail"){
					alert('<spring:message code="fail" />');
				}
			}, error : function(){
			}
		});
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
	function removeMedia(prdctId,mediaId,mediaTyCd,mediaName){
		//alert(mediaId);
		
		var url = '${ctxPath}/media/removeMediaAction.do'; // 수정;
		var msg;
		
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: "prdctId="+prdctId+"&mediaId="+mediaId+"&mediaTyCd="+mediaTyCd+"&mediaName="+mediaName+"&color="+jQuery('#listMediaForm1 input[name=colorCd]').val(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="fail"){
					alert("삭제 실패 하였습니다.");
				}else if(data=="success"){
					var obj = document.getElementById("p_img"+mediaId);
					obj.style.display="none";
					
					dbCnt=dbCnt-1;
					isFull=0;
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
	
	function getVideoCode(){
		var url = '${ctxPath}/media/getVideoCode.do';
		$.ajax({
			url		: url,
			type 	: "post",
			data 	: "prdctId="+$('#prdctId').val(),
			dataType	: "json",
			beforeSend	: function(){
			},
			success: function(data){
				//jQuery('#listMediaBody').html(data);
				jQuery('#listMediaForm1 input[name=modelName]').val(data.modelName);
				jQuery('#listMediaForm1 input[name=videoCd]').val(data.videoCd);
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
	
	
	var colorList;
	function loadColorItem(){
		var url = '${ctxPath}/prdct/listPrdctColor.do';
		$.ajax({
			url		: url,
			type 	: "post",
			data 	: "prdctId="+$('#prdctId').val(),
			dataType	: "json",
			beforeSend	: function(){
			},
			success: function(data){
				colorList=data.listColor;
				fncRemoveAllOption('sel_color');
				
				var i=0;
				for(i=0;i<colorList.length;i++){
					makeColorItem(i,colorList[i].color);
				}
				
				if(colorList.length==0){
					makeColorItem(-1,'No Color');
				}else{
					if(jQuery('#listMediaForm1 input[name=colorCd]').val()==''){
						initColor(0);
					}else{
						for(i=0;i<colorList.length;i++){
							if(colorList[i].color==jQuery('#listMediaForm1 input[name=colorCd]').val()){
								jQuery('#listMediaForm1 select[name=sel_color]').val(i);		
							}
						}
						
					}
				}
			}
			
		});  
	}
	function initColor(idx){
		jQuery('#listMediaForm1 input[name=colorCd]').val(colorList[idx].color);
		getMedias('00200001');
	}
	function changeColor(idx){
		
		jQuery('#listMediaForm1 input[name=colorCd]').val(colorList[idx].color);
		
		getMedias('00200001');
		
		isFull=0;
		jQuery('#queuedFiles li').remove();
		swfu.setButtonDisabled(false);
	}
	function makeColorItem(idx,cvalue){
		var elOptNew = document.createElement('option');
	  	elOptNew.text = cvalue;
	  	elOptNew.value = idx;
	  	var elSel = document.getElementById('sel_color');
	  	try {
	   		elSel.add(elOptNew, null); // standards compliant; doesn't work in IE
	  	}catch(ex) {
	   		elSel.add(elOptNew); // IE only
	  	}
	}
	
	function addColor(){
		url = '${ctxPath}/prdct/addPrdctColor.do'; // 추가
		params="color="+jQuery('#listMediaForm1 input[name=addColorTxt]').val()+"&prdctId="+$('#prdctId').val();
			
		 $.ajax({
			url : url,
			type : 'post',
			data : params,
			dataType : "text",
			beforeSend	: function(){
				
			},
			success : function(data){
				 if(data=="duple"){
					alert('<spring:message code="add.prdct.duple"/>');
				 }else if(data=="success"){
					 loadColorItem();
					alert('<spring:message code="add.success"/>');
				 }else{
					 alert('<spring:message code="fail"/>');
				 }
			}, error : function(){
			}
			
		});
	}
</script> 
</head>
<body>
	<div id="content">
			<form name="listMediaForm1"  id="listMediaForm1" method="post" enctype="multipart/form-data" action="">
					<input type="hidden" id='mediaId' name='mediaId'>
					<input type="hidden" id='mediaTyCd' name='mediaTyCd' value='00200001'>
					<input type="hidden" id='prdctId' name='prdctId'>
					<input type="hidden" id='colorCd' name='colorCd'>
					<br>
					<div id="tab_media">
					
					<div id="frame_still"> 
					<table width="100%" border="1">
						<tr>
							<th>
								색상
							</th>
							<td>
								<table width="100%">
									<tr>
										<td>
											<select onchange="changeColor(value);return false;" id="sel_color" name="sel_color">
											</select>
										</td>
										<td align="right">
											<input size="7" id="addColorTxt" name="addColorTxt"><button onclick="addColor();return false;">색상 추가</button>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					
					<br>
					<br>
					</div>
					<table>
					<tr>
					<td>
						<img src="<c:url value="/images/content/dot.png"/>" /> 
					</td>
					<td>
						<p id="img_title">스틸샷 이미지 등록</p>
					</td>
					</tr>
					
					</table>
					<table width="100%">
					<tr >
					<td valign="top">
						
						<table width="100%" border="1" class="mdmtable2">
							
							<tbody>
							
							<tr>
								<th style="width:20%"><label for="">파일 선택</label></th>
								<td style="width:30%">
									<ul id="listMediaBody"></ul>
									<ul class="file" id="queuedFiles" style='color:red'></ul> 
									<span id="spanButtonPlaceholder"></span>
								</td>
							</tr>
							</tbody>
						</table>
					
					</td>
					</tr>
					<tr>
					<td colspan="2" align="right">
						<div id="btn_sctn">
							<button onclick="startSubmitFn();return false;">저장</button>
							<button onclick="goPrdctScreen();return false;">상품 화면</button>
						</div>
					</td>
					</tr>
					</table>
					</div>
					<div id="tab_vod_code" style="display:none">
						<table>
							<tr>
								<td>
									<img src="<c:url value="/images/content/dot.png"/>" /> 
								</td>
								<td>
									<p id="img_title">유튜브 영상 코드</p>
								</td>
							</tr>
						</table>
						
						<input type="hidden" id="modelName" name="modelName">
						<table width="100%" class="list" border="1">
							<tr>
								<th width="20%">
									동영상 코드
								</th>
								<td width="80%">
									<input  type="text" style="width:100%" id="videoCd" name="videoCd"></input>
								</td>
							</tr>
						</table>
						<table width="100%">
							<tr>
								<td colspan="2" align="right">
									<div id="btn_sctn">
										<button onclick="fncSaveMediaCodeAction();return false;">저장</button>
										<button onclick="goPrdctScreen();return false;">상품 화면</button>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</fieldset>
			</form>
	
		
		</div>
</body>
</html>
