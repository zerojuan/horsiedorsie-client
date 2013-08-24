package com.tada.clopclop.dataproviders
{
	import com.tada.clopclop.datamodels.Building;
	import com.tada.clopclop.datamodels.IDBModel;
	import com.tada.utils.debug.Logger;

	public class BuildingDataProvider implements IDataProvider
	{
		public function get isReady():Boolean{
			return _isReady;
		}

		public function init(res:Array):void{
			Logger.print(this, "Populating from database records");
			_isReady = true;
			for(var i:int = 0; i < res.length; i++){
				var result:Object = res[i];
				var building:Building = new Building();
				building.fill(res[i]);
				
				_modelArray[building.id] = building;
			}			
		}
		
		public function getModelById(id:Number):IDBModel{
			if(!_isReady){
				throw new Error("DataProvider isn't ready yet");
			}
			return _modelArray[id];
		}
		
		public function getModelsByCategory(arr:Array):Array{
			if(!_isReady){
				throw new Error("DataProvider isn't ready yet");
			}			
			var retArr:Array = [];
			for each(var building:Building in _modelArray){
				var isValid:Boolean = true;
				for(var category:String in arr){
					if(arr[category] != building[category]){
						isValid = false;
						break;
					}
				}
				if(isValid){
					retArr.push(building);
				}
			}
			
			return retArr;
		}
		
		
		public function getModelsInArrayByCategory(arr:Array, category:String, value:*):Array{
			if(!_isReady){
				throw new Error("DataProvider isn't ready yet");
			}
			var retArr:Array = [];
			for each(var building:Building in arr){
				if(building[category] == value){
					retArr.push(building);
				}
			}
			return retArr;
		}
		
		private var _modelArray:Array = [];
		
		private var _isReady:Boolean = false;
				
	}
}