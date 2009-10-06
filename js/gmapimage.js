if (! window.RelBrowser) { RelBrowser = {}; }

RelBrowser.GMapImage = {

    initialZoom: 1,
    imageWraps: false,
    map: null,

	init: function (id, maxResolution) {
		if (GBrowserIsCompatible()) {
			// create a custom picture layer
			var copyright = new GCopyright(
				1,
				new GLatLngBounds(new GLatLng(-90, -180), new GLatLng(90, 180)),
				0,
				""
			);
			var copyrightCollection = new GCopyrightCollection("");
			copyrightCollection.addCopyright(copyright);

			var pic_tileLayers = [ new GTileLayer(copyrightCollection, 0, 17)];
			pic_tileLayers[0].getTileUrl = RelBrowser.GMapImage.getCustomTileURLFn(id);
			pic_tileLayers[0].isPng = function () { return false; };
			pic_tileLayers[0].getOpacity = function () { return 1.0; };
			var proj = new RelBrowser.GMapImage.CustomProjection(maxResolution + 1, RelBrowser.GMapImage.imageWraps);
			var pic_customMap = new GMapType(pic_tileLayers, proj, "Pic", {
				maxResolution: maxResolution,
				minResolution: 0,
				errorMessage: "Data not available"
			});
			RelBrowser.GMapImage.map = new GMap2(document.getElementById("map"), { mapTypes: [pic_customMap] });
			RelBrowser.GMapImage.map.addControl(new GLargeMapControl());
			RelBrowser.GMapImage.map.addControl(new GOverviewMapControl());
			RelBrowser.GMapImage.map.enableDoubleClickZoom();
			RelBrowser.GMapImage.map.enableContinuousZoom();
			RelBrowser.GMapImage.map.enableScrollWheelZoom();
			RelBrowser.GMapImage.map.setCenter(new GLatLng(0.0, 0.0), RelBrowser.GMapImage.initialZoom, pic_customMap);
		}
    },

    CustomProjection: function (a, b) {
		this.imageDimension = 65536;
		this.pixelsPerLonDegree = [];
		this.pixelOrigin = [];
		this.tileBounds = [];
		this.tileSize = 256;
		this.isWrapped = b;
		var b = this.tileSize;
		var c = 1;
		for (var d = 0; d < a; d++){
			var e = b/2;
			this.pixelsPerLonDegree.push(b/360);
			this.pixelOrigin.push(new GPoint(e, e));
			this.tileBounds.push(c);
			b *= 2;
			c *= 2;
		}
	},

    getCustomTileURLFn: function (id) {
		var fn = function (a, b) {
			//converts tile x,y into keyhole string
			var c = Math.pow(2, b);
			var d = a.x;
			var e = a.y;
			var f = "t";
			for (var g = 0; g < b; g++) {
				c = c/2;
				if (e < c) {
					if (d < c) { f += "q"; }
					else { f += "r"; d -= c; }
				} else {
					if (d < c) { f +="t"; e -= c; }
					else { f += "s"; d -= c; e -= c; }
				}
			}
			return RelBrowser.baseURL + "tiles/" + id + "/" + f + ".jpg";
		};
		return fn;
	}
};


RelBrowser.GMapImage.CustomProjection.prototype = new GProjection();

RelBrowser.GMapImage.CustomProjection.prototype.fromLatLngToPixel = function (latlng, zoom) {
	var c = Math.round(this.pixelOrigin[zoom].x+latlng.lng()*this.pixelsPerLonDegree[zoom]);
	var d = Math.round(this.pixelOrigin[zoom].y+(-2*latlng.lat())*this.pixelsPerLonDegree[zoom]);
	return new GPoint(c, d)
};

RelBrowser.GMapImage.CustomProjection.prototype.fromPixelToLatLng = function (pixel, zoom, unbounded) {
	var d = (pixel.x-this.pixelOrigin[zoom].x)/this.pixelsPerLonDegree[zoom];
	var e = -0.5*(pixel.y-this.pixelOrigin[zoom].y)/this.pixelsPerLonDegree[zoom];
	return new GLatLng(e, d, unbounded)
};

RelBrowser.GMapImage.CustomProjection.prototype.tileCheckRange = function (tile, zoom, tilesize) {
	var tileBounds = this.tileBounds[zoom];
	if (tile.y < 0  ||  tile.y >= tileBounds) {
		return false;
	}
	if (this.isWrapped) {
		if (tile.x < 0  ||  tile.x >= tileBounds) {
			tile.x = tile.x % tileBounds;
			if (tile.x < 0) {
				tile.x += tileBounds;
			}
		}
	}
	else {
		if (tile.x < 0  ||  tile.x >= tileBounds) {
			return false;
		}
	}
	return true;
};

RelBrowser.GMapImage.CustomProjection.prototype.getWrapWidth = function (zoom) {
	return this.tileBounds[zoom] * this.tileSize;
};


