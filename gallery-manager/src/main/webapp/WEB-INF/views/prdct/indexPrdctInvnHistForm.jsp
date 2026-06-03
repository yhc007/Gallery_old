<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">
	google.load("visualization", "1", {packages : [ "corechart" ]});
</script>
<script>
	
	//----------------------
	//화면 초기 실행 
	jQuery(document).ready(function(){
		fncListPrdctInvnHistData();
		//fncListPrdctInvnHistDataOutPut();	
		getPrdctInfo();
		getBrand();
	});
	//----------------------
	
	function chkManager(){
		$("#ManagerDiv").dialog({
			title : "비밀번호",
			width : 300,
			height : 150
		});
	}
	
	
	function goShopSalesPage(){
		var pwd = $("#pwd").val();
		
		var param = "shopId=" + shopId + 
						"&pwd=" + pwd;
		var url = "${ctxPath}/shop/chkManager.do";
		
		$.ajax({
			url : url,
			data : param,
			dataType : "text",
			type : "post",
			success : function(data){
				if(data=="success"){
					location.href='${ctxPath}/sale/indexSalesHistForm.do';			
				}else{
					alert("비밀번호가 일치하지 않습니다.");
					$("#pwd").focus();
				}
			}
		});
		
	}
	
	//출고 
	var sort2 = "D";
	function fncListPrdctInvnHistDataOutPut(ty){
		
		if(typeof(ty)=="undefined"){
			 ty = "regtime";
		}
		
		
		var url = '${ctxPath}/prdct/fncListPrdctInvnHistDataOutPut.do';
		/* if(no){
			jQuery('#listPrdctForm1 input[name=currentPage]').val(no);
		}	 */		
		
		var param = jQuery('#listPrdctForm1').serialize() + 
						"&shopId=" + shopId + "&sort=" + ty + sort2;
		
		if(sort=="D"){
			sort = "A";
		}else{
			sort = "D";
		}
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listBrandDiv').html(data);
			}
			
		});  
		
	}
	
	/* 차트 */
	 function drawChartCountry(k,f,u) {
		console.log(k + "/" + f)
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          	['국산',     Number(k)],
          	['수입',      Number(f)],
          	['UD',      Number(u)],
        ]);

        var options = {
          title: '국산 / 수입',
          chartArea: {'width': '90%', 'height': '90%'},
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        chart.draw(data, options);
      }
	
	
	
	
	 function drawChartFunction(f,o,w,s,z) {
		 console.log(f,o,w,s,z)
	        var data = google.visualization.arrayToDataTable([
	          ['T11', 'Hours per Day'],
	          	['도수용',     Number(f)],
	          	['고글',     Number(o)],
	          	['수경',     Number(w)],
	          	['선글라스',     Number(s)],
	          	['돋보기',     Number(z)] 
	          
	        ]);

	        var options = {
	          title: '기능별 비율',
	          chartArea: {'width': '90%', 'height': '90%'},
	        };

	        var chart = new google.visualization.PieChart(document.getElementById('piechart_function'));
	        chart.draw(data, options);
	      }
	
	 
	 function drawShape(f,h,n) {
		 console.log(f,h,n)
	        var data = google.visualization.arrayToDataTable([
	          ['T11', 'Hours per Day'],
	          	['온테',     Number(f)],
	          	['반무테',     Number(h)],
	          	['무테',     Number(n)] 
	          
	        ]);

	        var options = {
	          title: '타입별 비율',
	        	  chartArea: {'width': '90%', 'height': '90%'},
	        };

	        var chart = new google.visualization.PieChart(document.getElementById('piechart_shape'));
	        chart.draw(data, options);
	      }
	
	/*
	 * 고객 데이타 리스트 보드 페이징
	 */
	var brandId;
	var prdctId;
	var shopId = ${shopId};
	var sort = "D";
	function fncListPrdctInvnHistData(ty){
		
		if(typeof(ty)=="undefined"){
			 ty = "regtime";
		}
		
		
		var url = '${ctxPath}/prdct/listPrdctInvnHistData.do';
		/* if(no){
			jQuery('#listPrdctForm1 input[name=currentPage]').val(no);
		}	 */		
		
		var param = jQuery('#listPrdctForm1').serialize() + 
						"&shopId=" + shopId + "&sort=" + ty + sort;
		
		if(sort=="D"){
			sort = "A";
		}else{
			sort = "D";
		}
		//javax
		 $.ajax({
			url		: url,
			type 	: "post",
			data 	: param,
			dataType	: "html",
			beforeSend	: function(){
			},
			success: function(data){
				jQuery('#listBrandDiv').html(data);
			}
			
		});  
		
	}
	
	
	function getPrdctInfo(){
		var param = "shopId=" + shopId;
		var url = "${ctxPath}/prdct/getPrdctType.do";
		
		$.ajax({
			url : url,
			dataType :"json",
			data : param,
			type : "post",
			success : function(data){
				console.log(data)
				var undefined = data.total - data.korea - data.forign;
				google.setOnLoadCallback(function(){drawChartCountry(data.korea, data.forign, undefined)}, true);
				google.setOnLoadCallback(function(){drawChartFunction(data.g,data.o,data.w,data.s,data.z)}, true);
				google.setOnLoadCallback(function(){drawShape(data.sfull,data.shalf,data.sud)}, true);
				
				$("#total").text(format(data.total) + "개");
				$("#korea").text(format(data.korea) + "개");
				$("#forign").text(format(data.forign) + "개");
				$("#G").text(format(data.g) + "개");
				$("#O").text(format(data.o) + "개");
				$("#W").text(format(data.w) + "개");
				$("#S").text(format(data.s) + "개");
				$("#Z").text(format(data.z) + "개");
				$("#full_").text(format(data.full_) + "개");
				$("#half_").text(format(data.half_) + "개");
				$("#no_").text(format(data.no_) + "개");
			}
		});
	}
	
	
	function format(n) {
		  var reg = /(^[+-]?\d+)(\d{3})/;   
		  n += '';                          

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');

		  return n;
		}
	
	//삭제
	function fncDelPrdctInvnHist(){
		
		if(jQuery('#listPrdctForm2 input[name=prdctId]').val() == ""){
			return;
		} 
				
		var url = '${ctxPath}/prdct/removePrdctAction.do';
		  	
		var param = jQuery('#listPrdctForm2').serialize();
		 
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
					fncListPrdctInvnHistData();
				}else if(data == "fail"){
				}
				
				  //성공시....
				 
			}
			
		}); 
		
	}
	
	
	/*
	 * 재고 이력 상세 
	 */
	function fncGetPrdctInvnHistInfo(invnHistId){
		//alert("data="+invnHistId);
		jQuery.ajax({  
			url: '${ctxPath}/prdct/popupPrdctInvnHistForm.do'
			, type: "POST"
			, data: "invnHistId="+invnHistId
			, dataType: "html"
			, beforeSend: function(xhr){
				
			}
			, success:  function(data) {
				jQuery('#dialog').html(data);
			}	
		});	// end ajax	
		
		jQuery('#dialog').dialog({
			//bgiframe: true
			 title: "이력 상세"
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
	
	//브랜드 리스트 
	function getBrand(){
		var brandName = $("#srchBrand").val();
		var url = "${ctxPath}/invn/srchBrand.do";
		var param = "brandName=" + brandName;
		
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				$("#brandId").html(data);
				
			}
		});
	}
	
	//모델 선택
	function getPrdctList(){
		var brandId = $("#brandId").val();
		var param = "brandId=" + brandId + 
						"&comTy=1";

		var url = "${ctxPath}/prdct/getPrdctListByBrand.do";
	
		$.ajax({
			url : url,
			dataType : "html",
			type : "post",
			data : param,
			success : function(data){
				$("#prdctId").html(data);
			}
		})
	}
	
	function getPrdct(){
		var prdctName = $("#srchPrdct input[id='srchPrdct']").val();
		var brandId = $("#brandId").val(); 
		var url = "${ctxPath}/invn/srchingPrdct.do";
		var param = "PrdctName=" + prdctName + 
						"&shopTy=shop" + 
						"&brandId=" + brandId + 
						"&comTy=1";
		$.ajax({
			url : url,
			dataType : "text",
			type : "post",
			data : param,
			success : function(data){
				$("#prdctId").html(data);
			}
		});
	}
