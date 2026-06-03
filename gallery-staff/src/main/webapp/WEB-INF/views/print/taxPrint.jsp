<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>

	jQuery(document).ready(function(){
		$('#printable').append('${taxHtml}');
		$("#imgStamp")
		.load(function() {
			console.log("image loaded correctly");
			window.print();
			updatePrintTax(printName);
		})
		.error(function() { alert("실패. 재시도 바랍니다."); })
	});
	
	function printTax(){
		var printName = $('#inputTaxName').val();
		var printSSN = '';
		if(!printName){alert('발급자 정보가 누락되었습니다.');return;}
		 
		if(printSSN){
			if(printSSN.length != 13){
				alert('주민등록번호는 13자리 숫자만 입력 바랍니다.');
				return;
			}
			printSSN = printSSN.replace('-','');
			printSSN = printSSN.replace(/(^\s*)|(\s*$)/gi, "");
			var printSSN1 = printSSN.substr(0,6);
			var printSSN2 = printSSN.substr(6,7);
			printSSN = printSSN1 +'-'+ printSSN2; 			
		}
		
// 		console.log('printSSN:'+printSSN);
// 		console.log('printName:'+printName);
// 		console.log('printSSN:'+printSSN);
		
		var url = '${ctxPath}/shop/getShopInfo.do';
		var param = 'shopId='+jsonSale.shopId;
		
		var shopId;
		var cName;
		var cNum;
		var shopName;
		var telephone;
		var addr;
		var headHtml='';
		var tailHtml='';
		var urlStr='';
		var stampImgPath='';
		
		jQuery.ajax({
			url: url,
			type : "post",
			data : param,
			dataType : "json",
			error:function(request,status,error){
				alert('실패. 재로그인 바랍니다.');
			},
			success : function(data){
				 shopId = data.shopId;
				 cName = data.taxName;
				 cNum = data.taxNum;
				 shopName = data.shopName;
				 telephone = data.telephone;
				 addr = data.addr;
				 stampImgPath=data.urlStr+data.stampImgPath;

				 headHtml = makeHead(printName,printSSN,cName,cNum,telephone,addr);
				 tailHtml = makeTail(cName,stampImgPath);
				 makeBody(headHtml,tailHtml);

				 $("#imgStamp")
					.load(function() {
				    	console.log("image loaded correctly");
				    	window.print();
				    	//var myWindow = window.open("", "myWindow", "width=200, height=100");    // Opens a new window
						//myWindow.document.write($('#printable').html());                  // Text in the new window
				    	updatePrintTax(printName);
				  	})
				  .error(function() { alert("실패. 재시도 바랍니다."); })
			}
		});
	}
function goTaxPrintPage(taxHtml){
	var url = '${ctxPath}/tax/printTax.do';
	var param = 'taxHtml=' + taxHtml;
	
}

	  

function makeHead(printName,printSSN,cName,cNum,telephone,addr){
	var date = new Date();
	var day = date.getDate();
	var month = date.getMonth() + 1;
	var year = date.getFullYear();
	if (month < 10) month = "0" + month;
	if (day < 10) day = "0" + day;
	var today = year + "-" + month + "-" + day;
	
	var headHtml="\
		<table class='tbPrint' style='border:0.5; border-collapse:collapse;'>\
		<tr>\
			<td colspan='6'>\
				<center>\
					<h2>의료비납입증명서(연말정산용)</h2>\
				</center>\
			</td>\
		</tr>\
		<tr>\
			<td style='width:16%'></td>\
			<td style='width:16%'></td>\
			<td style='width:16%'></td>\
			<td style='width:16%'></td>\
			<td style='width:16%;text-align:right;'>발급일자</td>\
			<td class ='thickTd' style='width:16%;'>"+today+"</td>\
		</tr>\
		<tr>\
			<td colspan='6'>&nbsp;</td>\
		</tr>\
		<tr>\
			<td>[고객정보]</td>\
			<td colspan='5'></td>\
		</tr>\
		<tr>\
			<td class='thinTd'>성명</td>\
			<td class='thickTd'>"+printName+"</td>\
			<td class='thinTd'>주민등록번호</td>\
			<td colspan ='3' class='thickTd'>"+printSSN+"</td>\
		</tr>\
		<tr>\
			<td colspan='6'>&nbsp;</td>\
		</tr>\
		<tr>\
			<td>[공급자]</td>\
			<td colspan='5'></td>\
		</tr>\
		<tr>\
			<td class='thinTd'>사업자 등록</br>번호</td>\
			<td class='thickTd'>"+cNum+"</td>\
			<td class='thinTd'>상호</td>\
			<td class='thickTd'>갤러리안경</td>\
			<td class='thinTd'>대표자</td>\
			<td class='thickTd'>"+cName+"</td>\
		</tr>\
		<tr>\
			<td class='thinTd'>업태</td>\
			<td class='thickTd'>소매</td>\
			<td class='thinTd'>종목</td>\
			<td class='thickTd'>안경</td>\
			<td class='thinTd'>전화번호</td>\
			<td class='thickTd'>"+telephone+"</td>\
		</tr>\
		<tr>\
			<td class='thinTd'>소재지</td>\
			<td class='thickTd' colspan='5'>"+addr+"</td>\
		</tr>\
		<tr>\
			<td colspan='6'>&nbsp;</td>\
		</tr>\
		<tr>\
			<td>[구매내역]</td>\
			<td colspan='5'></td>\
		</tr>\
		<tr>\
			<td colspan='6'>&nbsp;</td>\
		</tr>\
		<tr><td colspan='6'>\
		<table class='tbList' style='border:0.5; border-collapse:collapse;'>\
		<tr>\
			<td width='25%' class='thinTd'>년 월</td>\
			<td width='20%' class='thinTd'>신용카드</td>\
			<td width='20%' class='thinTd'>현 금</td>\
			<td width='20%' class='thinTd'>합계</td>\
			<td width='15%' class='thinTd'>비고</td>\
		</tr>";
		
	return headHtml;
}
		
		//size of printOut table.
	
