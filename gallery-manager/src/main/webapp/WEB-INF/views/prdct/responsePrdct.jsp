<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	$(function(){
		getReeustData();
	});
	
	function getReeustData(){
		var url = "${ctxPath}/prdct/getReqstPrdct.do";
		
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			success : function(data){
				console.log(data)
				$("#reqstTbl").html(data);
			}
		});
	};
</script> 
<style>
	#reqstTbl{
		width: 80%;
	}
</style>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<center>
		<table id="reqstTbl" border="1">
		
		</table>
	</center>
</body>
</html>
