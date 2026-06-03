<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		fncListFileServerData(1);
	});
	//----------------------
	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncListFileServerData(no){
		var url = 'listFileServerData.do';
		if(no){
			jQuery('#listFileServerForm1 input[name=currentPage]').val(no);
		}					  	
		var param = jQuery('#listFileServerForm1').serialize();
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listFileServerDiv').html(data);
			}
			
		});  
		 fncFileServerDetailClear();
	}
	
	
	
	/*
	 * 밸리데이션 체크
	 */
	 
	function fncCheckValidation(){
		if(listFileServerForm2.serverName.value==""){
			alert('<spring:message code="validation.put" arguments="서버명을"/>');
			return false;
		}
		return true;
	}
	
	/*
	 * 고객 데이타 저장.
	 */
	function fncSaveFileServerAction(){
		if(!fncCheckValidation()){
			return;
		}
		var url;
		var msg;
		var no;
		
		if(jQuery('#listFileServerForm2 input[name=serverId]').val() == ""){
			url = '${ctxPath}/fileserver/addFileServerAction.do'; // 추가
			no = 1;
		} else{
			url = '${ctxPath}/fileserver/modifyFileServerAction.do'; // 수정
			no = jQuery('#listCstmrForm1 input[name=currentPage]').val();
		}
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#listFileServerForm2').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="duple"){
					alert('<spring:message code="add.duple" arguments="서버"/>');
				}else if(data=="addsuccess"){
					alert('<spring:message code="add.success" />');				
				}else if(data=="fail"){
					alert('<spring:message code="fail" />');
				}else if(data=="upsuccess"){
					alert('<spring:message code="update.success" />');				
				}
				  //성공시....
				fncFileServerDetailClear();
				fncListFileServerData(1);
			}
			
		});  
		
	}
	
	//삭제
	function fncDelFileServer(){
		if(!confirm('<spring:message code="del.confirm" />')){
			return;
		}
		if(jQuery('#listFileServerForm2 input[name=serverId]').val() == ""){
			return;
		} 
				
		var url = '${ctxPath}/fileserver/removeFileServerAction.do';
		  	
		var param = jQuery('#listFileServerForm2').serialize();
		 
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
					fncFileServerDetailClear();
					fncListFileServerData();
				}else if(data == "fail"){
					alert('<spring:message code="fail" />');
				}
				
				  //성공시....
				 
			}
			
		}); 
		
	}
	 
	
	
	/*
	 * html 클리어
	 */
	function fncFileServerDetailClear(){
		 //jQuery('#listCstmrForm2 input[name=cstmrId]').val('');
		 jQuery('#listFileServerForm2 input[name=serverId]').val('');
		 jQuery('#listFileServerForm2 input[name=serverName]').val('');
		 jQuery('#listFileServerForm2 input[name=serverUrl]').val('');
		 jQuery('#listFileServerForm2 select[name=isdefault]').val('');
		 jQuery('#listShopForm2 select[name=shopstateCd]').val('1');
		 jQuery('#listFileServerForm2 TEXTAREA[name=bigo]').val('');
		 
		 
		 /*
		 var viewForm = jQuery('#listFileServerForm2');
		 viewForm.find('span[id=serverIdSpan]').text('');
		 viewForm.find('span[id=updDttm]').text('');
		 viewForm.find('span[id=upderNm]').text('');
		 viewForm.find("*").removeClass('formError'); // validation CSS 제거
		 */
	}
	

	/*
	 * 신규시 
	 */
	function fncNewFileServer(){
		
		fncFileServerDetailClear();
		
	}
	
	/*
	 * 고객 상세 
	 */
	function fncGetFileServerInfo(serverId){
		 var url = '${ctxPath}/fileserver/getFileServerData.do';
		 
		 //var userId = $('#userId').getValue();
		   
		 jQuery.ajax({
				url: url,
				type : "post",
				data : "serverId=" + serverId,
				dataType	: "json",
				beforeSend	: function(){
				},
				success		: function(data){
					 //clear 
					 fncFileServerDetailClear();
					 //-----------------------------
					 //-----------------------------
					 var viewForm = jQuery('#listFileServerForm2');
					 
					 //viewForm.deserialize(data);
					 jQuery('#listFileServerForm2 input[name=serverId]').val(data.serverId);
		 			 jQuery('#listFileServerForm2 input[name=serverName]').val(data.serverName);
			 		 jQuery('#listFileServerForm2 input[name=serverUrl]').val(data.serverUrl);
		 			 jQuery('#listFileServerForm2 select[name=isdefault]').val(data.isdefault);
		 			 jQuery('#listShopForm2 select[name=shopstateCd]').val('00500001');
		 			 jQuery('#listFileServerForm2 TEXTAREA[name=bigo]').val(data.bigo);
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
					
		<form name="listFileServerForm1"  id="listFileServerForm1" method="post" action="">
			
			<input type="hidden" name="currentPage" value="1"/>
			<input type="hidden" name="pageSize" value="5"/>
			
			
				<table width="100%" class="search" id="listTable" border="1">
					<tbody>
					<tr id="listTr" >
						<th style="width:20%" class="header"><label for="searchName">서버 명</label></th>
						<td style="width:80%">
							<input type="text" id="serverName" name="serverName">
							<button onclick="fncListFileServerData('1');return false;">조회</button>
						</td>
					</tr>
					</tbody>
				</table>

			</form>
		<form name="listFileServerForm2"  id="listFileServerForm2" method="post" action="">
				<input type="hidden" id='serverId' name='serverId'>
				
				<div id="listFileServerDiv"> 
				</div>
				
				
				
				
				<table>
				<tr>
				<td>
					<img src="<c:url value="/images/content/dot.png"/>" /> 
				</td>
				<td>
					<p>서버 정보</p>
				</td>
				</tr>
				</table>
				
				<table width="100%" border="1" class="detail"> 
					<br>
					<tbody>
					
					<tr>
						<th style="width:20%"><label for="">서버 명</label></th>
						<td colspan="3" style="width:80%">
							<input type="text" id='serverName' name='serverName' title='서버 명'>
						</td>
					</tr>
					<tr>
						<th style="width:20%"><label for="">서버 주소</label></th>
						<td style="width:50%">
							<input type="text" id='serverUrl' name='serverUrl' style="width:90%" title='서버 주소'>
						</td>
						<th style="width:20%"><label for="">Default 여부</label></th>
						<td style="width:10%">
							<select id="isdefault" name="isdefault" style="width:80px">
								<option value='1' >Y</option>
								<option value='0'>N</option>
							</select>
						</td>
					</tr>
					<tr>
						<th><label for="">비고</label></th>
						<td colspan="3"><TEXTAREA id="bigo" name="bigo" ROWS="5" style="width:100%"></TEXTAREA></td>
					</tr>
					</tbody>
				</table>

				
				
				<div id="btn_sctn" align="right">
					<button onclick="fncNewFileServer();return false;">신 규</button>
					<button onclick="fncSaveFileServerAction();return false;">저 장</button>
					<button onclick="fncDelFileServer();return false;">삭 제</button>
				</div>
				
		</form>
	</div>
</body>
</html>
