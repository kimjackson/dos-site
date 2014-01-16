/*
var imagePath:String = "image_590x380.jpg";
var videoPath:String = "cerego.flv";
var autoStart:Boolean = false;
var autoHide:String = "true";
var volAudio:Number = 60;
var disableMiddleButton:Boolean = false;
var playSounds:Boolean = true;

*/
var imagePath:String;
var videoPath:String;
var autoStart:Boolean;
var autoHide:String;
var volAudio:Number;
var disableMiddleButton:Boolean;
var playSounds:Boolean;

var myTween;

var VideoImage:XML = new XML();
VideoImage.ignoreWhite = true;
VideoImage.onLoad = function(success:Boolean):Void{
	if(success)
	{
		imagePath = VideoImage.firstChild.childNodes[0].attributes.set;
		videoPath = VideoImage.firstChild.childNodes[1].attributes.set;
		//autoStart = VideoImage.firstChild.childNodes[2].attributes.set;
		autoHide = VideoImage.firstChild.childNodes[3].attributes.set;
		volAudio = VideoImage.firstChild.childNodes[4].attributes.set;
		disableMiddleButton= VideoImage.firstChild.childNodes[5].attributes.set;
		playSounds= VideoImage.firstChild.childNodes[6].attributes.set;		
		if (autoStart=='false')
		{
			autoStart=false;
		}
		else
		{
			autoStart=true;
		}
		if (disableMiddleButton=='false')
		{
			disableMiddleButton=false;
		}
		else
		{
			disableMiddleButton=true;
		}
		if (playSounds=='false')
		{
			playSounds=false;
		}
		else
		{
			playSounds=true;
		}
		executeEGS();				
	}
}

function init(){
		//imagePath = _level0.videoURL;
		//videoPath = _level0.videoURL;
		//autoStart = true;
		//autoHide = true;
		//volAudio = 100;
		//disableMiddleButton = true;
		//playSounds= true;		
		if (autoStart=='false')
		{
			autoStart=false;
		}
		else
		{
			autoStart=true;
		}
		if (disableMiddleButton=='false')
		{
			disableMiddleButton=false;
		}
		else
		{
			disableMiddleButton=true;
		}
		if (playSounds=='false')
		{
			playSounds=false;
		}
		else
		{
			playSounds=true;
		}
		executeEGS();				
		
}
init();
function executeEGS()
{
	if(videoPath != undefined)
	{
		myTween = new Tween(mcVideoPlayer.mcControlPanel, "_y", Elastic.easeInOut, stageh, stageh - mcVideoPlayer.mcControlPanel._height, 1, true);
		specialInterval = setInterval(callSpecial,1000);
		myTweenLogo = new Tween(mcLogo, "_alpha", None.easeNone, mcLogo._alpha, 100, 1, true);
				
	}
	else
	{
		onResize();
	}
}

function callSpecial()
{
	//{
		clearInterval(specialInterval);
		if (autoStart == false)
		{
			loadImage();
		}
		else
		{
			loadVideo();
			mcVideoPlayer.mcPlay.butPlay._visible = false;
		}
					
		setAudio(volAudio); 
		initDoubleClick();
		onResize();
	//};
}



//duplicate thumbnail and big image holders==================
//VideoImage.load("VideoImage.xml");


/**

   October 2007
   Copyright © 2007 by Andrei Potorac  
   All rights reserved.
   
   For customization, please contact me at:
   Email: flashden@andreipotorac.com
   
   
   Last modification: 13 January 2009
   

*/


/**

General settings

*/

Stage.scaleMode = "noScale";
Stage.align = "TL";

import flash.display.BitmapData;
import mx.transitions.Tween;
import mx.transitions.easing.*

this._lockroot = true;
var nrFrames:Number = 30;


/**

Init stage size and variables from flashvars

*/


mcVideoPlayer.myVideo._visible = false;

var stagew:Number = Number(stageW);
var stageh:Number = Number(stageH);

if(isNaN(stagew)) stagew = Stage.width;
if(isNaN(stageh)) stageh = Stage.height;

var initialWidth:Number = mcVideoPlayer.myVideo._width;
var initialHeight:Number = mcVideoPlayer.myVideo._height;


// if the user want a specific size of the video to raport on not on the stage size
if(videoMetaWidth != undefined && videoMetaWidth != "")
{
	videoMetaWidth = int(videoMetaWidth);
}
else // default value for flash IDE
{
	//var newWidth : Number = stagew;
} //trace(videoMetaWidth);

// --------------------------------------------
if(videoMetaHeight != undefined && videoMetaHeight != "")
{
	videoMetaHeight = int(videoMetaHeight);
}
else // default value for flash IDE
{
   //var newHeight : Number = stageh;
}



// --------------------------------------------

if(disableMiddleButton == undefined)
{
	var disableMiddleButton:Boolean = false;
}
else
{
   if( disableMiddleButton == "false" )
   {
	   disableMiddleButton = false;
   }
   
   if( disableMiddleButton == "true" )
   {
	   disableMiddleButton = true;
   }
}

// --------------------------------------------

if(extendVideo == undefined)
{
	var extendVideo:Boolean = false;
}
else
{
   if( extendVideo == "false" )
   {
	   extendVideo = false;
   }
   
   if( extendVideo == "true" )
   {
	   extendVideo = true;
   }
}


// -------------------------------------------


if(playSounds == undefined)
{
	var playSounds:Boolean = false;
}
else
{
   if( playSounds == "false" )
   {
	   playSounds = false;
   }
   
   if( playSounds == "true" )
   {
	   playSounds = true;
   }
}

// --------------------------------------------

if(autoStart == "false")
{
	autoStart = false;
}
else if(autoStart == "true")
{
	autoStart = true;
}

// --------------------------------------------

if(soundBarColor != "" && soundBarColor!=undefined)
{
	mcVideoPlayer.mcControlPanel.mcAudio.mcPlayed.setColor(soundBarColor);
}

// --------------------------------------------

if(barColor != "" && barColor!=undefined)
{
	mcVideoPlayer.mcControlPanel.mcPlayed.setColor(barColor);
}

// --------------------------------------------

if(barShadowColor != "" && barShadowColor!=undefined)
{
	mcVideoPlayer.mcControlPanel.mcVideoLoader.mcOver.setColor(barShadowColor);
}

