<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	
	window.onload = function(){
		jQuery('#listEventForm2 select[name=smonth]').val('${cmonth}');
		jQuery('#listEventForm2 select[name=sday]').val('${cday}');
		jQuery('#listEventForm2 select[name=emonth]').val('${cmonth}');
		jQuery('#listEventForm2 select[name=eday]').val('${cday}');
	};
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		fncListEventData(1);
		getMax('${cyear}','${cmonth}',1);
		getMax('${cyear}','${cmonth}',2);
		
		
	});
	//----------------------
	
	/*
	 * 년 월의 마지막 일 획득
	 */
	function getMax(year,month,tp){
		if(tp==1){
			if(year==null||month==null){
				year= jQuery('#listEventForm2 select[name=syear]').val();
				month= jQuery('#listEventForm2 select[name=smonth]').val();
			}
			form= document.getElementById("sday"); //jQuery('#cstmrInfoForm select[name=bday]');
			getMaxOfMonth(year,month,form);
		}
		
		if(tp==2){
			if(year==null||month==null){
				year= jQuery('#listEventForm2 select[name=eyear]').val();
				month= jQuery('#listEventForm2 select[name=emonth]').val();
			}
			form= document.getElementById("eday"); //jQuery('#cstmrInfoForm select[name=bday]');
			getMaxOfMonth(year,month,form);
		}
	}
	
	/*
	 * 이벤트 데이타 리스트 보드 페이징
	 */
	function fncListEventData(no){
		var url = 'listEventData.do';
		if(no){
			jQuery('#listEventForm1 input[name=currentPage]').val(no);
		}					  	
		var param = jQuery('#listEventForm1').serialize();
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listEventDiv').html(data);
			}
			
		});  
	}
	
	
	
	/*
	 * 밸리데이션 체크
	 */
	 
	function fncCheckValidation(){
		if(listEventForm2.eventName.value==""){
			alert('<spring:message code="validation.put" arguments="이벤트명을"/>');
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
					alert('<spring:message code="add.duple" arguments="이벤트"/>');
				}else if(data=="addsuccess"){
					alert('<spring:message code="add.success" />');				
				}else if(data=="fail"){
					alert('<spring:message code="fail" />');
				}else if(data=="upsuccess"){
					alert('<spring:message code="update.success" />');				
				}
				  //성공시....
				fncListEventData(1);
				fncEventDetailClear();
			}
			
		});  
		
	}
	
	//삭제
	function fncDelEvent(){
		if(!confirm('<spring:message code="del.confirm" />')){
			return;
		}
		if(jQuery('#listEventForm2 input[name=eventId]').val() == ""){
			return;
		} 
				
		var url = '${ctxPath}/event/removeEventAction.do';
		  	
		var param = jQuery('#listEventForm2').serialize();
		 
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
					fncEventDetailClear();
					fncListEventData();
				}else if(data == "fail"){
					alert('<spring:message code="fail" />');
				}else if(data == "exist"){
					alert('<spring:message code="del.exist" arguments="이벤트,상품이"/>');
				}
				
				  //성공시....
				 
			}
			
		}); 
		
	}
	 
	//이벤트 참여 모델 추가
	function fncAddModel(eventId){
		
		if(!fncCheckValidation()){
			return;
		}
		var url;
		var msg;
		var no;
		/*
		if(jQuery('#listEventForm2 input[name=eventId]').val() == ""){
			url = '${ctxPath}/event/addEventAction.do'; // 추가
			no = 1;
		} else{
			url = '${ctxPath}/event/modifyEventAction.do'; // 수정
			no = jQuery('#listCstmrForm1 input[name=currentPage]').val();
		}
		*/
		url = '${ctxPath}/event/modifyEventAction.do'; // 수정
		 $.ajax({
			url 	: url,
			type 	: "post",
			data 	: jQuery('#listEventForm2').serialize(),
			dataType	: "text",
			beforeSend	: function(){
				
			},
			success: function(data){
				if(data=="duple"){
					alert('<spring:message code="add.duple" arguments="이벤트"/>');
				}else if(data=="addsuccess"){
					location.href="eventPrdctForm.do?eventId="+jQuery('#listEventForm2 input[name=eventId]').val();				
				}else if(data=="fail"){
					alert('<spring:message code="fail" />');
				}else if(data=="upsuccess"){
					location.href="eventPrdctForm.do?eventId="+jQuery('#listEventForm2 input[name=eventId]').val();				
				}
			}
		});  
		 
		
	}
	
	

	/*
	 * 신규시 
	 */
	function fncNewEvent(){
		location.replace('${ctxPath}/event/newEventForm.do');
		
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
		 			 
		 			 jQuery('#listEventForm2 select[name=syear]').val(data.syear);
		 			 jQuery('#listEventForm2 select[name=smonth]').val(data.smonth);
		 			 jQuery('#listEventForm2 select[name=sday]').val(data.sday);
		 			 jQuery('#listEventForm2 select[name=eyear]').val(data.eyear);
		 			 jQuery('#listEventForm2 select[name=emonth]').val(data.emonth);
		 			 jQuery('#listEventForm2 select[name=eday]').val(data.eday);
		 			 jQuery('#listEventForm2 select[name=dscnt]').val(data.dscnt);
		 			 jQuery('#listEventForm2 select[name=eventStatTyCd]').val(data.eventStatTyCd);
					 
		 			 if(data.eventTyCd=="01000001"){
		 				var obj = document.getElementById("addModel");
		 				obj.style.display="none";
		 			 }
		 			 
		 			if(data.eventTyCd=="01000002"){
		 				var obj = document.getElementById("addModel");
		 				obj.style.display="";
		 			 }
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
		 
		 var obj = document.getElementById("addModel");
		 obj.style.display="none";
	}
	