</script>
<style>
	#piechart{
		float: left;
	}
	#ManagerDiv{
		display: none;
	}
</style> 
<html>
<head>
	<title>Home</title>
</head>
<body>
	<div id="content">
			
			<Table id="srchPrdct"  width="90%" border="1" style="border-collapse: collapse; text-align: center">
			<form id="srchForm">
				<tr>
					<th>브랜드</th> <td><input type="text" id="srchBrand" onkeyup="getBrand()" size="10"><select id="brandId" onchange="getPrdctList();">
																						<option>선택</option>
																					</select> </td>  
					<th>모델명</th><td><input type="text" id="srchPrdct" onkeyup="getPrdct()" size="10"><select id="prdctId">
																						<option>선택</option>
																					</select> </td>
					<td>
						<button onclick="fncListPrdctInvnHistData(); return false;">검색</button>
					</td>
				</tr>
			</form>
		</table>
		<br>
 			<table width="100%">
 				<tr>
 					<td width="33%"><div id="piechart" style="width: 300px; height: 300px;"></div></td> 
 					<td width="33%"><div id="piechart_function" style="width: 300px; height: 300px;"></div></td> 
 					<td width="33%"><div id="piechart_shape" style="width: 300px; height: 300px;"></div></td>
 				</tr>
 			</table>
 			
 			
 			<!-- <table class="prdctIno" width="100%" border="1" style="border-collapse: collapse;" >
 				<tr>
 					<th width="8%">총 수량</th><td width="8%" id="total" style="text-align: right;">  </td>
 					<th width="8%">국산</th><td width="8%" id="korea" style="text-align: right;"></td>
 					<th width="8%">수입</th><td width="8%" id="forign" style="text-align: right;"> </td>
 					<th width="8%">온테</th><td width="8%" id="full_" style="text-align: right;"></td>
 					<th width="8%">반무테</th><td width="8%" id="half_" style="text-align: right;"></td>
 					<th width="8%">무테</th><td width="8%" id="no_" style="text-align: right;"></td>
 				</tr>
 				<tr>
 					<th width="8%">도수용</th><td id="G" style="text-align: right;">  </td>
 					<th width="8%">고글</th><td id="O" style="text-align: right;"></td>
 					<th width="8%">선글라스</th><td id="S" style="text-align: right;"></td>
 					<th width="8%">수경</th><td id="W" style="text-align: right;"></td>
 					<th width="8%">돋보기</th><td id="Z" style="text-align: right;"></td>
 					<th width="8%"></th><td id=""></td>
 				</tr>
 			</table> -->
 			<center><button onclick="fncListPrdctInvnHistData()">입고</button> <button onclick="fncListPrdctInvnHistDataOutPut()">출고</button></center>
			<form name="listPrdctForm2"  id="listPrdctForm2" method="post" action="">
					<input type="hidden" id='prdctId' name='prdctId'>
					<input type="hidden" id='prdctStatTyCd' name='prdctStatTyCd' value="00100001">
							
					<div id="listBrandDiv"></div>			
			</form>
		</div>
		<div id="dialog"></div>
	
	
<div id="ManagerDiv">
<center>
<!-- onkeypress="if(event.keyCode==13){goShopSalesPage();}" -->
	<input type="password" id="pwd" onkeypress="if(event.keyCode==13){goShopSalesPage();}"><br>
	<button onclick="goShopSalesPage();" >확인</button>
</center>
</div>

</body>
</html>
