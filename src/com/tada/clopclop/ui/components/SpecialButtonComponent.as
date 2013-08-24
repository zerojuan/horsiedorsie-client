package com.tada.clopclop.ui.components {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class SpecialButtonComponent extends ButtonTypeComponent {
		protected var _active:Boolean;
		protected const INACTIVE_FRAME:int = 1;
		protected const HOVER_FRAME:int = 2;
		protected const ACTIVE_FRAME:int = 3;
		
		
		public function SpecialButtonComponent(buttonObject:MovieClip, callback:Function=null) {
			super(buttonObject, callback);
			MovieClip(_buttonObject).mouseChildren = false;
			MovieClip(_buttonObject).buttonMode = true;
			setToInactive();
		}
		
		override public function addListeners():void {
			super.addListeners();
			_buttonObject.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_buttonObject.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		override public function removeListeners():void {
			super.removeListeners();
			_buttonObject.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_buttonObject.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		override protected function onButtonClick(e:MouseEvent):void {
			if (_active == false) {
				super.onButtonClick(e);
				setToActive();
			}
		}
		
		protected function onMouseOver(e:MouseEvent):void {
			if (_active == false) {
				MovieClip(_buttonObject).gotoAndStop(HOVER_FRAME);
			}
		}
		
		protected function onMouseOut(e:MouseEvent):void {
			if (_active == false) {
				MovieClip(_buttonObject).gotoAndStop(INACTIVE_FRAME);
			}
		}
		
		public function setToActive():void {
			_active = true;
			MovieClip(_buttonObject).gotoAndStop(ACTIVE_FRAME);
		}
		
		public function setToInactive():void {
			_active = false;
			MovieClip(_buttonObject).gotoAndStop(INACTIVE_FRAME);
		}
	}
}