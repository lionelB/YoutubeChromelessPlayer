package com.youtube.controls
{
	import mx.formatters.DateFormatter;
	
	public class VideoControlBar extends VideoControlBarView
	{ 
		public static const DEFAULT_TRACK_HEIGHT:int = 11;
		public static const DEFAULT_HEIGHT:int = 30;
		
		private var _duration:Number;
		private var durationChanged:Boolean;
		
		private var _playHeadTime:Number;
		private var playHeadTimeChanged:Boolean
		
		protected var timeFormat:String="NN:SS";
		
		private var dateFormatter:DateFormatter;
				
		public function VideoControlBar()
		{
			super();
			dateFormatter = new DateFormatter();
			dateFormatter.formatString = timeFormat;
		}
		
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			setStyle("trackHeight",getStyle("trackHeight")||DEFAULT_TRACK_HEIGHT);
						
			playHeadSlider.styleName = this;			
			playHeadSlider.dataTipFormatFunction = dataTipFormat;
			
		}
		
		override protected function measure():void
		{
			measuredHeight = getExplicitOrMeasuredHeight() || DEFAULT_HEIGHT;
		}
		
		override protected function commitProperties():void
		{
			if( durationChanged )
			{
				durationChanged = false;
				playHeadSlider.maximum = _duration;
				durationLabel.text = formatTime( new Date(_duration*1000));
			}
			if( playHeadTimeChanged )
			{
				playHeadTimeChanged = false;
				playHeadSlider.value = _playHeadTime;
				playHeadTimeLabel.text = formatTime( new Date(_playHeadTime*1000));
			}

		}
		
		/**
		 * 
		 * Facility Method
		 * 
		 */
		private function formatTime(item:Date):String 
		{
			return dateFormatter.format(item);
        }
		public function dataTipFormat(value:Number):String
		{
			return formatTime( new Date(value*1000) );
		}
		/**
		 * 
		 * Getter / Setter
		 * 
		 */		
		public function get duration():Number {return _duration;}		
		public function set duration(value:Number):void
		{
			_duration = value;
			durationChanged = true;
			invalidateProperties();
		}
		public function get playHeadTime():Number {return _playHeadTime;}

		public function set playHeadTime(value:Number):void
		{
			_playHeadTime = value;
			playHeadTimeChanged = true;
			invalidateProperties();
		}

		
		
		
	}
}