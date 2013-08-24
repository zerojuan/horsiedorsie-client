package com.tada.clopclop.world
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class WorldView extends Sprite
	{
		private var _world:World;
		private var _tileGroupModel:TileGroupModel;
		private var _assetGroupModel:AssetGroupModel;
		
		private static const LIMIT_X_LF:Number = -52
		private static const LIMIT_X_RT:Number = -2340
		private static const LIMIT_Y_UP:Number = -80 
		private static const LIMIT_Y_DN:Number = -1300
			
		private var DOWN_ON_WORLD:Boolean
		
		public function WorldView()
		{
		}
		
		public function initWorldView():void 
		{
			inheritWorld(0,0);
		
			addListeners();
		
		}
		
		public function spawnHorse(tile_x:Number, tile_y:Number):void 
		{
			_assetGroupModel.placeHorseOnWorld(tile_x,tile_y)
		}
		
		public function changePosition(pos_x:Number, pos_y:Number):void 
		{
			x = pos_x
			y = pos_y
		}
		
		public function changeMode(value:String):void 
		{
			_tileGroupModel.changeMode(value)
		}
		
		public function removePopupInfos():void 
		{
			_assetGroupModel.removePopupInfos();
		}
		public function createTileGroup(tile_multiple:Number):void 
		{
			inheritTileGroup(tile_multiple);
			
			
			
		}
		private function inheritAssetGroup():void 
		{
			_assetGroupModel = new AssetGroupModel()
			_assetGroupModel.name = "_assetGroupModel"
			addChild(_assetGroupModel)
			
			_assetGroupModel.centerToTheWorld();
			
			
		}
		
		private function inheritTileGroup(tile_multiple:Number):void 
		{
			_tileGroupModel = new TileGroupModel()
			_tileGroupModel.name = "_tileGroupModel"
			addChild(_tileGroupModel)
			
			_tileGroupModel.populateWithTileModel(tile_multiple)
			_tileGroupModel.centerToTheWorld();
			
			inheritAssetGroup();
		}
		
		private function inheritWorld (pos_x:Number,pos_y:Number):void 
		{
			_world = new World;
			_world.name = "_world";
			addChild(_world);
			
			x = pos_x;
			y = pos_y;
			
			changePosition(-1100,-80);
		}
		
		private function addListeners():void 
		{
			addEventListener(MouseEvent.MOUSE_DOWN, startDragWorld);
			addEventListener(MouseEvent.MOUSE_UP, stopDragWorld);
			addEventListener(MouseEvent.MOUSE_MOVE, moveWorld);
			
			_world.addEventListener(MouseEvent.CLICK,clickWorld)
			
		}
		
		//mouse listener functions		
		
		private function clickWorld(me:MouseEvent):void 
		{
			_assetGroupModel.removePopupInfos();
		}
		private function startDragWorld(me:MouseEvent):void 
		{
			startDraggingTheWorld();			
		}
		
		private function stopDragWorld(me:MouseEvent):void 
		{
			dropTheWorld();			
		}
		
		private function moveWorld(me:MouseEvent):void 
		{
			if(DOWN_ON_WORLD == true) {
				analyzeTheWorldPosition(x,y);
			}
		}
		
		
		
		private function startDraggingTheWorld():void 
		{
			//start dragging
			startDrag();
			DOWN_ON_WORLD = true
			
			
			
			
		}
		
		private function dropTheWorld():void 
		{
			//drop the world
			stopDrag();
			DOWN_ON_WORLD = false
		}
		
		private function analyzeTheWorldPosition(pos_x:Number, pos_y:Number):void 
		{
			if(y >= LIMIT_Y_UP) {
				y = LIMIT_Y_UP
			}
			if(y <= LIMIT_Y_DN) {
				y = LIMIT_Y_DN
			}
			if(x >= LIMIT_X_LF) {
				x = LIMIT_X_LF
			}
			if(x <= LIMIT_X_RT) {
				x = LIMIT_X_RT
			}
		}
		
		
	}
}