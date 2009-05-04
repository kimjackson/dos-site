
var _nameTrack ='bcrumb'; //global name for the PJ object
var _nameZoom ='zoomtrackPJ'; //global name for the PJ object

// Functions for storing zoom level (scale persistence)
function saveZoomView(zT1, zT2, zId) {
 	HAPI.PJ.retrieve(_nameZoom, function (name, value){
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
     	HAPI.PJ.store (_nameZoom, newVal);
  	});
}


function loadSavedView(){
	HAPI.PJ.retrieve(_nameZoom, function (name, value){
		if (value) { 
			loadTMap(value.tOne, value.tTwo, value.id);
		} else {
			loadTMap(tl1, tl2, id);
		}
	});
}

// functions looking after timeline scale rendering and presetnation
function loadZooms(){
	var zoom = document.getElementById("timeline-zoom");
	zoom.innerHTML = "<b>Timeline Views</b><br>";
	createZoomLinks("Seconds / Minutes", Timeline.DateTime.SECOND, Timeline.DateTime.MINUTE, "SECOND-MINUTE");
	createZoomLinks("Minutes / Hours", Timeline.DateTime.MINUTE, Timeline.DateTime.HOUR, "MINUTE-HOUR");
	createZoomLinks("Hours / Days", Timeline.DateTime.HOUR, Timeline.DateTime.DAY, "HOUR-DAY");
	createZoomLinks("Days / Months", Timeline.DateTime.DAY, Timeline.DateTime.MONTH, "DAY-MONTH");
	createZoomLinks("Months / Years", Timeline.DateTime.MONTH, Timeline.DateTime.YEAR, "MONTH-YEAR");
	createZoomLinks("Years / Decades", Timeline.DateTime.YEAR, Timeline.DateTime.DECADE, "YEAR-DECADE");
	createZoomLinks("Decades / Centuries", Timeline.DateTime.DECADE, Timeline.DateTime.CENTURY, "DECADE-CENTURY");
}


function createZoomLinks(text, t1, t2, id){
	var zoom = document.getElementById("timeline-zoom");
	var a = document.createElement("a");
    a.href="#";
	a.id=id;
	a.name="timeline-zommies";
	a.className="timeline-zoom-a";
	a.onclick = function(){
		removeZoomSelect();
		saveZoomView(t1, t2, id);
		loadTMap(t1, t2, id);
	}
	var t = document.createTextNode(text);
	a.appendChild(t);
	zoom.appendChild(a);
	zoom.appendChild(document.createElement("br"));
}

function removeZoomSelect(){
	var elts = document.getElementsByName("timeline-zommies");
	for (var i = 0; i < elts.length; ++i) {
		elts[i].className = "timeline-zoom-a";
	}
}


// PJ functions for Map bread crumbs
function saveAndLoad(cValue) {
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
		loadSavedView();
  	});
}


function gatherCrumbs(_nameTrack, value, currentId) {
		if (value && value.length >= 1) {
			var placeHolder = document.getElementById("track-placeholder");
			placeHolder.innerHTML = ""; //reset
			var header = document.createElement("div");
			header.id = "track-header";
			header.innerHTML = "My Map Track";
			placeHolder.appendChild(header);
			
			var div = document.createElement("div");
			div.id = "track";
			
			value.reverse();
			var i,lastCrumb;
			value[0].recId == currentId? lastCrumb = parseInt(maptrackCrumbNumber + 1) : lastCrumb = maptrackCrumbNumber;
				
			if (value.length > lastCrumb) { //a bit of housekeeping to prevent session from overloading
				 value.pop();
				 value.reverse();
				 HAPI.PJ.store (_nameTrack, value);
				 value.reverse();
			}
			
			for ((value[0].recId == currentId? i=1 : i=0); i < value.length; ++i){ 
					var crumb = value[i];
					var a = document.createElement("a");
					a.href="../" + crumb.recId;				
					a.style.paddingBottom = "10px";
					a.style.textDecoration = "none";
					var t = document.createTextNode(crumb.recTitle);
					a.appendChild(t);
					
					//only display colour square only if there is geographic data associated with the record,
					//since this is when it will be displayed on the timeline, not in the case when the record is an aggregation of records
					if (crumb.hasGeoData && crumb.recType != "103") {
						if (crumb.hasGeoData.indexOf("l") != -1){
							var spanchik = document.createElement("span");
							spanchik.style.backgroundColor = crumbThemes[(value[0].recId == currentId)?i-1:i].colour;
							spanchik.style.paddingLeft = "5px";
							spanchik.style.paddingRight = "10px";
							a.style.paddingLeft = "5px";
							div.appendChild(spanchik);
						}
						if (crumb.hasGeoData.indexOf("p") != -1){
							var imgik = document.createElement("img");
							imgik.src= crumbThemes[(value[0].recId == currentId)?i-1:i].icon;
							imgik.height = "15";
							div.appendChild(imgik);
						}
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
		
}

function cleanUpCrumbs(){
	document.getElementById("track").innerHTML ="";
	HAPI.PJ.store (_nameTrack, null);
}

// TMap rendering
function loadTMap(tl1, tl2, id){
	TimeMap.init({
			mapId: "map", // Id of map div element (required)
			timelineId: "timeline", // Id of timeline div element (required)
			datasets:dataSets,
			bandInfo:[ {
				width: "50%",
				intervalUnit: tl1,
				intervalPixels: 100,
				showEventText: false,
				trackHeight: 1.5,
				trackGap: 0.2
				}, {
				width: "50%",
				intervalUnit: tl2,
				intervalPixels: 200,
				showEventText: false,
				trackHeight: 1.5,
				trackGap: 0.2
			}]
	});
	document.getElementById(id).className = "timeline-zoom-a selected";
}

