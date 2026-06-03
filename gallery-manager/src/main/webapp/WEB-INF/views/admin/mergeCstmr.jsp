<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>
<script type="text/javascript">
	$(function() {
	    $( "#cstmrTabs" ).tabs();
	    
	    var date = new Date();
		var year_c = date.getFullYear();
		var year_tg = date.getFullYear()-3;
		var month = addZero(String(date.getMonth() + 1));
		var day = addZero(String(date.getDate()));
		
		today = year_c + "-" + month + "-" + day;
		
		$("#tgDay").val(year_tg + "-" + month + "-" + day);
	});

	function getCstmrForMerge(){
		$("#loader1").css("display","inline");
		$("#cstmrList").html("");
		var cstmrName = $("#cstmrName").val();
		var cstmr4Digit = $("#cstmr4Digit").val();
		var url = "${ctxPath}/cstmr/getCstmrForMerge.do";
		var param = "cstmrName=" + cstmrName + 
						"&digit4=" + cstmr4Digit;
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#cstmrListMerge").html(data);
				$("#loader1").css("display","none");
			}
		});
	}
	
	function getCstmrForRemove(){
		$("#loader2").css("display","inline");
		$("#cstmrList").html("");
		var cstmrName = $("#cstmrNameDel").val();
		var cstmr4Digit = $("#cstmr4DigitDel").val();
		var url = "${ctxPath}/cstmr/getCstmrForRemove.do";		
		var param = "cstmrName=" + cstmrName + 
						"&digit4=" + cstmr4Digit;
		
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#cstmrListRemove").html(data);
				$("#loader2").css("display","none");
			}
		});
	}
	
	var listCstmrCd = new Array();
	function mergeHistory(){
		var DS = $('input[name="merge_info"]:checked').val();
		var SC = $('input[name="merge_info"]:not(:checked');
		console.log('DS:'+DS);
		var size = SC.length;
		var jsonSC = {
				arraySC : []				
		}
		
		for(var i=0;i<size;i++){
			jsonSC.arraySC.push(SC[i].value);
		}
		
		jsonSC = JSON.stringify(jsonSC);
		
		if(SC.length==0){
			alert("통합할 코드가 선택되지 않았습니다.");
			return;
		}
		if(DS==""	){
			alert("통합할 코드가 선택되지 않았습니다.");
			return;
		}
		
		if(confirm("통합하시겠습니까?\n삭제코드의 고객은 지워집니다.")==false){
			return;
		}
		var param = "jsonSC=" + jsonSC + 
						"&DS=" + DS;
		 
		var url = "${ctxPath}/cstmr/mergeCstmr.do";		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				console.log(data);
				if(data=="success"){
					getCstmrForMerge();
					alert("통합되었습니다.");
				}
			}
		});
		
	}
	
	function delCstmr(input){
		//console.log('input id:'+input);
		var url = "${ctxPath}/cstmr/removeCstmr.do";
		var param = "SCID="+input;
		//console.log(param);
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				//console.log(data);
				if(data=="success"){
					getCstmrForRemove();
					alert("삭제되었습니다.");
					
				}
			}
		});
	}
	
	
	var cstmrCd;
	function getCstmrPoint(){
		$("#cstmrList").css("display","none");
		var cstmrName = $("#cstmrNamePoint").val();
		var cstmr4Digit = $("#cstmr4DigitPoint").val();
		if(!cstmrName || !cstmr4Digit){
			alert('검색 조건을 채워주세요.');
			return;
		}
		
		$("#loader3").css("display","inline");
		
		var url = "${ctxPath}/cstmr/getCstmrCd.do";
		var param = "cstmrName=" + cstmrName + 
						"&digit4=" + cstmr4Digit;		
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$('#cstmrPointList').html('');
				$('#cstmrPointList').html(data);
				/* var item = data.split("/");
				var point = item[0];
				cstmrCd = item[1]; */
				/* $("#cstmrList").css("display","inline");
				$("#point").html(format(point*100));*/
				$("#loader3").css("display","none"); 
			}
		});
	}
	
	function runPointExpire(){
		//$("#cstmrList").css("display","none");
		var slctDate = $("#tgDay").val();
		
		if(! confirm("["+slctDate+"] 이전 포인트가 정리됩니다.\n이 작업은 최대 10분 정도 소요되며 전체 포인트 관련 시스템이 일시 정지 되므로 매장 영업시간 이후로 부탁드립니다.\n실행 하시겠습니까? 실행 후 되돌릴 수 없습니다.")){
			return;
		}
		// 대상 날짜 출력.
		// 1년전 날짜.
		
		$("#loader4").css("display","inline");
		
		var url = "${ctxPath}/point/expirePoint.do";
		var param = "crtDate=" + today + "&tgtDate=" + slctDate ;		
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data){
				$("#loader4").css("display","none");
				
				if(data == 'OK'){
					alert("성공");
				}else{
					alert("포인트 정리 작업이 실패하였습니다. 전산실에 문의 바랍니다. (tel : 051 - 442 - 0335)");	
				}
			}
		});
	}
	
	
	
	function removeComma(str){
		if(!str){str='0';}
		//console.log('removeComma:'+str);
		str = str.toString();
		var result = str.replace(/,/gi,"");
		result = parseInt(result,10);
		return result;
	}
	
	
	function addComma(x) {
		if(!x){x=0;}
		//console.log('addComma:'+x);
		x = removeComma(x);
		x = parseInt(x,10);
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function format(n) {
		  var reg = /(^[+-]?\d+)(\d{3})/;   
		  n += '';                          

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');

		  return n;
	}
	
	function addZero(str){
		if(str.length=="1"){
			str = "0" + str;
		}
		return str;
	}
	
</script>
<style type="text/css">
	#loader1{
		display : none;
	}
	#loader2{
		display : none;
	}
	#loader3{
		display : none;
	}
	#loader4{
		display : none;
	}