// --------------------------------------------

if(subbarColor != "" && subbarColor!=undefined)
{
	mcVideoPlayer.mcControlPanel.mcVideoLoader.mcBackVideoLoader.setColor(subbarColor);
	mcVideoPlayer.mcControlPanel.mcAudio.mcAudioLine.setColor(subbarColor);
}

// --------------------------------------------


if(autoHideTime != "" && autoHideTime != undefined)
{
	menuTotalTime = int(autoHideTime);
}
else
{
	var menuTotalTime:Number = 3;
}


// Uncomment this piece of code to make the player work from flash (for testing purposes)





scaleRatio = (stagew * 100) / mcVideoPlayer._width;
mcLogo._xscale = mcLogo._yscale = scaleRatio;


mcBack._visible = false;

//mcVideoPlayer.myVideo._width = stagew;
//mcVideoPlayer.myVideo._height = stageh;

mcVideoPlayer.mcSkin._width = stagew;
mcVideoPlayer.mcSkin._height = stageh;
mcBack._width = stagew;
mcBack._height = stageh;




/**

Variables and initialization

*/

var offset:Number = 1;

var startAudioPosition:Number = mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._x;
var endAudioPosition:Number = mcVideoPlayer.mcControlPanel.mcAudio.mcAudioLine._width - mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._width - 2 * offset;

var startPosition:Number = mcVideoPlayer.mcControlPanel.mcScrub._x - mcVideoPlayer.mcControlPanel.mcScrub._width/2+offset;
var endPosition:Number = Math.round(mcVideoPlayer.mcControlPanel.mcVideoLoader._width + mcVideoPlayer.mcControlPanel.mcVideoLoader._x - mcVideoPlayer.mcControlPanel.mcScrub._width)- startPosition - mcVideoPlayer.mcControlPanel.mcScrub._width - 2*offset;

var settingsArray:Array = new Array();
var videoDuration:Number;
var videoInterval:Number;
var scrubInterval:Number;
var audioInterval:Number;
var vStatusNumber:Number = 0;
var rememberValue:Number = 0;
var speed:Number = 20;
var isOnPosition:Boolean = false;


var isFirst:Boolean = true;
var isLoading:Boolean = true;
var isPaused:Boolean = true;

var soundColor:String = "0xffffff";
var muteColor:String = "0x626262";

mcVideoPlayer.loader._visible = false;
mcVideoPlayer.mcBuffering._visible = false;
mcVideoPlayer.mcControlPanel.butPause._visible = false;
mcVideoPlayer.mcPause.butPause._visible = false;
mcVideoPlayer.mcPause._visible = false;
mcVideoPlayer.mcControlPanel.mcBackCP.mc.butBack.useHandCursor = false;
mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcSpeaker.setColor(soundColor);
mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL1.mcShape.setColor(soundColor);
mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL2.mcShape.setColor(soundColor);
mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL3.mcShape.setColor(soundColor);
mcVideoPlayer.mcControlPanel.mcFullScreen.mcArrowDown._visible = false;
mcVideoPlayer.mcControlPanel.mcScrub.but.enabled = false;
mcVideoPlayer.mcControlPanel.mcVideoLoader.butLine.enabled = false;
mcVideoPlayer.mcControlPanel._y = stageh;
mcVideoPlayer.mcControlPanel._visible = false;
mcVideoPlayer.mcPlay._visible = false;
mcError._visible = false;

mcLogo._alpha = 0;
mcLogo._visible = false;

initialLogoX = stagew - mcLogo._width - 5;
initialLogoY = stageh - mcLogo._height - 30;

mcLogo._x = initialLogoX;
mcLogo._y = initialLogoY;

var isLoaded:Boolean = false;


/**

Variables used to hold the initial position of the elements

*/



var initialMaskLineWidth:Number = initialWidth - mcVideoPlayer.mcControlPanel.mcMaskLine._width;
var initialmcFullScreenX:Number = initialWidth - mcVideoPlayer.mcControlPanel.mcFullScreen._x;

var initialmcTimerX:Number = initialWidth - mcVideoPlayer.mcControlPanel.mcTimer._x;
var initialmcAudioX:Number = initialWidth - mcVideoPlayer.mcControlPanel.mcAudio._x;
var initialmcLineX:Number = initialWidth - mcVideoPlayer.mcControlPanel.mcLine._x;
var initialmcLineX1:Number = initialWidth - mcVideoPlayer.mcControlPanel.mcLine1._x;
var initialmcLineX2:Number = initialWidth - mcVideoPlayer.mcControlPanel.mcLine2._x;

if(disableMiddleButton == true)
{
	mcVideoPlayer.mcPlay.butPlay._visible = false;
}


/**

   This function is used to readjust the size and position of the elements on the stage,
   based on the new size or when the video is set to play full screen (in which case the size changes)

*/

