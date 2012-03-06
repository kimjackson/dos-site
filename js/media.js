if (! window.DOS) { DOS = {}; }

DOS.Media = {

	embed: function (swf, width, height, elemID, flashvars) {
		var params, attributes;

		params = {
			play: "true",
			loop: "true",
			menu: "false",
			quality: "high",
			scale: "showall",
			salign: "t",
			bgcolor: "#000000",
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

		swfobject.embedSWF(swf, elemID, width, height, "8", "swf/expressInstall.swf", flashvars, params, attributes);
	},

	playAudio: function (elemID, file) {
		var flashvars = {
			src: file,
			length: 100,
			title: ""
		};
		if ('ontouchstart' in document.documentElement) {
			document.write("<audio src='"+file+"' controls='controls' style='width:60%; height:100px; background-image:url(../images/img-entity-audio.jpg);background-repeat:no-repeat;background-size: 100% 100%;background-position:bottom'></video>");
		}else{
			DOS.Media.embed((RelBrowser.baseURL && RelBrowser.baseURL != "" ? RelBrowser.baseURL:"../")+"swf/audio-player.swf", "358", "87", elemID, flashvars);
		}
	},

	playVideo: function (elemID, file, image) {
		var flashvars = {
			videoPath: file,
			autoStart: true,
			autoHide: true,
			autoHideTime: 3,
			hideLogo: true,
			volAudio: 100,
			disableMiddleButton: false
		};

		if (image) {
			flashvars.imagePath = image;
			flashvars.autoStart = false;
		}
		if ('ontouchstart' in document.documentElement) {
			document.write("<video controls='controls' style='width:60%;'><source src='"+file+".3gp' type='video/3gpp'></video>");
	}else{
		DOS.Media.embed((RelBrowser.baseURL && RelBrowser.baseURL != "" ? RelBrowser.baseURL:"../")+"swf/video-player.swf", "424", "346", elemID, flashvars);
		}
	},

	embedBrowser: function (elemID) {
		DOS.Media.embed( RelBrowser.baseURL +"swf/dosMenu.swf", "700", "320", elemID, null);
	}


};
