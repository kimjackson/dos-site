
/*window.onload = function() {
	if (GBrowserIsCompatible()) {
		var gx;
		var map = new GMap2(document.getElementById("map"));
		map.addControl(new GLargeMapControl());
		map.addControl(new GMapTypeControl());
		map.addMapType(G_PHYSICAL_MAP);
		map.enableScrollWheelZoom();
		map.setCenter(new GLatLng(-33.9, 151.2), 5);

		if (window["mapdata"]  &&  window.mapdata["kml"]) {
			for (var i in window.mapdata.kml) {
				map.addOverlay(new GGeoXml(window.mapdata.kml[i]));
			}
		}
	}
}
*/

// timemap time scales
function renderScales() {
	var div = document.getElementById("timeline-scales");
	if (! div) return;
	div.innerHTML = "Scale<br>";

	var scales = [
		[ "Seconds / Minutes", Timeline.DateTime.SECOND, Timeline.DateTime.MINUTE ],
		[ "Minutes / Hours", Timeline.DateTime.MINUTE, Timeline.DateTime.HOUR ],
		[ "Hours / Days", Timeline.DateTime.HOUR, Timeline.DateTime.DAY ],
		[ "Days / Months", Timeline.DateTime.DAY, Timeline.DateTime.MONTH ],
		[ "Months / Years", Timeline.DateTime.MONTH, Timeline.DateTime.YEAR ],
		[ "Years / Decades", Timeline.DateTime.YEAR, Timeline.DateTime.DECADE ],
		[ "Decades / Centuries", Timeline.DateTime.DECADE, Timeline.DateTime.CENTURY ]
	];

	var makeClickFn = function(i) {
		return function() {
			$(".timeline-scale.selected").removeClass("selected");
			$(this).addClass("selected");
			loadTMap(scales[i][1], scales[i][2]);
			return false;
		};
	};

	for (var i = 0; i < scales.length; ++i) {
		$("<a href='#' class='timeline-scale'>" + scales[i][0] + "</a>")
			.click(makeClickFn(i))
			.appendTo($("<div>").appendTo(div));
	}
}


function initTMap(units_top, units_bottom) {
	if (! (units_top  &&  units_bottom)) {
		units_top = Timeline.DateTime.MONTH;
		units_bottom = Timeline.DateTime.YEAR;
	}

	SimileAjax.History.enabled = false;
	renderScales();

	loadTMap(units_top, units_bottom);
}

function loadTMap(units_top, units_bottom) {
	window.tmap = TimeMap.init({
		mapId: "map", // Id of map div element (required)
		timelineId: "timeline", // Id of timeline div element (required)
		datasets: window.mapdata.timemap,
		bandInfo: [ {
			width: "50%",
			intervalUnit: units_top,
			intervalPixels: 50,
			showEventText: false,
			trackHeight: 1.5,
			trackGap: 0.2
			}, {
			width: "50%",
			intervalUnit: units_bottom,
			intervalPixels: 100,
			showEventText: false,
			trackHeight: 1.5,
			trackGap: 0.2
		} ]
	});

	if (window.mapdata["layers"]) {
		addLayers();
	}
}

function tileToQuadKey (x, y, zoom) {
	var i, mask, cell, quad = "";
	for (i = zoom; i > 0; i--) {
		mask = 1 << (i - 1);
		cell = 0;
		if ((x & mask) != 0) cell++;
		if ((y & mask) != 0) cell += 2;
		quad += cell;
	}
	return quad;
}

function addLayers() {
	var map = window.tmap.map;

	for (var i = 0; i < window.mapdata.layers.length; ++i) {
		var layer = window.mapdata.layers[i];

		var newLayer = new GTileLayer(new GCopyrightCollection(""),layer.min_zoom, layer.max_zoom);
// tileToQuadKey only for "virtual earth" maps!
		newLayer.getTileUrl = function (a,b) {
			return layer.url + tileToQuadKey(a.x,a.y,b) + (layer.mime_type == "image/png" ? ".png" : ".gif");
		};
		newLayer.getCopyright = function(a,b) { return layer.copyright; };
		newLayer.isPng = function() { return layer.mime_type == "image/png"; };

		var newMapType = new GMapType([newLayer], G_NORMAL_MAP.getProjection(), layer.title);
		map.addMapType(newMapType);


		var newLayer2 = new GTileLayer(new GCopyrightCollection(""),layer.min_zoom, layer.max_zoom);
// tileToQuadKey only for "virtual earth" maps!
		newLayer2.getTileUrl = function (a,b) {
			return layer.url + tileToQuadKey(a.x,a.y,b) + (layer.mime_type == "image/png" ? ".png" : ".gif");
		};
		newLayer2.getCopyright = function(a,b) { return layer.copyright; };
		newLayer2.isPng = function() { return layer.mime_type == "image/png"; };
		newLayer2.getOpacity = function() { return 0.8; };

		var newMapType2 = new GMapType([G_NORMAL_MAP.getTileLayers()[0], newLayer2], G_NORMAL_MAP.getProjection(), layer.title);
		map.addMapType(newMapType2);

		var control = new GHierarchicalMapTypeControl();
		control.addRelationship(newMapType, newMapType2, "hybrid");
		map.addControl(control);
	}
}