function onResize():Void
{
	 stagew = Stage.width;
	 stageh = Stage.height;
	 
	 mcBack._width = stagew;
	 mcBack._height = stageh;
	 
	 mcBack._visible = true;
	 trace("onResize");
	 if(videoPath != undefined)
	 { 
		 if(Stage["displayState"] == "normal")
		 {
			full = false;
			mcVideoPlayer.mcControlPanel.mcFullScreen.mcArrowUp._visible = true;
			mcVideoPlayer.mcControlPanel.mcFullScreen.mcArrowDown._visible = false;
			
			if(autoHide == "true")
			{
				showMenu();
			}
		 }
		 else
		 {
			full = true;
			mcVideoPlayer.mcControlPanel.mcFullScreen.mcArrowUp._visible = false;
			mcVideoPlayer.mcControlPanel.mcFullScreen.mcArrowDown._visible = true;
		 }
	
	
		 initialLogoX = stagew - mcLogo._width - 5;
		 initialLogoY = stageh - mcLogo._height - 30;
		 
		 mcLogo._x = initialLogoX;
		 mcLogo._y = initialLogoY; 
		 
		 mcVideoPlayer.loader._x = (stagew - mcVideoPlayer.loader._width)/2;
		 mcVideoPlayer.loader._y = (stageh - mcVideoPlayer.loader._height)/2;
		 
		 mcVideoPlayer.mcBuffering._x = (stagew - mcVideoPlayer.mcBuffering._width)/2;
		 mcVideoPlayer.mcBuffering._y = (stageh - mcVideoPlayer.mcBuffering._height)/2;
		 
		 
		  // reposition and rescale the mage and video
		 scaleImage(mcVideoPlayer.myVideo, mcVideoPlayer.mcControlPanel.mcBackCP.mc.butBack._height);
		 
		 if(mcVideoPlayer.imageControl._width)
		 {
		 	scaleImage(mcVideoPlayer.imageControl, mcVideoPlayer.mcControlPanel.mcBackCP.mc.butBack._height);
		 }
		
		
		 // reposition and rescale the control panel
		 
		 mcVideoPlayer.mcControlPanel._y = stageh - mcVideoPlayer.mcControlPanel.mcBackCP.mc.butBack._height;
		 mcVideoPlayer.mcControlPanel.mcBackCP.mc._width = stagew;
		
		 mcVideoPlayer.mcPlay._x = Math.ceil((stagew - mcVideoPlayer.mcPlay._width)/2 + mcVideoPlayer.mcPlay._width/2);
		 mcVideoPlayer.mcPlay._y = Math.ceil((stageh - mcVideoPlayer.mcPlay._height)/2  + mcVideoPlayer.mcPause._height/2);
		 mcVideoPlayer.mcPause._x = Math.ceil((stagew - mcVideoPlayer.mcPause._width)/2 + mcVideoPlayer.mcPause._width/2);
		 mcVideoPlayer.mcPause._y = Math.ceil((stageh - mcVideoPlayer.mcPause._height)/2  + mcVideoPlayer.mcPause._height/2);
		
		 mcVideoPlayer.mcControlPanel.mcMaskLine._width = stagew - initialMaskLineWidth;
		 mcVideoPlayer.mcControlPanel.mcPlayed._width = stagew - initialMaskLineWidth;
		 mcVideoPlayer.mcControlPanel.mcPlayed._x = mcVideoPlayer.mcControlPanel.mcScrub._x - (stagew-initialMaskLineWidth);
		 mcVideoPlayer.mcControlPanel.mcVideoLoader._width = stagew - initialMaskLineWidth;
		
		 mcVideoPlayer.mcControlPanel.mcFullScreen._x = stagew - initialmcFullScreenX;
		 mcVideoPlayer.mcControlPanel.mcTimer._x = stagew - initialmcTimerX;
		
		 mcVideoPlayer.mcControlPanel.mcAudio._x = stagew - initialmcAudioX;
		 mcVideoPlayer.mcControlPanel.mcLine._x = stagew - initialmcLineX;
		 mcVideoPlayer.mcControlPanel.mcLine1._x = stagew - initialmcLineX1;
		 mcVideoPlayer.mcControlPanel.mcLine2._x = stagew - initialmcLineX2;
		
		 endPosition = Math.round(mcVideoPlayer.mcControlPanel.mcVideoLoader._width + mcVideoPlayer.mcControlPanel.mcVideoLoader._x - mcVideoPlayer.mcControlPanel.mcScrub._width) - startPosition + mcVideoPlayer.mcControlPanel.mcScrub._width/2;
	 }
	 else
	 {
		mcVideoPlayer._visible = false;
		mcError._visible = true;
		mcError._x = Math.round((stagew - mcError._width)/2);
		mcError._y = Math.round((stageh - mcError._height)/2);
		mcError._alpha = 100;
	 }
	 
	 mcVideoPlayer.mcControlPanel._visible = true;
	 
	 if(hideLogo != "true")
	{
		mcLogo._visible = true;
	}
		
}


var full:Boolean = false;
Stage["displayState"] = "normal";

Stage.addListener(this);


/**

	Scale the large image to fit the browser window

*/


function resizeObject(mcHolder : MovieClip, pWidth : Number, pHeight : Number) : Void 
{
    // video object
    var proc1 : Number = pWidth / mcHolder._width;
    var proc2 : Number = pHeight / mcHolder._height;
    
    if (proc1 >= proc2) 
    {
        mcHolder._height = pHeight;
        mcHolder._width = proc2 * mcHolder._width;
    }else 
    {
        mcHolder._width = pWidth;
        mcHolder._height = proc1 * mcHolder._height;
    }
    
    mcHolder._x = Math.floor((pWidth - mcHolder._width) / 2);
    mcHolder._y = Math.floor((pHeight - mcHolder._height) / 2);
}



function scaleImage(mc:MovieClip, dropSize:Number):Void
{
	if(extendVideo == true)
	{
		dropSize = 0;
	}
	
	//txt.htmlText += mc._width + " - " + mc;
	//txt.htmlText += mc._height + " - " + mc;
	
	//First check what the ratio enlargement is in horizontal en vertical
	//direction. We use the smallest one as our multiplication factor for
	//both height and width. This way it will stage on stage and not be 
	//deformed, because we use the same factor for height and width
	
	//First the 2 ratio's
	var ratioWidth:Number = Stage.width/mc._width;
	var ratioHeight:Number = (Stage.height - dropSize)/mc._height;
	
	//If the height ratio is smaller than the width ratio, we want to use
	//that as are ratio to enlarge in height and width
	
	if(ratioHeight < ratioWidth)
	{
		mc._height = (Stage.height - dropSize);
		mc._width = mc._width * ratioHeight;
	}
	//Otherwise we use the width ration
	else
	{
		mc._height = mc._height * ratioWidth;
		mc._width = Stage.width;
	}
	
	mc.forceSmoothing = true;
	
		
	// center the image on the browser window
	mc._x = (Stage.width - mc._width)/2;
	mc._y = ((Stage.height - dropSize) - mc._height)/2;
}


/**

   Functions to enter and leave full screen mode

*/

function goFullScreen() 
{
	full = true;
	Stage["displayState"] = "fullScreen";
	mcVideoPlayer.mcControlPanel.mcFullScreen.mcArrowUp._visible = false;
	mcVideoPlayer.mcControlPanel.mcFullScreen.mcArrowDown._visible = true;
}
function exitFullScreen() 
{
	full= false;
	Stage["displayState"] = "normal";
	mcVideoPlayer.mcControlPanel.mcFullScreen.mcArrowUp._visible = true;
	mcVideoPlayer.mcControlPanel.mcFullScreen.mcArrowDown._visible = false;
	
	if(autoHide == "true")
	{
		showMenu();
	}
}


