package com.tada.clopclop.ui.components {
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class ButtonTypeComponent extends EventDispatcher implements IComponent {
		protected var _buttonObject:InteractiveObject;
		protected var _callback:Function;
		
		public function ButtonTypeComponent(buttonObject:InteractiveObject, callback:Function = null) {
			_buttonObject = buttonObject;
			_callback = callback;
		}
		
		protected function onButtonClick(e:MouseEvent):void {
			if (_callback != null) {
				_callback(e);
			}
			dispatchEvent(e);
		}
		
		public function addListeners():void {
			_buttonObject.addEventListener(MouseEvent.CLICK, onButtonClick);
		}
		
		public function removeListeners():void {
			_buttonObject.removeEventListener(MouseEvent.CLICK, onButtonClick);
		}
		
		public function setPosition(X:Number, Y:Number):void {
			_buttonObject.x = X;
			_buttonObject.y = Y;
		}
		
		public function getPosition():Point {
			return new Point(_buttonObject.x, _buttonObject.y);
		}
		
		public function get displayObject():DisplayObject {
			return _buttonObject;
		}
	}
}