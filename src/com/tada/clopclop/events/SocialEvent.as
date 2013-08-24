package com.tada.clopclop.events
{
	import flash.events.Event;
	
	public class SocialEvent extends Event
	{
		public static const FACEBOOK_COMPLETE:String = "onFacebookComplete";
		
		public function SocialEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}