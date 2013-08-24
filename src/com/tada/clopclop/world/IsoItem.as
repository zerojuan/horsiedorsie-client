package com.tada.clopclop.world
{
	import com.tada.engine.iso.IsoObject;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	/**
	 * An Isometric Item in the game world.
	 * Contains a grid background, and a MovieClip reference of the item
	 */
	public interface IsoItem extends IsoObject{
		function get displayObject():DisplayObjectContainer;
		function set visibleBase(val:Boolean):void;
		function get visibleBase():Boolean;
	}
}