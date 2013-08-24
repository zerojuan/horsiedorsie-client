package com.tada.clopclop.toolsets.character.horse.event
{
	import flash.events.Event;

	public class HorseEvent extends Event
	{
		public static const MESH_LOADED:String = "meshLoaded";
		public static const XML_LOADED:String = "xMLLoaded";
		public static const ANIMXML_LOADED:String = "animationXMLLoaded";
		public static const MESH_RETRIEVED:String = "meshRetrieved";
		public static const MESH_LOADED_ANIM:String = "meshLoadedForAnimationSynch";
		
		public var params:Object;
		
		public function HorseEvent(type:String, Params:Object = null, bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super (type, bubbles, cancelable)
			params = Params
		}
	}
}