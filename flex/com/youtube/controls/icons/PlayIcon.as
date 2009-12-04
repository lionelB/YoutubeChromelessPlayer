package com.youtube.controls.icons
{
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	
	import mx.skins.ProgrammaticSkin;

	public class PlayIcon extends ProgrammaticSkin
	{
		override public function get width():Number{ return 6; }
		override public function get height():Number{ return 12; }
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var g:Graphics = graphics;
			g.clear();
			switch(name)
			{
				case "upIcon":
				case "overIcon":
				case "downIcon":
				case "disabledIcon":
					g.beginFill(0x454545);
					g.moveTo(0,1);
					g.lineTo(6,6);
					g.lineTo(0,11);
					g.endFill();
					break;
				case "selectedUpIcon":
				case "selectedOverIcon":
				case "selectedDownIcon":
				case "selectedDisabledIcon":
					g.beginFill(0x454545);
					g.drawRect(0,2,2,8);
					g.drawRect(4,2,2,8);
					g.endFill();
					break;
			}
			var shadow:DropShadowFilter = 
				new DropShadowFilter(
					2,90,0x000000,.8,3,3,1,1,true);
			
			filters = [shadow];	 
		}	
	}
}