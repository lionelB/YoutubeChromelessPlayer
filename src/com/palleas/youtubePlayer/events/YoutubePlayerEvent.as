package events
{
  import flash.events.Event;
  
  public class YoutubePlayerEvent extends Event
  {
    static public const READY : String = "onReady";
    static public const ERROR : String = "onError";
    static public const STATE_CHANGE : String = "onStateChange";
    static public const QUALITY_CHANGE : String = "onPlaybackQualityChange";

    public function YoutubePlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
    {
      super(type, bubbles, cancelable);
    }
  }
}