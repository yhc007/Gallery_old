<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		jQuery('#listEventForm2 input[name=eventId]').val('${eventVo.eventId}');
		fncListEventPrdctData('${eventVo.eventId}');
		
	});
	//----------------------
	
	/*
	 * 이벤트 데이타 리스트 보드 페이징
	 */
	function fncListEventPrdctData(eventId){
		var url = 'listEventPrdctData.do';					  	
		var param = jQuery('#listEventForm1').serialize();
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: "eventId=" + eventId,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listEventPrdctDiv').html(data);
			}
			
		});  
	}
	
	
	/*
	 * 단말 검색
	 */
	function fncSearchPopup(){
		//alert("data="+prdctId);
		jQuery.ajax({  
			url: '${ctxPath}/event/popupEventPrdctForm.do'
			, type: "POST"
			, data: null
			, dataType: "html"
			, beforeSend: function(xhr){
				
			}
			, success:  function(data) {
				jQuery('#dialog').html(data);
			}	
		});	// end ajax	
		
		jQuery('#dialog').dialog({
			//bgiframe: true
			 title: "상품 검색"
			 , modal: true
		     , width: 900 // 가로 크기
		     , background: "#000"
			 , close: function(event, ui){
				jQuery('#dialog').dialog('destroy');
				jQuery('#dialog').html('');
			}, success:  function(data) {
			} 
		});	
	}
	
	
	/*
	 * 밸리데이션 체크
	 */
	 
	function fncCheckValidation(){
		if(listEventForm2.eventName.value==""){
			alert('<spring:message code="validation.put" arguments="브랜드명을"/>');
			return false;
		}
		return true;
	}
	
	/*
	 * 이벤트 데이타 저장.
	 */
	function fncSaveEventAction(){
		if(!fncCheckValidation()){
			return;
		}
		var url;
		var msg;
		var no;
		
		if(jQuery('#listEventForm2 input[name=eventId]').val() == ""){
			url = '${ctxPath}/event/addEventAction.do'; // 추가
			no = 1;
		} else{
			url = '${ctxPath}/event/modifyEventAction.do'; // 수정
			no = jQuery('#listCstmrForm1 input[name=currentPage]').val();
		}
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#listEventForm2').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="duple"){
					alert('<spring:message code="add.duple" arguments="브랜드"/>');
				}else if(data=="addsuccess"){
					alert('<spring:message code="add.success" />');				
				}else if(data=="fail"){
					alert('<spring:message code="fail" />');
				}else if(data=="upsuccess"){
					alert('<spring:message code="update.success" />');				
				}
				  //성공시....
				fncEventDetailClear();
				fncListEventData(1);
			}
			
		});  
		
	}
	
	//취소
	function fncMoveBack(){
		location.replace('${ctxPath}/event/indexEventForm.do');
		
	}
	 
	
	/*
	 * 이벤트 상세 
	 */
	function fncGetEventInfo(eventId){
		 var url = '${ctxPath}/event/getEventData.do';
		 
		 //var userId = $('#userId').getValue();
		   
		 jQuery.ajax({
				url: url,
				type : "post",
				data : "eventId=" + eventId,
				dataType	: "json",
				beforeSend	: function(){
				},
				success		: function(data){
					 //clear 
					 //-----------------------------
					 //-----------------------------
					 var viewForm = jQuery('#listEventForm2');
					 
					 //viewForm.deserialize(data);
					 jQuery('#listEventForm2 input[name=eventId]').val(data.eventId);
		 			 jQuery('#listEventForm2 input[name=eventName]').val(data.eventName);
					
		 			 jQuery('#listEventForm2 select[name=eventTyCd]').val(data.eventTyCd);
		 			 
		 			 getMax('${cyear}','${cmonth}',1);
		 			 getMax('${cyear}','${cmonth}',2);
		 			 
		 			 alert(data.syear+":"+data.smonth+":"+data.sday);
		 			 jQuery('#listEventForm2 select[name=syear]').val(data.syear);
		 			 jQuery('#listEventForm2 select[name=smonth]').val(data.smonth);
		 			 jQuery('#listEventForm2 select[name=sday]').val(data.sday);
		 			 jQuery('#listEventForm2 select[name=eyear]').val(data.eyear);
		 			 jQuery('#listEventForm2 select[name=emonth]').val(data.emonth);
		 			 jQuery('#listEventForm2 select[name=eday]').val(data.eday);
		 			 jQuery('#listEventForm2 select[name=dscnt]').val(data.dscnt);
		 			 jQuery('#listEventForm2 select[name=eventStatTyCd]').val(data.eventStatTyCd);
					  
				}
				
			});  
	}
	
	/*
	 * html 클리어
	 */
	function fncEventDetailClear(){
		 //jQuery('#listCstmrForm2 input[name=cstmrId]').val('');
		 jQuery('#listEventForm2 input[name=eventId]').val('');
		 jQuery('#listEventForm2 input[name=eventName]').val('');
		 jQuery('#listEventForm2 select[name=eventTyCd]').val('01000001');
		 
		 getMax('${cyear}','${cmonth}',1);
		 getMax('${cyear}','${cmonth}',2);
		 
		 jQuery('#listEventForm2 select[name=syear]').val('${cyear}');
		 jQuery('#listEventForm2 select[name=smonth]').val('${cmonth}');
		 jQuery('#listEventForm2 select[name=sday]').val('${cday}');
		 jQuery('#listEventForm2 select[name=eyear]').val('${cyear}');
		 jQuery('#listEventForm2 select[name=emonth]').val('${cmonth}');
		 jQuery('#listEventForm2 select[name=eday]').val('${cday}');
		 jQuery('#listEventForm2 select[name=dscnt]').val('1');
		 jQuery('#listEventForm2 select[name=eventStatTyCd]').val('00500001');
		 /*
		 var viewForm = jQuery('#listBrandForm2');
		 viewForm.find('span[id=brandIdSpan]').text('');
		 viewForm.find('span[id=updDttm]').text('');
		 viewForm.find('span[id=upderNm]').text('');
		 viewForm.find("*").removeClass('formError'); // validation CSS 제거
		 */
	}
</script> 
<html>
<head>
	<title>Home</title>
</head>
<body>
	<div id="content">
					
		<form name="listEventForm2"  id="listEventForm2" method="post" action="">
			<input type="hidden" id='eventId' name='eventId'>
			
			<div id="model_list">
				<table>
				<tr>
				<td>
					<img src="<c:url value="/images/content/dot.png"/>" /> 
				</td>
				<td>
					<p>참여상품 정보</p>
				</td>
				</tr>
				</table>
				
				<div id="listEventPrdctDiv"> 
				</div>
				
			</div>
			<div id="btn_sctn" align="right">
				<button onclick="fncMoveBack();return false;">확인</button>
			</div>
			
			
		</form>
			
	</div>
	<div id="dialog"></div>
</body>
</html>
