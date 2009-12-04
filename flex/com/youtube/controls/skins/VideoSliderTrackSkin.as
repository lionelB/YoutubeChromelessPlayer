package com.youtube.controls.skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	
	import mx.core.UIComponent;
	import mx.styles.StyleProxy;
	
	public class VideoSliderTrackSkin extends UIComponent
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
				}
			}
			
		}
		override public function get height():Number {return _height;}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			var g:Graphics = graphics;
			
			g.clear();
			g.beginGradientFill(
				GradientType.LINEAR,
				[0x999999,0xCCCCCC],
				[1,1],
				[0,255],
				verticalGradientMatrix(0,0,unscaledWidth,unscaledHeight));
			
			g.drawRoundRect(-unscaledHeight/2,0,unscaledWidth+unscaledHeight,unscaledHeight,unscaledHeight,unscaledHeight);
			//g.drawRoundRect(0,0,unscaledWidth,unscaledHeight,unscaledHeight,unscaledHeight);
			g.endFill();
			
			g.beginFill(0xFFFFFF,.5);
			
			 
			var  light:DropShadowFilter = 
				new DropShadowFilter(1,90,0xFFFFFF,.6,2,2);
			var dark:DropShadowFilter = 
				new DropShadowFilter(1,90,0x000000,.4,2,2,1,1,true);
			filters = [dark,light];
		}
	}
}