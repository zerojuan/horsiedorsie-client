package com.tada.clopclop.jockeyequip.JockeyComponent
{
	import flash.events.Event;
	
	public class JockeyEquipEvent extends Event {
		public var params:Object;
		public static const CLICKED_BOX0:String = "clickedbox0";
		public static const CLICKED_BOX1:String = "clickedbox1";
		public static const CLICKED_BOX2:String = "clickedbox2";
		public static const CLICKED_BOX3:String = "clickedbox3";
		public static const CLICKED_BOX4:String = "clickedbox4";
		
		public function JockeyEquipEvent(type:String, params:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.params = params;
		}
	}
}