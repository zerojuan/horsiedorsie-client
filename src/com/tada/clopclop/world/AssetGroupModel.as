package com.tada.clopclop.world
{
	import com.tada.clopclop.common.assets.BuildingHolderModel;
	import com.tada.clopclop.common.assets.HorseHolderModel;
	import com.tada.clopclop.common.assets.JockeyHolderModel;
	
	import flash.display.Sprite;

	public class AssetGroupModel extends Sprite
	{
		
		public var HORSE_ID:Number = 0
			
		public function AssetGroupModel()
		{
			
		}
		
		public function placeBuildingOnWorld(_item:String,placeType:String,getFieldArea:String,_idx:Number,_hSize:Number,_wSize:Number):void 
		{
			switch (placeType) {
				case "by_rebuild":
					placeByRebuild(_item,placeType,getFieldArea,_idx,_hSize,_wSize);
					break;
				case "by_start_dragging":
					placeByStartDragging(_item,placeType,getFieldArea);
					break;				
			}
			
			
		}
		
		public function removePopupInfos():void 
		{
			for (var i:Number=0; i<numChildren; i++) {
				var _buildingHolder:Object = getChildAt(i)
				
				if(_buildingHolder.name.split("_")[0] == "building") {
					_buildingHolder.removeOwnPopup();
				}
				
			}
		}
		
		public function organizeOrder():void 
		{
			/*
			for (var i:Number=0; i<numChildren; i++) {
				var _buildingHolder:Object = getChildAt(i)
				var _fieldInfo:String = _buildingHolder.FIELD_INFO
				var _fieldInfoArray:Array = _fieldInfo.split("_")
				var _order:Number = Number(_fieldInfoArray[0]) + Number(_fieldInfoArray[1])
				
				
				
			}
			*/
		}
		
		private function placeByRebuild(_item:String,placeType:String,getFieldArea:String,_idx:Number,_hSize:Number,_wSize:Number):void 
		{
			/*var _buildingHolder:BuildingHolderModel = new BuildingHolderModel(_item,true,placeType)
			var _tileGroupModel:Object = parent.getChildByName("_tileGroupModel")
			var _fieldAreaArray:Array = getFieldArea.split("_")
			var _tile:Object = _tileGroupModel.getChildByName("tile_" + _fieldAreaArray[0] + "_" + _fieldAreaArray[1])
				
			//_buildingHolder.setFieldArea(getFieldArea)
			_buildingHolder.name = _item
			addChild(_buildingHolder)
			
			
			_buildingHolder.setTileInfo(getFieldArea)
			_buildingHolder.setHSize(_hSize)
			_buildingHolder.setWSize(_wSize)
			_buildingHolder.setIdx(_idx)
			_buildingHolder.changePosition(_tile.x,_tile.y)
			//_buildingHolder.analyzePlaceByRebuild(_tile,_idx)
			_buildingHolder.visibilityBase(false)			
			_buildingHolder.occupyFieldArea();
			_buildingHolder.swapWithOthers();
				
				*/
		}
		
		
		
		
		private function placeByStartDragging(_item:String,placeType:String,getFieldArea:String):void 
		{
			/*var _buildingHolder:BuildingHolderModel = new BuildingHolderModel(_item,true,placeType)
			_buildingHolder.name = _item
			
			addChild(_buildingHolder)*/
		}
		
		private function placeByTileHit(_item:String,placeType:String,getFieldArea:String):void 
		{
			/*var _buildingHolder:BuildingHolderModel = new BuildingHolderModel(_item,true,placeType)
			_buildingHolder.name = _item
			
			addChild(_buildingHolder) */
		}
		
		
		public function placeHorseOnWorld(tile_x:Number, tile_y:Number):void 
		{
			var _horseHolder:HorseHolderModel = new HorseHolderModel()
			_horseHolder.name = "horse_" + HORSE_ID
			addChild(_horseHolder)
			
			_horseHolder.initHolder();
			
			incrementHorseId();
			_horseHolder.teleport(tile_x, tile_y)
		}
		
		private function incrementHorseId(): void 
		{
			HORSE_ID += 1
		}
		
		public function placeJockeyOnWorld(_item:String):void 
		{
			var _jockeyHolder:JockeyHolderModel = new JockeyHolderModel(_item)
			_jockeyHolder.name = _item
			addChild(_jockeyHolder)
		}
		
		
		
		
		public function centerToTheWorld():void 
		{
			var _worldView:Object = parent
			var center_x:Number = 1480 //_worldView.width/2
			var center_y:Number = 250
				
			changePosition(center_x,center_y)
		}
		
		public function changePosition(pos_x:Number,pos_y:Number):void 
		{
			x = pos_x
			y = pos_y
		}
		
		
	}
}