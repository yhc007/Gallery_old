<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script> -->

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script src="${ctxPath}/js/dataTables/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${ctxPath}/js/dataTables/css/jquery.dataTables.css">

<script type="text/javascript">
	var csvOutput = "이름, 휴대전화, SMS수신여부, 성인여부, 최근 방문 일LINE";
	$(function() {
		var date = new Date();
		var year = date.getFullYear();
		var month = addZero(String(date.getMonth() + 1));
		var day = addZero(String(date.getDate()));

		//$("#date").val(year + "-" + month + "-" + day);
		$("#fromDate").val(year + "-" + month + "-" + day);
		$("#toDate").val(year + "-" + month + "-" + day);
	});

	function removeHypen(str) {
		console.log("str : ",str)
		str = str.replace(/-/gi, "");
		return str;
	}
	function csvData() {
		$("#csvBtn").attr("disabled", true);

		var fromDate = removeHypen($("#fromDate").val());
		var toDate = removeHypen($("#toDate").val());

		//fromDay, toDay
		var fromDay = fromDate.substr(6, 2);
		var toDay = toDate.substr(6, 2);

		//Adult FromDate
		var aFromYear = fromDate.substr(0, 4) - 1;
		var aFromMonth = fromDate.substr(4, 2);
		var startDate = aFromYear + "." + addZero(String(aFromMonth)) + "."
				+ fromDay;

		//Adult ToDate
		var aToYear = toDate.substr(0, 4) - 1;
		var aToMonth = toDate.substr(4, 2);
		var endDate = aToYear + "." + addZero(String(aToMonth)) + "." + toDay;

		//Child FromDate
		var cFromYear = fromDate.substr(0, 4);
		var cFromMonth = fromDate.substr(4, 2);
		if (cFromMonth <= 6) {
			cFromMonth = Number(cFromMonth) + Number(6);
			cFromYear--;
		} else {
			cFromMonth -= 6;
		}
		var sDate = cFromYear + "." + addZero(String(cFromMonth)) + "."
				+ fromDay;

		//Child ToDate
		var cToYear = toDate.substr(0, 4);
		var cToMonth = toDate.substr(4, 2);
		if (cToMonth <= 6) {
			cToMonth = Number(cToMonth) + Number(6);
			cToYear--;
		} else {
			cToMonth -= 6;
		}
		var eDate = cToYear + "." + addZero(String(cToMonth)) + "." + toDay;

		
		var srchTy = $("#srchTy").val();
		var url = "${ctxPath}/cstmr/getCstmrListForCsv.do";
		
		var param="startDate="+startDate
			+ "&endDate="+endDate
			+ "&sdate="+sDate
			+ "&edate="+eDate
			+ "&byear=" + aFromYear 
			+ "&srchTy=" + srchTy;


		//console.log(param);
		$.ajax({
			url : url,
			type : "post",
			data : param,
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				//console.log(data);
				//data = data.replace(/\n/gi,"");
				var cvs = data.trim().split("|");
				for (var i = 0; i < cvs.length; i++) {
					var trimInput = cvs[i].replace(/(^\s*)|(\s*$)/, '');
					csvOutput += trimInput + "LINE";
				}
				$("#csvBtn").attr("disabled", false);
			}
		});
	}

	function addZero(str) {
		if (str.length == "1") {
			str = "0" + str;
		}
		return str;
	}

	var intervalId;
	var cnt = 1;
	function loading() {
		$("#loadText").css("display", "inline");
		var dot = ".";
		var text = "약 1분 정도 소요됩니다.";
		$("#loadText").html(text);
		intervalId = setInterval(function() {
			cnt++;

			if (cnt == 1) {
				dot = ".";
			} else if (cnt == 2) {
				dot = "..";
			} else if (cnt == 3) {
				dot = "...";
			} else if (cnt == 4) {
				dot = "....";
			}

			text = "약 1분 정도 소요됩니다" + dot;
			$("#loadText").html(text);
			if (cnt == 4) {
				cnt = 0;
			}
		}, 1000);
	}

	function getCstmrList() {
		$("#cstmrList").html("");
		$("#loader").css("display", "inline");
		csvData();
		loading();
		//var date = removeHypen($("#date").val());
		var fromDate = removeHypen($("#fromDate").val());
		var toDate = removeHypen($("#toDate").val());

		/* var year = date.substr(0,4);
		var month = date.substr(4,2);
		var day = date.substr(6,2);
		var year2 = date.substr(0,4)-1;
		var month2 = date.substr(4,2);  */

		//fromDay, toDay
		var fromDay = fromDate.substr(6, 2);
		var toDay = toDate.substr(6, 2);

		//Adult FromDate
		var aFromYear = fromDate.substr(0, 4) - 1;
		var aFromMonth = fromDate.substr(4, 2);
		var startDate = aFromYear + "." + addZero(String(aFromMonth)) + "."
				+ fromDay;

		//Adult ToDate
		var aToYear = toDate.substr(0, 4) - 1;
		var aToMonth = toDate.substr(4, 2);
		var endDate = aToYear + "." + addZero(String(aToMonth)) + "." + toDay;

		//Child FromDate
		var cFromYear = fromDate.substr(0, 4);
		var cFromMonth = fromDate.substr(4, 2);
		if (cFromMonth <= 6) {
			cFromMonth = Number(cFromMonth) + Number(6);
			cFromYear--;
		} else {
			cFromMonth -= 6;
		}
		var sDate = cFromYear + "." + addZero(String(cFromMonth)) + "."
				+ fromDay;

		//Child ToDate
		var cToYear = toDate.substr(0, 4);
		var cToMonth = toDate.substr(4, 2);
		if (cToMonth <= 6) {
			cToMonth = Number(cToMonth) + Number(6);
			cToYear--;
		} else {
			cToMonth -= 6;
		}
		var eDate = cToYear + "." + addZero(String(cToMonth)) + "." + toDay;

		/* 		//학생들 6달 전 계산
		 if(month<=6){
		 month = Number(month) + Number(6);
		 year--;
		 }else{
		 month -= 6;
		 } */

		/* var datetime = year + "." + addZero(String(month)) + "." + day;//학생
		var datetime2 = year2 + "." + addZero(String(month2)) + "." + day;//어른 */
		
		
		var srchTy = $("#srchTy").val();
		var url = "${ctxPath}/cstmr/getCstmrListForChk.do";
		/* 		var param = "datetime=" + datetime + 
		 "&datetime2=" + datetime2 + 
		 "&byear=" + year2 + 
		 "&srchTy=" + srchTy; */
		/* var param = "datetime=" + datetime + "&datetime2=" + datetime2
				+ "&byear=" + year2 + "&srchTy=" + srchTy; */
				
		var param="startDate="+startDate
			+ "&endDate="+endDate
			+ "&sdate="+sDate
			+ "&edate="+eDate
			+ "&byear=" + aFromYear 
			+ "&srchTy=" + srchTy;

		//var url_lang = "${ctxPath}/js/dataTables/lang/Korean.txt";
		$.ajax({
			url : url,
			data : param,
			dataType : "html",
			type : "post",
			success : function(data) {
				//console.log(data);
				//$("#cstmrList").html(data);
				$("#loader").css("display", "none");
				$("#loadText").css("display", "none");
				cnt = 1;
				clearInterval(intervalId);

				$("#cstmrList").html('');
				$("#cstmrList").html(data);
				if ($.fn.dataTable.isDataTable('#cstmrList')) {
					console.log('destory routine');
					$("#cstmrList").dataTable({
						"destroy" : true
					});

					$("#cstmrList").dataTable();
					/* {
						"language": {
							"url" : url_lang
					    }
					}); */
				} else {
					dataTable = $("#cstmrList").dataTable();
					/* {
						"language": {
							"url" : url_lang
					    }
					}); */
				}
			}
		});
	}

	function csvSend() {

		csvOutput = csvOutput.replace(/\n/gi, "");

		f.csv.value = encodeURIComponent(csvOutput);
		f.startDate.value = $('#fromDate').val();
		f.endDate.value = $('#toDate').val();
		f.submit();
	}
