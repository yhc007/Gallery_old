<script>
var valList=[];
function ViewValidation(){
	var i=0;
	for(i=0;i<valList.size();i++){
		alert(valList.get(i));
	};
	return false;
};

function addVal(str){
	valList.add(str);
};

function numCheck(Ev) {
    var evCode = (window.netscape) ? Ev.which : event.keyCode;
    if ((evCode < 48 || evCode > 57) && (evCode < 96 || evCode > 105) && evCode != 8 && evCode != 9 && evCode != 13 && (evCode < 37 || evCode > 40)) {
        if (window.netscape) {
            Ev.preventDefault();
        } else {
            event.returnValue = false;
        };
    };
};
function makePagingButton(currentPage,startPage,endPage,totalPage,listfnc){
	//alert(endPage);
	var pageInner="";
	
	var prev_page=1;
	var next_page=1;
	if(currentPage>10){
		prev_page=(currentPage*1)-(10*1);
	}
	if(((currentPage*1)+(10*1))>totalPage){
		next_page=totalPage;
	}else{
		next_page=(currentPage*1)+(10*1);
	}
	pageInner+='<table width="400" border="0" cellspacing="0" cellpadding="0">';
	pageInner+='<tr><td width="22">';
	pageInner+='<a href="#" onclick="'+listfnc+'(1);return false;">'; 
	pageInner+='<img src="<c:url value="/images/bttn_gostart.gif"/>" width="14" height="13" />';
	pageInner+='</a>';
	pageInner+='</td><td width="28">';
	pageInner+='<a href="#" onclick="'+listfnc+'('+prev_page+');return false;">';
    pageInner+='<img src="<c:url value="/images/bttn_goprev.gif"/>" width="14" height="13" />';
    pageInner+='</a>';
    pageInner+='</td> <td width="200" align="center"><table align="center"><tr align="center">';
    
    for(i=startPage;i<=endPage;i++){
    	//alert("i="+i);
    	if(i==currentPage){
    		 pageInner+='<td width="20" class="pagenow"><font style="font-weight: bold">'+i+'<font></td>';
    	}else{
    		pageInner+='<td width="20" class="pagenow">';
    		pageInner+='<a href="#" onclick="'+listfnc+'('+i+');return false;">';
    		pageInner+='<font color="#000000">';
    		pageInner+=i+'</font></a></td>';
    		
    		
    	};    	
    };
    pageInner+='</tr></table></td>';
    
    
    pageInner+='<td width="22" align="right">';
    pageInner+='<a href="#" onclick="'+listfnc+'('+next_page+');return false;">';
    pageInner+='<img src="<c:url value="/images/bttn_gonext.gif"/>" width="14" height="13" />';
    pageInner+='</a>';
    pageInner+='</td><td width="22" align="right">';
    pageInner+='<a href="#" onclick="'+listfnc+'('+totalPage+');return false;">';
    pageInner+='<img src="<c:url value="/images/bttn_goend.gif"/>" width="14" height="13" />';
    pageInner+='</a>';
    pageInner+='</td>';
    
    pageInner+='</tr></table>';    
    
    $("#paging_button_div").html("");
    $("#paging_button_div").append(pageInner);
}


function getMaxOfMonth(year,month,selectform){
	
	selectform.innerHTML ="";
	year=Number(year);
	month=Number(month);
	var maxday=0;
	switch(month){
	case 1:
	case 3:
	case 5:
	case 7:
	case 8:
	case 10:
	case 12:
		maxday=31;
		break;
	case 4:
	case 6:
	case 9:
	case 11:
		maxday=30;
		break;
	case 2:
		if(year%400==0){
			maxday = 29;
		}else if(year%100==0){
			maxday = 28;
		}else if(year % 4 == 0){
			maxday = 29;
		}else{
			maxday = 28;
		}
		break;	
	}
	
	for(var i = 0 ; i < maxday ; i++){
	  var elOptNew = document.createElement('option');
	  elOptNew.text = i+1;
	  elOptNew.value = i+1;
	  selectform.options[i] =elOptNew;
	}
	
	
}


function fncRemoveAllOption(itemId){
	var elSel = document.getElementById(itemId);
	var i;
  	for (i = elSel.length - 1; i>=0; i--) {
	 	elSel.remove(elSel.length - 1);
  	}
};

	function numFormat(n) {
		var reg = /(^[+-]?\d+)(\d{3})/;   
		n += '';                          
	
	  	while (reg.test(n)){
	  		n = n.replace(reg, '$1' + ',' + '$2');		  
	  	};
	  	
	  	return n;
	};
</script>