/**

   Middle button

*/

mcVideoPlayer.mcPlay.butPlay.onRollOver = function():Void
{
	if(playSounds == true)
	{
		var sou:Sound = new Sound();
		//sou.attachSound("over");
		sou.start();
	}
}

mcVideoPlayer.mcPlay.butPlay.onPress = function():Void
{
	if(playSounds == true)
	{
		var sou:Sound = new Sound();
		//sou.attachSound("click");
		sou.start();
	}
}


/**

   Fullscreen button

*/

mcVideoPlayer.mcControlPanel.mcFullScreen.but.onRelease = function():Void
{
	if(full == false)
	{
		goFullScreen();
	}
	else if(full == true)
	{
		exitFullScreen();
	}
}

mcVideoPlayer.mcControlPanel.mcFullScreen.but.onRollOver = function():Void
{
	if(playSounds == true)
	{
		var sou:Sound = new Sound();
		//sou.attachSound("over");
		sou.start();
	}
}

mcVideoPlayer.mcControlPanel.mcFullScreen.but.onPress = function():Void
{
	if(playSounds == true)
	{
		var sou:Sound = new Sound();
		//sou.attachSound("click");
		sou.start();
	}
}


/**

Sound

*/

this.createEmptyMovieClip("vSound", this.getNextHighestDepth());

function setAudio(val):Void 
{
    var end:Number = (startAudioPosition + mcVideoPlayer.mcControlPanel.mcAudio.mcAudioLine._width- mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._width - 2*offset);
	mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._x =  startAudioPosition + Math.round(val * ((end - startAudioPosition)/100));
	mcVideoPlayer.mcControlPanel.mcAudio.mcPlayed._x = mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._x;
	changeVolume(val);
}


/**

Add items to right-click menu

*/

// function to enable, disable context menu items, based on which mode we are in.
function menuHandler(obj, menuObj) 
{
	if (Stage["displayState"] == "normal") 
	{
		// if we're in normal mode, enable the 'go full screen' item, disable the 'exit' item
		menuObj.customItems[0].enabled = true;
		menuObj.customItems[1].enabled = false;
	} 
	else 
	{
		// if we're in full screen mode, disable the 'go full screen' item, enable the 'exit' item
		menuObj.customItems[0].enabled = false;
		menuObj.customItems[1].enabled = true;
	}
}

var fullscreenCM:ContextMenu = new ContextMenu(menuHandler);                          // create a new context menu
fullscreenCM.hideBuiltInItems();                                                      // hide the regular built-in items
var fs:ContextMenuItem = new ContextMenuItem("Go Full Screen", goFullScreen);         // add the items to enter and leave full screen mode
fullscreenCM.customItems.push(fs);
var xfs:ContextMenuItem = new ContextMenuItem("Exit Full Screen", exitFullScreen);
fullscreenCM.customItems.push(xfs);

menu = fullscreenCM;


/**

Check loading progress - main image

*/

var listnerGallery:Object = new Object();
listnerGallery.onLoadInit = function(mc:MovieClip) 
{
		bmp = new BitmapData(mc._width, mc._height, true, ffffff);
		bmp.draw(mc);
		mc.attachBitmap(bmp, 1, "auto", true);

		mcVideoPlayer.loader._visible = false;
		
		isLoaded = true;
		
		if(playButtonDisplayed != true)
		{
			if(isPaused != false)
			{
				myTweenAlpha1 = new Tween(mc, "_alpha", None.easeNone, 0, 100, 1, true);
			}
			
			playButtonDisplayed = true;
			
			myTweenAlpha1.onMotionFinished = function() 
			{
				displayPlayButton();
			};
		}
		else
		{
			if(isPaused != false)
			{
				myTweenAlpha1 = new Tween(mc, "_alpha", None.easeNone, 0, 100, 1, true);
			}
		}
		
		scaleImage(mc, mcVideoPlayer.mcControlPanel.mcBackCP.mc.butBack._height);
};


var objGallery:MovieClipLoader = new MovieClipLoader();
objGallery.addListener(listnerGallery);


/**

Load main image

*/

function loadImage():Void 
{
	trace("hello");
	isLoading = true;
	mcVideoPlayer.imageControl._alpha = 0;
	objGallery.loadClip(imagePath, mcVideoPlayer.imageControl);
	mcVideoPlayer.loader._visible = true;
}


/**

   Display middle button with the bounce effect - looks really nice! :)

*/

function displayPlayButton():Void
{
	mcVideoPlayer.mcPlay._xscale = mcVideoPlayer.mcPlay._yscale = 10;
	mcVideoPlayer.mcPlay._visible = true;
	var myTween1:Tween = new Tween(mcVideoPlayer.mcPlay, "_xscale", Bounce.easeOut, 10, 100, 0.8, true);
	var myTween2:Tween = new Tween(mcVideoPlayer.mcPlay, "_yscale", Bounce.easeOut, 10, 100, 0.8, true);
}


/**

Pause video button

*/

mcVideoPlayer.mcControlPanel.butPause.onRollOver = function():Void
{
	if(playSounds == true)
	{
		var sou:Sound = new Sound();
		//sou.attachSound("over");
		sou.start();
	}
}

mcVideoPlayer.mcControlPanel.butPause.onPress = function():Void
{
	if(playSounds == true)
	{
		var sou:Sound = new Sound();
		//sou.attachSound("click");
		sou.start();
	}
}

mcVideoPlayer.mcControlPanel.butPause.onRelease = function():Void
{
	isPaused = true;
	ns.pause(true);

	mcVideoPlayer.mcControlPanel.butPause._visible = false;
	mcVideoPlayer.mcPause.butPause._visible = false;
	mcVideoPlayer.mcControlPanel.butPlay._visible = true;
	
	if(disableMiddleButton == false)
	{
		mcVideoPlayer.mcPlay.butPlay._visible = true;
	}
};

mcVideoPlayer.mcPause.butPause.onRelease = mcVideoPlayer.mcControlPanel.butPause.onRelease;


/**

Play video button

*/

