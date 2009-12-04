package com.youtube.controls.skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	
	import mx.core.UIComponent;

	public class VideoControlBarSkin extends UIComponent
	{
		public function VideoControlBarSkin()
		{
			super();
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var g:Graphics = graphics;
			g.clear();
			g.beginGradientFill(
				GradientType.LINEAR,
				[0xFFFFFF,0xCCCCCC],
				[1,1],
				[0,255],
				verticalGradientMatrix(0,0,unscaledWidth,unscaledHeight));
			g.drawRect(0,0,unscaledWidth,unscaledHeight);
			g.endFill();
		}
	}
}