package com.tada.clopclop.events
{
	import flash.events.Event;
	
	public class HorseWorldEvent extends Event
	{
		public static const HORSE_CLICKED:String = "HORSE_CLICKED";
		
		public function HorseWorldEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}