mcVideoPlayer.mcControlPanel.butPlay.onRollOver = function():Void
{
	if(playSounds == true)
	{
		var sou:Sound = new Sound();
		//sou.attachSound("over");
		sou.start();
	}
}

mcVideoPlayer.mcControlPanel.butPlay.onPress = function():Void
{
	if(playSounds == true)
	{
		var sou:Sound = new Sound();
		//sou.attachSound("click");
		sou.start();
	}
}

mcVideoPlayer.mcPlay.butPlay.onRelease = loadVideo;
mcVideoPlayer.mcControlPanel.butPlay.onRelease = loadVideo;


/**

Load the video and display main image

*/

function loadVideo():Void
{
	isPaused = false;
	mcVideoPlayer.mcControlPanel.mcScrub.but.enabled = true;
	mcVideoPlayer.mcControlPanel.mcVideoLoader.butLine.enabled = true;
	mcVideoPlayer.mcControlPanel.butPlay._visible = false;
	mcVideoPlayer.mcPlay.butPlay._visible = false;
	
	
	delete mcVideoPlayer.imageControl.onEnterFrame();
	
	if (isFirst == true)
	{
		isFirst = false;
		mcVideoPlayer.loader._visible = false;
		
		// if the image is loaded, the video can start after the image fades out
		
		myTweenAlpha1.stop();
		
		if (isLoading == false)
		{
			var myTweenAlpha3:Tween = new Tween(mcVideoPlayer.imageControl, "_alpha", None.easeNone, mcVideoPlayer.imageControl._alpha, 0, 0.5, true);
			mcVideoPlayer.mcControlPanel.butPause.enabled = false;
			mcVideoPlayer.mcPause.butPause.enabled = false;
			//isLoaded = true;
		}
		else 
		{
			var myTweenAlpha3:Tween = new Tween(mcVideoPlayer.imageControl, "_alpha", None.easeNone, mcVideoPlayer.imageControl._alpha, 0, 0.5, true);
			//isLoaded = false;
		}
		
		myTweenAlpha3.onMotionFinished = function() 
		{
			playVideo();
			mcVideoPlayer.myVideo._visible = true;
		};
	} 
	else
	{
		ns.pause(false);
	}
	
	mcVideoPlayer.mcControlPanel.butPause._visible = true;
	mcVideoPlayer.mcPause.butPause._visible = true;
}


/**

Stop video button

*/

mcVideoPlayer.mcControlPanel.butStop.onRollOver = function():Void
{
	if(playSounds == true)
	{
		var sou:Sound = new Sound();
		//sou.attachSound("over");
		sou.start();
	}
}

mcVideoPlayer.mcControlPanel.butStop.onPress = function():Void
{
	if(playSounds == true)
	{
		var sou:Sound = new Sound();
		//sou.attachSound("click");
		sou.start();
	}
}

mcVideoPlayer.mcControlPanel.butStop.onRelease = function():Void
{
		if (isPaused == false)
		{
			ns.pause();
			isPaused = true;
		}
		clearInterval(videoInterval);
		
		mcVideoPlayer.mcPlay._visible = true;
		mcVideoPlayer.mcControlPanel.mcVideoLoader.mcMask._xscale = 0;
		vStatusNumber = 0;
		
		clearInterval(buffer_interval);
		mcVideoPlayer.mcBuffering._visible = false;
		
		mcVideoPlayer.mcControlPanel.butPause._visible = false;
		mcVideoPlayer.mcPause.butPause._visible = false;
		mcVideoPlayer.mcControlPanel.butPlay._visible = true;
		
		if(disableMiddleButton == false)
		{
			mcVideoPlayer.mcPlay.butPlay._visible = true;
		}
		
		mcVideoPlayer.mcControlPanel.mcScrub._x = startPosition + mcVideoPlayer.mcControlPanel.mcScrub._width/2 - offset;
		mcVideoPlayer.mcControlPanel.mcPlayed._x = mcVideoPlayer.mcControlPanel.mcScrub._x;
		mcVideoPlayer.mcControlPanel.mcTimer.tPassedTime.htmlText = "00:00";
		mcVideoPlayer.mcControlPanel.mcTimer.tTotalTime.htmlText = "00:00";
		mcVideoPlayer.mcControlPanel.mcScrub.but.enabled = false;
		mcVideoPlayer.mcControlPanel.mcVideoLoader.butLine.enabled = false;
		
		ns.pause(true);
		
		if (isLoaded == true)
		{
			mcVideoPlayer.imageControl._alpha=100;
			ns.seek(0);
		}
		else
		{	
			mcVideoPlayer.imageControl._alpha=100;
			loadImage();
			//trace("here")
		}
		
		mcVideoPlayer.myVideo._visible = false;
		isFirst = true;
};


/**

Video scrub

*/

function playVideo():Void
{
	// start checking the buffer
	clearInterval(buffer_interval);
	buffer_interval = setInterval(checkBufferTime, 10, ns);


	mcVideoPlayer.mcControlPanel.butPause.enabled = true;
	mcVideoPlayer.mcPause.butPause._visible = true;
	
	ns.play(videoPath);
	clearInterval(videoInterval);
	videoInterval = setInterval(videoStatus, 10);
}

function videoStatus():Void
{
	vStatusNumber = Math.round(ns.bytesLoaded/ns.bytesTotal*100);
	
	if (vStatusNumber<=100)
	{
		mcVideoPlayer.mcControlPanel.mcVideoLoader.mcMask._xscale = vStatusNumber;
	}
	
	if (videoDuration != undefined && isPaused == false)
	{
		mcVideoPlayer.mcControlPanel.mcScrub._x = (startPosition + mcVideoPlayer.mcControlPanel.mcScrub._width/2 - offset)+ ns.time/videoDuration * (endPosition - mcVideoPlayer.mcControlPanel.mcScrub._width/2);
		mcVideoPlayer.mcControlPanel.mcPlayed._x = mcVideoPlayer.mcControlPanel.mcScrub._x;
		showTime(ns.time);
	}
}


/**

Display time passed

*/

