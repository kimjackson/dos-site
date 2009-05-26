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
