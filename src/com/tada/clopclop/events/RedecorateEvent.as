package com.tada.clopclop.events
{
	import com.tada.clopclop.world.BuildingItem;
	import com.tada.clopclop.world.BuildableItem;
	
	import flash.events.Event;
	
	public class RedecorateEvent extends Event
	{
		public static const ROTATE:String = "onRotate";
		public static const SELL:String = "onSell";
		public static const STORAGE:String = "onStorage";
		public static const MOVE:String = "onMove";
		
		public var redecoratedItem:BuildingItem;
		
		public function RedecorateEvent(type:String,  redecoratedItem:BuildingItem, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.redecoratedItem = redecoratedItem;
		}
	}
}