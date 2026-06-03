<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

$(function() {
    
});


Map = function(){
	 this.map = new Object();
	};   
Map.prototype = {   
  put : function(key, value){   
      this.map[key] = value;
  },   
  get : function(key){   
      return this.map[key];
  },
  containsKey : function(key){    
   return key in this.map;
  },
  containsValue : function(value){    
   for(var prop in this.map){
    if(this.map[prop] == value) return true;
   }
   return false;
  },
  isEmpty : function(){    
   return (this.size() == 0);
  },
  isExist : function(key){
	  return (this.map[key])?true:false;
  },
  clear : function(){   
   for(var prop in this.map){
    delete this.map[prop];
   }
  },
  remove : function(key){    
   delete this.map[key];
  },
  keys : function(){   
      var keys = new Array();   
      for(var prop in this.map){   
          keys.push(prop);
      }   
      return keys;
  },
  values : function(){   
   var values = new Array();   
      for(var prop in this.map){   
       values.push(this.map[prop]);
      }   
      return values;
  },
  size : function(){
    var count = 0;
    for (var prop in this.map) {
      count++;
    }
    return count;
  }
};
  
function ObjCstmr(cstmrCd,cellphone,fmlyCd,birthDay,addr,telephone,cstmrName,cstmrId){
	this.cstmrCd = cstmrCd;
	this.cellphone = cellphone;
	this.fmlyCd = fmlyCd;
	this.birthDay = birthDay;
	this.addr = addr;
	this.telephone = telephone;
	this.cstmrName = cstmrName;
	this.cstmrId = cstmrId;
}

var arrCstmr = new Array();
var arrAllCstmr = new Array();
var arrFmlyCstmr = new Array();
var mapFmlyName = new Map();
var mapCstmr = new Map();

