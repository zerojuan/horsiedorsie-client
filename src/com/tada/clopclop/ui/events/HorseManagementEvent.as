package com.tada.clopclop.ui.events {
	import flash.events.Event;
	
	public class HorseManagementEvent extends Event {
		public var params:Object;
		
		public static const CLOSE:String = "close";
		public static const INFO:String = "info";
		public static const RACING:String = "info";
		public static const SHOWER:String = "shower";
		public static const FEEDING:String = "feeding";
		public static const TRAINING:String = "training";
		
		public function HorseManagementEvent(type:String, params:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.params = params;
		}
	}
}