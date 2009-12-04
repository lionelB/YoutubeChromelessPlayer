package com.youtube.controls.skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	
	import mx.graphics.GradientEntry;
	import mx.graphics.LinearGradient;
	import mx.graphics.LinearGradientStroke;
	import mx.skins.ProgrammaticSkin;

	public class VideoButtonSkin extends ProgrammaticSkin
	{
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var themeColor:uint = getStyle("themeColor");
			var w:Number = unscaledWidth;
			var h:Number = unscaledHeight;
 
			// hold the values of the gradients depending on button state
			var backgroundFillColor:uint = 0xFFFFFF;
			var backgroundFillColor2:uint = 0xCCCCCC;				
  
 			var strokeColor1:uint = themeColor;
			var strokeColor2:uint = themeColor;
			
			//	which skin is the button currently looking for? Which skin to use?
			switch (name) {
				case "upSkin":
					strokeColor1=themeColor;
					strokeColor2=themeColor&0x808080;
					break;
				case "overSkin":
					strokeColor1=themeColor|0x7F7F7F;
					strokeColor2=themeColor;
					break;
				case "downSkin":
					strokeColor1=themeColor;
					strokeColor2=themeColor;
					color: 0xCC0000;
					break;
				case "disabledSkin":
					strokeColor1=0xaaaaaa;
					strokeColor2=0xaaaaaa;
					backgroundFillColor = 0xCCCCCC;
					backgroundFillColor2 = 0xCCCCCC;
					break;
			}
			
			// reference the graphics object of this skin class
			var g:Graphics = graphics;
 			g.clear();
 			g.lineStyle(1);
 			
 			g.beginGradientFill(
				GradientType.LINEAR,
				[backgroundFillColor,backgroundFillColor2],
				[1,1],
				[0,255],
				verticalGradientMatrix(0,0,unscaledWidth,unscaledHeight));
			
			g.lineGradientStyle(
				GradientType.LINEAR,
				[strokeColor1,strokeColor2],
				[1,1],
				[0,255],
				verticalGradientMatrix(0,0,unscaledWidth,unscaledHeight));
			 
			 g.drawRect(0,0,w,h);
			 
			 g.endFill();
			// if we're not showing the down skin, show the shadow. Otherwise hide it on the "down state" to look like it's being pressed
			if(name != "downSkin") {
	        	filters = [new DropShadowFilter(2, 90,0x000000,.2)];
			}
		}
	}
}