<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<html>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type='text/javascript' src='https://www.google.com/jsapi'></script>

<%
	Integer shopId = (Integer)session.getAttribute("shopId");
%>
<script type="text/javascript">
	google.load("visualization", "1", {packages : [ "corechart" ]});
	google.load('visualization', '1', {packages:['gauge']});
</script>

<script type="text/javascript">
	var staffId;
	var selectStaff;
	var staffShop;
	var prdctTy = "00300001";
	var prevButton;
	var nextButton;
	var current = 0;
	var shopCnt;
	var shopId = <%=shopId%>;
	
	
	var shopPerfom = new Array();
	var prdctRankInfo = new Array();
	var shopProftInfo = new Array();
	var staffSalesInfo =new Array();
	var staffJobInfo = [
                        ['선택', 0],
                        ['검안', 0],
                        ['조립', 0],
                        ['결제', 0],
                        ['전달', 0]
                      ];
	var profitChart_;
	var RankChart ;	
	var staffSaleChart;
	var jobChart;
	$(function() {
		$("#container").on("swipeleft", swipeSlide);
		getSales(shopName);
		shopSales();
		findShopName();
		jobChart = new google.visualization.PieChart(document.getElementById('staffJob'));
		staffSaleChart = new google.visualization.ComboChart(document.getElementById('staffChart'));
		profitChart_ = new google.visualization.ColumnChart(document.getElementById('profitChart'));
		RankChart = new google.visualization.ComboChart(document.getElementById('prdctRank'));
	  	getPrdctRank();
	  	getProfit();
	  	getStaffChart();
	  	getStaffJob();
	  	
	  	
	  	
	  	//change view
	  	
	  		$("#b1").click(function(){
	  			$("#b2").prop('disabled', false);
	  			shopOptions .hAxis.viewWindow.min -= 10;
	  			shopOptions .hAxis.viewWindow.max -= 10;
	  			shopChart();
    		});
	  	
	 	   $("#b2").click(function(){
	 		   $("#b1").prop('disabled', false);
	 		   shopOptions .hAxis.viewWindow.min += 10;
	 		   shopOptions .hAxis.viewWindow.max += 10;
	 		   shopChart();
	 	   });
	});
	
	
	var prdct ="안경테";
	function swtich(v){
		if(v=="1"){
			prdct = "안경테";
			prdctTy = "00300001";
		}else if(v=="2"){
			prdct = "렌즈";
			prdctTy = "00300002";
		}else if(v=="3"){
			prdct = "콘텍트 렌즈";
			prdctTy = "00300003";
		}
		
		
		getPrdctRank('day');
	}
	function findShopName() {
		var url = '${ctxPath}/sale/findShopName.do';

		//javax
		$.ajax({
			url : url,
			type : "post",
			dataType : "text",
			beforeSend : function() {
			},
			success : function(data) {
				var option = "";
				
				$(".shopName").append(option + data);
			}
		});
	}

	
	function time(str){
		var date = new Date(str);
		var year = date.getFullYear();
		var month = date.getMonth()+1;
		var day = date.getDate();
		
		return "" + addZero(year) + addZero(month) + addZero(day);
	}
	
	function addZero(t){
		return t < 10 ? "0" + t : t;
	}
	function getToday(){
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth()+1;
		var day = date.getDate();
		
		return "" + addZero(year) + addZero(month) + addZero(day);
	}
	function getSales(shop) {
		var date = new Date();
		var week = time(new Date(Date.parse(date)-7*1000*60*60*24));
		var ystDay = week;
		var tDay = getToday();
		$.ajax({
			url : '${ctxPath}/chart/getSales.do',
			dataType : "text",
			type : "post",
			data : "yesterDay=" + ystDay + "&toDay=" + tDay + "&shopId=" + shop,
			success : function(data) {

				sale = data.trim().split("/");
				yesterDay = Number(sale[0]);
				toDay = Number(sale[1]);
				
				$("#ystdaySales").html("어제 판매액 : \\" + yesterDay);
				$("#tdaySales").html("현재 판매액 : " + format(toDay));
				
				google.setOnLoadCallback(drawChart, true);
			}
		});
	}

	var shopChart_;
	//매장 순위
	function shopSales() {
		var date = new Date();
		var week = time(new Date(Date.parse(date)-7*1000*60*60*24));
		var ystDay = week;
		var tDay = getToday();
		$.ajax({
			url : '${ctxPath}/chart/shopSales.do',
			dataType : "html",
			type : "post",
			data : "yesterDay=" + ystDay + "&toDay=" + tDay,
			success : function(data) {
				shopChart_ = new google.visualization.ColumnChart(document
						.getElementById('shopSales'));
				
				shopPerfom = new Array();
				var saleInfo = data.trim().split("-");
				var length = Number(saleInfo.length) - 1;
				shopCnt = length;
				for (var i = 0; i < length; i++) {
					var shopPerfomSub = new Array();
					var shop = saleInfo[i];
					var shopSales = shop.split("/");
					shopPerfomSub.push(shopSales[0]);
					shopPerfomSub.push(Number(shopSales[1]));
					shopPerfomSub.push(Number(shopSales[2]));
					
					shopPerfom.push(shopPerfomSub);
				}
				google.setOnLoadCallback(shopChart, true);
			}
		});
	}

	var shopOptions = {
			title : '매장별 매출 비교',
			hAxis : {
				title : '매장',
				titleTextStyle : {
				color : 'blue',
				italic: false
				}
			},
			 animation: {
	    	        duration: 1000,
	    	        easing: 'in'
	    	 },
			 hAxis: {viewWindow: {min:0, max:10}},
			 chartArea: {'width': '80%', 'height': '80%'},
		};
	
	//게이지 차트
	function drawChart() {
		toDay = toDay/yesterDay*100;
		var data = google.visualization.arrayToDataTable([
				[ 'Label', 'Value' ], 
				[ '매출액',  Number(toDay.toFixed(2))] 
				]);
		
			var options = {
			width : 220,
			height : 220,
			redFrom : 90,
			redTo : 100,
			yellowFrom : 75,
			yellowTo : 90,
			minorTicks : 5,
			chartArea: {'width': '100%', 'height': '100%'},
		}; 

		var chart = new google.visualization.Gauge(document.getElementById('chart_div'));
		
		 
		chart.draw(data, options);
	}

	
	//매장 순위
	function shopChart() {

		 var data = new google.visualization.DataTable();
		 data.addColumn('string', '매장');
		  // Use custom HTML content for the domain tooltip.
		  data.addColumn('number', '전주');
		  data.addColumn('number', '현재');
		  data.addRows(shopPerfom);
		
		
		
		
		   var formatter = new google.visualization.NumberFormat( {pattern:'#,###'});
 			formatter.format(data, 1);
 			formatter.format(data, 2); 
			shopChart_.draw(data, shopOptions, {allowHtml: true});
		
		
		
		if(shopOptions.hAxis.viewWindow.min <= 0){
			$("#b1").prop('disabled', true);
      	}else if(shopOptions.hAxis.viewWindow.max >= shopCnt){
      		$("#b2").prop('disabled', true);
      	}
		
		
	}
	
	
	
	//제품 랭킹
	
	function getPrdctRank(n){
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth();
		var week = time(new Date(Date.parse(date)-7*1000*60*60*24));
		var tDay = getToday();
		var data;
		if(n=="day"){
			data = "toDay=" + tDay + "&prdctTy=" + prdctTy;
		}else if (n=="week"){
			data = "yesterDay=" + week + "&toDay=" + tDay + "&prdctTy=" + prdctTy;
		}else if(n=="month"){
			data = "month=" + year + addZero(month)+"01" + "&toDay=" + year+ addZero(month+1)+"01" + "&prdctTy=" + prdctTy;
		}else{
			data = "toDay=" + tDay + "&prdctTy=" + prdctTy;
		}
		$.ajax({
			url : '${ctxPath}/chart/getPrdctRank.do',
			dataType : "text",
			type : "post",
			data : data,
			success : function(data) {
				
				
				prdctRankInfo = new Array();
				
				
				var split = data.trim().split("line");
				for(var i = 0; i < split.length-1; i++){
					var prdctRankInfoSub = new Array();
					var split_ = split[i].split("|");
					prdctRankInfoSub.push(split_[0]);
					prdctRankInfoSub.push(tooltips(split_[1],Number(split_[2]),Number(split_[3])));
					prdctRankInfoSub.push(Number(split_[2]));
					
					prdctRankInfo.push(prdctRankInfoSub);
				} 
				prdctRank();
			}
		
		});
		
	}
	
	
	//제품 랭킹
	function prdctRank(){
	  var dataTable = new google.visualization.DataTable();
	  dataTable.addColumn('string', 'prdct');
	  // Use custom HTML content for the domain tooltip.
	  dataTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	  dataTable.addColumn('number', '판매액');
	  
	  dataTable.addRows(prdctRankInfo);
	  
	  Rankoptions = {
	      width: 1000,
	      height: 640,
	      vAxis: {title: "판매액"},
	      hAxis: {title: "제품"},
	      seriesType: "bars",
	      series: {5: {type: "line"}},
	      animation:{
	        duration: 1000,
	        easing: 'out'
	      },
	      focusTarget: 'category',
	      tooltip: { isHtml: true },
	      isStacked: true, 
	    };
	    
	    Rankoptions['title'] = prdct + " 최다 판매 10개 제품";
	  
	    // Create and draw the visualization.
	    

	      RankChart.draw(dataTable, Rankoptions);

	}
	
	
	function tooltips (imgSrc,prc,cnt){
		 return '<div style="padding:5px 5px 5px 5px;">' +
	      '<img src="' + imgSrc + '" style="width:75px;height:50px"><br/>' + 
	      '<b><center>' + format(prc) + '</center></b><br>' +
	      '<b><center>' + format(cnt) + '개</center></b>' +
	      '</div>';
	}
	function selectShop() {
		shopName = $("#shopName").val();
		getSales(shopName);
		
	}
	
	function format(n) {
		  var reg = /(^[+-]?\d+)(\d{3})/;   
		  n += '';                          

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');

		  return n;
		}
	
	 var distance = 0;
	 
	 function right(){
		 if(distance == 3){
				distance = 0;
			}else{
				distance +=1;
			}
		 $("#slider").animate({
			left : distance * "-1024"
		 },1000,function(){
		 });
	 }
	 
	 function left(){
		 if(distance == 0){
				distance = 3;
			}else{
				distance -=1;		
			}
		 
		 $("#slider").animate({
			left : distance * "-1024"
		 },1000,function(){
		 });
	 }
	 
	 
	 
	 
	 function swipeSlide(){
		 alert("swipe");
	 }
	 //매장별 순이익
	 function getProfit(n){
			var date = new Date();
			var year = date.getFullYear();
			var month = date.getMonth();
			var week = time(new Date(Date.parse(date)-7*1000*60*60*24));
			var tDay = getToday();
			var data;
			if(n=="day"){
				data = "toDay=" + tDay;
			}else if (n=="week"){
				data = "yesterDay=" + week + "&toDay=" + tDay;
			}else if(n=="month"){
				data = "month=" + year + addZero(month)+"01" + "&toDay=" + year+ addZero(month+1)+"01";
			}else{
				data = "toDay=" + tDay;
			}
			$.ajax({
				url : '${ctxPath}/chart/getProfit.do',
				dataType : "text",
				type : "post",
				data : data,
				success : function(data) {
					
					
					shopProftInfo = new Array();
				 	var split = data.trim().split("line");
					for(var i = 0; i < split.length-1; i++){
						var shopProftInfoSub = new Array();
						var split_ = split[i].split("|");
						shopProftInfoSub.push(split_[0]);
						shopProftInfoSub.push(Number(split_[1]));
						shopProftInfoSub.push(Number(split_[1])-Number(split_[2]));
						
						shopProftInfo.push(shopProftInfoSub);
					}  
					profitChart();
				}
			
			});
		 
	 }
	 //매장별 순이익
	 function profitChart(){
		  var dataTable = new google.visualization.DataTable();
		  dataTable.addColumn('string', 'prdct');
		  // Use custom HTML content for the domain tooltip.
		  dataTable.addColumn('number', '매출');
		  dataTable.addColumn('number', '순이익');
		  
		  dataTable.addRows(shopProftInfo);
		  
		  var options = {
		      width: 1000,
		      height: 640,
		      vAxis: {title: "이익률"},
		      hAxis: {title: "매장"},
		      seriesType: "bars",
		      series: {5: {type: "line"}},
		      animation:{
		        duration: 1000,
		        easing: 'out'
		      },
		      focusTarget: 'category',
		      tooltip: { isHtml: true },
		      isStacked: true,
		      title : "매장별 매출액 & 수익"
		    };
		    
		   
		  
		    // Create and draw the visualization.
		    
			    var formatter = new google.visualization.NumberFormat( {pattern:'#,###'});
	  			formatter.format(dataTable, 1);
	  			formatter.format(dataTable, 2); 
			  profitChart_.draw(dataTable, options, {allowHtml: true});

		}
	 
	 
	 //사원별 판매
	 
	 function getStaffChart(n){
		 var date = new Date();
			var year = date.getFullYear();
			var month = date.getMonth();
			var week = time(new Date(Date.parse(date)-7*1000*60*60*24));
			var tDay = getToday();
			var data;
			if(n=="day"){
				data = "toDay=" + tDay + "&shopId=" + staffShop;
			}else if (n=="week"){
				data = "yesterDay=" + week + "&toDay=" + tDay + "&shopId=" + staffShop;
			}else if(n=="month"){
				data = "month=" + year + addZero(month)+"01" + "&toDay=" + year+ addZero(month+1)+"01" + "&shopId=" + staffShop;
			}else{
				data = "toDay=" + tDay + "&shopId=" + staffShop;;
			}
			$.ajax({
				url : '${ctxPath}/chart/getStaffSales.do',
				dataType : "text",
				type : "post",
				data : data,
				success : function(data) {
					
					staffSalesInfo = new Array();
					selectStaff = "<option value='-1'>목록</option>";
				 	var split = data.trim().split("line");
					for(var i = 0; i < split.length-1; i++){
						var staffSalesInfoSub = new Array();
						var split_ = split[i].split("|");
						staffSalesInfoSub.push(split_[0]);
						staffSalesInfoSub.push(Number(split_[1]));
						staffSalesInfoSub.push(Number(split_[2]));
						
						staffSalesInfo.push(staffSalesInfoSub);
						
					}  
					
					staffChart();
				}
			
			});
		 
	 }
	 function staffChart(){
		 var data = new google.visualization.DataTable();
		 data.addColumn('string', '사원');
		  data.addColumn('number', '판매액');
		  data.addColumn('number', '평균');
		  data.addRows(staffSalesInfo);
		 var options = {
		          title : '사원별 판매액 & 평균',
		          vAxis: {title: "판매액"},
		          hAxis: {title: "사원"},
		          seriesType: "bars",
		          series: {1: {type: "line"}},
		          chartArea: {'width': '70%'},
		          animation:{
				        duration: 1000,
				        easing: 'out'
				      },
		        };

		        
		 var formatter = new google.visualization.NumberFormat( {pattern:'#,###'});
			 formatter.format(data, 1);
			 formatter.format(data, 2); 
		     staffSaleChart.draw(data, options, {allowHtml: true});
	 }
	 
	 //사원업무 비중
	 function getStaffJob(n){
		 var date = new Date();
			var year = date.getFullYear();
			var month = date.getMonth();
			var week = time(new Date(Date.parse(date)-7*1000*60*60*24));
			var tDay = getToday();
			var data;
			if(n=="day"){
				data = "toDay=" + tDay + "&shopId=" + staffShop + "&staffId=" + staffId;
			}else if (n=="week"){
				data = "yesterDay=" + week + "&toDay=" + tDay + "&shopId=" + staffShop + "&staffId=" + staffId;
			}else if(n=="month"){
				data = "month=" + year + addZero(month)+"01" + "&toDay=" + year+ addZero(month+1)+"01" + "&shopId=" + staffShop + "&staffId=" + staffId;
			}else{
				data = "toDay=" + tDay + "&shopId=" + staffShop + "&staffId=" + staffId;
			}
			$.ajax({
				url : '${ctxPath}/chart/getStaffJob.do',
				dataType : "text",
				type : "post",
				data : data,
				success : function(data) {
					
				 	var split = data.trim().split("line");
					for(var i = 0; i < split.length-1; i++){
						var split_ = split[i].split("|");
						staffJobInfo[0][1] = Number(split_[1]);
						staffJobInfo[1][1] = Number(split_[2]);
						staffJobInfo[2][1] = Number(split_[3]);
						staffJobInfo[3][1] = Number(split_[4]);
						staffJobInfo[4][1] = Number(split_[5]);
						
					}   
					staffJob();
				}
			
			});
	 }
	 function staffJob(){
		 var dataTable = new google.visualization.DataTable();

			  dataTable.addColumn('string', '업무');
			  dataTable.addColumn('number', '시간');
			  dataTable.addRows(staffJobInfo);
           var options = {
             title: '사원별 업무 비중',
             titleTextStyle : {fontSize: 11},
             legend : {position: 'top', textStyle: {color: 'black', fontSize: 11}},
             chartArea: {'width': '100%', 'height': '70%'},
             animation:{
			        duration: 1000,
			        easing: 'out'
			      },
           };

           
           jobChart.draw(dataTable, options);
	 }
	 
	 function changeShopStaff(){
		 var shop = $("#shopStaff").val();
		 staffShop = shop;
		 getStaffList(shop);
		 selectChange();
		 getStaffChart();
	 }
	 
	 
	 //사원 목록
	 function getStaffList(shop){
		 $.ajax({
				url : '${ctxPath}/chart/getStaffList.do',
				dataType : "html",
				data : "shopId=" + shop,
				type : "post",
				success : function(data) {
					var option = "<option value='-1'>사원선택</option>";
					$("#staffSelect").html(option + data);
				}
			
			});
	 }
	 
	 function selectChange(){
		 var staff = $("#staffSelect").val();
		 staffId = staff;
		 getStaffJob();
	 }
