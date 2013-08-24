package com.tada.clopclop.world
{
	import flash.display.MovieClip;

	public class TileModel extends MovieClip
	{
		private var _tile:Tile
		
		public var OCCUPIED:Boolean = false
		
		public function TileModel()
		{
			inheritTile();
		}
		
		private function  inheritTile():void 
		{
			_tile = new Tile
			_tile.name = "_tile"
			addChild(_tile)
			
			changeMode("redecorate")
		}
		
		public function setOccupied(value:Boolean):void 
		{
			OCCUPIED = value
		}
		
		public function changeMode(mode:String):void 
		{
			_tile.tileStatus.gotoAndStop(2);
		}
		
		public function setName(set_name:String):void 
		{
			_tile.txtName.text = set_name
		}
		
		public function changePosition(pos_x:Number,pos_y:Number):void 
		{
			x = pos_x
			y = pos_y
		}
		
		public function setTileVisibility(value:Boolean):void 
		{
			visible = value
		} 
		
		public function getTileXY():String 
		{
			var get_xy:String
			
			var nameArray:Array = name.split("_")
			get_xy = nameArray[1] + "_" + nameArray[2]
			
			return get_xy
			
		}
	}
}