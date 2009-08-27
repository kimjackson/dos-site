(function () {

/* Private variables and functions */

var _cookieName = "DoSFontSizeNum";
var _classNameBase = "fontSize";
var _minSize = -1;
var _maxSize = 3;
var _defaultSize = 0;

var _set = function (n) {
	var matches, i;

	if (n < _minSize) {
		n = _minSize;
	}
	if (n > _maxSize) {
		n = _maxSize;
	}

	if ($("body").hasClass(_classNameBase + n)) {
		return;
	}
	matches = $("body").attr("class").match(/fontSize-?\d+/g);
	if (matches) {
		for (i = 0; i < matches.length; ++i) {
			$("body").removeClass(matches[i]);
		}
	}
	if (n != 0) {
		$("body").addClass(_classNameBase + n);
	}

	if (window.alignImages) {
		alignImages();
	}
	if (RelBrowser.Mapping  &&
		RelBrowser.Mapping.tmap  &&
		RelBrowser.Mapping.tmap.timeline) {
		RelBrowser.Mapping.tmap.timeline.layout();
	}
	writePersistentCookie(_cookieName, n, "days", 5);
};


if (! window.RelBrowser) { RelBrowser = {}; }

RelBrowser.FontSize = {

	restore: function () {
		var n = getCookieValue(_cookieName);
		if (n !== false  &&  n != 0) {
			_set(parseInt(n));
		}
	},

	increase: function () {
		var n = getCookieValue(_cookieName);
		if (n === false) {
			n = _defaultSize;
		}
		_set(parseInt(n) + 1);
	},

	decrease: function () {
		var n = getCookieValue(_cookieName);
		if (n === false) {
			n = _defaultSize;
		}
		_set(parseInt(n) - 1);
	}
};

})();


$(function () {
	RelBrowser.FontSize.restore();
	$(".increasefont").click(function () {
		RelBrowser.FontSize.increase();
		return false;
	});
	$(".decreasefont").click(function () {
		RelBrowser.FontSize.decrease();
		return false;
	});
});
