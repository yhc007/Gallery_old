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
	$(function(){
	//	getCstmrPoint();
	});
	
	var cstmrCd;
	function getCstmrPoint(){
		$("#cstmrList").css("display","none");
		var cstmrName = $("#cstmrName").val();
		var cstmr4Digit = $("#cstmr4Digit").val();
		
		if(!cstmrName || !cstmr4Digit){
			alert('검색 조건을 채워주세요.');
			return;
		}
		
		$("#loader").css("display","inline");

		
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
				$("#loader").css("display","none"); 
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
	#cstmrList{
		display : none;
	}
	#loader{
		display :none;
	}
</style>
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon" type="image/x-icon" />
<title>Gallery Manager</title>
</head>
<body>
	<CenteR>
		고객명:<input type="text" id="cstmrName" data-role="none" size="7" onkeydown="if (event.keyCode == 13)getCstmrPoint() " >
		4자리:<input type="text" id="cstmr4Digit" data-role="none" size="7" onkeydown="if (event.keyCode == 13)getCstmrPoint() " >
		<button onclick="getCstmrPoint();" data-role="none" >검색</button>
		<br><Br>
	
	<img alt="" src="${ctxPath }/images/loader.gif" id="loader">
	<div id='cstmrPointList' width='50%'></div>
	<!-- <table id="cstmrList" width="50%" >
		<tr>
			<td id="title">포인트 : </td><td id="point"></td><td><button onclick="showPrompt();" data-role="none">수정</button> </td>
		</tr>
	</table > -->	
	</Center>
	
</body> 
</html>