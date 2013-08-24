package com.tada.clopclop.popups
{
	import flash.display.DisplayObjectContainer;

	/**
	 * Interface for popups
	 */
	public interface IPopup{
		/**
		 * Returns the displayObject containing the images of the popup
		 */
		function get displayObject():DisplayObjectContainer;
		/**
		 * Show on parent
		 */
		function show(parentDisplay:DisplayObjectContainer, callBack:Function, X:int = 0, Y:int = 0):void;
		/**
		 * Hide
		 */
		function hide():void;
		/**
		 * True if it is on display, false if not
		 */
		function get visible():Boolean;
	}
}