package com.tada.clopclop.events
{
	import com.tada.clopclop.world.BuildableItem;
	
	import flash.events.Event;
	
	public class NavigationEvent extends Event
	{
		public static const REDECORATE:String = "redecorateClicked";	
		public static const REDECORATE_DONE:String = "redecorateDone";
		public static const HORSE_EQUIP:String = "horseEquip";
		public static const HORSE_EQUIP_DONE:String = "horseEquipDone";
		public static const JOCKEY_EQUIP:String = "jockeyEquip";
		public static const JOCKEY_EQUIP_DONE:String = "jockeyEquipDone";
		
		public var selectedBuilding:BuildableItem;
		
		public function NavigationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}