function showTime(id:Number):Void
{
	var minutes:Number = int((int(id))/60);
	var seconds:Number = (int(id))%60;
	
	if (minutes<10)
	{
		var m = "0"+minutes;
	} 
	else 
	{
		var m = minutes;
	}
	
	if (seconds<10) 
	{
		var s = "0"+seconds;
	} 
	else 
	{
		var s = seconds;
	}
	
	mcVideoPlayer.mcControlPanel.mcTimer.tPassedTime.htmlText = m+":"+s;
}


/**

Audio button

*/

mcVideoPlayer.mcControlPanel.mcAudio.mcScrub.but.onPress = function():Void  
{
	clearInterval(audioInterval);
	audioInterval = setInterval(scrubAudio, 10);
	var end:Number = (startAudioPosition + mcVideoPlayer.mcControlPanel.mcAudio.mcAudioLine._width- mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._width - 2*offset);
	mcVideoPlayer.mcControlPanel.mcAudio.mcScrub.startDrag(false, startAudioPosition, mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._y, end, mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._y);
};

mcVideoPlayer.mcControlPanel.mcAudio.mcScrub.but.onRelease = mcVideoPlayer.mcControlPanel.mcAudio.mcScrub.but.onReleaseOutside=function():Void 
{
	clearInterval(audioInterval);
	mcVideoPlayer.mcControlPanel.mcAudio.mcScrub.stopDrag();
};

function scrubAudio():Void 
{
	v = Math.floor((((mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._x-startAudioPosition)/endAudioPosition)*100));
	mcVideoPlayer.mcControlPanel.mcAudio.mcPlayed._x = mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._x;
	changeVolume(v);
}


/**

Change the audio icon color and number of lines, based on the volume

*/

function changeVolume(v:Number):Void 
{
	backSound.setVolume(v);
	
	if (v == 0) 
	{
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcSpeaker.setColor(muteColor);
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL1.mcShape.setColor(muteColor);
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL2.mcShape.setColor(muteColor);
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL3.mcShape.setColor(muteColor);
	} 
	else 
	{
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcSpeaker.setColor(soundColor);
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL1.mcShape.setColor(soundColor);
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL2.mcShape.setColor(soundColor);
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL3.mcShape.setColor(soundColor);
	}
	
	if (v == 0) 
	{
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL1._visible = false;
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL2._visible = false;
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL3._visible = false;
	}
	else
	{
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL1._visible = true;
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL2._visible = true;
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL3._visible = true;
	}
	
	if (v<=33 && v>0) 
	{
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL1._visible = true;
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL2._visible = false;
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL3._visible = false;
	}
	
	if (v<=66 && v>33)
	{
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL1._visible = true;
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL2._visible = true;
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL3._visible = false;
	}
	
	if (v>66) 
	{
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL1._visible = true;
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL2._visible = true;
		mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.mcL3._visible = true;
	}
}


mcVideoPlayer.mcControlPanel.mcAudio.mcAudioSign.but.onRelease = function():Void  
{
	if (backSound.getVolume() != 0) 
	{
		if(backSound.getVolume() != undefined)
		{
			rememberValue = backSound.getVolume();
		}
		backSound.setVolume(0);
		changeVolume(0);
		mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._x = Math.round(startAudioPosition);
		mcVideoPlayer.mcControlPanel.mcAudio.mcPlayed._x = mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._x;
	} 
	else 
	{
		backSound.setVolume(rememberValue);
		changeVolume(rememberValue);
		mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._x = Math.round(rememberValue/100*endAudioPosition+startAudioPosition);
	    mcVideoPlayer.mcControlPanel.mcAudio.mcPlayed._x = mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._x;
	}
};


/**

Line button - audio volume

*/

mcVideoPlayer.mcControlPanel.mcAudio.mcAudioLineBut.but.useHandCursor = false;

mcVideoPlayer.mcControlPanel.mcAudio.mcAudioLineBut.but.onPress = function():Void 
{
	clearInterval(audioInterval);
	
	if (_xmouse - mcVideoPlayer.mcControlPanel.mcAudio._x + 1 < startAudioPosition)
	{
		mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._x = startAudioPosition;
	}
	else if (_xmouse - mcVideoPlayer.mcControlPanel.mcAudio._x + 1 > startAudioPosition + endAudioPosition)
	{
		mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._x = startAudioPosition + endAudioPosition;
	}
	else
	{
		mcVideoPlayer.mcControlPanel.mcAudio.mcScrub._x = _xmouse - mcVideoPlayer.mcControlPanel.mcAudio._x + 1;
	}
	
	scrubAudio();
};


/**

Scrub video button

*/

mcVideoPlayer.mcControlPanel.mcScrub.but.onPress = function():Void 
{
	// add '&& full==false' if you want a user not to be able to drag the scrub while the player is full screen
	if (vStatusNumber != 0) 
	{
		clearInterval(videoInterval);
		scrubInterval = setInterval(scrubIt, 10);
		mcVideoPlayer.mcControlPanel.mcScrub.startDrag(true, startPosition + (mcVideoPlayer.mcControlPanel.mcScrub._width/2 - offset), mcVideoPlayer.mcControlPanel.mcScrub._y, startPosition + endPosition - offset , mcVideoPlayer.mcControlPanel.mcScrub._y);
	}
};

mcVideoPlayer.mcControlPanel.mcScrub.but.onRelease = mcVideoPlayer.mcControlPanel.mcScrub.but.onReleaseOutside=function():Void 
{
	// add '&& full==false' if you want a user not to be able to drag the scrub while the player is full screen
	if (vStatusNumber != 0) 
	{
		clearInterval(scrubInterval);
		if (isPaused == false) 
		{
			ns.pause();
		}
		mcVideoPlayer.mcControlPanel.mcScrub.stopDrag();
		ns.seek(Math.floor((((mcVideoPlayer.mcControlPanel.mcScrub._x-startPosition)/endPosition)*videoDuration)));
		videoInterval = setInterval(videoStatus, 10);
	}
};

mcVideoPlayer.mcControlPanel.mcScrub.but.onReleaseOutside = mcVideoPlayer.mcControlPanel.mcScrub.but.onRelease;

