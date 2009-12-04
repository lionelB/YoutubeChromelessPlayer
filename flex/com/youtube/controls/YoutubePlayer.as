package com.youtube.controls
{
	
	import com.youtube.chromelessPlayer.YoutubeVideo;
	import com.youtube.chromelessPlayer.constants.PlayerStateCode;
	import com.youtube.chromelessPlayer.events.PlaybackQualityEvent;
	import com.youtube.chromelessPlayer.events.PlayerStateEvent;
	import com.youtube.chromelessPlayer.events.SimpleVideoEvent;
	import com.youtube.chromelessPlayer.events.VideoErrorEvent;
	
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	import mx.events.SliderEvent;
	import mx.utils.URLUtil;
	
	
	public class YoutubePlayer extends UIComponent
	{
		
		private var _ready:Boolean;
		private var _url:String;
		private var urlChanged:Boolean;
		private var videoID:String;
		private var durationInitialized:Boolean;
		
		
	
		protected var video:YoutubeVideo
		protected var controlBar:VideoControlBar;
		
		protected var default_width:Number = 200;
		protected var default_height:Number = 150;
		
		public function YoutubePlayer()
		{
 
 		}
		
		/**
		 * 
		 * UIComponents Overriden Methods
		 * 
		 */		
		override protected function createChildren():void
		{
			if( video==null )
			{
				video = new YoutubeVideo();	
				video.addEventListener(Event.INIT, onPlayerInit);				
				video.addEventListener(PlayerStateEvent.PLAYER_STATE_CHANGE, onPlayerStateChange);
				video.addEventListener(VideoErrorEvent.VIDEO_ERROR, onVideoError);
				video.addEventListener(PlaybackQualityEvent.PLAYBACK_QUALITY_CHANGE, onPlaybackQualityChange);
				
			}
			addChild( video );
			if( controlBar==null)
			{
				controlBar = new VideoControlBar();
				controlBar.enabled = false;
			}
			addChild( controlBar );
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if( urlChanged && _ready)
			{
				urlChanged = false;
				video.cueVideoById(videoID);
			}
		}
		
		override protected function measure():void
		{
			super.measure();
			var w:Number = getExplicitOrMeasuredWidth() || default_width;
			var h:Number = getExplicitOrMeasuredHeight() || default_height;
			if( _ready )
			{				
				if( w > h )
				{
					//Paysage
					measuredWidth = w;
					measuredHeight = w*3/4;
				}
				else
				{
					//Portrait - carré
					measuredHeight = h;			
					measuredWidth = h*4/3;
				}
			}
			measuredHeight += controlBar.height;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(0x0000CC);
			g.drawRect(0,0,unscaledWidth,unscaledHeight);
			g.endFill();
			if( _ready )
			{
				var w:Number = unscaledWidth;
				var h:Number = unscaledHeight - controlBar.getExplicitOrMeasuredHeight();
				var ph:Number;
				var pw:Number;
				
				if( w/h > 4/3 )
				{
					ph = h;			
					pw = ph*4/3;
				}
				else
				{
					pw = w;
					ph = w*3/4;
				}
				video.setSize(pw,ph);
				video.x = (w - pw)/2 
				video.y = (h - ph)/2 
				
				
			}
			controlBar.setActualSize(unscaledWidth,controlBar.getExplicitOrMeasuredHeight());
			controlBar.move(0,unscaledHeight-controlBar.getExplicitOrMeasuredHeight());
		}
		
		

		protected function initControlBarEvent():void
		{
			controlBar.playButton.addEventListener(MouseEvent.CLICK, playClickHandler);
			controlBar.soundButton.addEventListener(MouseEvent.CLICK, soundClickHandler);
			
			controlBar.playHeadSlider.addEventListener(SliderEvent.CHANGE, playHeadSliderChange);
			controlBar.playHeadSlider.addEventListener(SliderEvent.THUMB_DRAG, playHeadSliderThumbDrag);
			controlBar.playHeadSlider.addEventListener(SliderEvent.THUMB_PRESS, playHeadSliderThumbPress);
			controlBar.playHeadSlider.addEventListener(SliderEvent.THUMB_RELEASE, playHeadSliderThumbRelease);
			
		}
		protected function initControlBarData():void
		{
			controlBar.enabled = true;
		}
		
		
		/**
		 * 
		 * Youtube apiplayer event handlers
		 * 
		 */
		 
		 

		protected function onVideoError(event:VideoErrorEvent):void
		{
		    trace("player error:", event.errorCode," - ",event.error );
		}
		protected function onPlayerInit(event:Event):void
		{
			trace("player init:" );
		    setReady(true);
	   		initControlBarEvent();
			invalidateSize();
			invalidateDisplayList();
		}
			
		protected function onPlayerStateChange(event:PlayerStateEvent):void 
		{
		    trace("player state change : " , event.stateCode,"-",event.state);
		    
		    switch(event.stateCode)
		    {
		    	case PlayerStateCode.PLAYING:
		    		video.addEventListener(SimpleVideoEvent.PLAYHEAD_UPDATE, onPlayHeadUpdate);
		    		if( !durationInitialized )
		    		{
		    			durationInitialized = true;
		    			controlBar.duration = video.duration;
		    			controlBar.playButton.selected = true;
		    		}
		    		break;
		    	case PlayerStateCode.PAUSED:			    	
					break;
				case PlayerStateCode.ENDED:
					break;
				case PlayerStateCode.VIDEO_CUED:
					invalidateSize();
					invalidateDisplayList();
					initControlBarData();
					break;
				case PlayerStateCode.UNSTARTED:
					break;
				case PlayerStateCode.BUFFERING:
					break;
		    }
		}
		
		protected function onPlaybackQualityChange(event:PlaybackQualityEvent):void 
		{
		    // Event.data contains the event parameter, which is the new video quality
		    trace("video quality:", event.quality);
		}
		
		
		
		protected function onPlayHeadUpdate(event:SimpleVideoEvent):void
		{
			controlBar.playHeadTime = video.currentTime;
		}
		
		/**
		 * 
		 * ControlBar Event Handler
		 * 
		 */
		protected function playClickHandler(event:MouseEvent):void
		{
			//Play			
			trace("click handler " , controlBar.playButton.selected  );			
			if( controlBar.playButton.selected )
			{
				video.playVideo();
			}
			else
			{
				video.pauseVideo();
			}
			
			
		}
		protected function soundClickHandler(event:MouseEvent):void
		{
			//toggleSound 
			controlBar.soundButton.selected = video.isMuted();
			if( controlBar.soundButton.selected )
			{
				video.unMute();
			}
			else
			{
				video.mute();
			}
		}
		protected function playHeadSliderThumbPress(event:SliderEvent):void
		{
			trace("Slider thumb Press");
			video.removeEventListener(SimpleVideoEvent.PLAYHEAD_UPDATE, onPlayHeadUpdate);
		}
		protected function playHeadSliderThumbRelease(event:SliderEvent):void
		{
			trace("Slider thumb Release");
			video.seekTo(event.value);
		}
		protected function playHeadSliderThumbDrag(event:SliderEvent):void
		{
			trace("Slider thumb Drag");
			
		}
		protected function playHeadSliderChange(event:SliderEvent):void
		{
			trace("SliderChange");
		}
		
	 	/**
	 	 * 
	 	 * Getter / setter
	 	 * 
	 	 */
	 	[Bindable(event="readyChanged")]
	 	public function get ready():Boolean{return _ready;}
	 	private function setReady(value:Boolean):void
	 	{
	 		if( _ready != value)
	 		{
	 			_ready = value;
	 			invalidateProperties();
	 			invalidateDisplayList();	
	 			dispatchEvent( new Event("readyChanged"));
	 		}
	 	}
	 	[Bindable(event="urlChanged")]
	 	public function get url():String{return _url;}
	 	public function set url(value:String):void
	 	{
	 		if( _url != value)
	 		{
	 			_url = value;
	 			urlChanged = true;
	 			videoID = getVideoId( value);
	 			invalidateProperties();
	 			dispatchEvent( new Event("urlChanged"));
	 		}
	 	}
	 	
	 	public function destroy():void
	 	{
	 		video.removeEventListener(PlayerStateEvent.PLAYER_STATE_CHANGE, onPlayerStateChange);
			video.removeEventListener(VideoErrorEvent.VIDEO_ERROR, onVideoError);
			video.removeEventListener(PlaybackQualityEvent.PLAYBACK_QUALITY_CHANGE, onPlaybackQualityChange);
	 		video.destroy();
	 	}
	 	
	 	/**
	 	 * 
	 	 * Youtube utils
	 	 * 
	 	 */
	 	protected function getVideoId(value:String):String
	 	{
	 		var ar:Array=value.split('?');
	 		if(ar.length==2)
	 		{
		 		var params:Object = URLUtil.stringToObject(ar[1],"&");		 		
		 		if( params.hasOwnProperty("v"))
	 			{
	 				return params.v;
	 			}
	 		}
 			return null;
	 	}
	}
}