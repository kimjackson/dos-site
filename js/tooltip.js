if (! window.DOS) { DOS = {}; }

DOS.ToolTip = {
	addToolTips: function ($elems) {
		$elems.hover(function (e) {
			var myClass, preview, maxX, minY, x, y;
			myClass = $(this).attr("class").replace(/.*(preview-\S+).*/, "$1");
			preview = $("#"+myClass);
			$(".preview").hide();
			preview.show();
			maxX = $(window).width() + $(window).scrollLeft();
			minY = $(window).scrollTop();
			x = e.pageX;
			y = e.pageY - preview.height() - 5;
			if (x + preview.width() > maxX) {
				x = maxX - preview.width();
			}
			if (y < minY) {
				// if the tooltip goes off the top of the page, flip it down below the cursor instead
				y = e.pageY + 5;
			}
			preview.css({'left':x+'px','top':y+'px'})
		}, function () {
			var myClass = $(this).attr("class").replace(/.*(preview-\S+).*/, "$1");
			$("#"+myClass).hide();
		});
	}
};

$(document).ready(function () {
	// load preview contents
	$("#previews div").each(function () {
		$(this).load(this.id.replace(/^preview-(.*)$/, RelBrowser.pipelineBaseURL + "preview/$1"));
	});

	DOS.ToolTip.addToolTips($("a[class*=preview-]:not(.annotation)"));
});

