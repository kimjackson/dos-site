package com {
	
    import flash.display.*;
    import flash.net.*;
	import flash.events.*;	
	import flash.utils.*;
	import flash.utils.Timer;
    import flash.events.TimerEvent;

	//import flash.net.URLLoader;
	//import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	
	
	import gs.TweenLite;
	import gs.easing.*;	
	
	
    public class DosMenu extends MovieClip {
		public var loader				:Loader;
		private var name_array			: Array = new Array();
			
		private var url_array			: Array = new Array();
		private var sensitivity			: Number = 1;
		private var stageWidth			: Number = 700;
		private var stageHeight			: Number = 320;
		private var refX              	: Number = stageWidth/2;			
		private var refY        		: Number = stageHeight/2;	
		private var refScale       		: Number = 0.9;	
		
		private var easingAmount		:Number = 10; //the lower this number the faster they icons move
		
		private var maxSpeedX       	: Number = 1; 
		private var maxSpeedY	        : Number = 0.5; 		
		private var rotationToChangeTo  : Number = 0;
		
		private var menuActive			: Boolean = true;		
		private var createdLine			: Number = 0;
		
		
		//ICONS
		private var iconNumber  		: Number = 12;	
		
		private var scaleRange  		: Number = 0.4;	
		private var mousePosX			: Number = 0;
		private var mousePosY			: Number = 0;
		
		private var icon1OrigX			: Number = 0;
		private var icon1OrigY			: Number = 0;
		private var icon1OrigScale		: Number = 0;
		
		private var icon2OrigX			: Number = 0;
		private var icon2OrigY			: Number = 0;
		private var icon2OrigScale		: Number = 0;
		
		private var icon3OrigX			: Number = 0;
		private var icon3OrigY			: Number = 0;
		private var icon3OrigScale		: Number = 0;
		
		private var icon4OrigX			: Number = 0;
		private var icon4OrigY			: Number = 0;
		private var icon4OrigScale		: Number = 0;
		
		private var icon5OrigX			: Number = 0;
		private var icon5OrigY			: Number = 0;
		private var icon5OrigScale		: Number = 0;
		
		private var icon6OrigX			: Number = 0;
		private var icon6OrigY			: Number = 0;
		private var icon6OrigScale		: Number = 0;
		
		private var icon7OrigX			: Number = 0;
		private var icon7OrigY			: Number = 0;
		private var icon7OrigScale		: Number = 0;
		
		private var icon8OrigX			: Number = 0;
		private var icon8OrigY			: Number = 0;
		private var icon8OrigScale		: Number = 0;
		
		private var icon9OrigX			: Number = 0;
		private var icon9OrigY			: Number = 0;
		private var icon9OrigScale		: Number = 0;
		
		private var icon10OrigX			: Number = 0;
		private var icon10OrigY			: Number = 0;
		private var icon10OrigScale		: Number = 0;
		
		private var icon11OrigX			: Number = 0;
		private var icon11OrigY			: Number = 0;
		private var icon11OrigScale		: Number = 0;
		
		private var icon12OrigX			: Number = 0;
		private var icon12OrigY			: Number = 0;
		private var icon12OrigScale		: Number = 0;
		
		
		public var iconTemp1				: MovieClip;
		public var iconTemp2				: MovieClip;
		public var iconTemp3				: MovieClip;
		public var iconTemp4				: MovieClip;
		public var iconTemp5				: MovieClip;
		public var iconTemp6				: MovieClip;
		public var iconTemp7				: MovieClip;
		public var iconTemp8				: MovieClip;
		public var iconTemp9				: MovieClip;
		public var iconTemp10				: MovieClip;
		public var iconTemp11				: MovieClip;
		public var iconTemp12				: MovieClip;
		
		private var icon1				: MovieClip;
		private var icon2				: MovieClip;
		private var icon3				: MovieClip;
		private var icon4				: MovieClip;
		private var icon5				: MovieClip;
		private var icon6				: MovieClip;
		private var icon7				: MovieClip;
		private var icon8				: MovieClip;
		private var icon9				: MovieClip;
		private var icon10				: MovieClip;
		private var icon11				: MovieClip;
		private var icon12				: MovieClip;
		
		private var iconRolledOver		: MovieClip;
		public var stageBackground		: MovieClip;
		public var rolloverClip			: MovieClip;
		public var linesHolder			: MovieClip;
		private var lineGraphics		: Shape = new Shape(); 
					
		private var posX_array			:Array = new Array();
		private var posY_array			:Array = new Array();
		private var startPoint			:Number = 0;
		private var nextPos				:Number = 0;
        public function DosMenu() {  
			
			
			config();	
			
		}
		
		private function config():void {
			var loader:URLLoader = new URLLoader();
			configureListeners(loader);
			var request:URLRequest = new URLRequest("config.xml");
			try {
				loader.load(request);
			} 
			catch (error:Error) {
				trace("Unable to load XML document.");
			}					
		}
		private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, XMLloadCompleteHandler);          
        }
		private function XMLloadCompleteHandler(event:Event):void {
            var loader:URLLoader = URLLoader(event.target);           
            var configXML = new XML(event.target.data);							
			for (var i in configXML.icon){			
				name_array.push(configXML.icon.id[i]);
				url_array.push(configXML.icon.pageUrl[i]);
				trace(i+": "+name_array[i]);
			}			
           	init();	
        }
		// FIRST WE START FROM THE PLAY OR REPLAY BUTTONS
		public function init(){	
			createdLine = 0;
			lineGraphics.graphics.lineStyle (1, 0xCCCCCC, 1);	
        	stage.addEventListener(Event.ENTER_FRAME, EnterFrameHandler);
			stageBackground.addEventListener(MouseEvent.ROLL_OVER, handleIconOut);		
			
			for(var j:int=1;j<=iconNumber;j++){
				posX_array.push(this["iconTemp"+j].x);
				posY_array.push(this["iconTemp"+j].y);
				//this["iconTemp"+j].visible = false;
				this.setChildIndex(this["iconTemp"+j],j+1);
			}
			for(var i:int=1;i<=iconNumber;i++){
				var MenuIcon : Class = getDefinitionByName('MenuIcon') as Class;
				var d : MovieClip = new MenuIcon();
				d.name = "icon" + i;				
				this.addChildAt(d, i+13);	
				d.nextPos = i-1;		
				d.origX = posX_array[i-1];
				d.origY = posY_array[i-1];
				//d.rad = d.y/d.x;
				d.idNum = i;
				d.newIndex = i+13;
				d.gotoAndStop(i);
				d.addEventListener(MouseEvent.ROLL_OVER, handleIconOver);
				d.addEventListener(MouseEvent.CLICK, handleIconClick);
				d.clickURL = url_array[i-1];
				d.nameDisplay = name_array[i-1];
				
				// Pre animation if needed
				d.alpha = 0;
				d.origScale = 0; //d.scaleX;
				d.scaleX = d.scaleY = d.origScale;
				d.scaleX = d.scaleY = refScale;
				d.x = refX;
				d.y = refY;
				d.StartX = d.x;
				d.StartY = d.y;
				TweenLite.to(d, 1, {x: d.origX, y: d.origY, scaleX:d.origScale,scaleY:d.origScale,alpha:1, ease:Strong.easeOut});	
				d.addEventListener(Event.ENTER_FRAME, EnterFrameIconHandler);
			}
			startPoint = 0;
			TimerStart();
		}
		//Timer for moving icons
		private function TimerStart() {
            var myTimer:Timer = new Timer(3000);
            myTimer.addEventListener("timer", timerHandler);
            myTimer.start();
			timerHandler(null);
        }

        private function timerHandler(event:TimerEvent):void {			
			// As soon as the start point is changed the icons will all get a new destination
			if(startPoint>iconNumber-1){
				startPoint = 0;
			}
			startPoint++;
        }
		private function EnterFrameIconHandler(event : Event) : void {				
			var d : MovieClip = event.currentTarget as MovieClip;
			
			d.origScale = -0.5+((d.y+100)/refY);
			d.scaleX = d.scaleY = d.origScale;
			// How much should X move
			var moveX:Number = ((refScale-d.origScale)*((mousePosX-refX)*sensitivity));	
			// How much should Y move	
			var moveY:Number = ((refScale-d.origScale)*((mousePosY-refY)*sensitivity));
			
			var NewX:Number = d.x+(((d.origX+moveX)-d.x)/easingAmount);							
			var NewY:Number = d.y+(((d.origY+moveY)-d.y)/easingAmount);		
			d.x = NewX;				
			d.y = NewY;
			
			
			// Check Index
			if(9+Math.round(d.y*iconNumber/160)<25){
				this.setChildIndex(d,(9+(Math.round(d.y*iconNumber/160))));
			}else{
				this.setChildIndex(d,25);
			}
			
			// Move white too
			this["iconTemp"+d.idNum].x = d.x;
			this["iconTemp"+d.idNum].y = d.y;
			this["iconTemp"+d.idNum].scaleX = this["iconTemp"+d.idNum].scaleY = d.origScale;

		// Try to rotate the icons
			if(d.nextPos != startPoint+d.idNum-1){
			   	d.nextPos = startPoint+d.idNum-1;
				if(d.nextPos>iconNumber){
					d.nextPos -= iconNumber;
				}
				d.origX = posX_array[d.nextPos-1];
				d.origY = posY_array[d.nextPos-1];
				
			}
			
			
		}
		

		private function EnterFrameHandler(event:Event = null):void {
			if(menuActive){		
				mousePosX = mouseX;
				mousePosY = mouseY;
				if(mousePosX<=refX-150){					
					mousePosX = refX-150;
				}else if(mousePosX>=refX+150){					
					mousePosX = refX+150;
				}
				if(mousePosY<=refY){					
					mousePosY = refY;
				}else if(mousePosY>=refY+40){					
					mousePosY = refY+40;
				}
				if(iconRolledOver){
					rolloverClip.x = iconRolledOver.x;
					rolloverClip.y = iconRolledOver.y;
				}		
				
				for(var i:int=1;i<=iconNumber;i++){
					// Lines					
					var l : Shape = new Shape();
					l.name = "Line" + i;					
					l.graphics.lineStyle (1, 0xCCCCCC, 1);			
				
					var d1:DisplayObject = this.getChildByName("icon" + i); 
					var d2:DisplayObject = this.getChildByName("icon1"); 
					
					
					if(i<iconNumber){
						d2 = this.getChildByName("icon" + (i+1)); 
					}
					l.graphics.moveTo(d1.x, d1.y);						
					l.graphics.lineTo(d2.x, d2.y);					
					linesHolder.addChild(l);					
					TweenLite.to(l, 0.05, {alpha:0, ease:Strong.easeIn, onComplete:alphaFinished, onCompleteParams:[l]});			
					
				}
				
			}
			
		}
		
		private function alphaFinished(clipName : Shape) : void {							
			linesHolder.removeChild(clipName);				
		}
		
		// ICON INTERACTION
		private function handleIconClick(event:Event):void {
			var iconHit : MovieClip = event.currentTarget as MovieClip;
			trace(iconHit.clickURL);
			navigateToURL(new URLRequest(iconHit.clickURL), '_self');
		}
		private function handleIconOver(event:Event):void {
			var iconHit : MovieClip = event.currentTarget as MovieClip;
			iconRolledOver = iconHit;
			rolloverClip.name_txt.text = iconHit.nameDisplay;
			rolloverClip.name_txt.autoSize = "left";
			rolloverClip.x = iconHit.x;
			rolloverClip.y = iconHit.y;
			if(rolloverClip.name_txt.width>90){
				rolloverClip.midSection.width = rolloverClip.name_txt.width-20;
				rolloverClip.endSection.x = rolloverClip.midSection.x+rolloverClip.midSection.width-2;
			}else{
				rolloverClip.midSection.width = 69; //Dude
				rolloverClip.endSection.x = rolloverClip.midSection.x+rolloverClip.midSection.width-2;
			}
			rolloverClip.alpha = 0;
			TweenLite.removeTween();
			TweenLite.to(rolloverClip, 1, {alpha:1, ease:Strong.easeOut});	
				
		}
		private function handleIconOut(event:Event):void {
			TweenLite.removeTween();
			TweenLite.to(rolloverClip, 1, {alpha:0, ease:Strong.easeOut});	
		}
    }
}