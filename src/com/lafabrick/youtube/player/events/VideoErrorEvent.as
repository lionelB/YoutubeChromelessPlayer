package com.lafabrick.youtube.player.events
{
	import com.lafabrick.youtube.player.constants.ErrorCode;
	
	import flash.events.Event;

	public class VideoErrorEvent extends Event
	{
		
		public static const VIDEO_ERROR : String = "videoError";
		
		public var errorCode:int;
		
		public function VideoErrorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);			
		}

		public function get error():String
		{
			switch(errorCode)
			{
				case ErrorCode.VIDEO_NOT_FOUND:
					return "Video not Found";
				case ErrorCode.EMBED_NOT_ALLOWED:
					return "Embed not Allowed";
				case ErrorCode.EMBED_NOT_ALLOWED2:
					return "Embed not allowed, too";
				default : 
					return "unsupported error";
			}
			
		} 
		
	}
}