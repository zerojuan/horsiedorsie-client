package com.tada.clopclop.ui.components
{
	import flash.display.InteractiveObject;

	public interface IItemComponent	{
		
		function displayItem(buttonReference:InteractiveObject):void;
		
		function removeItem():void;
		
		function get buttonReference():InteractiveObject;
	}
}