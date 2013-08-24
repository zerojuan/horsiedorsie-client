package com.tada.clopclop.ui.components {
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	public interface IComponent {
		
		function addListeners():void;
		
		function removeListeners():void;
		
		function setPosition(X:Number, Y:Number):void;
		
		function getPosition():Point;
		
		function get displayObject():DisplayObject;
	}
}