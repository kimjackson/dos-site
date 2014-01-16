package com.rimv.application 
{
	import caurina.transitions.*;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.net.*;
	import flash.filters.*;
	import flash.text.TextField;
	
	/**
	 * @author Rimmon Trieu
	 * RV Compact MP3 Player
	 * www.mymedia-art.com - trieuduchien@gmail.com
	 */
	
	public class RVCMP3 extends MovieClip
	{
		
		//________________________________________ parameters feed from XML
		
		public var SpectrumLineWidth:Number;
		public var SpectrumLineColor:Number;
		public var SpectrumGlowColor:String;
		public var SpectrumGlowIntensity:Number;
		public var SpectrumGlowDirection:String;
		public var bufferTime:Number = 3;
		public var scrollSpeed:Number = 100;
		public var _xmlPath:String;
		
		//________________________________________ misc variables
		
		private var xmlLoader:URLLoader = new URLLoader();
		private	var xmlData:XML = new XML();
		private var TOTAL:Number;
		private var progressChecking:Timer = new Timer(40);
		private var scrolling:Timer = new Timer(1000);
		private var ssUpdate:Timer = new Timer(20);
		private var lastID:Number;
		private var currentID:Number = 999;
		private var currentVolume:Number = 1;
		private var down:Boolean = false;
		private var dir:Number = 1;
		private var currentSoundProgress:Number;
		private var SGD:String;
		
		// Data array
		private var items:Array = new Array();
		// sound spectrum array
		private var ss:ByteArray = new ByteArray();
		// bitmap data to create spectrum
		private var bmpData:BitmapData;
		private var bmp:Bitmap;
		// to draw line spectrum
		private var lsp:Sprite = new Sprite();
		// filter
		private var blur:BlurFilter;
		private var colorMatrix:ColorMatrixFilter

		// Main sounds object
		private var _sound:Sound = new Sound();
		private var _soundChannel:SoundChannel;
		private var _soundTransform:SoundTransform;
		private var _soundLoaderContext:SoundLoaderContext = new SoundLoaderContext();
		
		
		//__________________________________________________________ get - set property
		
		
		public function set xmlPath(s:String):void
		{
			_xmlPath = s;
		}
		
		public function get xmlPath():String
		{
			return _xmlPath;
		}
		
		//__________________________________________________________  constructor - initialize
		
		public function RVCMP3() 
		{
			// hide display clip
			display.visible = false;
			// hide buffer clip
			bufferClip.visible = false;
		}
		
		
		private function showBanner(e:MouseEvent):void
		{
			// fade in progress
			Tweener.addTween(control, { alpha:1, time:1 } );
			//Tweener.addTween(progressBar, { alpha:1, time:1 } );
		}
		
		private function hideBanner(e:MouseEvent):void
		{
			// fade out progress
			Tweener.addTween(control, { alpha:0, time:3});
			//Tweener.addTween(progressBar, { alpha:0, time:3});
		}
		
		public function initialize():void
		{
			// hide initial button
			with (control)
			{
				playBut.visible = soundMute.visible = false;
				// add interactive
				playBut.addEventListener(MouseEvent.CLICK, playRVMP3);
				pauseBut.addEventListener(MouseEvent.CLICK, pauseRVMP3);
				stopBut.addEventListener(MouseEvent.CLICK, stopRVMP3);
				nextBut.addEventListener(MouseEvent.CLICK, nextRVMP3);
				preBut.addEventListener(MouseEvent.CLICK, preRVMP3);
				sound.addEventListener(MouseEvent.CLICK, soundOn);
				soundMute.addEventListener(MouseEvent.CLICK, soundOff);
				vSlider.scrubber.addEventListener(MouseEvent.MOUSE_DOWN, scrubberPress);
				vSlider.scrubber.addEventListener(MouseEvent.MOUSE_UP, scrubberRelease);
				vSlider.volumeBar.addEventListener(MouseEvent.CLICK, volumeSeek);
			}
			
			control.addEventListener(MouseEvent.MOUSE_OVER, showBanner);
			control.addEventListener(MouseEvent.MOUSE_OUT, hideBanner);
			
			// progress update
			progressChecking.addEventListener(TimerEvent.TIMER, progressUpdate);
			// text scrolling
			scrolling.addEventListener(TimerEvent.TIMER, textScrolling);
			// seek progress bar
			control.progressBar.addEventListener(MouseEvent.CLICK, progressSeek);
			//progressBar.addEventListener(MouseEvent.MOUSE_OVER, progressBarOver);
			//progressBar.addEventListener(MouseEvent.MOUSE_OUT, progressBarOut);
			// spectrum area
			//spectrumArea.addEventListener(MouseEvent.MOUSE_OVER, spectrumAreaOver);
			//spectrumArea.addEventListener(MouseEvent.MOUSE_OUT, spectrumAreaOut);
			//spectrumArea.addEventListener(MouseEvent.CLICK, spectrumAreaClick);
			ssUpdate.addEventListener(TimerEvent.TIMER, ssUpdateHandler);
			//progressBar.visible = true;
			// setup spectrum
			bmpData = new BitmapData(358, 100, true, 0x000000);
			bmp = new Bitmap(bmpData);
			spectrumArea.specArea.addChild(lsp);
			spectrumArea.specArea.addChild(bmp);
			// filter
			blur = new BlurFilter(8,8,3);
			colorMatrix = new ColorMatrixFilter([
				 1, 0, 0, 0, 0,
				 0, 1, 0, 0, 0,
				 0, 0, 1, 0, 0,
				 0, 0, 0, 1, 0
			]);
			// Load data from XML
			xmlLoad(_xmlPath);
		}
		
		//__________________________________________________________ LOAD XML
		
		private function xmlLoad(xmlPath:String):void
		{
			ParseData();
			//xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			//xmlLoader.load(new URLRequest(xmlPath));
		}
		
		private function xmlLoaded(e:Event):void
		{
			//Extract data
			xmlData = new XML(e.target.data);
			//ParseData(xmlData);
		}
		
		private function ParseData():void
		{
			// save configuration
			SpectrumLineWidth = 1;
			SpectrumLineColor = 0xfab704;
			SpectrumGlowDirection = "horizontal";
			bufferTime = 10;
			scrollSpeed = 80;
			/*SpectrumLineWidth = Number(data.config.@SpectrumLineWidth);
			SpectrumLineColor = Number(data.config.@SpectrumLineColor);
			SpectrumGlowColor = String(data.config.@SpectrumGlowColor);
			SpectrumGlowIntensity = Number(data.config.@SpectrumGlowIntensity);
			SGD = SpectrumGlowDirection = String(data.config.@SpectrumGlowDirection);
			scrollSpeed = Number(data.config.@scrollSpeed);
			bufferTime = Number(data.config.@bufferTime);
			scrolling.delay = scrollSpeed;
			*/
			// total items
			/*
			TOTAL = data.musics.music.length();
			for (var i:uint = 0; i < TOTAL; i++)
			{
				items[i] = new Object();
				items[i].title = String(data.musics.music.@title[i]);
				items[i].src = String(data.musics.music.@src[i]);
				items[i].length = Number(data.musics.music.@length[i]);
			}
			*/
			items[0] = new Object();
			/*items[0].title = "Go Girl - Pitbull";
			items[0].src = "asset/go girl.mp3";
			items[0].length = "100";*/
			items[0].title = stage.loaderInfo.parameters.title;
			items[0].src = stage.loaderInfo.parameters.src;
			items[0].length = stage.loaderInfo.parameters.length;
			// load / play first song
			playMP3(0);
			progressChecking.start();
			// sound spectrum
			ssUpdate.start();
		}
		
		//__________________________________________________________ interactive
		
		private function playRVMP3(e:MouseEvent):void
		{
			playMP3(currentID);
			control.playBut.visible = false;
			control.pauseBut.visible = true;
		}
		
		
		
		private function playMP3(index:Number):void
		{
			// Play new song
			if (index != currentID)
			{
				// update id
				currentID = index;
				// load new sound
				_sound = new Sound();
				_soundLoaderContext = new SoundLoaderContext(bufferTime);
				_sound.load(new URLRequest(items[currentID].src), _soundLoaderContext);
				_soundChannel = _sound.play(0);
				_sound.addEventListener(Event.COMPLETE, loadComplete);
				// add event for playing finish
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, playingComplete);
				resumeVolume();
				// update title
				spectrumArea.titleClip.content.x = 0;
				spectrumArea.titleClip.content.text = items[currentID].title;
				control.sound.visible = true;
				control.soundMute.visible = false;
				// check if scrollling is needed
				if (spectrumArea.titleClip.content.width > 96) scrolling.start(); else scrolling.stop();
			}
			// or resume current playing
			else
			{
				_soundChannel = _sound.play(currentSoundProgress);
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, playingComplete);
				resumeVolume();
				control.sound.visible = true;
				control.soundMute.visible = false;
			}
			if (!progressChecking.running) progressChecking.start();
		}
		
		private function pauseRVMP3(e:MouseEvent):void
		{
			pauseMP3();
			control.playBut.visible = true;
			control.pauseBut.visible = false;
		}
		
		private function pauseMP3():void
		{
			currentSoundProgress = _soundChannel.position;
			_soundChannel.stop();
		}
		
		private function stopRVMP3(e:MouseEvent):void
		{
			stopMP3();
			control.playBut.visible = true;
			control.pauseBut.visible = false;
		}
		
		private function stopMP3():void
		{
			currentSoundProgress = 0;
			progressChecking.stop();
			_soundChannel.stop();
			control.progressBar.pBar.scaleX = 0;
			control.time.timeNumber.text = "00:00";
		}
		
		private function nextRVMP3(e:MouseEvent):void
		{
			// stop current sound
			stopMP3();
			control.playBut.visible = false;
			control.pauseBut.visible = true;
			// load next sound
			if (currentID < TOTAL - 1) playMP3(currentID + 1); else playMP3(0);
		}
		
		private function preRVMP3(e:MouseEvent):void
		{
			// stop current sound
			stopMP3();
			control.playBut.visible = false;
			control.pauseBut.visible = true;
			// load previous sound
			if (currentID > 0) playMP3(currentID - 1); else playMP3(TOTAL - 1);
		}
		
		// VOLUME / SOUND CONTROL
		private function soundOn(e:MouseEvent):void
		{
			_soundTransform = _soundChannel.soundTransform;
			_soundTransform.volume = 0;
			_soundChannel.soundTransform = _soundTransform;
			control.sound.visible = false;
			control.soundMute.visible = true;
		}
		
		private function soundOff(e:MouseEvent):void
		{
			resumeVolume();
			control.sound.visible = true;
			control.soundMute.visible = false;
		}
		
		private function resumeVolume():void
		{
			_soundTransform = _soundChannel.soundTransform;
			_soundTransform.volume = currentVolume;
			_soundChannel.soundTransform = _soundTransform;
		}
		
		private function volumeSeek(e:MouseEvent):void
		{
			var num:Number = e.currentTarget.mouseX;
			(num > 31) ? (31) : num;
			control.vSlider.scrubber.x = num;
			currentVolume = control.vSlider.scrubber.x / 31;
			_soundTransform = _soundChannel.soundTransform;
			_soundTransform.volume = currentVolume;
			_soundChannel.soundTransform = _soundTransform;
			control.sound.visible = true;
			control.soundMute.visible = false;
		}
		
		// DRAG - RELESAE SCRUBBER
		private function scrubberPress(e:MouseEvent):void
		{
			e.target.startDrag(false, new Rectangle(0, -4, 31, 0));
			stage.addEventListener(MouseEvent.MOUSE_MOVE, scrubberMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, scrubberRelease);
			control.sound.visible = true;
			control.soundMute.visible = false;
		}
		
		private function scrubberMove(e:MouseEvent):void
		{
			currentVolume = control.vSlider.scrubber.x / 31;
			_soundTransform = _soundChannel.soundTransform;
			_soundTransform.volume = currentVolume;
			_soundChannel.soundTransform = _soundTransform;
		}
		
		private function scrubberRelease(e:MouseEvent):void
		{
			control.vSlider.scrubber.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, scrubberMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, scrubberRelease);
		}
		
		private function progressSeek(e:MouseEvent):void
		{
			e.currentTarget.pBar.scaleX = e.currentTarget.mouseX / 150;
			var cP:Number = e.currentTarget.pBar.scaleX * items[currentID].length;
			if (cP <= _sound.length)
			{
				currentSoundProgress =  cP;
				_soundChannel.stop();
				_soundChannel = _sound.play(currentSoundProgress);
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, playingComplete);
				resumeVolume();
				control.playBut.visible = false;
				control.pauseBut.visible = true;
				control.sound.visible = true;
				control.soundMute.visible = false;
			}
		}
		
		private function progressBarOver(e:MouseEvent):void
		{
			Tweener.removeTweens(control.progressBar);
			Tweener.addTween(control.progressBar, { alpha:1, time:1 } );
		}
		
		private function progressBarOut(e:MouseEvent):void
		{
			// fade out progress
			Tweener.addTween(control.progressBar, { alpha:0, time:1, onComplete:function():void { control.progressBar.visible = false;} } );
		}
		
		private function spectrumAreaOver(e:MouseEvent):void
		{
			// fade in progress
			control.progressBar.visible = true;
			Tweener.addTween(control.progressBar, { alpha:1, time:1 } );
		}
		
		private function spectrumAreaOut(e:MouseEvent):void
		{
			// fade out progress
			Tweener.addTween(control.progressBar, { alpha:0, time:1, onComplete:function():void {control.progressBar.visible = false;} } );
		}
		
		private function spectrumAreaClick(e:MouseEvent):void
		{
			// move up / down
			if (!down)
			{
				Tweener.removeTweens(spectrumArea);
				Tweener.addTween(spectrumArea, { y:70, time:1 } );
				//spectrumArea.specArea.visible = false;
				
			}
			else
			{
				Tweener.removeTweens(spectrumArea);
				Tweener.addTween(spectrumArea, { y:0, time:1 } );
			}
			down = !down;
		}
		
		// Sound spectrum control
		private function ssUpdateHandler(e:TimerEvent):void
		{
			lsp.graphics.clear();
			lsp.graphics.lineStyle(SpectrumLineWidth, SpectrumLineColor);
			lsp.graphics.moveTo(-1, 50);
			SoundMixer.computeSpectrum(ss);
			for(var i:uint = 0; i<358; i++)
			{
				var num:Number = -ss.readFloat()*30 + 50;
				lsp.graphics.lineTo(i, num);
			}
			bmpData.draw(lsp);
			bmpData.applyFilter(bmpData, bmpData.rect,new Point(), blur);
			bmpData.applyFilter(bmpData, bmpData.rect, new Point(), colorMatrix);
			if (SpectrumGlowDirection != SGD)	
			{
				SGD = SpectrumGlowDirection;
				lsp.graphics.clear();
				bmpData.draw(lsp);
			}
			(SGD == "horizontal") ? bmpData.scroll(3, 0) : bmpData.scroll(0, -3);
			
		}
		
		// playing complete turn to next song
		private function playingComplete(e:Event):void
		{
			var index = (currentID == TOTAL - 1) ? 0 : (currentID + 1);
			playMP3(index);
		}
		
		// sound loaded complete, update duration
		private function loadComplete(e:Event):void
		{
			items[currentID].length = _sound.length;
		}
		
		// progress update
		private function progressUpdate(e:Event):void
		{
			// buffering 
			if (_sound.isBuffering)
			{
				bufferClip.visible = true;
				lsp.visible = bmp.visible = false;
			}
			// playing progress
			else
			{
				bufferClip.visible = false;
				lsp.visible = bmp.visible = true;
				control.progressBar.pBar.scaleX = _soundChannel.position / items[currentID].length;
				// time
				var sec = Math.floor(_soundChannel.position * .001);
				control.time.timeNumber.text = Math.floor(sec / 60 / 10).toString() + Math.floor(sec / 60 % 10) + ":" + Math.floor(sec % 60 / 10) + Math.floor(sec % 60 % 10);
			}
		}
		
		// text scrolling
		private function textScrolling(e:Event):void
		{
			var tf = spectrumArea.titleClip.content;
			if (tf.x + dir > 0 || tf.x + dir < (96 - tf.width)) dir = -dir;
			tf.x += dir;
		}
		
	}
	
}