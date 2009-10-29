package com.palleas.youtubePlayer
{
  import com.palleas.youtubePlayer.events.YoutubePlayerEvent;
  
  import flash.display.DisplayObject;
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
      trace("initializing player");
      init(); 
    }
    
    // ----------- Public methods ----------------//
    public function cueVideoById(videoId:String, startSeconds:Number = 0, suggestedQuality:String = "default") : void
    {
      player.cueVideoById(videoId, startSeconds, suggestedQuality);
    }
    
    public function loadVideoById(videoId:String, startSeconds:Number = 0, suggestedQuality:String = "default") : void
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
    
    public function playVideo() : void
    {
      trace("playing video");
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
    
    // ----------- Protected methods ------------ //
    protected function init() : void
    {
      Security.allowDomain("*");
      Security.allowInsecureDomain("*");
      
      trace("Initializing player loading");
      playerContainer = new Loader();
      playerContainer.contentLoaderInfo.addEventListener(Event.INIT, playerLoadingInitHandler);
      playerContainer.load(new URLRequest(PLAYER_URL));
    }
    
    // ----------- Event Handlers ------------//
    protected function playerLoadingInitHandler(e:Event) : void
    {
      trace("player download initialized");
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
      trace("Player is ready");
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.READY));
    }
    
    private function _playerErrorHandler(e:Event) : void
    {
      trace("Player error");
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.ERROR));
    }
    
    private function _playerStateChangeHandler(e:Event) : void
    {
      trace("Player state changed");
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.STATE_CHANGE));  
    }
    
    private function _playerQualityChangeHandler(e:Event) : void
    {
      trace("Player quality changed");
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.QUALITY_CHANGE));
    }
  }
}