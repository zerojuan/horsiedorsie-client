package com.tada.clopclop.racing.event
{
	import flash.events.Event;

	public class RacingViewEvent extends Event
	{
		public var params:Object = new Object();
		
		public function RacingViewEvent(type:String, Params:Object = null, bubbles:Boolean, cancelable:Boolean)
		{
			super (type, bubbles, cancelable);
			params = Params;
		}
	}
}