function openDlgCstmrList()
{
	console.log('Run openDlgCstmrList');
	arrCstmr = new Array();
	arrAllCstmr = new Array();
	mapFmlyName = new Map();
	mapCstmr = new Map();
	var url = '${ctxPath}/tax/getListCstmr.do';
	var csName = $('#csName').val();
	var cs4Digit = $('#cs4Digit').val();
	//mapSaleObj.clear();
	
	if((!csName || !cs4Digit)){
		alert('검색어가 누락되었습니다.');
		return;
	}
	var param = 'cstmrName='+csName+'&digit4='+cs4Digit;
	$.ajax({
		url : url,
		type : "post",
		data : param,
		dataType : "json",
		beforeSend : function() {
		},
		success : function(data) {
			console.log("djfdkfkdjfkjd")
			console.log(data)
			var jsonTmp = JSON.stringify(data);
			
			var jsonTmpList = data.listCstmr;
			var strJsonTmpList = JSON.stringify(data.listCstmr);
			var tmpJsonArray = JSON.parse(strJsonTmpList);
			//console.log('strJsonTmpList:'+strJsonTmpList);
// 			console.log('tmpJsonArray[0]:'+JSON.stringify(tmpJsonArray[0]));
// 			console.log('tmpJsonArray[1]:'+JSON.stringify(tmpJsonArray[1]));
// 			console.log('tmpJsonArray[2]:'+JSON.stringify(tmpJsonArray[2]));
// 			console.log('tmpJsonArray[3]:'+JSON.stringify(tmpJsonArray[3]));
			//var arr = new Array();
			
			console.log('tmpJsonArray.length:'+tmpJsonArray.length);
			console.log(tmpJsonArray)
			for(var i=0 , size = tmpJsonArray.length;i<size;i++){
				var tmpCstmr = tmpJsonArray[i];
			
				console.log('tmpCstmr:'+JSON.stringify(tmpCstmr));
				tmpCstmr.cstmrName = decodeURIComponent(tmpCstmr.cstmrName);
				tmpCstmr.addr = decodeURIComponent(tmpCstmr.addr);
				if(!tmpCstmr.telephone){
					tmpCstmr.telephone = '';
				}
				if(!tmpCstmr.cellphone){
					tmpCstmr.cellphone = '';
				}
// 				console.log('['+i+']cellphone:' + tmpCstmr.cellphone );
// 				console.log('['+i+']telephone:' + tmpCstmr.telephone );
				
				//"cstmrCd":"m10420140424000001","cellphone":"--5646","fmlyCd":"m08320140412000009","birthDay":"","addr":"","telephone":"","cstmrName":"???19","cstmrId":880453051},
				//console.log('['+i+']cstmrCd:'+tmpCstmr.cstmrCd);
				mapCstmr.put(tmpCstmr.cstmrCd,tmpCstmr);
				//console.log('['+i+']emptyCheck:'+mapFmlyName.isExist(tmpCstmr.fmlyCd) );
				
				if(mapFmlyName.isExist(tmpCstmr.fmlyCd)){
					var tmpName2 = mapFmlyName.get(tmpCstmr.fmlyCd);
					var tmpName3 = tmpCstmr.cstmrName;
// 					console.log('tmpName2:'+tmpName2);
// 					console.log('tmpName3:'+tmpName3);
					mapFmlyName.put(tmpCstmr.fmlyCd , tmpName2+","+tmpName3);
				}else{
					var tmpName1 = tmpCstmr.cstmrName;
//					console.log('tmpName1:'+tmpName1);
					mapFmlyName.put(tmpCstmr.fmlyCd , tmpName1);
				}
				
				//console.log('['+i+']:'+csName+":"+tmpCstmr.cstmrName);
				
				arrAllCstmr.push(tmpCstmr);
				console.log('csName:'+csName.length);
				console.log('tmpCstmr.cstmrName:'+tmpCstmr.cstmrName.length);
				console.log(arrCstmr)
				if(csName == tmpCstmr.cstmrName){
					console.log("ddd")
					arrCstmr.push(tmpCstmr);
					console.log(arrCstmr)
				}else{
					console.log("fff")
				}
			}
			//console.log('arrCstmr.length:'+arrCstmr.length);
			
			if(arrCstmr.length==1){
				//console.log('arrCstmr[0]:'+arrCstmr[0]);
				slctCstmr(0);
				return;
			}else if(arrCstmr.length==0){
				alert('일치 고객이 없습니다.');
				return;
			}
		
			var inputHtml="<tr>\
			<th width='5%'></th>\
			<th width='10%'>이름</th>\
			<th width='20%'>전화번호</th>\
			<th width='20%'>휴대전화</th>\
			<th width='15%'>생일</th>\
			<th width='20%'>주소</th>\
			<th width='20%'>가족이름</th>\
			</tr>";
			
			//console.log('size:'+arrCstmr.length);
			
			for(var i=0,size=arrCstmr.length;i<size;i++){
				var cnt = i+1;
				
				var trStyle = (i%2==1)? 'whiteClass':'grayClass' ;
				var tmpTr="\
					<tr onclick='slctCstmr("+i+")' class="+trStyle+">\
					<td>"+cnt+"</td>\
					<td>"+arrCstmr[i].cstmrName+"</td>\
					<td>"+arrCstmr[i].telephone+"</td>\
					<td>"+arrCstmr[i].cellphone+"</td>\
					<td>"+arrCstmr[i].birthDay+"</td>\
					<td>"+arrCstmr[i].addr+"</td>\
					<td>"+mapFmlyName.get(arrCstmr[i].fmlyCd)+"</td>\
				</tr>";
				inputHtml+=tmpTr;
			}
			$('#tblCstmr').html('');
			$('#tblCstmr').append(inputHtml);
			$('#dlgCstmr').popup("open");
 		}
		
	});
	
	
    /* $( "#dlgCstmr" ).dialog({
      height: 140,
      modal: true
    }); */
	
}

</script>

<div data-role="popup" id="dlgCstmr" style='width:50%;left:25%'>
	<a href="#" data-rel="back" data-role="button" data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
	<div data-role="header" data-theme="a" class="ui-corner-top" >
		<h3>중복고객선택</h3>
	</div>
	<table id='tblCstmr' style='font-size:0.8em'>
	
	</table>
</div>
<div data-role="popup" id="dlgFmly">
	<a href="#" data-rel="back" data-role="button" data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
	<div data-role="header" data-theme="a" class="ui-corner-top" >
		<h3>대상가족선택</h3>
	</div>
	<table id='tblFmly' style='font-size:0.8em'>
	</table>
	<input type='button' value='거래내역 검색' onclick='addCstmrs();' />
</div>