package com.palleas.youtubePlayer
{
  import com.palleas.youtubePlayer.events.YoutubePlayerEvent;
  
  import flash.display.Loader;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.IEventDispatcher;
  import flash.net.URLRequest;

  public class YoutubePlayer extends Sprite
  {
    static public const PLAYER_URL : String = "http://www.youtube.com/apiplayer?version=3";
    protected var playerLoader : Loader;
    protected var player : Object;
    
    public function YoutubePlayer()
    {
      super();
      trace("initializing player");
      init(); 
    }
    
    // ----------- Public methods ----------------//
    public function cueVideoById(videoId:String, startSeconds:Number, suggestedQuality:String) : void
    {
      player.cueVideoById(videoId, startSeconds, suggestedQuality);
    }
    
    public function loadVideoById(videoId:String, startSeconds:Number = 0, suggestedQuality:String = null) : void
    {
      player.loadVideoById(videoId, startSeconds, suggestedQuality);
    }
    
    public function cueVideoByUrl(mediaContentUrl:String, startSeconds:Number) : void
    {
      player.cueVideoByUrl(mediaContentUrl, startSeconds);
    }
    
    public function loadVideoByUrl(mediaContentUrl:String, startSeconds:Number) : void
    {
      player.loadVideoByUrl(mediaContentUrl, startSeconds);
    }
    
    // ----------- Protected methods ------------ //
    protected function init() : void
    {
      trace("Initializing player loading");
      playerLoader = new Loader();
      playerLoader.contentLoaderInfo.addEventListener(Event.INIT, playerLoadingInitHandler);
      playerLoader.load(new URLRequest(PLAYER_URL));
    }
    
    // ----------- Event Handlers ------------//
    protected function playerLoadingInitHandler(e:Event) : void
    {
      trace("player download initialized");
      playerLoader.contentLoaderInfo.removeEventListener(Event.INIT, playerLoadingInitHandler);

      player = IEventDispatcher(playerLoader.content);
      player.addEventListener("onReady", _playerReadyHandler);
      player.addEventListener("onError", _playerErrorHandler);
      player.addEventListener("onStateChange", _playerStateChangeHandler);
      player.addEventListener("onPlaybackQualityChange", _playerQualityChangeHandler);
      
      playerLoader = null;
    }
    
    private function _playerReadyHandler(e:Event) : void
    {
      trace("Player is ready");
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.READY));
    }
    
    private function _playerErrorHandler(e:Event) : void
    {
      trace("Player error");
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.READY));
    }
    
    private function _playerStateChangeHandler(e:Event) : void
    {
      trace("Player state changed");
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.READY));  
    }
    
    private function _playerQualityChangeHandler(e:Event) : void
    {
      trace("Player quality changed");
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.READY));
    }
  }
}