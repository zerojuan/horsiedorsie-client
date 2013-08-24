package com.tada.clopclop.world
{
	import com.tada.clopclop.common.assets.BuildingHolderModel;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class TileGroupModel extends Sprite
	{
		private static const _tileWidth:Number = 46.40
		private static const _tileHeight:Number = 19.15	
			
		public function TileGroupModel()
		{
			//populateWithTileModel(tile_multiple)
			
			addListener();
		}
		
		private function addListener():void 
		{
			addEventListener(MouseEvent.CLICK,clickTileGroup)
		}
		private function clickTileGroup(me:MouseEvent):void 
		{
			var _assetGroupModel:Object = parent.getChildByName("_assetGroupModel")
			_assetGroupModel.removePopupInfos();
		}
		
		public function populateWithTileModel (tile_multiple:Number):void
		{
			
			
			for (var iy:Number=0; iy<tile_multiple; iy++) {				
				for (var ix:Number=0; ix<tile_multiple; ix++) {
					
					var pos_x:Number = (-((_tileWidth/2) * ix)) + (_tileWidth/2 * iy)
					var pos_y:Number = ((_tileHeight/2) * ix) + (_tileHeight/2 * iy)	
						
					inheritTileModel(pos_x,pos_y,ix,iy);
				}
			}
			
			/* once laying of tile is complete center tile group*/
			
		}
		
		
		
		public function changeMode(value:String):void 
		{
			for (var i:Number=0; i<numChildren; i++) {
				var _tileHolder:Object = getChildAt(i)
				_tileHolder.changeMode(value)
			}
		}
		
		public function placeOnWorld():void 
		{
			var _redecorateController:Object = parent.parent.getChildByName("_redecorateController")
			var _item:String = _redecorateController.CURRENT_SELECTED + "_" + 	(_redecorateController.CURRENT_ID)
		
			//var _buildingHolder:BuildingHolderModel = new BuildingHolderModel(_item,true,"byplace")
			//_buildingHolder.name = _item
			//addChild(_buildingHolder)
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
		
		private function inheritTileModel(pos_x:Number, pos_y:Number, id_x:Number, id_y:Number) :void 
		{
			var _tileModel:TileModel = new TileModel
			_tileModel.name = "tile_" + id_x + "_" + id_y
			_tileModel.changePosition(pos_x,pos_y)
			addChild(_tileModel)
			
			_tileModel.setName(id_x + "_" + id_y)
			
		}
	}
}