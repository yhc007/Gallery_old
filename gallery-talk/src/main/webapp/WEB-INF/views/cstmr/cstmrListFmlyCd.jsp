<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>
<%@ include file="/WEB-INF/views/include/timerLib.jsp"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script type="text/javascript">
function goIndexForm(){
	location.replace("${ctxPath}/cstmr/indexCstmrForm.do");
};

function fncSelectFmlyCd(cstmrId,cstmrName,cstmrCd){
	
	var form=document.createElement("form");
	  form.name='tempPost';
	  form.method='post';
	  form.action='${ctxPath}/sale/indexSetFmlyCd.do';  
	  
	  var input=document.createElement("input");
	  input.type="hidden";
	  input.name='cstmrId';
	  input.value= cstmrId;
	  $(form).append(input);
	  
	  var input2=document.createElement("input");
	  input2.type="hidden";
	  input2.name='cstmrName';
	  input2.value= cstmrName;
	  $(form).append(input2);
	  
	  var input3=document.createElement("input");
	  input3.type="hidden";
	  input3.name='cstmrCd';
	  input3.value= cstmrCd;
	  $(form).append(input3);
	  
	  $('#body').append(form); 
	  form.submit();
	  
};

function goRegistForm(){
	//location.replace("${ctxPath}/cstmr/mNewCstmrTabForm.do");
	var form=document.createElement("form");
	  form.name='tempPost';
	  form.method='post';
	  form.action='${ctxPath}/cstmr/mNewCstmrTabForm.do';  
	  
	  var input=document.createElement("input");
	  input.type="hidden";
	  input.name='cstmrName';
	  input.value= '${srchCstmr.cstmrName}';
	  $(form).append(input);
	  $('#body').append(form); 
	  form.submit();
};

	function fncGoStaffPage(shopId){
		
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
	function staffLogin(staffId) {
		
		var form = document.createElement("form");
		form.name = 'tempPost';
		form.method = 'post';
		form.action = '${ctxPath}/staff/staffLogin.do';
	
		var input=document.createElement("input");
		  input.type="hidden";
		  input.name='staffId';
		  input.value= staffId;
		  $(form).append(input);
		  $('#body').append(form); 
		  form.submit();
	};


	var srchType = "";
	
	function findInFind(ty){
		var title = "";
		if(ty=="num"){
			title = "고객코드";
			srchType = "cstmrCd";
		}else if(ty=="name"){
			title = "이름";
			srchType = "cstmrName";
		}else if(ty=="cel"){
			title = "휴대폰";
			srchType = "cellphone";
		}else if(ty=="tel"){
			title = "전화번호";
			srchType = "telephone";
		}else if(ty=="addr"){
			title = "주소";
			srchType = "addr";
		}else if(ty=="birth"){
			title = "생년월일";
			srchType = "birthDay";
		}
		
		$.ajax({  
			url: '${ctxPath}/cstmr/findInFind.do'
			, type: "POST"
			, dataType: "html"
			, beforeSend: function(xhr){
				
			}
			, success:  function(data) {
				jQuery('#dialog').html(data);
			}	
		});	// end ajax	
		
		$('#dialog').dialog({
			//bgiframe: true
			 title: title
			 , modal: true
		     , width: 400 // 가로 크기
		     , background: "#000"
		     , position:{my:"center",at:"bottom",of:"#tile" }
			 , close: function(event, ui){
			}, success:  function(data) {
				
			} 
		});	
	}
	

	function reFind(){
		var cstmrName = window.sessionStorage.getItem("cstmrName");
		var val = $("#find").val();
		
		var form = document.createElement("form");
		form.name = 'tempPost';
		form.method = 'post';
		form.action = '${ctxPath}/cstmr/cstmrListForm.do';

		var param = document.createElement("input");
		param.setAttribute("type", "hidden");
		param.setAttribute("name", "cstmrName");
		param.setAttribute("value", cstmrName);
		
		
		var param2 = document.createElement("input");
		param2.setAttribute("type", "hidden");
		param2.setAttribute("name", srchType);
		param2.setAttribute("value", val);
		
		
		$(form).append(param);
		$(form).append(param2);
		$('#body').append(form);
		form.submit();
		
		
	}
	
	function goPrdctPayment(){
		//location.replace("${ctxPath}/prdct/indexPrdctPaymentForm.do");
		location.href="${ctxPath}/prdct/indexPrdctPaymentForm.do";
	};
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="format-detection" content="telephone=no, address=no, email=no" />
<title>Untitled Document</title>
<style type="text/css">
	#tr{
    	background: rgba(255, 255, 255, 0.5);
		}
</style>
</head>

<body>
<center>
<table class="listShop transBoxTable" width="800" border="0.5" style="font-size: 16px" >
	<colgroup>
		<col width="196">
		<col width="76">
		<col width="233">
		<col width="161">
		<col width="118">
	</colgroup>
	
	<tr>
		<td height="26" onclick="staffLogin(${staffVo.staffId});return false;" >매장고객</td>
		<td height="26">&nbsp;</td>
		<td height="26">&nbsp;</td>
		<td height="26">&nbsp;</td>
		<td height="26" onclick="fncGoStaffPage(${shopVo.shopId});return false;" >Log-out</td>
	</tr>
			
  <tr>
    <td height="78" colspan="6"><div class="head_title">고객 포인트 카드 선택</div></td>
    </tr>
  <tr>
    <td colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
  </tr>

			<tr id="tr">
				<!-- <td onclick="findInFind('num')">번호</td>
				<td>이름</td>
				<td onclick="findInFind('addr')">주소</td>
				<td onclick="findInFind('tel')">전화번호</td>
				<td onclick="findInFind('cel')">휴대폰</td>
				<td onclick="findInFind('birth')">생년월일</td> -->
				<td>번호</td>
				<td>이름</td>
				<td>주소</td>
				<td>전화번호</td>
				<td>휴대폰</td>
				<td>생년월일</td>
			</tr>
			<tr>
    <td colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />" width="100%" height="1" /></td>
  </tr>
  <c:choose>
		<c:when test="${!empty listcstmr}">
	   		<c:forEach var="cstmr" items="${listcstmr}" varStatus="status">
				<tr height="40px" onclick="fncSelectFmlyCd('${cstmr.cstmrId}','${cstmr.cstmrName }','${cstmr.cstmrCd}');return false;" class="listData">		
					<td width="10%">${cstmr.cstmrCd }</td>
					<td width="10%">${cstmr.cstmrName }</td>
					<td width="30%">${cstmr.addr }</td>
					<td width="20%">${cstmr.telephone}</td>
					<td width="20%">${cstmr.cellphone }</td>
					<td width="10%">${cstmr.birthDay }</td>
				</tr>
				<tr>
			     <td colspan="6"><img src="<c:url value="/images/content/Whiteline.jpg" />"  width="100%" height="1" /></td>
			    </tr>		
			</c:forEach>
		</c:when>		
		<c:otherwise>
			<tr>					
				<td colspan="6" align="center">고객이 없습니다.</td>	
			</tr>
		</c:otherwise>
	</c:choose>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
	<tr>
	    <td colspan="6">
	    	<center>
	    		<a href="#" onclick="goPrdctPayment();return false;">
	    			<img src="<c:url value="/images/content/back.png" />" width="72" height="72" ></img>
	    		</a>
	    	</center>
	    </td>
    </tr>
	<tr>
	
    	<td colspan="6">결제 페이지로</td>
	</tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</center>

<div id="dialog">

</div>
</body>
</html>
