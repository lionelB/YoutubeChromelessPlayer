package com.youtube.chromelessPlayer
{
	import com.youtube.chromelessPlayer.constants.PlayerStateCode;
	import com.youtube.chromelessPlayer.events.PlaybackQualityEvent;
	import com.youtube.chromelessPlayer.events.PlayerEvents;
	import com.youtube.chromelessPlayer.events.PlayerStateEvent;
	import com.youtube.chromelessPlayer.events.SimpleVideoEvent;
	import com.youtube.chromelessPlayer.events.VideoErrorEvent;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	 
	
	
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name="playHeadUpdate", type="com.youtube.player.events.SimpleVideoEvent")]
	
	[Event(name="init", type="flash.events.Event")]
	[Event(name="videoError", type="com.youtube.player.events.VideoErrorEvent")]
	[Event(name="playBackQualityChange", type="com.youtube.player.events.PlaybackQualityEvent")]
	[Event(name="playerStateChange", type="com.youtube.player.events.PlayerStateEvent")]
 
	
	public class YoutubeVideo extends Sprite
	{
		public static const PLAYER_URL:String = "http://www.youtube.com/apiplayer?version=3";
		
		private var _initialized:Boolean;
		private var _loader:Loader;
		private var _state:String;
		private var _player:Object;
		
		public function YoutubeVideo()
		{
			super();
			
			Security.allowDomain("http://www.youtube.com/");
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.INIT, playerInitialize);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, playerIOError);
			_loader.load(new URLRequest(PLAYER_URL));
		}
		
		private function playerInitialize(event:Event):void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.INIT, playerInitialize);
			
			addChild(_loader); 
			_loader.content.addEventListener(PlayerEvents.READY, _onPlayerReady);
			_loader.content.addEventListener(PlayerEvents.ERROR, _onPlayerError);
			_loader.content.addEventListener(PlayerEvents.STATE_CHANGE, _onPlayerStateChange);
			_loader.content.addEventListener(PlayerEvents.QUALITY_CHANGE, _onVideoPlaybackQualityChange);	

		}
		private function playerIOError():void
		{
			throw new IOError("Cannot load youtube as3 api player");
		}
		
		/**
		 * 
		 * player handler
		 * 
		 */
		private function _onPlayerReady(event:Event):void 
		{
			_loader.content.removeEventListener(PlayerEvents.READY, _onPlayerReady);
			
			_player = _loader.content;
			
			
			_initialized = true;
			
			dispatchEvent(  new Event(Event.INIT) );
		}

		private function _onPlayerError(event:Event):void
		{
		    var e:VideoErrorEvent = new VideoErrorEvent(VideoErrorEvent.VIDEO_ERROR);
		    e.errorCode = Object(event).data;
		    dispatchEvent( e );	
		}
			
		private function _onPlayerStateChange(event:Event):void 
		{
			switch(Object(event).data)
			{ 
				case PlayerStateCode.BUFFERING:
					removeEventListener(Event.ENTER_FRAME, onPlayHeadUpdate);
					addEventListener(Event.ENTER_FRAME, onProgress);
					break;
				case PlayerStateCode.ENDED:
					removeEventListener(Event.ENTER_FRAME, onProgress);
					removeEventListener(Event.ENTER_FRAME, onPlayHeadUpdate);
					break;
				case PlayerStateCode.PAUSED:
					removeEventListener(Event.ENTER_FRAME, onProgress);
					break;
				case PlayerStateCode.PLAYING:
					addEventListener(Event.ENTER_FRAME, onPlayHeadUpdate);
					break;
				case PlayerStateCode.UNSTARTED:
					break;
				case PlayerStateCode.VIDEO_CUED:
					break;
				case PlayerStateCode.READY:
					break;
				default:
					break;
			}
			
			var e:PlayerStateEvent = new PlayerStateEvent( PlayerStateEvent.PLAYER_STATE_CHANGE);
			e.stateCode = Object(event).data;
			trace(e.state);		 
			dispatchEvent( e );
			
		}
		
		private function _onVideoPlaybackQualityChange(event:Event):void 
		{
		    var e:PlaybackQualityEvent = new PlaybackQualityEvent( PlaybackQualityEvent.PLAYBACK_QUALITY_CHANGE );
		    e.quality = Object(event).data;
		    dispatchEvent( e );
		}
		
		/**
		 * 
		 * Getter / Setter
		 * 
		 */
		public function get initialized():Boolean {return _initialized;}
		 
		/**
		 * 
		 * Youtube Chromeless player wrapper methods
		 * 
		 */
		
		public function cueVideoById(videoId:String, startSeconds:Number = 0, suggestedQuality:String = null) : void
		{
			_player.cueVideoById(videoId, startSeconds, suggestedQuality);
	    }
	    public function loadVideoById(videoId:String, startSeconds:Number = 0, suggestedQuality:String = null) : void
		{
			_player.loadVideoById(videoId, 2, suggestedQuality);
		}
		public function cueVideoByUrl(mediaContentUrl:String, startSeconds:Number = 0) : void
		{
			_player.cueVideoByUrl(mediaContentUrl, startSeconds);
		}
	    
		public function loadVideoByUrl(mediaContentUrl:String, startSeconds:Number = 0) : void
		{
			_player.loadVideoByUrl(mediaContentUrl, startSeconds);
		}
	    
		// video playing methods
		public function playVideo() : void
		{
			_player.playVideo();
		}
	    
		public function stopVideo() : void
		{
			_player.stopVideo();
		}
	    
		public function pauseVideo() : void
		{
			_player.pauseVideo();
		}
	    
		public function seekTo(seconds:uint, allowSeekAhead:Boolean = true) : void
		{
			_player.seekTo(seconds, allowSeekAhead);
		} 
	    
		public function setSize(width:Number, height:Number) : void
		{
			_player.setSize(width, height);
		}
	    
	    // volume methods
		public function mute() : void
		{
			_player.mute();
		}
	    
		public function unMute() : void
		{
			_player.unMute(); 
		}
	    
		public function isMuted() : Boolean
		{
			return _player.isMuted();
		}
	    
		public function set volume(volume:Number) : void
		{
			_player.setVolume(volume);
		}
	    
		public function get volume() : Number
		{
			return _player.getVolume(); 
		}
	    	    
		// Playback status methods
		public function get videoBytesLoaded() : Number
		{
			return _player.getVideoBytesLoaded();
		}
	    
		public function get videoBytesTotal() : Number
		{
			return _player.getVideoBytesTotal();
		}
	    
		public function get videoStartBytes() : Number
		{
			return _player.getVideoStartBytes();
		}
	    
		public function get videoProgressLoaded() : Number
		{
			if (videoBytesTotal == 0)
			{
				return 0;
			}
			var progress : Number = (videoBytesLoaded/videoBytesTotal) * 100;
			return progress;
		}
	    
		public function get playerState() : Number
		{
			return _player.getPlayerState();
		}
	    
		public function get currentTime() : Number
		{
			return _player.getCurrentTime();
		}
	    
		// Playback quality methods
		public function get playbackQuality() : String
		{
			return _player.getPlaybackQuality();
		}
	    
		public function set playbackQuality(quality:String) : void
		{
			_player.setPlaybackQuality(quality);
		}
	    
		public function get availableQualityLevels() : Array
		{
			return _player.getAvailableQualityLevels();
		}
	    
		// informations methods
		public function get duration() : Number
		{
			return _player.getDuration();
		}
	    
		public function get videoUrl() : String
		{
			return  _player.getVideoUrl();
		}
	    
	    public function get videoEmbedCode() : String
	    {
	      return  _player.getVideoEmbedCode();  
	    }
	    
	    private function onPlayHeadUpdate(event:Event=null):void
	    {
	    	var e:SimpleVideoEvent = new SimpleVideoEvent(SimpleVideoEvent.PLAYHEAD_UPDATE);
	    	e.playheadTime = currentTime;
	    	
	    	dispatchEvent( e );
	    }
	    private function onProgress(event:Event=null):void
	    {
			if( videoBytesLoaded  >= videoBytesTotal )
			{
				removeEventListener(Event.ENTER_FRAME,onProgress);
			}
			else
			{
		    	var e:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
		    	e.bytesLoaded = videoBytesLoaded;
		    	e.bytesTotal = videoBytesTotal;
		    	dispatchEvent( e );
	  		}
	    }
	    
	    
	    // prevents memory leaks
	    public function destroy():void
	    {
			_loader.content.removeEventListener(PlayerEvents.READY, _onPlayerReady);
			_loader.content.removeEventListener(PlayerEvents.ERROR, _onPlayerError);
			_loader.content.removeEventListener(PlayerEvents.STATE_CHANGE, _onPlayerStateChange);
			_loader.content.removeEventListener(PlayerEvents.QUALITY_CHANGE, _onVideoPlaybackQualityChange);	
			
			_player.destroy();
			
			removeChild(_loader);
			_loader = null;
	    }
		
		
	}
}