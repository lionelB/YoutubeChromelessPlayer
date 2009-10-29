package com.palleas.youtubePlayer
{
  import com.palleas.youtubePlayer.events.YoutubePlayerEvent;
  
  import flash.display.Loader;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.net.URLRequest;
  import flash.system.Security;

  public class YoutubePlayer extends Sprite
  {
    static public const PLAYER_URL : String = "http://www.youtube.com/apiplayer?version=3";
    protected var playerContainer : Loader;
    protected var player : Object;
    
    public function YoutubePlayer()
    {
      super();
      init(); 
    }
    
    // ----------- Public methods ----------------//
    // queueing methods
    public function cueVideoById(videoId:String, startSeconds:Number = 0, suggestedQuality:String = "default") : void
    {
      player.cueVideoById(videoId, startSeconds, suggestedQuality);
    }
    
    public function loadVideoById(videoId:String, startSeconds:Number = 0, suggestedQuality:String = null) : void
    {
      player.loadVideoById(videoId, 2, suggestedQuality);
    }
    
    public function cueVideoByUrl(mediaContentUrl:String, startSeconds:Number) : void
    {
      player.cueVideoByUrl(mediaContentUrl, startSeconds);
    }
    
    public function loadVideoByUrl(mediaContentUrl:String, startSeconds:Number) : void
    {
      player.loadVideoByUrl(mediaContentUrl, startSeconds);
    }
    
    // video playing methods
    public function playVideo() : void
    {
      player.playVideo();
    }
    
    public function stopVideo() : void
    {
      player.stopVideo();
    }
    
    public function pauseVideo() : void
    {
      player.pauseVideo();
    }
    
    public function seekTo(seconds:uint, allowSeekAhead:Boolean = true) : void
    {
      player.seekTo(seconds, allowSeekAhead);
    } 

    public function setSize(width:Number, height:Number) : void
    {
      player.setSize(width, height);
    }
    
    // volume methods
    public function mute() : void
    {
      player.mute();
    }
    
    public function unMute() : void
    {
      player.unMute(); 
    }
    
    public function isMuted() : Boolean
    {
      return player.isMuted();
    }

    public function get muted() : Boolean
    {
      return isMuted();
    }
    
    public function setVolume(volume:Number) : void
    {
      //TODO dispatch VOLUME_CHANGED event
      player.setVolume(volume);
    }
    
    public function getVolume() : Number
    {
      return player.getVolume(); 
    }
    
    public function get volume() : Number
    {
      return getVolume();
    }
    
    // ----------- Protected methods ------------ //
    protected function init() : void
    {
      Security.allowDomain("*");
      Security.allowInsecureDomain("*");
      
      playerContainer = new Loader();
      playerContainer.contentLoaderInfo.addEventListener(Event.INIT, playerLoadingInitHandler);
      playerContainer.load(new URLRequest(PLAYER_URL));
    }
    
    // ----------- Event Handlers ------------//
    protected function playerLoadingInitHandler(e:Event) : void
    {
      addChild(playerContainer);
      playerContainer.contentLoaderInfo.removeEventListener(Event.INIT, playerLoadingInitHandler);

      player = playerContainer.content;
      
      player.addEventListener("onReady", _playerReadyHandler);
      player.addEventListener("onError", _playerErrorHandler);
      player.addEventListener("onStateChange", _playerStateChangeHandler);
      player.addEventListener("onPlaybackQualityChange", _playerQualityChangeHandler);
    }
    
    private function _playerReadyHandler(e:Event) : void
    {
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.READY));
    }
    
    private function _playerErrorHandler(e:Event) : void
    {
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.ERROR));
    }
    
    private function _playerStateChangeHandler(e:Event) : void
    {
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.STATE_CHANGE));  
    }
    
    private function _playerQualityChangeHandler(e:Event) : void
    {
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.QUALITY_CHANGE));
    }
  }
}