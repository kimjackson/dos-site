package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class main extends MovieClip
	{
		
		// XML source
		private var xmlPath:String = "audio-player.xml";
		
		private var dir:Number = 0;
		public function main()
		{
			myPlayer.xmlPath = xmlPath;
			myPlayer.initialize();
			// color selection
			with (colorSel)
			{
				red.buttonMode = blue.buttonMode = green.buttonMode = white.buttonMode = yellow.buttonMode = true;
				colorSel.red.addEventListener(MouseEvent.CLICK, redClick);
				colorSel.blue.addEventListener(MouseEvent.CLICK, blueClick);
				colorSel.green.addEventListener(MouseEvent.CLICK, greenClick);
				colorSel.white.addEventListener(MouseEvent.CLICK, whiteClick);
				colorSel.yellow.addEventListener(MouseEvent.CLICK, yellowClick);
			}
			// Glow selection
			glowSel.addEventListener(MouseEvent.CLICK, glowSelClick);
		}
		
		// apply spectrum area color based on color selection
		private function redClick(e:MouseEvent):void
		{
			myPlayer.SpectrumLineColor = 0xFF0000;
		}
		
		private function blueClick(e:MouseEvent):void
		{
			myPlayer.SpectrumLineColor = 0x0066FF;
		}
		
		private function greenClick(e:MouseEvent):void
		{
			myPlayer.SpectrumLineColor = 0x00FF00;
		}
		
		private function whiteClick(e:MouseEvent):void
		{
			myPlayer.SpectrumLineColor = 0xFFFFFF;
		}
		
		private function yellowClick(e:MouseEvent):void
		{
			myPlayer.SpectrumLineColor = 0xFFFF00;
		}
		
		private function glowSelClick(e:MouseEvent):void
		{
			if (dir == 0)
			{
				glowSel.sel.text = "Vertical Glow"
				myPlayer.SpectrumGlowDirection = "vertical";
			}
			else
			{
				glowSel.sel.text = "Horizontal Glow"
				myPlayer.SpectrumGlowDirection = "horizontal";
			}
			
			dir = Math.abs(dir - 1);
		}
		
	}
	
}