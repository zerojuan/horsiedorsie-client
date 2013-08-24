package com.tada.clopclop.events
{
	import flash.events.Event;
	
	public class RacingEvent extends Event
	{
		public static const START_HORSE_RACING:String = "Start_HORSE_RACING";
		
		public function RacingEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}