function scrubIt():Void 
{
	if (videoDuration != undefined) 
	{
		ns.seek(Math.floor((((mcVideoPlayer.mcControlPanel.mcScrub._x-startPosition)/endPosition) * videoDuration)));
		ns.pause(true);
		showTime(((mcVideoPlayer.mcControlPanel.mcScrub._x-startPosition)/endPosition)*videoDuration);
		mcVideoPlayer.mcControlPanel.mcPlayed._x = mcVideoPlayer.mcControlPanel.mcScrub._x;
		updateAfterEvent();
	}
}


/**

Line button - area where the video scrub moves

*/

mcVideoPlayer.mcControlPanel.mcVideoLoader.butLine.onPress = function():Void 
{
	if (vStatusNumber != 0) 
	{
		clearInterval(videoInterval);
		
		if (_xmouse-mcVideoPlayer.mcControlPanel.mcScrub._width<startPosition) 
		{
			mcVideoPlayer.mcControlPanel.mcScrub._x = startPosition;
		} 
		else if (_xmouse-mcVideoPlayer.mcControlPanel.mcScrub._width > startPosition + endPosition) 
		{
			mcVideoPlayer.mcControlPanel.mcScrub._x = startPosition+endPosition;
		}
		else 
		{
			mcVideoPlayer.mcControlPanel.mcScrub._x = _xmouse;
		}
		
		mcVideoPlayer.mcControlPanel.mcPlayed._x = mcVideoPlayer.mcControlPanel.mcScrub._x;
		
		ns.seek(Math.floor((((mcVideoPlayer.mcControlPanel.mcScrub._x-startPosition)/endPosition)*videoDuration)));
		ns.pause(true);
	}
};

mcVideoPlayer.mcControlPanel.mcVideoLoader.butLine.onRelease = function():Void  
{
	if (vStatusNumber != 0)
	{
		if (videoDuration != undefined)
		{
			ns.seek(Math.floor((((mcVideoPlayer.mcControlPanel.mcScrub._x-startPosition)/endPosition)*videoDuration)));
		}
		
		if (isPaused == false)
		{
			ns.pause();
		}
		
		videoInterval = setInterval(videoStatus, 10);
	}
};

mcVideoPlayer.mcControlPanel.mcVideoLoader.butLine.onReleaseOutside = mcVideoPlayer.mcControlPanel.mcVideoLoader.butLine.onRelease;


/**

Video

*/

var nc:NetConnection = new NetConnection();
nc.connect(null);

var ns:NetStream = new NetStream(nc);
ns.setBufferTime(5);


// start checking the buffer
var buffer_interval:Number;

function checkBufferTime(my_ns:NetStream):Void 
{
    var bufferPct:Number = Math.round(my_ns.bufferLength / my_ns.bufferTime * 100);
	
    if(bufferPct >= 100)
	{
    	mcVideoPlayer.mcBuffering._visible = false;
	}
	else
	{
		mcVideoPlayer.mcBuffering._visible = true;
	}
}



ns.onStatus = function(info):Void 
{
	/*
	trace("NetStream.onStatus called: ("+getTimer()+" ms)");
	for (var prop in info) 
	{
		trace("\t"+prop+":\t"+info[prop]);
	}
	
	trace("");
	*/
			
	if (info.code == "NetStream.Buffer.Full") 
	{
	}
	
	if (info.code == "NetStream.Buffer.Flush") 
	{
		clearInterval(buffer_interval);
		mcVideoPlayer.mcBuffering._visible = false;
	}
	
	if (info.code == "NetStream.Buffer.Notify") 
	{
	}
	
	if (info.code == "NetStream.Buffer.Empty" || info.code == "NetStream.Play.Start") 
	{
	}
	
	if (info.code == "NetStream.Play.Stop") 
	{
		
		if (isPaused == false)
		{
			ns.pause(true);
			isPaused = true;
		}
		clearInterval(videoInterval);
		
		mcVideoPlayer.mcControlPanel.mcVideoLoader.mcMask._xscale = 0;
		vStatusNumber = 0;
		mcVideoPlayer.mcBuffering._visible = false;
		mcVideoPlayer.mcControlPanel.butPause._visible = false;
		mcVideoPlayer.mcPause.butPause._visible = false;
		mcVideoPlayer.mcControlPanel.butPlay._visible = true;
		
		if(disableMiddleButton == false)
		{
			mcVideoPlayer.mcPlay.butPlay._visible = true;
		}
		
		mcVideoPlayer.mcControlPanel.mcScrub._x = startPosition + mcVideoPlayer.mcControlPanel.mcScrub._width/2 - offset;
		mcVideoPlayer.mcControlPanel.mcPlayed._x = mcVideoPlayer.mcControlPanel.mcScrub._x;
		mcVideoPlayer.mcControlPanel.mcTimer.tPassedTime.htmlText = "00:00";
		mcVideoPlayer.mcControlPanel.mcTimer.tTotalTime.htmlText = "00:00";
		mcVideoPlayer.mcControlPanel.mcScrub.but.enabled = false;
		mcVideoPlayer.mcControlPanel.mcVideoLoader.butLine.enabled = false;

		ns.pause(true);
		
		if (isLoaded == true) 
		{			
			mcVideoPlayer.imageControl._alpha = 100;
			ns.seek(0);
		}
		else 
		{	
			mcVideoPlayer.imageControl._alpha = 100;
			loadImage();
		}
		
		if(autoHide == "true")
		{
			showMenu();
		}
		
		mcVideoPlayer.myVideo._visible = false;
		isFirst = true;
	}
};

mcVideoPlayer.myVideo._visible = false;
mcVideoPlayer.myVideo.attachVideo(ns);
mcVideoPlayer.myVideo.smoothing = true;

ns["onMetaData"] = function (obj) 
{
	videoDuration = obj.duration;
	//mcVideoPlayer.myVideo._visible = true;
	
	if(obj.width != undefined)
	{
		mcVideoPlayer.myVideo._width = obj.width; 
		mcVideoPlayer.myVideo._height = obj.height;
	}
	else
	{
		//trace("Video-ul nu are dimensiuni in meta!");
		mcVideoPlayer.myVideo._width = videoMetaWidth; 
		mcVideoPlayer.myVideo._height = videoMetaHeight;
	}
	
	
	if (videoDuration != undefined)
	{
		var minutes:Number = int((int(videoDuration))/60);
		var seconds:Number = (int(videoDuration))%60;
		
		if (minutes<10) 
		{
			var m = "0"+minutes;
		} 
		else
		{
			var m = minutes;
		}
		
		if (seconds<10) 
		{
			var s = "0"+seconds;
		}
		else
		{
			var s = seconds;
		}
		
		if (isPaused == false)
		{
			mcVideoPlayer.mcControlPanel.mcTimer.tTotalTime.htmlText = m+":"+s;
			totalMinutes = m;
			totalSeconds = s;
		}
	}
	
	scaleImage(mcVideoPlayer.myVideo, mcVideoPlayer.mcControlPanel.mcBackCP.mc.butBack._height);
	
	mcVideoPlayer.myVideo._visible = true;
};

