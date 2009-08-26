if (! window.DOS) { DOS = {}; }

DOS.Media = {

	play: function (file, player, width, height) {
		var flashvars, params, attributes;

		flashvars = {
			externalVideo: file
		};

		params = {
			play: "true",
			loop: "true",
			menu: "false",
			quality: "high",
			scale: "showall",
			salign: "t",
			bgcolor: "#FFFFFF",
			wmode: "opaque",
			devicefont: "false",
			seamlesstabbing: "true",
			swliveconnect: "false",
			allowfullscreen: "false",
			allowscriptaccess: "sameDomain",
			allownetworking: "all"
		};

		attributes = {
			id: "media",
			name: "player",
			align: "middle"
		};

		swfobject.embedSWF(player, "media", width, height, "8", null, flashvars, params, attributes);
	},

	playAudio: function (file) {
		DOS.Media.play(file, RelBrowser.baseURL+"swf/audio-player.swf", "358", "87");
	},

	playVideo: function (file) {
		DOS.Media.play(file, RelBrowser.baseURL+"swf/video-player.swf", "424", "346");
	}

};