</script>
<style>
	#container{
		width: 1024px;
		position: relative;
		overflow: hidden;
	}
	#slider{
		width: 5140px;
		position: relative;
	}
	.chart{
		position: relative;
		float: left;
		width: 1024px;
	}
	#gaugeChart,#staffDiv{
		margin-top : 100px;
		float: left;
	}
	#gaugeChart{
		margin-left: 50px;
	}
	#shopdiv,#staffChart{
		float: right;
	}
	#btn{
		position: fixed;
	}
	#leftBtn{
		width: 30px;
		height: 60px;
		position: absolute;
		top: 250px;
		z-index: 1;
		opacity : 0.5;
	}
	#rightBtn{
		position: absolute;
		width: 30px;
		height: 60px;
		top: 250px;
		right: 0px;
		z-index: 1;
		opacity : 0.5;
	}
	.btnDiv{
		margin-left: 200px;
	}
	#btnDiv{
		margin-left: 360px;
	}
</style>
</head>
<body>
	<div id="container">
		<button onclick="left();" id="leftBtn"><</button> 
	<button onclick="right();" id="rightBtn">></button>
		<div id="slider">	
			<div id="chart1" class="chart">
				<div id="gaugeChart">
					
					<center>
						<select class="shopName" id="shopName" 	name="shopName" onchange="selectShop();"> 
						</select>
						
						<div id="chart_div" style="width: 220px; height: 220px;"></div>
						
						<!-- <div id="ystdaySales"></div> --> 
						<div id="tdaySales"></div>
					</center>
				</div>
				
				<div id="shopdiv">
					<div id="shopSales" style="width: 750px; height: 600px;" ></div>
					<center><button id="b1">이전</button><button id="b2">다음</button></center>
				</div>
			</div>
		
			<div id="chart2" class="chart">
				<center><button onclick="swtich('1');">안경테</button><button onclick="swtich('2');">렌즈</button><button onclick="swtich('3');">콘텍트렌즈</button></center>
					<div class="btnDiv">
						<button onclick="getPrdctRank('day');">일</button><button onclick="getPrdctRank('week');">주</button><button onclick="getPrdctRank('month');">월</button>
					</div>
		 		<div id="prdctRank" style="width: 1000px; height: 600px;" ></div>  
				<br><br><br>
			</div>
			
			<div id="chart3" class="chart">
			<div class="btnDiv">
						<button onclick="getProfit('day');">일</button><button onclick="getProfit('week');">주</button><button onclick="getProfit('month');">월</button>
					</div>
				<div id="profitChart" style="width: 1000px; height: 600px;" ></div>
			</div>
			
			<div id="chart4" class="chart">
				<div id="staffDiv">
					<center>
						<select class="shopName" id="shopStaff" onchange="changeShopStaff();">
						</select>
						<select id="staffSelect" onchange="selectChange()">
						</select>
					</center>
					<div id="staffJob" style="width: 250px; height: 250px;" ></div>
					<button onclick="getStaffJob('day');">일</button><button onclick="getStaffJob('week');">주</button><button onclick="getStaffJob('month');">월</button>
				</div>
				
				<div id="btnDiv">
						<button onclick="getStaffChart('day');">일</button><button onclick="getStaffChart('week');">주</button><button onclick="getStaffChart('month');">월</button>
				</div>
				<div id="staffChart" style="width: 750px; height: 600px;" ></div> 
			</div>
			
			
		</div>
	</div>
	
</body>

</html>