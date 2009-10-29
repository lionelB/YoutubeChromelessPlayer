package com.palleas.youtubePlayer
{
  import flash.display.Loader;
  import flash.events.Event;
  import flash.events.IEventDispatcher;
  import flash.net.URLRequest;

  public class YoutubePlayer
  {
    static public const PLAYER_URL : String = "http://www.youtube.com/apiplayer?version=3";
    protected var playerLoader : Loader;
    protected var player : IEventDispatcher;
    
    public function YoutubePlayer()
    {
      trace("initializing player");
      init(); 
    }
    
    public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
    {
      if (!player)
      {
        throw new Error("Player not ready");
      }
    }
    
    protected function init() : void
    {
      trace("Initializing player loading");
      playerLoader = new Loader();
      playerLoader.contentLoaderInfo.addEventListener(Event.INIT, playerLoadingInitHandler);
      playerLoader.load(new URLRequest(PLAYER_URL));
    }
    
    protected function playerLoadingInitHandler(e:Event) : void
    {
      trace("player download initialized");
      playerLoader.contentLoaderInfo.removeEventListener(Event.INIT, playerLoadingInitHandler);

      player = IEventDispatcher(playerLoader.content);
      playerLoader = null;
    }
  }
}