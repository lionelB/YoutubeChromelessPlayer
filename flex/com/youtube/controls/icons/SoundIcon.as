package com.youtube.controls.icons
{
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	
	import mx.formatters.SwitchSymbolFormatter;
	import mx.skins.ProgrammaticSkin;
	
	public class SoundIcon extends ProgrammaticSkin
	{
		override public function get height():Number {return 12}
		override public function get width():Number {return 12}

		override protected function updateDisplayList(unscaledWidth:Number, 
														unscaledHeight:Number):void
		{
			
			var w:Number = unscaledWidth ;
			var h:Number = unscaledHeight;
			
			var g:Graphics = graphics
			
			g.beginFill(0x454545);
			g.lineStyle(1,0x454545);
			g.drawRect(0,4,3,4);
			g.endFill();
			//triangle
			
			g.beginFill(0x454545);
			g.moveTo(2,6);
			g.lineTo(6,1);
			g.lineTo(6,11);
			g.lineTo(2,6);
			g.endFill();
			switch(name)
			{
				case "upIcon":
				case "overIcon":
				case "downIcon":
				case "disabledIcon":
					
					break;
				case "selectedUpIcon":
				case "selectedOverIcon":
				case "selectedDownIcon":
				case "selectedDisabledIcon":
					g.moveTo(8,4);
				 	g.curveTo(9,6,8,8);
				 	g.moveTo(9,1);
				 	g.curveTo(12,6,9,11);		
					break;
			}
			
			
			
			var light:DropShadowFilter = 
				new DropShadowFilter(2,135,0xFFFFFFF,.5,2,2,1,1);
			var dark:DropShadowFilter = 
				new DropShadowFilter(2,135,0x000000,.5,2,2,1,1,true);
			filters = [dark,light];			
		}
	}
}