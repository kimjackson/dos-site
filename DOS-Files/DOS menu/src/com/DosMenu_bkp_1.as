package com {
	
    import flash.display.*;
    import flash.events.*;
	import flash.utils.*;
	import flash.text.TextField;
	import gs.TweenLite;
	import gs.easing.*;	
	
	
    public class DosMenu extends MovieClip {
		
		private var sensitivity			: Number = 0.2;
		private var stageWidth			: Number = 700;
		private var stageHeight			: Number = 320;
		private var refX              	: Number = 100;			
		private var refY        		: Number = 50;	
		private var refScale       		: Number = 1;	
		private var menuActive			: Boolean = true;
		private var maxSpeedX       	: Number = 5; 
		private var maxSpeedY	        : Number = 5; 		
		private var rotationToChangeTo  : Number = 0;
		
		//ICONS
		private var iconNumber  		: Number = 6;	
		private var scaleRange  		: Number = 0.6;	
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
		
		public var icon1				: MovieClip;
		public var icon2				: MovieClip;
		public var icon3				: MovieClip;
		public var icon4				: MovieClip;
		public var icon5				: MovieClip;
		public var icon6				: MovieClip;
		
        public function DosMenu() {           
			init();
        }
		// FIRST WE START FROM THE PLAY OR REPLAY BUTTONS
		public function init(){		
		
        	stage.addEventListener(Event.ENTER_FRAME, EnterFrameHandler);		
			for(var i:int=1;i<=iconNumber;i++){
				this["icon"+i+"OrigScale"] = this["icon"+i].scaleX;
				this["icon"+i+"OrigX"] = this["icon"+i].x;
				this["icon"+i+"OrigY"] = this["icon"+i].y;
				
				this["icon"+i].alpha = 0;
				this["icon"+i].x = refX;
				this["icon"+i].y = refY;
				this["icon"+i].scaleX = this["icon"+i].scaleY = refScale;
				TweenLite.to(this["icon"+i], 1, {x: this["icon"+i+"OrigX"], y: this["icon"+i+"OrigY"], scaleX:this["icon"+i+"OrigScale"],scaleY:this["icon"+i+"OrigScale"],alpha:1, ease:Strong.easeOut});	
			
			}
		}
		//	
		
		
		private function EnterFrameHandler(event:Event = null):void {
			if(menuActive){		
				mousePosX = mouseX;
				mousePosY = mouseY;
				for(var i:int=1;i<=iconNumber;i++){
					var newX:Number = ((1-(this["icon"+i+"OrigScale"]-refScale)))*(this["icon"+i+"OrigX"]-((mousePosX-refX)*sensitivity));
					
					this["icon"+i].x += (newX-this["icon"+i].x)/50;
					
					var newY:Number = ((1-(this["icon"+i+"OrigScale"]-refScale)))*(this["icon"+i+"OrigY"]-((mousePosY-refY)*sensitivity));
					this["icon"+i].y += (newY-this["icon"+i].y)/50;
					/*var newScale:Number = this["icon"+i+"OrigScale"]+(((this["icon"+i].x-refX)/(mousePosX-newX))/10);
					if(newScale>=1){
						newScale = 1;
					}
					if(newScale<=0.4){
						newScale = 0.4;
					}
					this["icon"+i].scaleX = this["icon"+i].scaleY += (newScale-this["icon"+i].scaleX)/50;
					trace(newScale);
					*/
				}
				
				
			}
			
		}
		
		
    }
}