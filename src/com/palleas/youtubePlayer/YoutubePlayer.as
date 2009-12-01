/**
 Copyright (c) 2009 Romain 'Palleas' Pouclet
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 * */

package com.palleas.youtubePlayer
{
  import com.palleas.youtubePlayer.events.YoutubePlayerEvent;
  
  import flash.display.Loader;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.ProgressEvent;
  import flash.events.TimerEvent;
  import flash.net.URLRequest;
  import flash.system.Security;
  import flash.utils.Timer;
  
  [Event(type="flash.events.ProgressEvent", name="progress")]
  [Event(type="com.palleas.youtubePlayer.events", name="ready")]
  [Event(type="com.palleas.youtubePlayer.events", name="error")]
  [Event(type="com.palleas.youtubePlayer.events", name="state_change")]
  [Event(type="com.palleas.youtubePlayer.events", name="quality_change")]
  public class YoutubePlayer extends Sprite
  {
    static public const PLAYER_URL : String = "http://www.youtube.com/apiplayer?version=3";
    protected var playerContainer : Loader;
    protected var player : Object;
    protected var checkTimer : Timer;
    
    public function YoutubePlayer()
    {
      super();
      init();
    }
    
    // ----------- Public methods ----------------//
    // queueing methods
    /**
     * Retrieves and cue a video from its id 
     * The video won't start playing till an explicit call of playVideo() or seekTo() method
     * @param String videoId if of the video
     * @param Number startSeconds time to start loading the video at (optional, default 0)
     * @param String suggestedQuality default quality of the video (optional)
     * @return void
     * 
     */    
    public function cueVideoById(videoId:String, startSeconds:Number = 0, suggestedQuality:String = null) : void
    {
      player.cueVideoById(videoId, startSeconds, suggestedQuality);
    }
    
    /**
     * Retrieves and load a video by its ID
     * @param String videoId
     * @param Number startSeconds
     * @param String suggestedQuality
     * @return void
     * 
     */    
    public function loadVideoById(videoId:String, startSeconds:Number = 0, suggestedQuality:String = null) : void
    {
      player.loadVideoById(videoId, 2, suggestedQuality);
    }
    
    /**
     * Cues a video from its URL
     * @param mediaContentUrl video URL
     * @param startSeconds time in seconds to start the video at
     * @return void
     * 
     */    
    public function cueVideoByUrl(mediaContentUrl:String, startSeconds:Number) : void
    {
      player.cueVideoByUrl(mediaContentUrl, startSeconds);
    }
    
    /**
     * Loads a video from its URL
     * @param mediaContentUrl
     * @param startSeconds
     * 
     */    
    public function loadVideoByUrl(mediaContentUrl:String, startSeconds:Number) : void
    {
      player.loadVideoByUrl(mediaContentUrl, startSeconds);
    }
    
    // video playing methods
    /**
     * Plays a video
     * @return void 
     */    
    public function playVideo() : void
    {
      player.playVideo();
    }
    
    /**
     * Stops a video
     * @return void
     * 
     */    
    public function stopVideo() : void
    {
      player.stopVideo();
    }
    
    /**
     * Pauses a video
     * @return void
     * 
     */    
    public function pauseVideo() : void
    {
      player.pauseVideo();
    }
    
    /**
     * 
     * @param seconds
     * @param allowSeekAhead
     * 
     */    
    public function seekTo(seconds:uint, allowSeekAhead:Boolean = true) : void
    {
      player.seekTo(seconds, allowSeekAhead);
    } 
    
    /**
     * Sets the size of a video
     * @param width
     * @param height
     * @return void
     * 
     */    
    public function setSize(width:Number, height:Number) : void
    {
      player.setSize(width, height);
    }
    
    // volume methods
    
    /**
     * Mutes a video (set volume to 0)
     * @return void
     */    
    public function mute() : void
    {
      player.mute();
    }
    
    /**
     * Unmutes a video (retrieves previous volume)
     * @return void 
     * 
     */    
    public function unMute() : void
    {
      player.unMute(); 
    }
    
    /**
     * Checks if the video is muted, or not
     * @return Boolean
     * 
     */    
    public function isMuted() : Boolean
    {
      return player.isMuted();
    }
    
    /**
     * Checks of the video is muted
     * (alias for isMuted)
     * @return Boolean
     * 
     */    
    public function get muted() : Boolean
    {
      return isMuted();
    }
    
    /**
     * Sets the volume of the video
     * @param volume
     * @return void
     * 
     */    
    public function setVolume(volume:Number) : void
    {
      //TODO dispatch VOLUME_CHANGED event
      player.setVolume(volume);
    }
    
    /**
     * Returns the volume of the played video
     * @return Number volume of the video
     * 
     */    
    public function getVolume() : Number
    {
      return player.getVolume(); 
    }
    
    /**
     * Returns the volume of the played video
     * (Alias for getVolume)
     * @return Number volume of the video
     * 
     */    
    public function get volume() : Number
    {
      return getVolume();
    }
    
    // Playback status methods
    /**
     * 
     * @return 
     * 
     */    
    public function getVideoBytesLoaded() : Number
    {
      return player.getVideoBytesLoaded();
    }
    
    /**
     * 
     * @return 
     * 
     */    
    public function getVideoBytesTotal() : Number
    {
      return player.getVideoBytesTotal();
    }
    
    /**
     * 
     * @return 
     * 
     */    
    public function getVideoStartBytes() : Number
    {
      return player.getVideoStartBytes();
    }
    
    /**
     * 
     * @return 
     * 
     */    
    public function getVideoProgressLoaded() : Number
    {
      if (getVideoBytesTotal() == 0)
      {
        return 0;
      }
      var progress : Number = (getVideoBytesLoaded()/getVideoBytesTotal()) * 100;
      return progress;
    }
    
    /**
     * 
     * @return 
     * 
     */    
    public function getPlayerState() : Number
    {
      return player.getPlayerState();
    }
    
    /**
     * 
     * @return 
     * 
     */    
    public function getCurrentTime() : Number
    {
      return player.getCurrentTime();
    }
    
    // Playback quality methods
    /**
     * 
     * @return 
     * 
     */    
    public function getPlaybackQuality() : String
    {
      return player.getPlaybackQuality();
    }
    
    /**
     * 
     * @param quality
     * 
     */    
    public function setPlaybackQuality(quality:String) : void
    {
      player.setPlaybackQuality(quality);
    }
    
    /**
     * 
     * @return 
     * 
     */    
    public function getAvailableQualityLevels() : Array
    {
      return player.getAvailableQualityLevels();
    }
    
    // informations methods
    /**
     * 
     * @return 
     * 
     */    
    public function getDuration() : Number
    {
      return player.getDuration();
    }
    
    /**
     * 
     * @return 
     * 
     */    
    public function getVideoUrl() : String
    {
      return player.getVideoUrl();
    }
    
    /**
     * 
     * @return 
     * 
     */    
    public function getVideoEmbedCode() : String
    {
      return player.getVideoEmbedCode();  
    }
    
    // prevents memory leaks
    /**
     * 
     * 
     */    
    public function destroy():void
    {
      player.destroy();
      removeChild(playerContainer);
      playerContainer = null;
    }
    
    // ----------- Protected methods ------------ //
    /**
     * 
     * 
     */    
    protected function init() : void
    {
      // Sandbox stuff
      Security.allowDomain("*");
      Security.allowInsecureDomain("*");
      
      // player container loading
      playerContainer = new Loader();
      playerContainer.contentLoaderInfo.addEventListener(Event.INIT, playerLoadingInitHandler);
      playerContainer.load(new URLRequest(PLAYER_URL));
    }
    
    // ----------- Event Handlers ------------//
    /**
     * 
     * @param e
     * 
     */    
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
    
    /**
     * 
     * @param e
     * 
     */    
    protected function timerHitHandler(e:TimerEvent) : void
    {
      var currentProgress : Number = getVideoProgressLoaded();
      if (!(currentProgress == 0 || currentProgress == 100)) {
        var progress : ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
        progress.bytesLoaded = getVideoBytesLoaded();
        progress.bytesTotal = getVideoBytesTotal();
        dispatchEvent(progress);
      }
    }
    
    
    
    /* -------------------------------
    * Internal Player Event listeners 
    * -------------------------------
    */
    
    /**
     * Handles player ready state
     * @param Event e : dispatched event
     * @return void
     * 
     */    
    private function _playerReadyHandler(e:Event) : void
    {
      // now we can check on a few things
      checkTimer = new Timer(500);
      checkTimer.addEventListener(TimerEvent.TIMER, timerHitHandler);
      checkTimer.start();
      
      // dispatch Ready Event
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.READY));
    }
    
    /**
     * Handles player error
     * @param Event e : dispatched error
     * @return void
     * 
     */    
    private function _playerErrorHandler(e:Event) : void
    {
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.ERROR));
    }
    
    /**
     * Handles player state change
     * @param Event e : dispatched Event
     * @return void
     * 
     */    
    private function _playerStateChangeHandler(e:Event) : void
    {
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.STATE_CHANGE));  
    }
    
    /**
     * Handles Player Quality change
     * @param Event e : dispatched event
     * @return void
     * 
     */    
    private function _playerQualityChangeHandler(e:Event) : void
    {
      dispatchEvent(new YoutubePlayerEvent(YoutubePlayerEvent.QUALITY_CHANGE));
    }
  }
}