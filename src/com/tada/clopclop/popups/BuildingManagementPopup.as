package com.tada.clopclop.popups {
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Sine;
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class BuildingManagementPopup implements IPopup{
		
		private var _buildingPopup:PopupControl;
		private var _parentDisplay:DisplayObjectContainer;
		private var _callBack:Function;
		
		private var _visible:Boolean;
		
		public static const SELL:String = "sell";
		public static const ROTATE:String = "rotate";
		public static const STORAGE:String = "storage";
		public static const MOVE:String = "move";
		
		public function BuildingManagementPopup() {
			_buildingPopup = new PopupControl();					
		}
		
		public function get displayObject():DisplayObjectContainer{
			return _buildingPopup;
		}
		
		public function show(parent:DisplayObjectContainer, callback:Function, X:int = 0, Y:int = 0):void{
			_parentDisplay = parent;
			_callBack = callback;
			_visible = true;
			
			if (!_buildingPopup.parent) {
				_parentDisplay.addChild(_buildingPopup);
				_buildingPopup.x = X;
				_buildingPopup.y = Y;
				
				/*_buildingPopup.scaleX = 0;
				_buildingPopup.scaleY = 0;
				TweenLite.to(_buildingPopup, .5, {
					scaleX: 1,
					scaleY: 1,
					ease: Back.easeOut
				});*/
								
				_buildingPopup.alpha = 0;
				_buildingPopup.scaleX = .6;
				_buildingPopup.scaleY = .6;
				TweenLite.to(_buildingPopup, .2, {					
					alpha: 1,
					scaleX: 1,
					scaleY: 1,
					ease: Sine.easeIn					
				});
			}
			addListeners();
		}				
		
		public function hide():void {
			if (_buildingPopup.parent) {
				TweenLite.to(_buildingPopup, .4, {					
					scaleX: .6,
					scaleY: .6,
					alpha: 0,
					ease: Back.easeIn,
					onComplete: function():void {
						_buildingPopup.parent.removeChild(_buildingPopup);
						removeListeners();
					}
				});
			}
			_visible = false;
		}
		
		public function get visible():Boolean{
			return _visible;
		}
		
		private function addListeners():void {
			_buildingPopup.sell.addEventListener(MouseEvent.CLICK, onSellClick);
			_buildingPopup.rotate.addEventListener(MouseEvent.CLICK, onRotateClick);
			_buildingPopup.storage.addEventListener(MouseEvent.CLICK, onStorageClick);
			_buildingPopup.move.addEventListener(MouseEvent.CLICK, onMoveClick);
		}
		
		private function removeListeners():void {
			_buildingPopup.sell.removeEventListener(MouseEvent.CLICK, onSellClick);
			_buildingPopup.rotate.removeEventListener(MouseEvent.CLICK, onRotateClick);
			_buildingPopup.storage.removeEventListener(MouseEvent.CLICK, onStorageClick);
			_buildingPopup.move.removeEventListener(MouseEvent.CLICK, onMoveClick);
		}
		
		private function onSellClick(e:MouseEvent):void {
			_callBack(SELL);
		}
		
		private function onRotateClick(e:MouseEvent):void {			
			_callBack(ROTATE);
		}
		
		private function onStorageClick(e:MouseEvent):void {
			_callBack(STORAGE);
		}
		
		private function onMoveClick(e:MouseEvent):void{
			_callBack(MOVE);
		}
	}
}