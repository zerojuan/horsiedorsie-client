package com.tada.clopclop.events
{
	import com.tada.clopclop.datamodels.IDBModel;
	
	import flash.events.Event;
	
	public class ItemEvent extends Event
	{
		public static const ITEM_SELECTED:String = "itemSelected"; //
		public static const BUILD_ITEM:String = "buildItem"; //sent when trying to build an item into the world
		public static const ITEM_BOUGHT:String = "itemBought";
		public static const ITEM_SOLD:String = "itemSold";
				
		public var model:IDBModel;
		public var count:int = 0;
		
		public function ItemEvent(type:String, model:IDBModel = null, count:int = 1, cols:int = 1, rows:int = 1, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
			
			this.model = model;
			this.count = count;
		}
	}
}