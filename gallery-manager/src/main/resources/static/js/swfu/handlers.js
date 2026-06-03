/* Demo Note:  This demo uses a FileProgress class that handles the UI for displaying the file name and percent complete.
The FileProgress class is not part of SWFUpload.
*/

/*
 * swf 로딩에 성공 했을때
 */
function swfUploadLoaded(){
	if(this.customSettings['allowFileCnt'] <= this.customSettings['uploadedFileCnt'] ){
		this.setButtonDisabled(true); 
	}
	
}

/*
 * swf 로딩에 실패할때
 */
function swfUploadLoadFailed() {
	alert('플러그인 설치 하세요');
}

/*
 * 파일이 큐에 찰때 
 */
function fileQueued(file) {
	
	try {
		 
		__ATT_DEL_IMG__ = "/web/images/icon_del.gif";
		//var ii=file.id;
		//var qq=__ATT_DEL_IMG__;
		var imgUrl = ' <a href="#" onclick="deleteQueueFile(\''+file.id+'\'); return false;" ><img src="'+__ATT_DEL_IMG__+'" width="12" height="12" border="0" align="middle"  alt="파일삭제"/></a>';
		jQuery('#queuedFiles').append('<li id="'+file.id+'" class="attFile">'+file.name+imgUrl+' <span></span><div style="height:3px; display:none" class="ui-widget-header"></div></li>');

	} catch (ex) {
		console.log(ex);
		this.debug(ex);
	}
	
}

/*
 * 파일 큐에 넣는중 에러
 */
function fileQueueError(file, errorCode, message) {
	//TODO 이것들은 dialog로 바꿀꺼임.
	try {
		if (errorCode === SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
			alert("업로드 가능한 파일 갯수를 초과 했습니다\n" + "업로드  가능한 파일 갯수는" + this.customSettings['allowFileCnt'] +"개 입니다." );
			return;
		}
		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:		
			alert("파일이 너무 큽니다 : " + file.name + ", File size: " + file.size);
			break;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			alert("크기가 0 인 파일은 업로드 할 수 없습니다 : " + file.name);
			break;
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			alert("업로드 가능한 파일이 아닙니다 : " + file.name);
			break;
		default:
			alert("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		}
	} catch (ex) {
        this.debug(ex);
    }
}

/*
 * 파일 찾기를 할때
 */
function fileDialogStart() {
	//this.cancelQueue();
	//jQuery('#queuedFiles').html('');
	//this.cancelUpload();	
}

/*
 * 단일파일 업로드 시작
 */
function uploadStart(file) {
	try {
		jQuery('#'+file.id+' div').width('0%').show();
	}
	catch (ex) {}	
	return true;
}

/*
 * 단일 파일 업로드중..
 */
function uploadProgress(file, bytesLoaded, bytesTotal) {
	try {
		var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
		jQuery('#'+file.id+' div').width(percent+'%');
		jQuery('#'+file.id+' span').text('('+bytesLoaded+'/'+bytesTotal+')');
	} catch (ex) {
		this.debug(ex);
	}
}
/*
 * 단일파일 업로드 성공
 */
function uploadSuccess(file, serverData) {
	try {

		var data = eval('('+serverData+')');
		var file = data.file; 
		var origName = file.origName;
		var savedFileName = file.savedFileName;
		var fileURI= file.fileURI;
		var savedPath= file.savedPath;
		var fileSize= file.fileSize;
		
		//alert(origName + "\n" + savedFileName + "\n" + fileURI + "\n" + savedPath + "\n" + fileSize + "\n");
		
		jQuery('#'+file.id+' div').hide();
		jQuery('#'+file.id+' span').text('(업로드 완료)');
		
		jQuery('form[name='+this.customSettings['formName']+']').append('<input type="hidden" name="savedFileName" value="'+savedFileName+'">');
		jQuery('form[name='+this.customSettings['formName']+']').append('<input type="hidden" name="origName" value="'+origName+'">');
		jQuery('form[name='+this.customSettings['formName']+']').append('<input type="hidden" name="fileSize" value="'+fileSize+'">');
		jQuery('form[name='+this.customSettings['formName']+']').append('<input type="hidden" name="savedPath" value="'+savedPath+'">');
				
	} catch (ex) {
		this.debug(ex);
	}
}
/*
 * 단일파일 업로드 실패
 */
function uploadError(file, errorCode, message) {
	try {
		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
			alert("Error Code: HTTP Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
			alert("Error Code: Upload Failed, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.IO_ERROR:
			alert("Error Code: IO Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
			alert("Error Code: Security Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
			alert("Error Code: Upload Limit Exceeded, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
			alert("Error Code: File Validation Failed, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			break;
		default:
			alert("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		}
	} catch (ex) {
        this.debug(ex);
    }
}