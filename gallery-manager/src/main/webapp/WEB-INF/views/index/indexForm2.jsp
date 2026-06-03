<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>

<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type='text/javascript' src='https://www.google.com/jsapi'></script>
<script type='text/javascript' src='../js/date.js'></script>
<script type="text/javascript">
	google.load("visualization", "1", {packages : [ "corechart" ]});
	google.load('visualization', '1', {packages:['gauge']});
</script>
<script type="text/javascript">
	var shopName = "all";
	var shopPerfom = [ 
	                   [ "0", 0, 0 ], 
	                   [ "1", 0, 0 ], 
	                   [ "2", 0, 0 ],
					   [ "3", 0, 0 ], 
					   [ "4", 0, 0 ], 
					   [ "5", 0, 0 ], 
					   [ "6", 0, 0 ],
					   [ "7", 0, 0 ], 
					   [ "8", 0, 0 ], 
					   [ "9", 0, 0 ] 
	                  ];
	
	
	$(function() {
		getSales(shopName);
		shopSales();
		findShopName();
	});
	
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
				$("#shopName").append(data);
			}
		});
	}

	function getSales(shop) {
		var ystDay = Date.today().add(-1).days().toString("yyyyMMdd");
		var tDay = Date.today().toString("yyyyMMdd");
		$.ajax({
			url : '${ctxPath}/chart/getSales.do',
			dataType : "text",
			type : "post",
			data : "yesterDay=" + ystDay + "&toDay=" + tDay + "&shopId=" + shop,
			success : function(data) {
				console.log(data)

				sale = data.trim().split("/");
				yesterDay = Number(sale[0]);
				toDay = Number(sale[1]);
				
				$("#ystdaySales").html("어제 판매액 : \\" + yesterDay);
				$("#tdaySales").html("\\" + toDay);
				
				google.setOnLoadCallback(drawChart, true);
			}
		});
	}

	function shopSales() {
		var ystDay = Date.today().add(-1).days().toString("yyyyMMdd");
		var tDay = Date.today().toString("yyyyMMdd");
		$.ajax({
			url : '${ctxPath}/chart/shopSales.do',
			dataType : "html",
			type : "post",
			data : "yesterDay=" + ystDay + "&toDay=" + tDay,
			success : function(data) {
				console.log(data.trim())

				var saleInfo = data.trim().split("-");
				var length = Number(saleInfo.length) - 1;
				for (var i = 0; i < length; i++) {
					var shop = saleInfo[i];
					var shopSales = shop.split("/");
					shopPerfom[i][0] = shopSales[0];
					shopPerfom[i][1] = Number(shopSales[1]);
					shopPerfom[i][2] = Number(shopSales[2]);
				}
				google.setOnLoadCallback(shopChart, true);
			}
		});
	}

	
	
	
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
			minorTicks : 5
		}; 

		var chart = new google.visualization.Gauge(document.getElementById('chart_div'));
		chart.draw(data , options );
	}

	function shopChart() {

		var data = google.visualization.arrayToDataTable([
				[ '매장', '어제', '현재' ],
				[ shopPerfom[0][0], shopPerfom[0][1], shopPerfom[0][2] ],
				[ shopPerfom[1][0], shopPerfom[1][1], shopPerfom[1][2] ],
				[ shopPerfom[2][0], shopPerfom[2][1], shopPerfom[2][2] ],
				[ shopPerfom[3][0], shopPerfom[3][1], shopPerfom[3][2] ],
				[ shopPerfom[4][0], shopPerfom[4][1], shopPerfom[4][2] ],
				[ shopPerfom[5][0], shopPerfom[5][1], shopPerfom[5][2] ],
				[ shopPerfom[6][0], shopPerfom[6][1], shopPerfom[6][2] ],
				[ shopPerfom[7][0], shopPerfom[7][1], shopPerfom[7][2] ],
				[ shopPerfom[8][0], shopPerfom[8][1], shopPerfom[8][2] ],
				[ shopPerfom[9][0], shopPerfom[9][1], shopPerfom[9][2] ], ]);

		var options = {
			title : '매출액 (원)',
			hAxis : {
				title : '매장',
				titleTextStyle : {
				color : 'blue',
				italic: false
				}
			},
		};

		var chart = new google.visualization.ColumnChart(document
				.getElementById('shopSales'));
		chart.draw(data, options);
	}
	
	
	function selectShop() {
		shopName = $("#shopName").val();
		getSales(shopName);
		
	}
</script>
<style>
	#shopSales{
		float: right;
	}
	
</style>
</head>
<body>
	<div id="shopSales" style="width: 630px; height: 500px;" ></div>
	<br>
	<br>
	<center>
	
	<select id="shopName" name="shopName" onchange="selectShop();"> 
		<option value="all">전체</option>
		<option value="-1001">온라인</option>
	</select>
	</center>
	<div id="chart_div" style="width: 220px; height: 220px;"></div>
	<!-- <div id="ystdaySales"></div> --> 
	<center><div id="tdaySales"></div>
	</center>
	
</body>
</html>