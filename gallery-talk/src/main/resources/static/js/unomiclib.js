
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
}