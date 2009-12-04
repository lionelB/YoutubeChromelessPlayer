package com.youtube.chromelessPlayer.events
{
	import flash.events.Event;

	public class PlaybackQualityEvent extends Event
	{
		public static const PLAYBACK_QUALITY_CHANGE : String = "playbackQualityChange";
		
		public var quality:String;
		
		public function PlaybackQualityEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
	}
}