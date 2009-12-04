package com.youtube.controls.skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	
	import mx.core.UIComponent;
	
	public class VideoSliderTrackHighlightSkin extends UIComponent
	{
		private var heightChanged:Boolean = true;
		private var _height:int = 14;
		
		override protected function createChildren():void
		{
			super.createChildren();
		}
		override protected function commitProperties():void
		{
			if( heightChanged )
			{
				heightChanged = false;
				if( getStyle("trackHeight") )
				{
					_height = getStyle("trackHeight");
					trace("__height" + _height)
				}
			}
			
		}
		override public function get height():Number {return _height;}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			var themeColor:uint = getStyle("themeColor");
			var g:Graphics = graphics;
			
			g.clear();
			g.beginGradientFill(
				GradientType.LINEAR,
				[themeColor,themeColor&0xaaaaaa],
				[1,1],
				[0,255],
				verticalGradientMatrix(0,0,unscaledWidth,unscaledHeight));
			
			g.drawRoundRect(-unscaledHeight/2,0,unscaledWidth+unscaledHeight,unscaledHeight,unscaledHeight,unscaledHeight);
			//g.drawRoundRect(0,0,unscaledWidth,unscaledHeight,unscaledHeight,unscaledHeight);
			g.endFill();
			
			var  light:DropShadowFilter = 
				new DropShadowFilter(1,90,0xFFFFFF,.6,2,2);
			var dark:DropShadowFilter = 
				new DropShadowFilter(1,90,0x000000,.4,2,2,1,1,true);
			filters = [dark,light];
		}
	}
}