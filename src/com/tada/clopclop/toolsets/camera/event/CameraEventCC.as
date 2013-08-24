package com.tada.clopclop.toolsets.camera.event
{
	import flash.events.Event;

	public class CameraEventCC extends Event
	{
		
		public static const CAMERA_SEQDONE:String = "onCameraSequenceDone";
		
		private var params:Object = new Object();
		
		public function CameraEventCC(type:String, Params:Object, bubbles:Boolean = false, cancelable = false)
		{
			super (type, bubbles, cancelable);	
			params = Params;
		}
	}
}