function makeBody(headHtml,tailHtml){
	//console.log('listPayment.length:'+listPayment.length);
	//var tmpMapSize = mapAddTax.size();
	var tmpMapSize = listPayment.length;
	var limit = Math.ceil(tmpMapSize/9);
	var k=0;
	$('#printable').html('');
	for(var j =0 ;j<limit;j++){
		var tmpSize=9;
		//var tmpKeys = mapAddTax.keys();
		var tmpTr='';
		var tmpHtml;
		var tmpSum=0;
		var tmpCashSum=0;
		var tmpCardSum=0;
		for(var i=0;i<tmpSize;i++,k++){
			if(k<tmpMapSize){
				//var tmpSaleObj =  mapAddTax.get(tmpKeys[k]);
				//SaleObj(jobId,saleId, cnt, date, name, payCash, payCard, cardTy, bigo){
				//tmpSum = Number(removeComma(tmpSaleObj.payCard)) + Number(removeComma(tmpSaleObj.payCash));
				var payCash=0;
				var payCard=0;
				
				if(listPayment[k].cardTy==13){
					payCash = Number(removeComma(listPayment[k].payCash))+Number(removeComma(listPayment[k].payCard));
				}else{
					payCash = Number(removeComma(listPayment[k].payCash));
					payCard = Number(removeComma(listPayment[k].payCard));
				}
					
				tmpSum = payCard + payCash;
				tmpCashSum += payCash;
				tmpCardSum += payCard;
				tmpTr += "\
					<tr>\
						<td class='thickTd'>"+listPayment[k].datetime+"</td>\
						<td class='rightTd'>"+addComma(payCard)+"</td>\
						<td class='rightTd'>"+addComma(payCash)+"</td>\
						<td class='rightTd'>"+addComma(tmpSum)+"</td>\
						<td class='thickTd'>&nbsp;</td>\
					</tr>";
			}else{
				tmpTr+="\
					<tr>\
						<td class='thickTd'>&nbsp;</td>\
						<td class='thickTd'>&nbsp;</td>\
						<td class='thickTd'>&nbsp;</td>\
						<td class='thickTd'>&nbsp;</td>\
						<td class='thickTd'>&nbsp;</td>\
					</tr>";
			}
		}
		tmpTr+="<tr>\
			<td class='thickTd'>총구입비용</td>\
			<td class='rightTd'>"+addComma(tmpCardSum)+"</td>\
			<td class='rightTd'>"+addComma(tmpCashSum)+"</td>\
			<td class='rightTd'>"+addComma(tmpCardSum+tmpCashSum)+"</td>\
			<td class='thickTd'>&nbsp;</td>\
		</tr>";
		var breaker = "<p class='break'>&nbsp;</p>";
		if(j == limit-1){
			tmpHtml = headHtml+tmpTr+tailHtml;	
		}else{
			tmpHtml = headHtml+tmpTr+tailHtml+breaker;
		}
		//tmpHtml = headHtml+tmpTr+tailHtml+breaker;
		
		$('#printable').append(tmpHtml);
		console.log("print html:"+$('#printable').html());
	}
}

function makeTail(cName,stampImgPath){
	var tmpName = cName;
	var tailHtml = "\
		</table></td></tr>\
		<tr>\
			<td colspan='2' style='text-align:center'>[구입용도] : 시력교정용</td>\
			<td colspan='4'></td>\
		</tr>\
		<tr>\
		<td colspan='6'>&nbsp;</td>\
		</tr>\
		<tr>\
			<td colspan='6'>&nbsp;</td>\
		</tr>\
		<tr>\
			<td colspan='3'></td>\
			<td colspan='2' >위 사실을 확인합니다.</td>\
			<td rowspan='3'class='bgTd'>\
				<div class='imgWrap'>\
				  <center><img id='imgStamp' src='"+stampImgPath+"' width='45px'/></center>\
				  <span class='imgDescription'>"+tmpName+"&nbsp;(인)</span>\
				</div>\
			</td>\
		</td>\
		</tr>\
		<tr>\
			<td colspan='4'></td>\
			<td style='text-align:right'>확인자:\</td>\
		</tr>\
		<tr>\
			<td colspan='5'>&nbsp;</td>\
		</tr>\
		<tr>\
			<td colspan='6'><center>이 계산서는 소득세법상 의료비공제 신청에 필요합니다.</center></td>\
		</tr>\
	</table>\
	";
	
	return tailHtml;
}
	
