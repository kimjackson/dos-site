var _name ='zoomtrackPJ'; //global name for the PJ object


function saveZoomView(zT1, zT2, zId) {
 	HAPI.PJ.retrieve(_name, function (name, value){
		var newVal = {};
		if (!value || value == null){
			newVal = { tOne:zT1, tTwo:zT2, id:zId };
		} else { //determine the last value, only new value if different to the previous one, to avoid duplicates
		
			if (value.tOne != zT1 && value.tTwo != zT2 && value.id != zId){
	    		newVal = { tOne:zT1, tTwo:zT2, id:zId };
			} else {
				newVal = value;
			}
	 	}
     	HAPI.PJ.store (_name, newVal);
  	});
}


function loadSavedView(){
	HAPI.PJ.retrieve(_name, function (name, value){
		if (value) { 
			onLoad(value.tOne, value.tTwo, value.id);
		} else {
			onLoad();
		}
	});
}



 

