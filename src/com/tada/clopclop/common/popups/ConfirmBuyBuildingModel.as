package com.tada.clopclop.common.popups
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ConfirmBuyBuildingModel extends Sprite
	{
		private var _confirmBuy:ConfirmBuy;
		
		public function ConfirmBuyBuildingModel()
		{
			inheritConfirmBuy();			
			addListeners();
		}
		
		private function inheritConfirmBuy():void
		{
			_confirmBuy = new ConfirmBuy();
			_confirmBuy.name = "_confirmBuy";
			addChild(_confirmBuy);
		}
		
		private function addListeners():void 
		{
			_confirmBuy.yes.addEventListener( MouseEvent.CLICK , onYesClick);
			_confirmBuy.no.addEventListener( MouseEvent.CLICK , onNoClick);
		}
		private function removeListeners():void
		{
			_confirmBuy.yes.removeEventListener( MouseEvent.CLICK , onYesClick );
			_confirmBuy.no.removeEventListener( MouseEvent.CLICK , onNoClick );
		}
		private function onYesClick(event:MouseEvent):void		
		{
			var _buildingHolder:Object = parent
				
			_buildingHolder.removeConfirmBuy();
			removeListeners();
			removeChild( _confirmBuy );
			
			_buildingHolder.occupyFieldArea();
			_buildingHolder.visibilityBase(false)
			_buildingHolder.setAcquired(true)
			_buildingHolder.buyThisItem();
			
			
			_buildingHolder.inheritBuildingInfoModel();
				
		}
		private function onNoClick(event:MouseEvent):void		
		{
			var _buildingHolder:Object = parent
				
			_buildingHolder.releaseBuildingHolder();
			_buildingHolder.removeConfirmBuy();
			removeListeners();
			removeChild( _confirmBuy );
		}
		
		
	}
}