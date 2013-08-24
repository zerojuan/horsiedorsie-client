package com.tada.clopclop.events
{
	import flash.events.Event;
	
	public class BuildablesEvent extends Event
	{
		public static const MY_BUILDINGS_UPDATED:String = "_myBuildingsUpdated";
		public static const BUILDING_ASSETS_READY:String = "_buildingAssetsReady";
		
		public function BuildablesEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}