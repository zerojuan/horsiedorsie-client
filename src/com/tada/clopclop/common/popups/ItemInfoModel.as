package com.tada.clopclop.common.popups
{
	import flash.display.Sprite;

	public class ItemInfoModel extends Sprite
	{
		private var _itemInfo:ItemInfo;
		private var _lock:Boolean;
		
		public function ItemInfoModel( buildingName:String , buildingTime:String , buildingInfo:String , buildingLevel:String ) 
		{
			inheritItemInfo();
			_itemInfo.buildingName.text = buildingName;
			_itemInfo.buildingTime.text = buildingTime;
			_itemInfo.buildingInfo.text = buildingInfo;
			_itemInfo.buildingLevel.text = buildingLevel;
			
			_itemInfo.buildingName.selectable = false;
			_itemInfo.buildingTime.selectable = false;
			_itemInfo.buildingInfo.selectable = false;
			_itemInfo.buildingLevel.selectable = false;
		}
		
		public function setLock(lock:Boolean):void
		{
			_lock = lock;
		}
		
		private function inheritItemInfo():void
		{
			_itemInfo = new ItemInfo(); 
			_itemInfo.name = "_itemInfo";
			addChild(_itemInfo);
		}
		
	}
}