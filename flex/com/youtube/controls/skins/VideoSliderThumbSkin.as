package com.youtube.controls.skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	
	import mx.skins.ProgrammaticSkin;

	public class VideoSliderThumbSkin extends ProgrammaticSkin
	{
		public function VideoSliderThumbSkin()
		{
			super();
		}
		 
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
		
			var g:Graphics = graphics;
			g.clear();
			var c1:uint;
			var c2:uint;
			
			switch( name )
			{
				case "thumbOverSkin":
					c1 = getStyle("themeColor");
					c2 = c1 & 0x878787; 
					break;
				case "thumbDownSkin":
					c1 = 0x333333;
					c2 = 0x666666;
					break;
				case "thumbUpSkin":
					c1 = 0x999999;
					c2 = 0xCCCCCC;
					break;
				case "thumbDisabledSkin":
					c1 = 0x999999;
					c2 = 0x999999;
					break;
				default:
					c1 = 0x999999;
					c2 = 0xCCCCCC;
					break;
			}
			
			g.beginGradientFill(
				GradientType.LINEAR,
				[c1,c2],
				[1,1],
				[0,255],
				verticalGradientMatrix(0,0,unscaledWidth,unscaledHeight));
			var r:int = unscaledHeight/2;
			g.drawCircle(r,r+1,r);
			g.endFill();
			
			g.beginGradientFill(
				GradientType.LINEAR,
				[0xFFFFFF,0xDDDDDD],
				[1,1],
				[0,255],
				verticalGradientMatrix(0,0,unscaledWidth,unscaledHeight));
			g.drawCircle(r,r+1,r-1);
			g.endFill();
			
			var dark:DropShadowFilter = 
				new DropShadowFilter(1,90,0x000000,.4,2,2,1,1);
			filters = [dark];
		}
	}
}