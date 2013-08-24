package com.tada.engine.resource
{
	import flash.events.Event;

	public class ResourceEvent extends Event
	{
		/**
		 * This event is dispatched by a resource upon successful load of the resource's
		 * data.
		 * 
		 * @eventType LOADED_EVENT
		 */
		public static const LOADED_EVENT:String = "LOADED_EVENT";
		
		/**
		 * This event is dispatched by a resource when loading of the resource's
		 * data fails.
		 * 
		 * @eventType FAILED_EVENT
		 */
		public static const FAILED_EVENT:String = "FAILED_EVENT";
		/**
		 * The Resource associated with the event.
		 */
		public var resourceObject:Resource = null;
		public function ResourceEvent(type:String, resource:Resource, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			resourceObject = resource;
			
			super(type, bubbles, cancelable);
		}
	}
}