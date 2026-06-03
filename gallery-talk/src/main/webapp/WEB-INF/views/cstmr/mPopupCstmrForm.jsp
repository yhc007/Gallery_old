<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script>
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
	});
	//----------------------
	var mCstmrCd;
	function fncSelectCstmr(cstmrCd){
		mCstmrCd=cstmrCd;
	};
	function fncSelectComplete(){
		num=${num};
		if(num==1){
			jQuery('#cstmrInfoForm input[name=cstmrInfo1]').val(mCstmrCd);
		}else if(num==2){
			jQuery('#cstmrInfoForm input[name=cstmrInfo2]').val(mCstmrCd);
		}
		fncCancel();
	};
	function fncCancel(){
		jQuery('#dialog').dialog( 'close' );
		jQuery('#dialog').html('');
		/*
		jQuery('#dialog').dialog( 'close' );
		jQuery('#dialog').html('');
		*/
	};
	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncListCstmrData(){
		var url = '${ctxPath}/cstmr/listCstmrData.do';			  	
		var param = jQuery('#cstmrSearchForm').serialize();
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){   
				jQuery('#listCstmrBody').html(data);
			}
			
		});
	};
	
	 
</script> 
<html>
<head>
</head>
<body>
	<div align="left" style="width:100%">
	<div id="content" style="width:100%">
		<form name="cstmrSearchForm"  id="cstmrSearchForm" method="post" action="">
			<table style="width:100%" class="search" id="listTable" border="1" rules="none">
				
				<tbody>
				<tr>
					<th style="width:25%">
						<font size="1">이름</font>
					</th>
					<td style="width:60%">
						<input type="text" size="11" id="cstmrName" name="cstmrName"/>
					</td>
					<td style="width:15%">
						<button onclick="fncListCstmrData();return false;"><font size="1">조회</font></button>
					</td>
				</tr>
				
				</tbody>
			</table>
		</form>
		<form name="cstmrListForm"  id="cstmrListForm" method="post" action="">
			<input type="hidden" id="cstmrLoginIdAt" name="cstmrLoginIdAt"/>
						
			<table style="width:100%;height:30%" class="listTable" id="listTable" border="1">
				<colgroup>
					<col width="15%">
					<col width="85%">
				</colgroup>
				<thead>
					<tr>
						<th class="c1">코드 번호</th>
						<th class="c2">프로필</th>
					</tr>
				</thead>
				<tbody>
				
				<tr>
				<td colspan="2">
					<div class="byscrll" style="height:100px;overflow:auto;" >
					<table>
						<colgroup>
							<col width="15%">
							<col width="85%">
						</colgroup>
						<tbody id="listCstmrBody">
						</tbody>
					</table>
					</div>
				</td>
				</tr>
			</table>			
				
			
			<div align="right">
				<button onClick="fncSelectComplete();return false"><font size="1">선택</font></button>&nbsp;&nbsp;
				<button onClick="fncCancel();return false"><font size="1">취소</font></button>
			</div>
		</form>
		
	</div>
	</div>
</body>
</html>
