package com.tada.clopclop.dataproviders
{
	import com.tada.clopclop.datamodels.Character;
	import com.tada.clopclop.datamodels.IDBModel;
	
	import flash.utils.Dictionary;
	
	public class CharacterDataProvider implements IDataProvider
	{
		private var _modelArray:Array = [];		
		private var _isReady:Boolean = false;
		
		public function CharacterDataProvider()
		{
			
		}
		public function init(res:Array):void{
			//Logger.print(this, "Populating from database records");
			_isReady = true;
			for(var i:int = 0; i < res.length; i++){
				var result:Object = res[i];
				var character:Character = new Character();				
				character.fill(res[i]);	
				
				_modelArray[character._itemBase_idx] = character;					
			}				
		}
		
		public function get isReady():Boolean
		{
			return _isReady;
		}
		
		public function getModelById(id:Number):IDBModel
		{
			if(!_isReady){
				throw new Error("DataProvider isn't ready yet");
			}
			return _modelArray[id];
		}
		
		public function getModelsByCategory(arr:Array):Array
		{
			if(!_isReady){
				throw new Error("DataProvider isn't ready yet");
			}			
			var retArr:Array = [];
			for each(var character:Character in _modelArray){
				var isValid:Boolean = true;
				for(var category:String in arr){
					if(arr[category] != character[category]){
						isValid = false;
						break;
					}
				}
				if(isValid){
					retArr.push(character);
				}
			}
			
			return retArr;
		}
	}
}