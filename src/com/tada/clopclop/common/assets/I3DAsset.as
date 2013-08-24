package com.tada.clopclop.common.assets
{
	import flash.events.Event;

	public interface I3DAsset
	{
		function walk(direction:String):void;
		function update(e:Event = null):void;
	}
}