</script>
<style type="text/css">
#loader {
	display: none;
}

.grayClass {
	background-color: #d3d3d3;
}

.whiteClass {
	background-color: white;
}

#loadText {
	display: none;
}
</style>
<link href="${ctxPath }/images/gallery_favicon.ico" rel="shortcut icon"
	type="image/x-icon" />
<title>Gallery Manager</title>
</head>
<body>
	<CenteR>
		<input type="date" id="fromDate" data-role="none"> - <input
			type="date" id="toDate" data-role="none"><br> <select
			id="srchTy" data-role="none">
			<option value="a">성인</option>
			<option value="c">학생</option>
			<option value="all">전체</option>
		</select>
		<button onclick="getCstmrList();" data-role="none">조회</button>
		<button onclick="csvSend();" data-role="none" id="csvBtn">엑셀로
			출력</button>
		<br> <br>
		<div id="loadText"></div>
		<br> <br> <img alt="" src="${ctxPath }/images/loader.gif"
			id="loader">

		<!-- <table width="90%" id="cstmrList"></table> -->
		<table border="1" width="100%" id="cstmrList"
			style="text-align: center; border-collapse: collapse;">

		</table>
	</CenteR>

	<form action='${ctxPath}/sale/csv1.do' id="f" method="post">
		<input type="hidden" name="csv" value=""> <input type="hidden"
			name="startDate" value=""> <input type="hidden"
			name="endDate" value="">
	</form>
</body>
</html>