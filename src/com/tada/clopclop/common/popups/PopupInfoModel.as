package com.tada.clopclop.common.popups
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class PopupInfoModel extends Sprite
	{
		private var _popupControl:PopupControl;
		
		public function PopupInfoModel()
		{
			inheritPopupControl();
			addListeners();
		}
		
		private function inheritPopupControl():void
		{
			_popupControl = new PopupControl();
			_popupControl.name = "_popupControl";
			addChild(_popupControl);
		}
		
		private function addListeners():void
		{
			_popupControl.sell.addEventListener(MouseEvent.CLICK,onSellClick);
			_popupControl.rotate.addEventListener(MouseEvent.CLICK,onRotateClick);
			_popupControl.storage.addEventListener(MouseEvent.CLICK,onStorageClick);
		}
		
		private function onSellClick(event:MouseEvent):void
		{
			trace("Selling");
		}
		
		private function onRotateClick(event:MouseEvent):void
		{
			var _buildingHolder = parent
				
			_buildingHolder.tickRotate()			
				
		}
		
		private function onStorageClick(event:MouseEvent):void
		{
			trace("Storing");
		}
	}
}