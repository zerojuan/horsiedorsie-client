package com.tada.clopclop.popups {
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class HorseManagementPopup implements IPopup {
		
		private var _callBack:Function;
		private var _horseMgmtPopup:horseManagementPopup;
		private var _visible:Boolean;
		
		public static const FEEDING:String = "feeding";
		public static const INFO:String = "info";
		public static const RACE:String = "race";
		public static const SHOWER:String = "shower";
		public static const TRAINING:String = "training";
		
		public function HorseManagementPopup() {
			_horseMgmtPopup = new horseManagementPopup();
		}
		
		public function get displayObject():DisplayObjectContainer{
			return _horseMgmtPopup;
		}
		
		public function show(parentDisplay:DisplayObjectContainer, callBack:Function, X:int = 0, Y:int = 0):void {
			_visible = true;
			_callBack = callBack;
			if (!_horseMgmtPopup.parent) {
				parentDisplay.addChild(_horseMgmtPopup);
				_horseMgmtPopup.x = X;
				_horseMgmtPopup.y = Y;
				
				_horseMgmtPopup.scaleX = 0;
				_horseMgmtPopup.scaleY = 0;
				buttonPopupAnimation(_horseMgmtPopup.feeding);
				buttonPopupAnimation(_horseMgmtPopup.info);
				buttonPopupAnimation(_horseMgmtPopup.race);
				buttonPopupAnimation(_horseMgmtPopup.shower);
				buttonPopupAnimation(_horseMgmtPopup.training);
				TweenLite.to(_horseMgmtPopup, .5, {
					scaleX: 1,
					scaleY: 1,
					ease: Back.easeOut
				});
			}
			addListeners();
		}
		
		private function buttonPopupAnimation(button:DisplayObject):void {
		}
		
		public function hide():void {
			if (_horseMgmtPopup.parent) {
				TweenLite.to(_horseMgmtPopup, .5, {
					scaleX: 0,
					scaleY: 0,
					ease: Back.easeIn,
					onComplete: function():void {
						_horseMgmtPopup.parent.removeChild(_horseMgmtPopup);
					}
				});
			}
			removeListeners();
			_visible = false;
		}
		
		public function get visible():Boolean{
			return _visible;
		}
		
		private function addListeners():void {
			_horseMgmtPopup.feeding.addEventListener(MouseEvent.CLICK, onFeedingClick);
			_horseMgmtPopup.info.addEventListener(MouseEvent.CLICK, onInfoClick);
			_horseMgmtPopup.race.addEventListener(MouseEvent.CLICK, onRaceClick);
			_horseMgmtPopup.shower.addEventListener(MouseEvent.CLICK, onShowerClick);
			_horseMgmtPopup.training.addEventListener(MouseEvent.CLICK, onTrainingClick);
		}
		
		private function removeListeners():void {
			_horseMgmtPopup.feeding.removeEventListener(MouseEvent.CLICK, onFeedingClick);
			_horseMgmtPopup.info.removeEventListener(MouseEvent.CLICK, onInfoClick);
			_horseMgmtPopup.race.removeEventListener(MouseEvent.CLICK, onRaceClick);
			_horseMgmtPopup.shower.removeEventListener(MouseEvent.CLICK, onShowerClick);
			_horseMgmtPopup.training.removeEventListener(MouseEvent.CLICK, onTrainingClick);
		}
		
		private function onFeedingClick(e:MouseEvent):void {
			Logger.print(this, "HeyTrain");
			_callBack(FEEDING);
		}
		
		private function onInfoClick(e:MouseEvent):void {
			Logger.print(this, "HeyTrain");
			_callBack(INFO);
		}
		
		private function onRaceClick(e:MouseEvent):void {
			Logger.print(this, "HeyTrain");
			_callBack(RACE);
		}
		
		private function onShowerClick(e:MouseEvent):void {
			Logger.print(this, "HeyTrain");
			_callBack(SHOWER);
		}
		
		private function onTrainingClick(e:MouseEvent):void {
			Logger.print(this, "HeyTrain");
			_callBack(TRAINING);
		}
	}
}