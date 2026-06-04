<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="cache-control" content="no-store, no-cache, must-revalidate" />
<meta http-equiv="Pragma" content="no-store, no-cache" />
<meta http-equiv="Expires" content="0" />

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<!-- <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.1/jquery.mobile-1.4.1.min.css" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.1/jquery.mobile-1.4.1.min.js"></script> -->
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<link rel="stylesheet" href="${ctxPath }/js/jq/gallery.min.css" />
<link rel="stylesheet" href="${ctxPath }/js/jq/jquery.mobile.icons.min.css" />


<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.0/jquery.mobile.structure-1.4.0.min.css" />
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.js"></script>
<script src="${ctxPath }/js/jq/jquery.fileupload.js" > </script> 


<title>갤러리 커뮤니티</title>
<script type="text/javascript">
	var page = 0;
	var shopTy = '${shopTy}'; //
	var usr = '${usr}';
	var boardTy = "N";
	var shopId = ${shopId};
	var writer = ${writer};
	var writerTy;
	var no_;
	var originFileName;
	
	function downloadURI(uri, name) {
		  var link = document.createElement("a");
		  link.download = name;
		  link.href = uri;
		  link.click();	
	}
		
	
	function hideFooterBtn(){
		var os = navigator.platform;
		if(os=="Linux armv7l"){
			var div = "<div  data-role='navbar' class='navbar'>" + 
							"<ul>" + 
								"<li><a href='javascript:prePage()' >이전 페이지</a></li>" + 
								"<li><a href='javascript:nxtPage()' >다음 페이지</a></li>" + 
							"</ul>" + 
						"</div>";
			$("#footer").html(div).trigger("create");
		};	
	};
	
	function showWriterDiv(){
		if(boardTy=="N" && (shopId!=999 && shopId!=777)){
			alert("관리자가 아닙니다.");
			return;
		}
		if(!modifyMode){
			$("#upFile").css("display","inline");
		}
		$("#addParam").val("none");
		$("#upFile").val('');
		$.mobile.changePage("#writerDiv",{role:"dialog", transition : "none"});
		
		$("input:checkbox[name='priority']").prop("checked", false).checkboxradio("refresh");
	}
	
	function checkReader(){
		var shopTy_ = shopTy;
		var shopId_ = shopId;
		var no = no_;
		var param = "shopTy=" + shopTy_ +
						"&shopId=" + shopId_ +
						"&no=" + no;
		var url = "${ctxPath}/board/checkReader.do";
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : param,
			success : function(data){
				if(data="success"){
					console.log("checked");
				}			
			}
		});
	}
	$(function(){
		$("#addParam").val("none");
		
		$('#upFile').bind('fileuploadsubmit', function (e, data) {
		    // The example input, doesn't have to be part of the upload form:
		    var input = $('#addParam').val();
		    var fileNo_ = fileNo;
		    data.formData = {multiFile: input,
		    					  fileNo : fileNo_};
		    console.log("fileName : " + data.formData.fileNo)
			 $("#addParam").val("multi");
		    if (!data.formData.multiFile) {
		     
		      return false;
		    }
		});
		
		
		$('#modiFile').bind('fileuploadsubmit', function (e, data) {
		    // The example input, doesn't have to be part of the upload form:
		    var name_ = originFileName;
		    data.formData = {originFileName: name_}; 
		    console.log("fileName : " + data.formData.originFileName)
		    if (!data.formData.originFileName) {
		     
		      return false;
		    }
		});
		
		upload();
		upload2();
		var width = window.innerWidth;
		if(width>=1000){
			$("#replyPop").css("width","400px");
		}else{
			$("#replyPop").css("width",width * 0.8);	
		}
		
		$(".usr").html("접속자 : " + usr);
		
		if(shopTy=="2"){
			$(".navbar").css("display","none");
			$("#footer").css("display","none");
			writerTy = "C";
			boardTy = "C";
			getBoardList('C');
			$("#title").html("협력업체");
			$.mobile.changePage("#boardC");
		}else{
			getBoardList('N');
			$("navN").addClass('ui-btn-active');
			writerTy = "S";
			$("#title").html("공지사항");
		};
		
		hideFooterBtn();
	});
	
	function removeBr(str){
		var result = str.replace(/<br \/>/gi,"\n");
		
		return result;
	}
	function changeBoardPage(t,obj){
		page = 0;
		$.mobile.changePage("#board" + t);
		boardTy = t;
		$(".nav").removeClass("ui-btn-active");
		$(obj).addClass('ui-btn-active');
		getBoardList(t);
		
		//$("#board" + t).setAttribute('data-theme', 'D');
		if(t=="N"){
			$("#title").html("공지사항");
		}else if(t=="S"){
			$("#title").html("커뮤니티");
		}else if(t=="C"){
			$("#title").html("협력업체");
		}
	}
	function getBoardList(t){
		window.sessionStorage.setItem("board", t);
		if(t=="N"){
			$(".noticeTitle").css("color","#ffff00");
		}else if(t=="S"){
			$(".noticeTitle").css("color","#a0522d");
		}else if(t=="C"){
			$(".noticeTitle").css("color","#ffff00");
		};
		
		var type = boardTy;
		var param = "ty=" + type + 
						"&shopTy=1" + 
						"&page=" + page; 
		
		var url = "${ctxPath}/board/getBoardList.do";
		$("#nav" + t).addClass('ui-btn-active');
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#boardList" + t).html(data);
				$("#boardList" + t).listview("refresh");
				
				if(t=="N"){
					$(".noticeTitle").css("color","#ffff00");
				}else if(t=="S"){
					$(".noticeTitle").css("color","#a0522d");
				}else if(t=="C"){
					$(".noticeTitle").css("color","#ffff00");
				};
			}
		});
	};
	
	function closeDialog(){
		modifyMode = false;
		$("#writerDiv").dialog("close");
		$("#title2").val("");
		$("#content").val("");
		$("#no_").val("");
		$("input:checkbox[name='priority']").prop("checked", false).checkboxradio("refresh");
	}
	
	function nl2br(str){ 
		  return str.replace(/\n/g, "<br />"); 
	}
	
	function submit(){
		var no = $("#modifyNo").val();
		var url;
		if(no!="" && writingNo=="0"){
			url = "${ctxPath}/board/modifyWrite.do";
			console.log("file name : " + boardFile);
		}else if(no=="" && writingNo!="0"){
			url = "${ctxPath}/board/modifyWirteAfterFilUpload.do";
			no = writingNo;
		}else{
			url = "${ctxPath}/board/write.do";
		}
		var priority = $("input:checkbox[id='priority']").is(":checked");
		
		if(priority==true){
			priority = 1;
		}else{
			priority = 0;
		};
		var title = encodeURIComponent($("#title2").val());
		var content = encodeURIComponent(nl2br($("#content").val()));
		var param = "writer=" + writer +
						"&writerTy=" + writerTy +
						"&title=" + title + 
						"&content=" + content + 
						"&ty=" + boardTy +
						"&no=" + no + 
						"&fileName=" + boardFile + 
						"&priority=" + priority;
		
		$.ajax({
			url : url,
			data : param,
			type : "post",
			dataType : "text",
			success : function(data){
				if(data=="success"){
					writingNo = 0;
					alert("등록되었습니다.");
					$("#writerDiv").dialog("close");
					getBoardList(boardTy);
					closeDialog();
					
					if(priority==1){
						if(boardTy=="C"){
							getInumCnt();	
						}else if(boardTy=="N" || boardTy=="S"){
							getInumShopId();
						};
					};
				}else if(data=="modified"){
					writingNo = 0;
					alert("수정되었습니다.");
					boardFile = "none";
					$("#writerDiv").dialog("close");
					viewContent(no);
					closeDialog();
				}
				
				$("#modifyNo").val("");
			}
		});
	}
	
	function getInumCnt(){
		var url = "${ctxPath}/shop/getInum.do";
		
		$.ajax({
			url : url,
			type : "post",
			dataType : "text",
			success : function(data){
				var iNum = data.split("|");
				for(var i = 0; i < iNum.length; i++){
					notiToCom(iNum[i].trim());
				}
			}
		});
	};
	
	function getInumShopId(){
		var url = "${ctxPath}/shop/getShopId.do";
		
		$.ajax({
			url : url,
			type : "post",
			dataType : "text",
			success : function(data){
				var iNum = data.split("|");
				for(var i = 0; i < iNum.length; i++){
					notiToShop(iNum[i].trim());
				}
			}
		});
	};
	
	function notiToCom(iNum){
		//노티
		var url = "https://jaguar.s4g.kr/GalleryTalk/comm/sendMsg.do";
		//var url = "http://106.240.234.114:8080/GalleryTalk/comm/sendMsg.do";
		var msg = "커뮤니티에 공지사항이 등록되었습니다. 확인 바랍니다."
		var param = "sendGid=S777" + 
						"&sendName=Gallery Admin" +
						"&rcvGid=C" + iNum + 
						"&msg=" + msg;
		
	 	$.ajax({
			url : encodeURI(url),
			data : param,
			dataType : "post",
			success : function(){
				
			}
		}); 
	};
	
	function notiToShop(iNum){
		//노티
		var url = "https://jaguar.s4g.kr/GalleryTalk/comm/sendMsg.do";
		//var url = "http://106.240.234.114:8080/GalleryTalk/comm/sendMsg.do";
		var msg = "커뮤니티에 공지사항이 등록되었습니다. 확인 바랍니다."
		var param = "sendGid=S777" + 
						"&sendName=Gallery Admin" +
						"&rcvGid=S" + iNum + 
						"&msg=" + msg;
		
	 	$.ajax({
			url : encodeURI(url),
			data : param,
			dataType : "post",
			success : function(){
				
			}
		}); 
	};
	
	
	var boardFile = "none";
	var writerNo;
	var contentForModify;
	var wringNoforFile;
	var priority;
	function viewContent(no){
		wringNoforFile = no;
		boardFile = "none";
		modifyMode = false;
		var param = "no=" + no;
		var url = "${ctxPath}/board/viewContent.do";
		$("#imgViewer").html("");
		$.ajax({
			url : url,
			data : param,
			dataType : "json",
			type : "post",
			success : function(data){
				console.log(data)
				viewFile(no);
				writerNo = data.writerNo;
				priority = data.priority;
				no_ = data.no;
				$("#titleTd").html(data.title);
				$("#writerTd").html(data.writer);
				$("#updTimeTd").html(data.updTime.substr(0,16));
				$("#contentTd").html(data.content);
				contentForModify = removeBr(data.content);
				$("#replyForm input[id='no']").val(data.no);
				getReplyList();
				$.mobile.changePage("#contentPage", {transition:"none"});	
				checkReader();
				
				if((writerNo==shopId || shopId==104 || shopId==999 || shopId==777) && boardTy=="S"){
					$("#buttonSpan").html("<button data-inline='true' data-mini='true' data-icon='check' id='cmplBtn' onclick='setComplete();'>처리</button>");
					$("#cmplBtn").buttonMarkup();
				};
			},
			error : function(e1, e2, e3){
				alert(e2);
			}
		});
		
	};
	
	function setComplete(){
		var url = "${ctxPath}/board/setComplete.do";
		var param = "no=" + no_;
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				if(data=="success"){
					alert("처리 완료 되었습니다.");
				};
			}
		});
	};
	
	function viewFile(no){
		var param = "no=" + no;
		var url = "${ctxPath}/board/getFile.do";
		$("#file").html("");
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				
				$("#file").html(data);
			},
			error : function(e1,e2,e3){
				console.log(e2);
			}
		});
	}
	function getReplyList(){
		var no = $("#replyForm input[id='no']").val();
		var param = "no=" + no;
		
		var url = "${ctxPath}/board/getReplyList.do";
		
		$.ajax({
			url : url,
			data : param,
			type : "post",
			dataType : "text",
			success : function(data){
				$("#replyList").html(data)
				$("#replyList").listview('refresh');
			}
		});
	}
	
	function showReplyPop(){
		$("#replyPop").popup("open",{transition:"none"});
	}
	
	function writeReply(){
		var no = $("#replyForm input[id='no']").val();
		var content = encodeURIComponent($("#reply").val());
		var param = "no=" + no + 
						"&content=" + content + 
						"&writer=" + writer + 
						"&writerTy=" + writerTy; 
		
		var url = "${ctxPath}/board/writeReply.do";
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				if(data=="success"){
					$("#replyPop").popup('close',{transition:"none"} );
					$("#reply").val("");
					getReplyList();
				}
			}
		});
	}
	
	function delBoard(){
		if(confirm("삭제 하시겠습니까?")==false){
			return;
		}else{
			if(writerNo!=shopId){
				alert("작성자만 해당 글을 삭제할 수 있습니다.");
				return;
			}	
		}
		
		var param = "no=" + no_;
		var url = "${ctxPath}/board/delBoard.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : 'text',
			type : "post",
			success : function(data){
				if(data=="success"){
					alert("삭제되었습니다.");
					getBoardList(boardTy);
					$.mobile.changePage("#board" + boardTy);
				}
			}
		});
	}
	
	function delReply(replyNo,id){
		if(confirm("삭제 하시겠습니까?")==false){
			return;
		}else{
			if(replyNo!=shopId){
				alert("작성자만 해당 글을 삭제할 수 있습니다.");
				return;
			}	
		}
		
		var param = "id=" + id;
		var url = "${ctxPath}/board/delReply.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : 'text',
			type : "post",
			success : function(data){
				if(data=="success"){
					alert("삭제되었습니다.");
					getReplyList();
				}
			}
		});
	}
	
	function replydetail(content){
		console.log(content)
		$("#replyDetail").html(content);
		$("#replyDetailPop").popup("open" ,{transition:"none"} );
	}
	
	
	var modifyMode = false;
	function mofidyBoard(){
		modifyMode = true;
		if(writerNo!=shopId){
			alert("작성자만 해당 글을 수정할 수 있습니다.");
			return;
		}
		
		
		$("#upFile").css("display","none");
		$("#title2").val($("#titleTd").text());
		$("#content").val(contentForModify);
		$("#modifyNo").val(no_);
		$("#addParam").val("none");
		fileNo = 1;
		$("#upFile").val("");
		$.mobile.changePage("#writerDiv",{role:"dialog"});
		
		if(priority==true){
			$("input:checkbox[name='priority']").prop("checked", true).checkboxradio("refresh");
		}else{
			$("input:checkbox[name='priority']").prop("checked", false).checkboxradio("refresh");
		} 
	
		$("#writerDiv").bind("pagehide",function(){
			closeDialog();
		});
		
	}
	
	var writingNo = 0;
	var addFile = false;
	var multiFile = false;
	var fileNo = 1;
	
	
	function upload(){
		$('#upFile').fileupload({
	        url : '${ctxPath}/upload/upload.do',
	        dataType: 'json',
	        replaceFileInput: false,
	        add: function(e, data){
	        	   multiFile = true;	
	            var uploadFile = data.files[0];
	            	data.files[0] = uploadFile;
	            /* if (!(/png|jpe?g|gif/i).test(uploadFile.name)) {
	                alert('png, jpg, gif 만 가능합니다');
	                goUpload = false;
	            } */  if (uploadFile.size > 5000000) { // 5mb
	                alert('파일 용량은 5메가를 초과할 수 없습니다.');
	            }
	            data.submit();
	        },
	        beforeSend : function(e,data){
	        }
	        ,
	        progressall: function(e,data) {
	            var progress = parseInt(data.loaded / data.total * 100, 10);
	            $('#progress .bar').css(
	                'width',
	                progress + '%'
	            );
	        },
	        done: function (e, data) {
	            var code = data.result.code;
	            var msg = data.result.msg;
	            var fileName = data.result.fileName;
	            	if(!modifyMode){
	            		writingNo = msg;	
	            		fileNo = msg;
	            		console.log(fileName);
	            		console.log("fileName After Done : " + fileNo);
	            	}else{
	            		boardFile = fileName;
	            	}
	            if(code=='0') {
	                addFile = true;
	            } else {
	                alert(code + " : " + msg);
	            } 
	        },
	        fail: function(){
	            alert("서버와 통신 중 문제가 발생했습니다");
	        }
	    });
	}
	
	function upload2(){
		$('#modiFile').fileupload({
	        url : '${ctxPath}/upload/modifyFile.do',
	        dataType: 'json',
	        replaceFileInput: false,
	        add: function(e, data){
	            var uploadFile = data.files[0];
	            	data.files[0] = uploadFile;
	            	console.log("파일 : " + uploadFile.name)
	            /* if (!(/png|jpe?g|gif/i).test(uploadFile.name)) {
	                alert('png, jpg, gif 만 가능합니다');
	                goUpload = false;
	            } */  if (uploadFile.size > 5000000) { // 5mb
	                alert('파일 용량은 5메가를 초과할 수 없습니다.');
	            }
	            data.submit();
	        },
	        beforeSend : function(e,data){
	        }
	        ,
	        progressall: function(e,data) {
	            var progress = parseInt(data.loaded / data.total * 100, 10);
	            $('#progress .bar').css(
	                'width',
	                progress + '%'
	            );
	        },
	        done: function (e, data) {
	            var code = data.result.code;
	            var msg = data.result.msg;
	            var fileName = data.result.fileName;
	            viewFile(wringNoforFile);
	            if(code=='0') {
	                addFile = true;
	            } else {
	                alert(code + " : " + msg);
	            } 
	        },
	        fail: function(){
	            alert("서버와 통신 중 문제가 발생했습니다");
	        }
	    });
	}
	
	
	function editFile(fileName){
		if(writerNo!=shopId){
			alert("작성자만 해당 글을 수정 할 수 있습니다.");
			return;
		}	
		originFileName = fileName;
		document.getElementById("modiFile").click();
		console.log(fileName);
	}
	
	function showReader(){
		var no = no_;
		var url = "${ctxPath}/board/showReader.do";
		var param = "no=" + no;
		
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success :function(data){
				$("#readerDiv").html(data);
				$("#reader").popup("open",{positionTo:"origin"});		
			}
		});
		
	}
