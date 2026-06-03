<%@ page language="java" pageEncoding="UTF-8"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" scope="request"/> 

<script>
	setInterval(function(){fncGoStaffPage('${shopVo.shopId}');},900000);
	
	function fncGoStaffPage(shopId){
		//alert("shopId:"+shopId);
		console.log("shopId:"+shopId);
		var form=document.createElement("form");
		form.name='tempPost';
		form.method='post';
		form.action='${ctxPath}/staff/indexStaffForm.do';  
		  
		var input=document.createElement("input");
		input.type="hidden";
		input.name='shopId';
		input.value= shopId;
		$(form).append(input);
		$('#body').append(form); 
		form.submit();
	};
	
</script>