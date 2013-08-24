package com.tada.clopclop.popups
{
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ConfirmBuyPopup
	{
		private var _confirmBuy:ConfirmBuy;
		
		private var _yesCallBack:Function;
		private var _noCallBack:Function;
		
		private var _parent:DisplayObjectContainer;
		
		public function ConfirmBuyPopup(){
			_confirmBuy = new ConfirmBuy();
			_confirmBuy.name = "_confirmBuy";
		}
		
		public function initPopup(parent:DisplayObjectContainer, yesCallBack:Function, noCallBack:Function):void{
			_parent = parent;
			
			_yesCallBack = yesCallBack;
			_noCallBack = noCallBack;
			
			
			_parent.addChild(_confirmBuy);
			
			addListeners();
		}
		
		public function hidePopup():void{
			if(_parent && _parent.contains(_confirmBuy)){
				_parent.removeChild(_confirmBuy);
			}
			
			removeListeners();
		}
		
		private function addListeners():void{
			_confirmBuy.yes.addEventListener( MouseEvent.CLICK , onYesClick);
			_confirmBuy.no.addEventListener( MouseEvent.CLICK , onNoClick);
		}
		
		private function removeListeners():void{
			_confirmBuy.yes.removeEventListener( MouseEvent.CLICK , onYesClick );
			_confirmBuy.no.removeEventListener( MouseEvent.CLICK , onNoClick );
		}
		
		private function onYesClick(event:MouseEvent):void{
			Logger.print(this, "Clicked Yes");
			_yesCallBack();		
		}
		private function onNoClick(event:MouseEvent):void{
			_noCallBack();
		}
		
		
	}
}