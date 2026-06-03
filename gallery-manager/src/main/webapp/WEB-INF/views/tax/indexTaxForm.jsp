<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>
<%@ include file="/WEB-INF/views/include/taxLib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>

<!-- <script type="text/javascript" src="../js/jsPdf/jspdf.js"></script> -->
<!-- <script type="text/javascript" src="../js/jsPdf/jspdf.plugin.addimage.js"></script> -->
<!-- <script type="text/javascript" src="../js/jsPdf/jspdf.plugin.standard_fonts_metrics.js"></script> -->
<!-- <script type="text/javascript" src="../js/jsPdf/jspdf.plugin.split_text_to_size.js"></script> -->
<!-- <script type="text/javascript" src="../js/jsPdf/jspdf.plugin.from_html.js"></script> -->
<!-- <script type="text/javascript" src="../js/libJsPdf/Deflate/adler32cs.js"></script> -->
<!-- <script type="text/javascript" src="../js/libJsPdf/FileSaver.js/FileSaver.js"></script> -->
<!-- <script type="text/javascript" src="../js/libJsPdf/Blob.js/BlobBuilder.js"></script> -->


<script type="text/javascript">


var g_shopId = '${shopId}';

	function SaleObj(jobId,saleId, cnt, date, name, payCash, payCard, cardTy, bigo, shopId, shopName){
		this.jobId = jobId;
		this.saleId = saleId;
		this.cnt = cnt;
		this.date = date;
		this.name = name;
		this.payCash = payCash;
		this.payCard = payCard;
		this.cardTy = cardTy;
		this.bigo = bigo;
		this.shopId = shopId;
		this.shopName = shopName;
	}
	var arrSaleObj = new Array();
	//var mapSaleObj = {};
	var mapSaleObj = new Map();
	var mapAddTax = new Map();
	var today ;
	$(function(){
		var date = new Date();
		var year = date.getFullYear();
		tmpMonth = date.getMonth()+1;
		var month = addZero(String(date.getMonth()+1));
		var day = addZero(String(date.getDate()));
		today = year + "-" + month + "-" + day;
		
		var sDate;
		var eDate;
		if(tmpMonth<4){
			sDate = (year-1) + "-" + "01" + "-" + "01";
			eDate = (year-1) + "-" + "12" + "-" + "31" ;	
		}else{
			sDate = year + "-" + "01" + "-" + "01";
			eDate = year + "-" + month + "-" + day ;	
		}
		
		$("#sDate").val(sDate);
		$("#eDate").val(eDate);
		
		getShopId();
	});
	
	function addZero(str){
		if(str.length=="1"){
			str = "0" + str;
		}
		return str;
	}
	

	
	function getCstmrForRemove(){
		$("#loader").css("display","inline");
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
				$("#loader").css("display","none");
			}
		});
	}
	
	
	var listCstmrCd = new Array();
	function mergeHistory(){
		var SC = $("#SC").val();
		var DS = $("#DS").val();

		if(SC==""	){
			alert("삭제코드를 입력하세요");
			$("#SC").focus();
			return;
		}
		if(DS==""	){
			alert("통합코드를 입력하세요");
			$("#DS").focus();
			return;
		}
		var sChecker=0;
		for(var i=0,size=listCstmrCd.length;i<size;i++){
			if(listCstmrCd[i]==SC){
				sChecker=1;
			}
		}
		var dChecker=0;
		for(var i=0,size=listCstmrCd.length;i<size;i++){
			
			if(listCstmrCd[i]==DS){
				dChecker=1;
			}
		}
		if(sChecker==0){
			alert('리스트에 없는 코드 입니다.');
			return;
		}
		
		if(dChecker==0){
			alert('리스트에 없는 코드 입니다.');
			return;
		}
		if(confirm("통합하시겠습니까?\n삭제코드의 고객은 지워집니다.")==false){
			return;
		}
		var param = "SC=" + SC + 
						"&DS=" + DS;
		 
		var url = "${ctxPath}/cstmr/mergeCstmr.do";		
		console.log(param);
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
	
	
	$(function() {
	    $( "#cstmrTabs" ).tabs();
	});
	
	var lastSearchParam='';
	function saleSearch(csCds){		
		console.log('run saleSearch');
		var url = '${ctxPath}/tax/listSaleOff4Tax.do';
		var csName = $('#csName').val();
		var cs4Digit = $('#cs4Digit').val();
		//var csCd = $('#csCd').val();
		mapSaleObj.clear();
		if((!csName || !cs4Digit) && !csCd){
			alert('검색어가 누락되었습니다.');
			return;
		}
		var param = 'cstmrName='+csName+'&digit4='+cs4Digit+'&cstmrCds='+csCds
					+ "&sDate=" + $('#sDate').val().replace('-','.').replace('-','.')
					+ "&eDate=" + $('#eDate').val().replace('-','.').replace('-','.');
		lastSearchParam = param;
		$.ajax({
			url : url,
			type : "post",
			data : param,
			dataType : "html",
			beforeSend : function() {
			},
			success : function(data) {
				$('#listSaleTax').html('');
				$('#listSaleTax').html(data);
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
	
	function addAll(){
		var addKeys = mapSaleObj.keys();
		for(var i=0,size=addKeys.length;i<size;i++){
			var tmpShopId = $('#listShop').val();
			if(mapSaleObj.get(addKeys[i]).shopId==tmpShopId){
				mapAddTax.put(addKeys[i] ,mapSaleObj.get(addKeys[i]));
			}
		}
		drawTable();
	}
	function removeAll(){

		mapAddTax.clear();
		clearKeys =mapAddTax.keys();
		//console.log('clearKeys:'+clearKeys);
		drawTable();
	}
	function addTax(input){
		
		console.log('run addTax');
		
		var dupleCheck= mapAddTax.get(input);
		if(dupleCheck){
			alert('이미 추가된 항목입니다.');
			return;
		}
		
		mapAddTax.put(input ,mapSaleObj.get(input));
	
		drawTable();
		//console.log('mapAddTax.keys:'+mapAddTax.keys());
	}
	
	function removeTax(input){
		$('#tr'+input).html('');
		mapAddTax.remove(input);
		
		drawTable();
		//console.log('mapAddTax.keys:'+mapAddTax.keys());
	}
	
	function drawTable(){
		var drawKeys = mapAddTax.keys();

		$('.trAdd').remove();
		var size =drawKeys.length;
		$('#btnPrint').val(size+'건(' + Math.ceil(size/9) +'장)출력');
		$('#btnPrint').button('refresh');
		for(var i=0 ; i<size ; i++){
			var tmpSaleObj = mapAddTax.get(drawKeys[i]);
			var tmpJobId = tmpSaleObj.jobId;
			var tmpSaleId = tmpSaleObj.saleId;
			var tmpCnt = tmpSaleObj.cnt;
			var tmpDate = tmpSaleObj.date;
			var tmpName = tmpSaleObj.name;
			var tmpPayCash = addComma(tmpSaleObj.payCash);
			var tmpPayCard = addComma(tmpSaleObj.payCard);
			var tmpBigo = tmpSaleObj.bigo;
			var uiClass = (i%2==0)?'grayClass':'whiteClass';
			var strTr = "\
				<tr id='tr"+tmpSaleId+"' class='trAdd "+uiClass+"'>\
					<td align='center'>"+tmpCnt+" </td>\
					<td align='center'>"+tmpDate+"</td>\
					<td align='center'>"+tmpName+"</td>\
					<td align='right'>"+tmpPayCash+"</td>\
					<td align='right'>"+tmpPayCard+"</td>\
					<td align='center'>"+tmpBigo+"</td>\
					<td align='center'>\
						<input type='button' onclick='removeTax("+tmpSaleId+")' name='chkTax' value='제거'/>\
					</td>\
				";
			if(i==0){
				$('#trStart').after(strTr);
			}else{
				$('#tr'+drawKeys[i-1]).after(strTr);
			}
		}
	}
	
	function printTax(){
		console.log('run printTax');
		var printName = $('#printName').val();
		var printSSN = $('#printSSN').val();
		
		if(!printName){
			alert('발급자 정보가 누락되었습니다.');
			return;
		}
		
		if(1>mapAddTax.size()){
			alert('출력 건수가 없습니다.');			
			return;
		}
		
		 
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
		var param = 'shopId='+$('#listShop').val();
		
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
			dataType	: "json",
			error:function(request,status,error){
				console.log('실패. 재로그인 바랍니다.');
			},
			success		: function(data){
				 shopId = data.shopId;
				 cName = data.taxName;
				 cNum = data.taxNum;
				 shopName = data.shopName;
				 telephone = data.telephone;
				 addr = data.addr;
				 stampImgPath=data.urlStr+data.stampImgPath;
				 
// 				 console.log('cName:'+cName);
// 				 console.log('cNum:'+cNum);
// 				 console.log('shopName:'+shopName);
// 				 console.log('telephone:'+telephone);
// 				 console.log('addr:'+addr);
				 headHtml = makeHead(printName,printSSN,cName,cNum,telephone,addr);
				 tailHtml = makeTail(cName,stampImgPath);
				 makeBody(headHtml,tailHtml);
				 updatePrintTax(printName);
				 //setTimeout(function(){ window.print(); }, 2000);
				 $("#imgStamp")
				    .load(function() { console.log("image loaded correctly"); window.print(); })
				    .error(function() { alert("실패. 재시도 바랍니다."); })
				;
			}
			
		});
		
	function updatePrintTax(printName){
		
		console.log("run updatePrintTax:"+JSON.stringify(mapAddTax));
		
		var url = '${ctxPath}/tax/renewalTax.do';
		var arrTax = new Array;
		var keys = mapAddTax.keys();
// 		console.log('keys:'+keys);
// 		console.log('mapAddTax:'+mapAddTax);
		function JsonAddTax(arrTax, today,printName){
			this.arrTax = arrTax;
			this.today = today;
			this.printName = printName;
		}
		
		for(var i=0,size=keys.length;i<size;i++){
			arrTax.push(mapAddTax.get(keys[i]));
		}
		var jsonAddTax =new JsonAddTax(arrTax , today.replace('-','.').replace('-','.') , printName);
		
		var email = $('#taxEmail').val();
		var cstmrId =$('#taxCstmrId').val(); 
		var param = 'jsonTax='+JSON.stringify(jsonAddTax)+'&email='+email+'&cstmrId='+cstmrId;

		jQuery.ajax({
			url: url,
			type : "post",
			data : param,
			dataType	: "text",
			error:function(request,status,error){
				console.log('실패. 출력내용사항 업데이트안됨.');
			},
			success		: function(data){
				 console.log(data);
			}
			});
	}
		
		function makeHead(printName,printSSN,cName,cNum,telephone,addr){
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
			var tmpMapSize = mapAddTax.size();

			var limit = Math.ceil(tmpMapSize/9);
			var k=0;
			$('#printable').html('');
			for(var j =0 ;j<limit;j++){
				var tmpSize=9;
				var tmpMapSize = mapAddTax.size();
				var tmpKeys = mapAddTax.keys();
				var tmpTr='';
				var tmpHtml;
				var tmpSum=0;
				var tmpCashSum=0; 
				var tmpCardSum=0;
				for(var i=0;i<tmpSize;i++,k++){
					if(k<tmpMapSize){
						var tmpSaleObj =  mapAddTax.get(tmpKeys[k]);
						//SaleObj(jobId,saleId, cnt, date, name, payCash, payCard, cardTy, bigo){
						tmpSum = Number(removeComma(tmpSaleObj.payCard)) + Number(removeComma(tmpSaleObj.payCash));
						tmpCashSum += Number(removeComma(tmpSaleObj.payCash)); 
						tmpCardSum += Number(removeComma(tmpSaleObj.payCard));
						tmpTr+="\
							<tr>\
								<td class='thickTd'>"+tmpSaleObj.date+"</td>\
								<td class='rightTd'>"+addComma(tmpSaleObj.payCard)+"</td>\
								<td class='rightTd'>"+addComma(tmpSaleObj.payCash)+"</td>\
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
// 				console.log("j:"+j);
// 				console.log("limit:"+limit);
				if(j == limit-1){
					
					tmpHtml = headHtml+tmpTr+tailHtml;	
				}else{
					tmpHtml = headHtml+tmpTr+tailHtml+breaker;
				}
				
				$('#printable').append(tmpHtml);
			}
		}		
	}
	function makeTail(cName,stampImgPath){
		cName = cName;
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
					  <span class='imgDescription'>"+cName+"&nbsp;(인)</span>\
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
	
	
	function getShopId(){
		var url = '${ctxPath}/shop/taxShopList.do';
		//javax
		$.ajax({
			type : "post",
			url : url,
			dataType : "text",
			success : function(data) {
				$("#listShop").html('');
				$("#listShop").html(data);
				//console.log('g_shopId:'+g_shopId);
				$("#listShop").val(g_shopId);
				$('#listShop').selectmenu('refresh');
				//console.log('$("#listShop").val():'+$("#listShop").val());
			}
		});
	}
	
	function setShop(){
		console.log('runSetShop');
		removeAll();
		hiddenPay();
		// 2. 매장 변경시 리스트 클리어.
		// 전체 추가시 해당 매장것만.
	}
	function hiddenPay(){
		var shopId = $("#listShop").val();
		//console.log('shopId:'+shopId);
		var hiddenKeys = mapSaleObj.keys();
		//console.log('hiddenKeys:'+hiddenKeys);
		for(var i=0,size=hiddenKeys.length;i<size;i++){
			var tmpSaleObj='';
			tmpSaleObj = mapSaleObj.get(hiddenKeys[i]);
// 			console.log('tmpSaleObj.saleId:'+tmpSaleObj.saleId);
// 			console.log('tmpSaleObj.shopId:'+tmpSaleObj.shopId);
// 			console.log('shopId:'+shopId);
			if(tmpSaleObj.shopId == shopId){
				document.getElementById('btn'+tmpSaleObj.saleId).style.display = 'inline';
				document.getElementById('shopName'+tmpSaleObj.saleId).style.display = 'none';
			}else{
				document.getElementById('btn'+tmpSaleObj.saleId).style.display = 'none';
				document.getElementById('shopName'+tmpSaleObj.saleId).style.display = 'inline';
			}
		}
	}

	function initInput(input){
		$('#'+input.id).val('');
	}
	
	
	function printPdf() {
		var pdf = new jsPDF('p', 'in', 'letter');

		// source can be HTML-formatted string, or a reference
		// to an actual DOM element from which the text will be scraped.
		var source = $('#printable')[0];

		// we support special element handlers. Register them with jQuery-style 
		// ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
		// There is no support for any other type of selectors 
		// (class, of compound) at this time.
		var specialElementHandlers = {
			// element with id of "bypass" - jQuery style selector
			'#bypassme': function(element, renderer){
				// true = "handled elsewhere, bypass text extraction"
				return true;
			}
		}

		// all coords and widths are in jsPDF instance's declared units
		// 'inches' in this case
		pdf.fromHTML(
				source // HTML string or DOM elem ref.
				, 0.5 // x coord
				, 0.5 // y coord
				, {
					'width':7.5 // max width of content on PDF
					, 'elementHandlers': specialElementHandlers
				}
			);

			pdf.save('Test.pdf');
	}
// 	var arrCstmr = new Array();
// 	var arrAllCstmr = new Array();
// 	var mapFmlyName = new Map();
// 	var mapCstmr = new Map();

	var paramCstmrs='';
	function slctCstmr(index){
		var cstmrCd = arrCstmr[index].cstmrCd;
		var fmlyCd = arrCstmr[index].fmlyCd;
		var cstmrId = arrCstmr[index].cstmrId;
		var email = decodeURIComponent(arrCstmr[index].email);
		
		if(cstmrId){$('#taxCstmrId').val(cstmrId);}
		if(email){$('#taxEmail').val(email);}
		$('#printName').val($('#csName').val());

		console.log('inputCd:'+cstmrCd);
		console.log('fmlyCd:'+fmlyCd);
		console.log('email:'+email);
		console.log('cstmrId:'+cstmrId);
		
		var inputHtml="<tr>\
			<th width='5%'></th>\
			<th width='10%'>이름</th>\
			<th width='20%'>전화번호</th>\
			<th width='20%'>휴대전화</th>\
			<th width='15%'>생일</th>\
			<th width='20%'>주소</th>\
			<th onclick='fncSetFmlyCheckAll();' width='20%'>선택</th>\
			</tr>";
		console.log('arrAllCstmr.length:'+arrAllCstmr.length);
		var cnt=0;
		arrFmlyCstmr = new Array();
		for (var i = 0,size=arrAllCstmr.length;i<size;i++){
						
			if(arrCstmr[index].fmlyCd == arrAllCstmr[i].fmlyCd){
				cnt++;
				arrFmlyCstmr.push(arrAllCstmr[i]);
				var trStyle = (cnt%2==1)? 'whiteClass':'grayClass' ;
				var tmpTr="\
					<tr class="+trStyle+">\
					<td>"+cnt+"</td>\
					<td>"+arrAllCstmr[i].cstmrName+"</td>\
					<td>"+arrAllCstmr[i].telephone+"</td>\
					<td>"+arrAllCstmr[i].cellphone+"</td>\
					<td>"+arrAllCstmr[i].birthDay+"</td>\
					<td>"+arrAllCstmr[i].addr+"</td>\
					<td><center>\
						<input class='chkFmlyTax' id='chkFmlyTax"+(cnt-1)+"' type='checkbox'/>\
						<label for=chkFmlyTax"+(cnt-1)+"></label>\
					</center></td>\
				</tr>";
				inputHtml+=tmpTr;
			}
			
		}
		console.log('step3');
		
		$('#tblFmly').html('');
		$('#tblFmly').append(inputHtml);
		$('#dlgCstmr').popup("close");		
		
		if(arrFmlyCstmr.length==1){
			console.log('fmly is only one.');			
			paramCstmrs += arrFmlyCstmr[0].cstmrCd+'@';
			saleSearch(paramCstmrs);
			return;
		}
		window.setTimeout ( function() { $('#dlgFmly').popup("open"); }, 200 );
		//$('#dlgFmly').popup("open");
	}

	
	function addCstmrs(){
		console.log('addCstmrs:'+addCstmrs);
    	paramCstmrs='';
// 		console.log('arrFmlyCstmr.length:'+arrFmlyCstmr.length); 
// 		console.log('arrFmlyCstmr.length:'+arrFmlyCstmr);
		for ( var i = 0, size = arrFmlyCstmr.length; i < size; i++) {
			var tmpBool = $('#chkFmlyTax' + i).prop('checked');
			
			if (tmpBool) {
				paramCstmrs += arrFmlyCstmr[i].cstmrCd+'@';
			}
		}
		//console.log('tmpCstmrs:'+paramCstmrs);
		$('#dlgFmly').popup("close");
		saleSearch(paramCstmrs);
		
	}
	
	
	var fmlyAllChecked = true;
	function fncSetFmlyCheckAll() {
		console.log('go fncSetEarnCheckAll');
		var inputElements = document.getElementsByTagName('input');
		for ( var i = 0; i < inputElements.length; ++i) {
			if (inputElements[i].className == "chkFmlyTax") {
				inputElements[i].checked = fmlyAllChecked;
				//console.log('checkId:' + inputElements[i].id);
			}
		}
		if (fmlyAllChecked == true) {
			fmlyAllChecked = false;
		} else {
			fmlyAllChecked = true;
		}
	}
		
</script>
<style type="text/css">
	
	input[type=checkbox]{
		display: none;
	}
	
	input[type=checkbox]+label {
		background-image: url("/Manager/images/checkbox.png");
		background-position:center center;
		height: 20px;
		width: 20px;
		display: inline-block;
		padding: 0 0 0 0px;
	}
	
	input[type=checkbox]:checked+label {
		background-image: url("/Manager/images/checkbox_c.png");
		background-position:center center;
		height: 20px;
		width: 20px;
		display: inline-block;
		padding: 0 0 0 0px;
	}
	.grayClass {
		background-color: #d3d3d3;
	}
	
	.whiteClass {
		background-color: white;
	}
	#loader{
		display : none;
	}
	
	#printable {
     	display: none;
	}
	
	
	.tbPrint{
		border-width: 1px;
		border-spacing: 0px;
		border-style: outset;
		border-color: white;
		border-collapse: collapse;
		background-color: white;
		width:15cm;
		height:24cm;
		font-size:0.7em;
	}
	.tbList{
		border-width: 1px;
		border-spacing: 0px;
		border-style: outset;
		border-color: white;
		border-collapse: collapse;
		background-color: white;
		font-size:0.7em;
		width:100%;
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
		height:25px;
	}
	.thickTd{
		border-left: 1px solid;
	 	border-bottom: 1px solid;
	 	border-top: 1px solid;
	 	border-right: 1px solid;
		padding: 0px;
		border-style: outset;
		border-color: black;
		/* background-color: rgb(250, 240, 230); */
		/* background: url(../images/printBG.png); */
		text-align:center;
		
		height:25px;
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
		
		height:25px;
	}
	
	.bgTd{
		border-width: 0px;
		padding: 0px;
		border-style: outset;
		border-color: black;
		/* background-color: rgb(250, 240, 230); */
		/* background: url(../images/printBG.png); */
		height:25px;
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
	/* .stamp{
		background-image: url(../images/stamp.png);
		background-size:80px 80px;
		background-repeat:no-repeat;
	} */
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
	
	  /*remove comment if you want a gradual transition between states
	  -webkit-transition: visibility opacity 0.2s;
	  */
	
	@page {margin: 2em;}

</style>

<style type="text/css" media="print">
	#tileHeader,#tileMiddle,#cstmrTabs{
			display:none;
	}
	#printable {
		 display: inline;
		/*display: block;
		margin: 0;
		border: initial;
		border-radius: initial;
		min-height: initial;
		box-shadow: initial;
		background: initial;
		page-break-inside: avoid;
		page-break-after: auto; */
	}
	.break { page-break-before: always; }
	
	.tbPrint{
		border-width: 1px;
		border-spacing: 0px;
		border-style: outset;
		border-color: white;
		border-collapse: collapse;
		/* background-color: white; */
		width:15cm;
		height:25cm;
		font-size:0.7em;
		/* page-break-inside: avoid;
		page-break-after: always;
		page-break-before: always; */
	}
	/* table{
		page-break-inside: avoid;
		page-break-after: always;
		page-break-before: always;
	} */

	.thickTd{
		border-left: 1px solid;
	 	border-bottom: 1px solid;
	 	border-top: 1px solid;
	 	border-right: 1px solid;
		padding: 0px;
		border-style: outset;
		border-color: black;
		/* background: url(../images/printBG.png); */
		text-align:center;
		
		height:25px;
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
		
		height:25px;
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
		height:25px;
	}
	
	.bgTd{
		border-width: 0px;
		padding: 0px;
		border-style: outset;
		border-color: black;
		/* background: url(../images/printBG.png); */
		height:25px;
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
	/* .stamp{
		background-image: url(../images/stamp.png);
		background-size:80px 80px;
		background-repeat:no-repeat;
		display:inline;
	} */
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
	  /*remove comment if you want a gradual transition between states
	  -webkit-transition: visibility opacity 0.2s;
	  */
	}
	/* .stamp img{
		display:inline;
	} */	
	
	@page {margin: 2em;}   
</style>
<title>의료비납입증명서 - 연말정산용</title>
</head>
<body>
	<div id="cstmrTabs" style='width:100%;'>
	  <ul>
	    <li><a href="#cstmrTab1">구매조회</a></li>
	    <!-- <li><a href="#cstmrTab2">고객 삭제</a></li> -->
	  </ul>
	  <div id="cstmrTab1">
	  		<table>
	  			<tr><td colspan='2'><center>
	  					* 주민등록번호는 저장되지 않고 출력에만 사용됩니다.
	  			</center></td></tr>
	  		<tr>
	  		<td width='50%'>
	  			
	  			<table width='100%'>
					<tr>
						<td width='15%' >
							고객명:
						</td>
						<td>
							<input data-mini="true" type="text" id="csName" placeholder="구매고객"
									onclick='initInput(this); return false;'
									onKeyPress="javascript:if(event.keyCode == 13) openDlgCstmrList();"></input>
						</td>
						<td width='15%' >
							4자리:
						</td>
						<td>
							<input data-mini="true" type="text" id="cs4Digit" placeholder="끝 4자리"
									onclick='initInput(this); return false;'
									onKeyPress="javascript:if(event.keyCode == 13) openDlgCstmrList();"></input>
						</td>
						<!-- <td width ='45%' >
							<input data-mini="true" type="text" id="csCd" placeholder="가족코드"
									onclick='initInput(this); return false;'
							 		onKeyPress="javascript:if(event.keyCode == 13) saleSearch();" ></input>
						</td> -->
						<td width='15%' >
							<input data-mini="true" value='검색' type="button"  onclick="openDlgCstmrList();" ></input>
						</td>
					</tr>
					<tr>
						<td colspan='2'>
							<input type="date" id="sDate" data-role="none" style='font-size:0.8em; width:100%'>
						</td>
						<td colspan='2'>
							~<input type="date" id="eDate" data-role="none" style='font-size:0.8em; width:90%'>
						</td>
						<td width='15%' >
							<input data-mini="true" value='전체선택' type="button"  onclick="addAll();" ></input>
						</td>
					</tr>

				</table>
				<div style='height: 500px; overflow: auto;'>
				<table id="listSaleTax" width="100%">
					<!-- <tr>
						<th width='5%'>&nbsp;</th>
						<th width='15%'>결제일</th>
						<th width='15%'>이름</th>
						<th width='15%'>현금</th>
						<th width='15%'>카드</th>
						<th width='20%'>비고</th>
						<th width='10%'>선택</th>
					</tr> -->
	
				</table>
				</div>
	  		</td>
	  		<td width='50%'>
	  			<table width='100%'>
	  				<tr>
	  					<td>
	  						<label for="taxEmail">메일주소:</label>
	  					</td>
						<td colspan='2'>
							<input id='taxEmail' data-mini="true" placeholder="email" type="email" ></input>
							<input id='taxCstmrId' type="hidden" ></input>
							
						</td>
						
						<td>
							<input id='btnPrint' data-mini="true" value='출력' type="button"  onclick="printTax();" ></input>
						</td>
						
						
					</tr>
					<tr>
						<td width='20%'>
							<input data-mini="true" type="text" id="printName" placeholder="발급고객"
									onclick='initInput(this); return false;'
									onKeyPress="javascript:if(event.keyCode == 13) printTax();"></input>
						</td>
						<td width='30%'>
							<input data-mini="true" type="text" id="printSSN" placeholder="주민등록번호"
									onclick='initInput(this); return false;'
									onKeyPress="javascript:if(event.keyCode == 13) printTax();">
							</input>
						</td>
						<td width='30%'>
							 <select data-mini="true" id='listShop' onchange='setShop()'>
							</select>
						</td>
						<td width='20%'>
							<input data-mini="true" value='전체제거' type="button"  onclick="removeAll();" ></input>
						</td>
					</tr>
				</table>
	  			
	  			<div style='vertical-align:top; height: 500px; overflow: auto;'>
		  			<table id='tbTax' style='width:100%;font-size:0.8em'>
		  			<tr>
		  				<th width='5%'>&nbsp;</th>
						<th width='15%'>날짜</th>
						<th width='15%'>이름</th>
						<th width='15%'>현금</th>
						<th width='15%'>카드</th>
						<th width='20%'>발급기록</th>
						<th width='10%'>선택</th>
		  			</tr>
		  			<tr id='trStart'>
		  			</tr>
		  			</table>
	  			</div>
	  		</td>
	  		</tr>
	  		</table>
		</div>
	  
	</div>
<div id="editor"></div>
<div id="printable"></div>
	

	
	
</body> 
</html>