</script>
<style type="text/css">
	.select{
		background-color: blue; !important;
	}
	.notice{
		background-color: black !important;
	}
</style>
</head>
<body>
	<div data-role="page" id="boardN" data-theme="b">
	<%@include file="include.jsp" %>	
	
		<div data-role="content">
			<div class="usr"></div>
			<ul data-role="listview" id="boardListN" data-inset='true' data-filter="true" data-filter-placeholder="제목 or 작성자">
			</ul>
		</div>
	
	<%@include file="footer.jsp" %>
	</div>
	
	<div data-role="page" id="writerDiv">
		<div data-role="header">
			<h2>글쓰기</h2>
		</div>
		<div data-role="content">
			<input type="hidden" id="modifyNo">
			<input type="text" id="title2" placeholder="제목">
			<textarea rows="" cols="" id="content" placeholder="내용을 입력하세요."></textarea>
			<label for="priority">공지</label><input type="checkbox" id="priority" name="priority" >
			<center>
				<button onclick="submit()" data-inline="true">작성</button>
				<button onclick="closeDialog()" data-inline="true">취소</button>
				<input type="file" name="fileData" id="upFile" />
				<input type="file" name="fileData2" id="modiFile" style="display: none;"/>
				<input type="hidden" id="addParam">
				 <div id="progress">
        			<div class="bar" style="width: 0%;"></div>
    			</div>
			</center>
		</div>
	</div>
	
	<div data-role="page" id="contentPage">
		<%@include file="include.jsp" %>
		<div data-role="cotnent">
			<center>
			<form id="replyForm">
				<input type="hidden" id="no">
				<table width="95%">
					<Tr >
						<td id="titleTd"  width="33%" style="font-weight: bold;font-size: 18px;" colspan="2">
																				<td width="33%" id="updTimeTd" style="text-align: right;"></td>
					</Tr>
					<Tr>
						<td><a href="javascript:showReader();">읽은 사람</a></td>	<td></td>					<td id="writerTd" style="text-align: right;"></td>
					</Tr>
					
					<tr>
						<td id="file"></td>
					</tr>
					<tr>
						<td id="contentTd" colspan="3"></td>
					</tr>
				</table>
			</form>
			
			
			
			<button data-inline="true" data-mini="true" data-icon="gear" onclick="mofidyBoard();">수정</button>
			<button data-inline="true" data-mini="true" data-icon="delete" onclick="delBoard();">삭제</button>
			<button data-inline="true" data-mini="true" data-icon="plus" onclick="showReplyPop();">댓글달기</button>
			<span id="buttonSpan"></span>
			<Br>
			<br>
			
				<ul data-role="listview" id="replyList" data-inset='true' style="width: 95%">
			
				</ul>
			</center>
		</div>
		
		<div data-role="popup" id="replyDetailPop" data-transition="none" data-overlay-theme="b"  data-corners="false" style="padding: 10px;">
    		<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
    			<div id="replyDetail"></div>
		</div>
		
		<div data-role="popup" id="reader"  data-corners="true" data-transition="none" style="padding: 10px;">
    		<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
    			<div id="readerDiv"></div>
		</div>
		
		<div data-role="popup" id="replyPop" data-overlay-theme="b"  data-transition="none" data-corners="false" style="padding: 10px;">
    		<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
    			<input type="text" id="reply" placeholder="내용을 입력하세요." width="100%">
    			<button onclick="writeReply()" data-inline="true" data-mini="true">확인</button> 
		</div>
		
		
		
		
	</div>
	
	
	<div data-role="page" id="boardS" data-theme="c">
	<%@include file="include.jsp" %>	
	
		<div data-role="content">
			<div class="usr"></div>
			<ul data-role="listview" id="boardListS" data-inset='true' data-filter="true" data-filter-placeholder="제목 or 작성자">
			</ul>
		</div>
		<%@include file="footer.jsp" %>
	</div>
	
	
	<div data-role="page" id="boardC" data-theme="d">
	<%@include file="include.jsp" %>	
	
		<div data-role="content">
			<div class="usr"></div>
			<ul data-role="listview" id="boardListC" data-inset='true' data-filter="true" data-filter-placeholder="제목 or 작성자">
			</ul>
		</div>
		<%@include file="footer.jsp" %>
	</div>
</body>
</html>