</script>

<style>
    #printable {
		 display: none;	
	}
    #dateFrame{
    	width: 100px;
    	height: 700px;
    	overflow: auto;
    }
   	a{
   		text-decoration: none;
   	}
   	a:LINK{
   		color : blue;
   	}
   	a:VISITED{
		color : blue;
   	}
   	a:HOVER{
   		color: #ff0000;
   	}
   	a:ACTIVE{
		color: #3399ff;
   	}
   
   	.dateSpan{
   		font-weight: bold;
   		cursor : pointer;
   		border-bottom : 1px solid black;
   		height : 35px;
   		font-size:1.2em;
   	}
   	.blackTr{
   		color: black;
   	}
   	.redTr{
   		color: red;
   	}
   	#dateSelect{
   		display: none;
   	}
   	.blueTr{
   		background-color: #99ccff;
   	}
   	.whiteTr{
		background-color: white;   	
   	}
   	.greenTr{
   		background-color: #deb887;
   	}
   	.borderL{
   		border-top-left-radius:0.5em;
   	}
   	.borderR{
   		border-top-right-radius:0.5em;
   	}
   	.eyeChk{
   		width:100%;
		font-size:14px;
   	}
   	#saleLoader{
		position : absolute;
		left :100px;
		display : none; 
		height : 25px;
		z-index:9;
	}
	
	.inputPrdct{
		font-size:1em;
		font-weight: bold;	
	}
	.inputPrdctList{
		font-size:1em;
		font-weight: bold;
	}
	.trListPrdct{
		background-color: #39F;
	}
	* {
		text-shadow: none;
	}
}
</style>

<style type="text/css" media="print">
	.noPrint{
		display : none;
	}
	
	@page{
		size:8.27in 11.69in; 
		margin:.5in .5in .5in .5in; 
		mso-header-margin:.5in; 
		mso-footer-margin:.5in; 
		mso-paper-source:0;
	}
	
	#printable {
		display : block;
		margin: auto;
		padding : 30px;
		/* display:none; */
		border-style: solid;
    	border-width: 5px;
	}

	/* .break { page-break-before: always; } */
	
	
	.tbPrint{
		border-width: 1px;
		border-spacing: 0px;
		border-style: outset;
		border-color: white;
		border-collapse: collapse;
		width:15cm;
		height:23cm;
		font-size:0.7em;
	}
	.tbList{
		border-width: 1px;
		border-spacing: 0px;
		border-style: outset;
		border-color: white;
		border-collapse: collapse;
		width:15cm;
		font-size:0.7em;
	}

	.thickTd{
		border-left: 1px solid;
	 	border-bottom: 1px solid;
	 	border-top: 1px solid;
	 	border-right: 1px solid;
		padding: 10px;
		border-style: outset;
		border-color: black;
		text-align:center;
		height:20px;
	}
	.rightTd{
		border-left: 1px solid;
	 	border-bottom: 1px solid;
	 	border-top: 1px solid;
	 	border-right: 1px solid;
		padding: 10px;
		border-style: outset;
		border-color: black;
		background-color: white;
		text-align:right;
		height:20px;
	}
	.thinTd{
		border-left: 1px solid;
	 	border-bottom: 1px solid;
	 	border-top: 1px solid;
	 	border-right: 1px solid;
		padding: 0px;
		border-style: outset;
		border-color: black;
		background-color: white;
		text-align:center;
		height:20px;
	}
	
	.bgTd{
		border-width: 0px;
		padding: 0px;
		border-style: outset;
		border-color: black;
		height:20px;
	}
	
	.noLineTd{
	 	border-left: 0;
	 	border-bottom: 0;
	 	border-top: 0;
	 	border-right: 0;
		padding: 0px;
		border-style: outset;
		border-color: black;
		background-color: white;
		
		height:25px;
	}
	
	.thinTr{
		border-width: thin;
		padding: 0px;
		border-style: inset;
		border-color: black;
		background-color: white;
	}

	.graph-img img{display:none;}
	
	.imgWrap {
		position: relative;
		left:30%;
		width: 100%;
	}
	
	.imgDescription {
	  position: absolute;
	  top: 33%;
	  left: -20%;
	  color: #000;
	  width:100%;
	  visibility: visible;
	  opacity: 1;
	}	
</style>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>TexPrint Page</title>
</head>

<body >
	
<div id="printable"></div>
<!-- </div> -->
</body>
	
</html>