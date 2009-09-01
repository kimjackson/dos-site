if (! window.DOS) { DOS = {}; }

DOS.Media = {

	embed: function (swf, width, height, elemID, file) {
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
			id: elemID,
			name: "player",
			align: "middle"
		};

		swfobject.embedSWF(swf, elemID, width, height, "8", null, flashvars, params, attributes);
	},

	playAudio: function (elemID, file) {
		DOS.Media.embed(RelBrowser.baseURL+"swf/audio-player.swf", "358", "87", elemID, file);
	},

	playVideo: function (elemID, file) {
		DOS.Media.embed(RelBrowser.baseURL+"swf/video-player.swf", "424", "346", elemID, file);
	},

	embedBrowser: function (elemID) {
		DOS.Media.embed(RelBrowser.baseURL+"swf/dosMenu.swf", "700", "320", elemID, null);
	}


};
