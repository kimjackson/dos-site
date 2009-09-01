if (! window.RelBrowser) { RelBrowser = {}; }

// FIXME: make JSLint-happy

RelBrowser.Mapping = {

	tmap: null,

	timeZoomSteps : [
		{ pixelsPerInterval: 200,  unit: Timeline.DateTime.DAY },
		{ pixelsPerInterval: 100,  unit: Timeline.DateTime.DAY },
		{ pixelsPerInterval:  50,  unit: Timeline.DateTime.DAY },
		{ pixelsPerInterval: 400,  unit: Timeline.DateTime.MONTH },
		{ pixelsPerInterval: 200,  unit: Timeline.DateTime.MONTH },
		{ pixelsPerInterval: 100,  unit: Timeline.DateTime.MONTH },
		{ pixelsPerInterval:  50,  unit: Timeline.DateTime.MONTH },
		{ pixelsPerInterval: 200,  unit: Timeline.DateTime.YEAR },
		{ pixelsPerInterval: 100,  unit: Timeline.DateTime.YEAR },
		{ pixelsPerInterval:  50,  unit: Timeline.DateTime.YEAR },
		{ pixelsPerInterval: 200,  unit: Timeline.DateTime.DECADE },
		{ pixelsPerInterval: 100,  unit: Timeline.DateTime.DECADE },
		{ pixelsPerInterval:  50,  unit: Timeline.DateTime.DECADE },
		{ pixelsPerInterval: 200,  unit: Timeline.DateTime.CENTURY },
		{ pixelsPerInterval: 100,  unit: Timeline.DateTime.CENTURY }
	],

	customMapTypes: [],


	addCustomMapTypeControl: function () {
		var CustomMapTypeControl = function () {}, M = RelBrowser.Mapping;

		if (M.customMapTypes.length < 1) { return; }

		CustomMapTypeControl.prototype = new GControl(false);

		CustomMapTypeControl.prototype.getDefaultPosition = function () {
			return new GControlPosition(G_ANCHOR_TOP_RIGHT, new GSize(7, 30));
		};

		CustomMapTypeControl.prototype.initialize = function (map) {
			var i, $container, $cb, that = this;

			$container = $("<div/>");

			for (i = 0; i < M.customMapTypes.length; ++i) {
				(function (m) {
					var $a = $("<a href='#'>" + m.getName() + "</a>")
						.click(function () {
							M.tmap.map.setMapType(m);
							return false;
						})
						$div = $("<div/>");
						$a.appendTo($div.appendTo($container));

					GEvent.addListener(map, "maptypechanged", function () {
						that._setSelected($a, (map.getCurrentMapType() === m));
					});
					that._setSelected($a, (map.getCurrentMapType() === m));
					that._setLinkDivStyle($div);
				})(M.customMapTypes[i]);
			}

			$container.append("<hr/>");

			$cb = $("<input type='checkbox'/>")
				.change(function () {
					that._setOpacity(this.checked ? 0.7 : 1);
				});
			$label = $("<label/>").append($cb).append(" Transparent");
			$div = $("<div/>").append($label);
			$div.appendTo($container);
			this._setCheckboxStyle($cb);
			this._setLabelStyle($label);
			this._setContainerStyle($container);
			$container.appendTo(map.getContainer());
			return $container.get(0);
		};

		CustomMapTypeControl.prototype._setContainerStyle = function ($div) {
			$div.css("background-color", "white");
			$div.css("border", "1px solid black");
			$div.css("padding", "2px 10px");
			$div.css("font-family", "Arial,sans-serif");
			$div.css("font-size", "12px");
		};

		CustomMapTypeControl.prototype._setLinkDivStyle = function ($link) {
			$div.css("padding", "0 0 3px 0");
		};

		CustomMapTypeControl.prototype._setCheckboxStyle = function ($cb) {
			$cb.css("vertical-align", "middle");
		};

		CustomMapTypeControl.prototype._setLabelStyle = function ($div) {
			$div.css("font-size", "11px");
			$div.css("cursor", "pointer");
		};

		CustomMapTypeControl.prototype._setSelected = function ($a, selected) {
			$a.css("font-weight", selected ? "bold" : "");
		};

		CustomMapTypeControl.prototype._setOpacity = function (opacity) {
			var i, mapType, M = RelBrowser.Mapping;
			for (i = 0; i < M.customMapTypes.length; ++i) {
				M.customMapTypes[i].getTileLayers()[1].opacity = opacity;
			}
			mapType = M.tmap.map.getCurrentMapType();
			M.tmap.map.setMapType(G_NORMAL_MAP);
			M.tmap.map.setMapType(mapType);
		};

		RelBrowser.Mapping.tmap.map.addControl(new CustomMapTypeControl());
	},


	renderTimelineZoom: function () {
		var band, zoom, x, $div, M = RelBrowser.Mapping;

		$div = $("#timeline-zoom");

		if ($div.length < 1) { return; }

		zoom = function (zoomIn) {
			band = M.tmap.timeline.getBand(0);
			x = ($(M.tmap.tElement).width() / 2) - band.getViewOffset();
			band.zoom(zoomIn, x);
			M.tmap.timeline.paint();
		};
		$("<div title='Zoom In'><img src='"+RelBrowser.baseURL+"images/plus.png'></img></div>")
			.click(function () {
				zoom(true);
			})
			.appendTo($div);
		$("<div title='Zoom Out'><img src='"+RelBrowser.baseURL+"images/minus.png'></img></div>")
			.click(function () {
				zoom(false);
			})
			.appendTo($div);
	},


	openInfoWindowHandler: function () {
		var $preview, content;

		content = $(this).data("info");
		if (! content) {
			// grab the preview content
			if (this.dataset.opts.preview) {
				$preview = $("#preview-" + this.dataset.opts.preview + " .balloon-middle").clone();
				$preview.removeClass("balloon-middle").addClass("map-balloon");
				$(".balloon-content .clearfix", $preview).before(
					"<p><a href='" + this.dataset.opts.target + "'>more &raquo;</a></p>"
				);
				content = $preview.get(0);
			} else {
				content = this.dataset.getTitle();
			}
			$(this).data("info", content);
		}

		// open window
		if (this.getType() == "marker") {
			this.placemark.openInfoWindow(content);
		} else {
			this.map.openInfoWindow(this.getInfoPoint(), content);
		}
		// custom functions will need to set this as well
		this.selected = true;
	},


	initTMap: function (mini) {
		var tl_theme, onDataLoaded, M = RelBrowser.Mapping;

		SimileAjax.History.enabled = false;

		if (M.mapdata["layers"]) {
			M.addLayers();
		}

		// modify timeline theme
		tl_theme = Timeline.ClassicTheme.create();
		tl_theme.autoWidth = true;

		onDataLoaded = function (tm) {
			// find centre date, choose scale to show entire dataset
			var start, end, zoomIndex, changeScale, eventSource, d = new Date();

			eventSource = tm.timeline.getBand(0).getEventSource();
			if (eventSource.getCount() > 0) {
				start = eventSource.getEarliestDate();
				end = eventSource.getLatestDate();
				d = M.timeMidPoint(start, end);

				zoomIndex = M.findTimeScale(start, end, M.timeZoomSteps, ($(tm.tElement).width()));

				changeScale = function (bandIndex) {
					var band, interval;
					band = tm.timeline.getBand(bandIndex),
					interval = M.timeZoomSteps[zoomIndex].unit;
					band._zoomIndex = zoomIndex;
					band.getEther()._pixelsPerInterval = M.timeZoomSteps[zoomIndex].pixelsPerInterval;
					band.getEther()._interval = Timeline.DateTime.gregorianUnitLengths[interval];
					band.getEtherPainter()._unit = interval;
				};
				changeScale(0);
			}
			tm.timeline.getBand(0).setCenterVisibleDate(d);
			tm.timeline.layout();

			// finally, draw the zoom control
			M.renderTimelineZoom();
		};

		M.tmap = TimeMap.init({
			mapId: "map", // Id of map div element (required)
			timelineId: "timeline", // Id of timeline div element (required)
			datasets: M.mapdata.timemap,
			options: {
				showMapCtrl: false,
				showMapTypeCtrl: false,
				mapType: M.customMapTypes[0] || G_NORMAL_MAP,
				theme: TimeMap.themes.blue({ eventIconPath: RelBrowser.baseURL + "timemap.js/images/" }),
				openInfoWindow: mini ? function () { return false; } : RelBrowser.Mapping.openInfoWindowHandler
			},
			bandInfo: [ {
				theme: tl_theme,
				showEventText: true,
				intervalUnit: M.timeZoomSteps[M.initTimeZoomIndex].unit,
				intervalPixels: M.timeZoomSteps[M.initTimeZoomIndex].pixelsPerInterval,
				zoomIndex: M.initTimeZoomIndex,
				zoomSteps: M.timeZoomSteps,
				width: "100%"
			} ],
			dataLoadedFunction: onDataLoaded
		});

		M.tmap.map.setUIToDefault();
		if (! mini) {
			M.addCustomMapTypeControl();
		}
	},

	tileToQuadKey: function (x, y, zoom) {
		var i, mask, cell, quad = "";
		for (i = zoom; i > 0; i--) {
			mask = 1 << (i - 1);
			cell = 0;
			if ((x & mask) != 0) cell++;
			if ((y & mask) != 0) cell += 2;
			quad += cell;
		}
		return quad;
	},

	addLayers: function () {
		var i, M = RelBrowser.Mapping;
		for (i = 0; i < M.mapdata.layers.length; ++i) {
			(function (layer) {
				var newLayer, newMapType;
				newLayer = new GTileLayer(new GCopyrightCollection(""),layer.min_zoom, layer.max_zoom);
				// tileToQuadKey only for "virtual earth" maps!
				newLayer.getTileUrl = function (a,b) {
					return layer.url + M.tileToQuadKey(a.x,a.y,b) + (layer.mime_type == "image/png" ? ".png" : ".gif");
				};
				newLayer.getCopyright = function (a,b) { return layer.copyright; };
				newLayer.isPng = function () { return layer.mime_type == "image/png"; };
				newLayer.getOpacity = function () { return this.opacity; };
				newLayer.opacity = 1;

				newMapType = new GMapType([G_NORMAL_MAP.getTileLayers()[0], newLayer], G_NORMAL_MAP.getProjection(), layer.title);

				M.customMapTypes.push(newMapType);

			})(M.mapdata.layers[i]);
		}
	},

	timeMidPoint: function (start, end) {
		var d, diff;
		d = new Date();
		diff = end.getTime() - start.getTime();
		d.setTime(start.getTime() + diff/2);
		return d;
	},

	findTimeScale: function (start, end, scales, timelineWidth) {
		var diff, span, unitLength, intervals, i;
		s = new Date();
		e = new Date();
		diff = end.getTime() - start.getTime();
		span = diff * 1.1;	// pad by 5% each end
		for (i = 0; i < scales.length; ++i) {
			unitLength = Timeline.DateTime.gregorianUnitLengths[scales[i].unit];
			intervals = timelineWidth / scales[i].pixelsPerInterval;
			if (span / unitLength <= intervals) {
				return i;
			}
		}
		return i;
	}
};

// default to 100px per century
RelBrowser.Mapping.initTimeZoomIndex = RelBrowser.Mapping.timeZoomSteps.length - 1;

$(function () {
	var mini, $img, M = RelBrowser.Mapping;
	mini = M.mapdata.mini || false;
	$img = $("img.entity-picture");
	if ($img.length > 0  &&  $img.width() === 0) {
		$img.load(function () { M.initTMap(mini); });
	} else {
		M.initTMap(mini);
	}
});
