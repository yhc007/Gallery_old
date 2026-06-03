<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(String(date.getMonth() + 1));
		var day = addZero(String(date.getDate()));
		var today = year + "-" + month + "-" + day;
		$("#sdate").val(today);
		$("#edate").val(today);
		
		jQuery('#listDlvrForm1 input[name=syear]').val('${cyear}');
		jQuery('#listDlvrForm1 input[name=eyear]').val('${cyear}');
		
		
		//getMax('${cyear}','${cmonth}',1);
		//getMax('${cyear}','${cmonth}',2);
		
		
		jQuery('#listDlvrForm1 select[name=smonth]').val('${cmonth}');
		jQuery('#listDlvrForm1 select[name=sday]').val('${cday}');
		jQuery('#listDlvrForm1 select[name=emonth]').val('${cmonth}');
		jQuery('#listDlvrForm1 select[name=eday]').val('${cday}');
	});
	//----------------------
	
	function addZero(n	){
		if(n.length=="1"){
			console.log("log")
			n = "0"+ n;
		}
		return n;
	}
	/*
	 * 년 월의 마지막 일 획득
	 */
	function getMax(year,month,tp){
		if(tp==1){
			if(year==null||month==null){
				year= jQuery('#listDlvrForm1 input[name=syear]').val();
				month= jQuery('#listDlvrForm1 select[name=smonth]').val();
			}
			form= document.getElementById("sday"); //jQuery('#cstmrInfoForm select[name=bday]');
			getMaxOfMonth(year,month,form);
		}
		
		if(tp==2){
			if(year==null||month==null){
				year= jQuery('#listDlvrForm1 input[name=eyear]').val();
				month= jQuery('#listDlvrForm1 select[name=emonth]').val();
			}
			form= document.getElementById("eday"); //jQuery('#cstmrInfoForm select[name=bday]');
			getMaxOfMonth(year,month,form);
		}
	}
	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	function fncListDlvrData(){
		var sdate = $("#sdate").val();
		var syear = sdate.substring(0,4);
		var smonth = sdate.substring(5,7);
		var sday = sdate.substring(8,10);
		
		var edate = $("#edate").val();
		var eyear = edate.substring(0,4);
		var emonth = edate.substring(5,7);
		var eday = edate.substring(8,10);
		
		
		var url = '${ctxPath}/dlvr/listDlvrData.do';
		var param = jQuery('#listDlvrForm1').serialize() + 
				"&syear=" +syear + "&smonth=" + smonth + "&sday=" +sday +
				"&eyear=" +eyear + "&emonth=" + emonth + "&eday=" +eday;
		 
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listDlvrBody').html(data);
			}
			
		});  
		
	}
	
	
	
</script> 
<html>
<head>
	<title>Home</title>
</head>
<body>
	<div id="content" style="width:100%">
					
			<form name="listDlvrForm1"  id="listDlvrForm1" method="post" action="">
				
				<table border="1" class="search" width="100%">
					<tbody>
					<tr>
						<th style="width:10%"><label for="searchPrdct">매장</label></th>
						<td style="width:15%" align="center">
							<select id='shopId' name='shopId' title='매장 명'>
								<option value="-1">전체</option>
								<c:forEach items="${listShop}" var="item" varStatus="status">
									<option value="${item.shopId}">${item.shopName}</option>
								</c:forEach>
							</select>
						</td>
						
						<%-- <th style="width:10%"><label for="searchBrand">브랜드</label></th>
						<td style="width:13%" align="center">
							<select id='brandId' name='brandId' title='브랜드 명'>
								<option value="-1">전체</option>
								<c:forEach items="${listBrand}" var="item" varStatus="status">
									<option value="${item.brandId}">${item.brandName}</option>
								</c:forEach>
							</select>
						</td> --%>
						<th style="width:10%"><label for="searchName">고객 명</label></th>
						<td style="width:13%">
							<input id="cstmrName" name="cstmrName">
						</td>
						<td style="width:37%">
							<table border="0" width="100%">
							<tr>
							<td>
							<%-- <input id="syear" name="syear" size="1" maxlength="4">
							<select id="smonth" name="smonth" onChange="getMax(null,null,1);">
								<c:forEach var="i" begin="1" end="12">	
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>
							<select id="sday" name="sday">
							</select> --%>
							<input type="date" id="sdate">
							</td>
							<td rowspan="2" align="right">
							<button onclick="fncListDlvrData('1');return false;">조회</button>
							</td>
							</tr>
							<tr>
								<td>
								<input type="date" id="edate">
								</td>
							</tr>
							</table>
						</td>					
					</tr>
					</tbody>
				</table>
 
 			</form>
			<form name="listDlvrForm2"  id="listDlvrForm2" method="post" action="">
				<input type="hidden" id='prdctId' name='prdctId'>
				<input type="hidden" id='prdctStatTyCd' name='prdctStatTyCd' value="00100001">
				
				
				<table style="width:100%;height:300" class="list" id="listTable" border="1">
					<colgroup>
						<col width="10%">
						<col width="10%">
						<col width="40%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr>
							<th>판매 코드</th>
							<th>고객 이름</th>
							<th>주소</th>
							<th>전화번호</th>
							<th>배송 상태</th>
							<th>등록 일시</th>
							<th>수정 일시</th>
						</tr>
					</thead>
					<tbody>
					
					<tr>
						<tbody id="listDlvrBody">
						</tbody>
					</tr>
				</table>				
			</form>
		</div>
		<div id="dialog"></div>
</body>
</html>