</script> 
<html>
<head>
	<title>Home</title>
</head>
<body>
	<div id="content">
					
		<form name="listEventForm1"  id="listEventForm1" method="post" action="">
			
			<input type="hidden" name="currentPage" value="1"/>
			<input type="hidden" name="pageSize" value="5"/>
			
			
				<table width="100%" class="search" id="listTable" border="1">
					<tbody>
					<tr id="listTr" >
						<th style="width:20%" class="header"><label for="searchName">이벤트 명</label></th>
						<td style="width:80%">
							<input type="text" id="eventName" name="eventName">
							<button onclick="fncListEventData('1');return false;">조회</button>
						</td>
					</tr>
					</tbody>
				</table>

			</form>
		<form name="listEventForm2"  id="listEventForm2" method="post" action="">
				<input type="hidden" id='eventId' name='eventId'>
				
				<div id="listEventDiv"> 
				</div>
				
				
				
				
				<table>
				<tr>
				<td>
					<img src="<c:url value="/images/content/dot.png"/>" /> 
				</td>
				<td>
					<p>이벤트 정보</p>
				</td>
				</tr>
				</table>
				
				<table width="100%" border="1" class="detail"> 
					<br>
					<tbody>
					
					<tr>
						<th style="width:20%"><label for="">이벤트 명</label></th>
						<td style="width:30%">
							<input type="text" id='eventName' name='eventName' title='이벤트 명'>
						</td>
						<th style="width:20%"><label for="">적용 단말</label></th>
						<td style="width:30%">
							<select id="syear" name="eventTyCd">	
								<option value="01000001">전체</option>
								<option value="01000002">개별 선택</option>
							</select>
						</td>
					</tr>
					<tr>
						<th style="width:20%"><label for="">시작 날짜</label></th>
						<td style="width:30%">
							<select id="syear" name="syear" onChange="getMax(null,null,1);">
								<c:forEach var="i" begin="0" end="100">	
									<option value="${cyear+i+1900}">${cyear+i+1900}</option>
								</c:forEach>
							</select>
							<select id="smonth" name="smonth" onChange="getMax(null,null,1);">
								<c:forEach var="i" begin="1" end="12">	
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>
							<select id="sday" name="sday">
							</select>
						</td>
						<th style="width:20%"><label for="">종료 날짜</label></th>
						<td style="width:30%">
							<select id="eyear" name="eyear" onChange="getMax(null,null,2);">
								<c:forEach var="i" begin="0" end="100">	
									<option value="${cyear+i+1900}">${cyear+i+1900}</option>
								</c:forEach>
							</select>
							<select id="emonth" name="emonth" onChange="getMax(null,null,2);">
								<c:forEach var="i" begin="1" end="12">	
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>
							<select id="eday" name="eday">
							</select>
						</td>
					</tr>
					<tr>
						<th style="width:20%"><label for="">할인 율(%)</label></th>
						<td style="width:30%">
							<select id="dscnt" name="dscnt">
								<c:forEach var="i" begin="1" end="99">	
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>
						</td>
						<th style="width:20%"><label for="">사용 여부</label></th>
						<td style="width:30%">
							<select id="eventStatTyCd" name="eventStatTyCd">	
								<option value="00500001">사용</option>
								<option value="00500002">중지</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>모델 등록</th>
						<td colspan="3" align="center"><a style="display:none;" id="addModel" href="#" onclick="fncAddModel();return false;">모델 등록</a></td>
					</tr>
					</tbody>
				</table>

				
				
				<div id="btn_sctn" align="right">
					<button onclick="fncEventDetailClear();return false;">신 규</button>
					<button onclick="fncSaveEventAction();return false;">저 장</button>
					<button onclick="fncDelEvent();return false;">삭 제</button>
				</div>
				
		</form>
	</div>
</body>
</html>
