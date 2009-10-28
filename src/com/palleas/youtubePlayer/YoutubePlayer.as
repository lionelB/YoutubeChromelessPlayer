package com.palleas.youtubePlayer
{
  import flash.display.Loader;
  import flash.events.Event;
  import flash.net.URLRequest;

  public class YoutubePlayer 
  {
    static public const PLAYER_URL : String = "http://www.youtube.com/apiplayer?version=3";
    protected var playerLoader : Loader;
    protected var player : Object;
    
    public function YoutubePlayer()
    {
      
    }
    
    protected function init() : void
    {
      playerLoader = new Loader();
      playerLoader.contentLoaderInfo.addEventListener(Event.INIT, playerLoadingInitHandler);
      playerLoader.load(new URLRequest(PLAYER_URL));
      /*
      * ar loader:Loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
      loader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3"));
      */
    }
    
    protected function playerLoadingInitHandler(e:Event) : void
    {
      playerLoader.removeEventListener(Event.INIT, playerLoadingInitHandler);
    }
  }
}