vSound.attachAudio(ns);

var backSound:Sound = new Sound(vSound);
backSound.setVolume(100); 


/**

	Menu timer

*/


this.createEmptyMovieClip("mcTimer", this.getNextHighestDepth());
this.createEmptyMovieClip("mcHitTest", this.getNextHighestDepth());

var isHidden:Boolean = false;
var myTweena:Tween = new Tween();


function hideMenu(bClicked:Boolean):Void
{
	myTweena.stop();
	myTweena = new Tween(mcVideoPlayer.mcControlPanel, "_alpha", Strong.easeOut, mcVideoPlayer.mcControlPanel._alpha, 0, 0.5, true);
	
	isHidden = true;

	Mouse.hide();
	
	delete mcTimer.onEnterFrame;
	mcTimer.count = 0;
}

function showMenu():Void
{
	myTweena.stop();
	
	mcVideoPlayer.mcControlPanel._alpha = 100;
	isHidden = false;

	Mouse.show();
	
	startCounting();  
}

function startCounting():Void
{
	mcTimer.count = 0;
	delete mcTimer.onEnterFrame;
	
	mcTimer.onEnterFrame = function():Void
	{
		this.count++;

		if( Math.round(this.count / nrFrames) >= menuTotalTime && isPaused != true )
		{
			delete this.onEnterFrame;
			this.count = 0;
			hideMenu();
		}
	}
}


var someListener:Object = new Object();

someListener.onMouseMove = function ():Void 
{	
	if(autoHide == "true")
	{
		showMenu();
	}
};


/**

	Doubleclick - fullscreen toogle

*/

doubleclickDuration = 300;
lastClick = 0;

onMouseUp = function()
{
    if (lastClick == 0) 
	{
      lastClick = getTimer();
    } 
	else
	{
      lastClick = 0;
     //trace ("double click");
	  
	 mcVideoPlayer.mcControlPanel.mcFullScreen.but.onRelease();
    }
}

this.createEmptyMovieClip("doubleClick", this.getNextHighestDepth());

function initDoubleClick():Void
{
	Mouse.addListener(someListener);
	
	doubleClick.onEnterFrame = function():Void
	{
		
	  if(Stage.width < 275)
	  {
		  mcVideoPlayer.mcControlPanel._visible = false;
	  }
	  
	  if (lastClick>0)
	  {
		if ((getTimer()-lastClick) > doubleclickDuration) 
		{
		  lastClick = 0;
		 //trace ("single click");
		}
	  }  
	}
}


/**

	SPACE BUTTON - play/pause toogle

*/

var keyListener_obj:Object = new Object();

keyListener_obj.onKeyDown = function() 
{
	
    switch (Key.getCode())
	{
		case Key.SPACE :
			if(isPaused == true)
			{
				mcVideoPlayer.mcControlPanel.butPlay.onRelease();
			}
			else
			{
				mcVideoPlayer.mcControlPanel.butPause.onRelease();
			}
		break;
    }
};

Key.addListener(keyListener_obj);



/**

	SPACE BUTTON - play/pause toogle

*/

mcLogo.but.onRelease = function():Void
{
	//getURL("http://www.flashden.net?ref=bobocel", "_blank");
}




/**************************
* Bandwidth Detector

Downloads a hidden test image from a predefined URL
and determines client bandwidth based on how
quickly the image is downloaded. 
Test image must be ~12k in filesize (smaller filesizes 
result in inaccurate detections on fast connections). 
Image is not cached due to random string added to URL.

"Test" variable in calc_bandwidth(); is bandwidth value.
(~300kbps cable/DSL, ~20kbps dialup)

*************************/

// container for image
this.createEmptyMovieClip("imageMovieClip", this.getNextHighestDepth());
imageMovieClip._visible = false;

// gloabal vars
var startTime : Number;
var endTime : Number;
var datasize : Number;
var bandwidth : Number;

// image loader object
var testImage:MovieClipLoader = new MovieClipLoader();
var testListener:Object = new Object();
testImage.addListener(testListener);

// load the test image and prevent it from being cached
function detectBandwidth():Void
{
	testImage.loadClip("bandwidth_detection.jpg?v=" + new Date().getTime(), imageMovieClip);
}

// timer during image loading
testListener.onLoadStart = function(targetMovieClip : MovieClip):Void 
{
	//trace(targetMovieClip);
	startTime = getTimer();
};

// handle image loading
testListener.onLoadProgress = function(targetMovieClip:MovieClip, numBytesLoaded:Number, numBytesTotal:Number):Void 
{
	//trace(numBytesLoaded + " " + numBytesTotal);
	var imageLoaded : Number = Math.ceil(100 * (numBytesLoaded / numBytesTotal) );
	datasize = numBytesTotal;	
};


testListener.onLoadInit = function():Void
{
	endTime = getTimer();
	bdth = calc_bandwidth();
	imageMovieClip.removeMovieClip();
	
	//trace(bdth);
}

// kbps conversion
function calc_bandwidth() : Number
{
	//trace(endTime + " " + startTime);
	var offsetMilliseconds = endTime - startTime;
	var offsetSeconds = offsetMilliseconds / 1000;
	var bits = datasize * 8;
	var kbits = bits / 1024;
	
	bandwidth = (kbits / offsetSeconds) * 0.93;
	
	// show the bandwidth
	bandwidth = Math.round(bandwidth);

	// return the freandly number bandwidth
	return bandwidth;
};

//detectBandwidth();

// End bandwidth detector code




/**

	START PLAYER

*/


/**

Testing if the video path is sent, to display the player or the error panel - both centered

*/








