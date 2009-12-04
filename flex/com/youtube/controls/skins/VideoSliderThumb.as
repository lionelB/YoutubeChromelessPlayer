package com.youtube.controls.skins
{
	import com.youtube.controls.VideoControlBar;
	
	import mx.controls.sliderClasses.SliderThumb;

	public class VideoSliderThumb extends SliderThumb
	{
		public function VideoSliderThumb()
		{
			super();
		}
		override protected function measure():void
		{
			measuredHeight = measuredWidth = getStyle("trackHeight")||VideoControlBar.DEFAULT_TRACK_HEIGHT;
		}
	}
}