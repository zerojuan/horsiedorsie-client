package com.tada.clopclop.datamodels
{
	import com.tada.clopclop.dataproviders.IDataProvider;
	import com.tada.utils.debug.Logger;

	public class Ranch implements IDBModel
	{
		public var name:String;
		public var buildings:Array = [];
		
		public function Ranch(){
			
		}
		
		public function setShopProvider(dataProvider:IDataProvider):void{
			_shopProvider = dataProvider;
		}
		
		public function fill(res:Object):void{
			for(var i:int = 0; i < res.length; i++){
				var building:Building = getBuildingData(res[i]);
				buildings.push(building);
			}
			Logger.info(this, "fill", "Ranch has " + res.length + " buildings");
		}
		
		public function clone():IDBModel{
			return null;
		}
		
		private function getBuildingData(res:Object):Building{
			var building:Building = _shopProvider.getModelById(res.build_base_idx).clone() as Building;
			building.state = Building.FUNCTIONAL;
			var arr:Array = (res.field_area as String).split("_");			
			building.col = arr[0];
			building.row = arr[1];			
			building.flipped = (res.rotation != 0);
			building.ranchId = res.build_idx;			
			return building;
		}
		
		private var _shopProvider:IDataProvider
	}
}