</style>
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
</head>
<body>

	<div id="cstmrTabs">
	  <ul>
	    <li><a href="#cstmrTab1">고객 통합</a></li>
	    <li><a href="#cstmrTab2">고객 삭제</a></li>
	    <li><a href="#cstmrTab3">포인트 관리</a></li>
	    <li><a href="#cstmrTab4">포인트 만료</a></li>
	  </ul>
	  <div id="cstmrTab1" align='center'>
				고객명 <input type="text" id="cstmrName" data-role="none" size="7"
					onkeydown="if (event.keyCode == 13)getCstmrForMerge() ">
				4자리 <input type="text" id="cstmr4Digit" data-role="none" size="4"
					onkeydown="if (event.keyCode == 13)getCstmrForMerge() ">
				<button onclick="getCstmrForMerge();" data-role="none">검색</button>
				<br>
				<Br> <img alt="" src="${ctxPath }/images/loader.gif"
					id="loader1">
				<table id="cstmrListMerge" width="50%">
				</table>
	</div>
		
	<div id="cstmrTab2" align='center'>
	    	고객명 <input type="text" id="cstmrNameDel" data-role="none" size="7"
					onkeydown="if (event.keyCode == 13)getCstmrForRemove() ">
				4자리 <input type="text" id="cstmr4DigitDel" data-role="none" size="4"
					onkeydown="if (event.keyCode == 13)getCstmrForRemove() ">
				<button onclick="getCstmrForRemove();" data-role="none">검색</button>
				<br>
				<Br> <img alt="" src="${ctxPath }/images/loader.gif"
					id="loader2">

				<table id="cstmrListRemove" width="50%">
				</table>
	</div>
	  <div id="cstmrTab3" align='center'>
	    고객명<input type="text" id="cstmrNamePoint" data-role="none" size="7" onkeydown="if (event.keyCode == 13)getCstmrPoint() " >
		4자리<input type="text" id="cstmr4DigitPoint" data-role="none" size="7" onkeydown="if (event.keyCode == 13)getCstmrPoint() " >
		<button onclick="getCstmrPoint();" data-role="none" >검색</button>
		<br><Br>		
		<img alt="" src="${ctxPath }/images/loader.gif" id="loader3">
		<div id='cstmrPointList' style='width:100%;'></div>
	  </div>
	  <div id="cstmrTab4" align='center'>
	  	<table>
	  		<tr>
	  			<td>기준일 :</td>
	  			<td><input type="date" data-role="none" id="tgDay"/></td>
	  			<td><button onclick="runPointExpire();" data-role="none" >정리</button></td>
	  		</tr>
	  	</table>
		
		<br><Br>		
		<img alt="" src="${ctxPath }/images/loader.gif" id="loader4">
		<div id='cstmrPointList' style='width:100%;'></div>
	  </div>
	</div>
	
	
</body> 
</html>