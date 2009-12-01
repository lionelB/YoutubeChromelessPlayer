package com.lafabrick.youtube.player.events
{
	import flash.events.Event;

	public class SimpleVideoEvent extends Event
	{
		public static const PLAYHEAD_UPDATE:String = "playHeadUpdate";
		
		public var playheadTime:Number;
		
		public function SimpleVideoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}