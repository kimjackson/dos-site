$(document).ready(function () {

	Boxy.DEFAULTS.unloadOnHide = true;

	$(".popup").click(function () {
		var matches, src;

		matches = this.href.match(/\d+$/);
		if (matches) {
			src = "../popup/" + matches[0];
		} else {
			src = this.href;
		}

		Boxy.load(src, {
			center: true,
			modal: true,
			afterShow: function () {
				var that = this;
				$("img", this.boxy).load(function () {
					that.center();
				});
				$("#audio a", this.boxy).each(function () {
					DOS.Media.playAudio('audio', $(this).attr("href"));
				});
				$("#video a", this.boxy).each(function () {
					DOS.Media.playVideo('video', $(this).attr("href"));
				});
			}
		});

		return false;

	});
});
