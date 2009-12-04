package com.youtube.chromelessPlayer.events
{
	import com.youtube.chromelessPlayer.constants.PlayerStateCode;
	
	import flash.events.Event;

	public class PlayerStateEvent extends Event
	{
	 	public static const PLAYER_STATE_CHANGE : String = "playerStateChange";
	 	
	 	public var stateCode:int;
		
		public function PlayerStateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		public function get state():String
		{
			switch(stateCode)
			{
				case PlayerStateCode.BUFFERING:
					return "video is buffering";
				case PlayerStateCode.ENDED:
					return "video is ended";
				case PlayerStateCode.PAUSED:
					return "video is pause";
				case PlayerStateCode.PLAYING:
					return "video is video";
				case PlayerStateCode.UNSTARTED:
					return "video is unstarted";
				case PlayerStateCode.VIDEO_CUED:
					return "video is cued";
				case PlayerStateCode.READY:
					return "player is Ready";
				default:
					return "undefinde state";
			}
			
		}
		 
	}
}