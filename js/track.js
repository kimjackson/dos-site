
var _nameTrack ='bcrumb'; //global name for the PJ object


// PJ: store and retrieve functions 
function createCrumb(cValue) {
 	HAPI.PJ.retrieve(_nameTrack, function (name, value){
    	var newVals = [];
	  	if (!value || value == null){
	   		newVals.push(cValue);
	  	} else { //determine the last value, only new value if different to the previous one, to avoid duplicates
	   		var lastVal= value[value.length-1];
	     	if (lastVal.recId !== cValue.recId) {
	       		value.push(cValue);
			} 
		   	newVals = value;
	  	}
		
     	HAPI.PJ.store (_nameTrack, newVals);
		gatherCrumbs();
		
  	});
  //test
 	//HAPI.PJ.retrieve(_nameTrack, function (name, vvalue){
 		//console.log(vvalue);
	//});
}


function gatherCrumbs() {

  	HAPI.PJ.retrieve(_nameTrack, function (name, value){
		if (value && value.length > 1) {
			var placeHolder = document.getElementById("track-placeholder");
			var header = document.createElement("div");
			header.id = "track-header";
			header.innerHTML = "My Map Track";
			placeHolder.appendChild(header);
			
			var div = document.createElement("div");
			div.id = "track";
			
			value.reverse();
			var lastCrumbPosition = parseInt(maptrackCrumbNumber + 1);
			if (value.length > lastCrumbPosition) { //a bit of housekeeping to prevent session from overloading
				 value.pop();
				 value.reverse();
				 HAPI.PJ.store (_nameTrack, value);
				 value.reverse();
			}
			//TODO: parameterise number of breadcrumbs?
			for (var i = 1; i < (value.length < lastCrumbPosition ? value.length : lastCrumbPosition ); ++i){ //crumb[0] is current crumb
				var crumb = value[i];
				var a = document.createElement("a");
				a.href="../" + crumb.recId;				
				a.style.paddingBottom = "10px";
				a.style.textDecoration = "none";
				var t = document.createTextNode(crumb.recTitle);
				a.appendChild(t);
					
				//only display colour square only if there is geographic data associated with the record,
				//since this is when it will be displayed on the timeline, not in the case when the record is an aggregation of records
				if (crumb.hasGeoData &&  crumb.hasGeoData != ""){
					var spanchik = document.createElement("span");
					spanchik.style.backgroundColor = crumbColours[i-1];
					spanchik.style.paddingLeft = "5px";
					spanchik.style.paddingRight = "10px";
					a.style.paddingLeft = "5px";
					div.appendChild(spanchik);
				}
					
					
				div.appendChild(a);
				div.appendChild(document.createElement("br"));
				div.appendChild(document.createElement("br"));
			}
				
			var inp = document.createElement("input");
			inp.type = "button";
			inp.value  = "clear history";
			inp.onclick = function() {
				cleanUpCrumbs();
			}
			div.appendChild(inp);		
			placeHolder.appendChild(div);
			
		}
  });
}

function cleanUpCrumbs(){
	document.getElementById("track").innerHTML ="";
	HAPI.PJ.store (_nameTrack, null);
}


	


