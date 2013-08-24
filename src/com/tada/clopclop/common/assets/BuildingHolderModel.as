package com.tada.clopclop.common.assets
{
	import com.tada.clopclop.common.popups.ConfirmBuyPopup;
	import com.tada.clopclop.declarations.BuildingDeclaration;
	import com.tada.clopclop.toolsets.precisehittest.PreciseHitTest;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.clearInterval;
	import flash.utils.getDefinitionByName;
	import flash.utils.setInterval;

	public class BuildingHolderModel extends Sprite
	{
		private var _buildingDeclarations:BuildingDeclaration
		private var _hitInt:uint
		private var _building:MovieClip
		private var _hitTester:PreciseHitTest = new PreciseHitTest
		private var _confirmBuyBuildignModel:ConfirmBuyPopup
		
		
		public var W_SIZE:Number
		public var H_SIZE:Number
		public var TOTAL_SIZE:Number
		public var ON_WORLD:Boolean = false
		public var TILE_IS_HIT:Boolean = false
		public var BASE:String = "bad" 
		public var STARTING_TILE:String
		public var ENDING_TILE:String
		public var SELECTED:String
		public var IDX:Number
		public var ITEM:String
		public var FIELD_AREA:Array = []
		public var OCCUPIED_COUNT:Number = 0	
			
		
		
		//temp array
		private var cursorTileArray:Array = [
			"6_4_5_6",
			"3_1_3_2",
			"1_2_2_2",
			"3_3_2_2",
			"2_1_2_2",
			"2_2_2_2",
			"2_2_2_2",
			"2_2_2_2",
			"1_1_2_2",
		]
		
		
		
		public function BuildingHolderModel(item:String,on_world:Boolean)
		{
			setOnWorld(on_world);
			inheritBuilding(item);
			
			addListeners();
		}
		
		private function setOnWorld(value:Boolean):void 
		{
			ON_WORLD = value
		}

		public function setIdx(value:Number):void 
		{
			IDX = value
		}

		public function setSelected(value:String):void 
		{
			SELECTED = value
		}
		
		private function setTotalSize(value:Number):void 
		{
			TOTAL_SIZE = value
		}
		
		private function addListeners():void 
		{
			addEventListener(MouseEvent.MOUSE_UP,dropBuildingHolder)
		}
		
		private function inheritBuilding(item:String):void 
		{
			_building = new (getDefinitionByName(item) as Class)();			
			_building.name = item;			
			addChild(_building);
			
			setBase("bad");
			startDraggingBuildingHolder();
			startPrecisHitTest();
		}
		
		private function setBase(value:String):void 
		{
			BASE = value
			_building.base.gotoAndStop(BASE)
		}
		
		private function startDraggingBuildingHolder():void 
		{
			startDrag(true);
		}
		
		
		
		public function setWSize(value:Number):void 
		{
			W_SIZE = value
		}
		
		public function setHSize(value:Number):void 
		{
			H_SIZE = value
		}
		
		private function startPrecisHitTest():void 
		{
			_hitInt = setInterval(analyzeHit,1)
		}
		
		private function analyzeHit():void 
		{
			if(ON_WORLD) {
				analyzeHitInsideWorld();
			} else {					
				analyzeHitOutsideWorld();	
			}
		}
		
		private function analyzeHitInsideWorld():void 
		{
			var _worldView:Object = parent.parent
			var _tileGroupModel:Object = _worldView.getChildByName("_tileGroupModel")
			
			for (var i:Number = 0; i<_tileGroupModel.numChildren; i++) {				
				var _tileModel:MovieClip = _tileGroupModel.getChildAt(i)				
				processHit(_tileModel);
			}
		}
		
		private function analyzeHitOutsideWorld():void 
		{
			var _worldView:Object = parent.getChildByName("_worldView")
			var _tileGroupModel:Object = _worldView.getChildByName("_tileGroupModel")
			
			for (var i:Number = 0; i<_tileGroupModel.numChildren; i++) {
				var _tileModel:MovieClip = _tileGroupModel.getChildAt(i)	
				processHit(_tileModel);
			}	
		}
		
		private function processHit(_tileModel:Object):void 
		{
			if(parent != null) {
				if(ON_WORLD) {
					hitInsideWorld(_tileModel);					
				} else {					
					hitOutsideWorld(_tileModel);
				}
			}
		}
		
		private function hitOutsideWorld (_tileModel):void 
		{
			var _hitTester:PreciseHitTest = new PreciseHitTest
			var _hitDetector:Rectangle = (_hitTester.testHitting(_tileModel,_building.detector,0,stage));
			
			if(_hitDetector != null) {
				processTileHit(_tileModel);					
			} else {
				processTileNotHit(_tileModel)				
			}
		
		}
		
		private function processTileHit(_tileModel:Object):void 
		{	
			if(ON_WORLD) {
				snapTileInsideWorld(_tileModel)
				
			} else {
				preciseTileHitOutsideWorld(_tileModel);				
			}				
			
		}
		
		private function processTileNotHit(_tileModel:Object):void 
		{
			
			//_tileModel.setTileVisibility(true)
		}
		
		private function setTileHit(value:Boolean):void 
		{
			TILE_IS_HIT = value
		}
		
		private function hitInsideWorld (_tileModel):void
		{
			var _hitDetector:Rectangle = (_hitTester.testHitting(_tileModel,_building.detector,0,parent));
			
			if(_hitDetector != null) {					
				processTileHit(_tileModel);					
			} else {
				processTileNotHit(_tileModel);
			}
		
		}	
		
		
		private function snapTileInsideWorld(_tileModel:Object):void 
		{
			var _worldView:Object = parent.parent.parent						
			var _redecorateController:Object = _worldView.getChildByName("_redecorateController")
			
			setSelected(_redecorateController.CURRENT_SELECTED);
			setIdx(_redecorateController.CURRENT_ID)
			setItem(SELECTED + "_" + IDX)
			setWSize(_redecorateController.BUILD_LIST[IDX-1]['w_size'])
			setHSize(_redecorateController.BUILD_LIST[IDX-1]['h_size'])
			setTotalSize(W_SIZE * H_SIZE)
			
			changePosition(_tileModel.x,_tileModel.y)
			analyzePlace(_tileModel)
		}
		
		private function analyzePlace(_tileModel:Object):void 
		{
			setStartingEndingTile(_tileModel,cursorTileArray[IDX-1])
		}
		
		
		private function setStartingEndingTile(_tileModel:Object,_cursor:String):void 
		{
			var _tileArray:Array = _tileModel.name.split("_")
			var _tileX:Number = _tileArray[1]
			var _tileY:Number = _tileArray[2]
			
			var _cursorArray:Array = _cursor.split("_")
			var _cursorStartX:Number = _cursorArray[0]
			var _cursorStartY:Number = _cursorArray[1]
			var _cursorEndX:Number = _cursorArray[2]
			var _cursorEndY:Number = _cursorArray[3]
				
			//processing the starting tile
			var _resultStartX:Number = _tileX - _cursorStartX
			var _resultStartY:Number = _tileY - _cursorStartY
			var _startingTile:String =  _resultStartX + "_" + _resultStartY
				
			//processing the ending tile
			var _resultEndX:Number = _tileX + _cursorEndX
			var _resultEndY:Number = _tileY + _cursorEndY			
			var _endingTile:String =  _resultEndX + "_" + _resultEndY
				
			STARTING_TILE = _startingTile
			ENDING_TILE = _endingTile
				
			processFieldArea(STARTING_TILE);
			analyzeBaseStatus(_tileModel)
			//clopclop connection set location
		}
		
		
		
		
		private function preciseTileHitOutsideWorld(_tileModel:Object):void 
		{
			var _worldView:Object = parent.getChildByName("_worldView")
			var _assetGroupModel:Object = _worldView.getChildByName("_assetGroupModel")			
			var _redecorateController:Object = parent.getChildByName("_redecorateController")
			
			setSelected(_redecorateController.CURRENT_SELECTED);
			setIdx(_redecorateController.CURRENT_ID)
			setItem(SELECTED + "_" + IDX)
			
			
			_assetGroupModel.placeBuildingOnWorld(ITEM);
			releaseBuildingHolder();
		}

		

		private function setItem(value:String):void 
		{
			ITEM = value
		}
		
		private function visibility(value:Boolean):void 
		{
			visible = value
		}
		
		
		
		private function changePosition(pos_x:Number,pos_y:Number):void 
		{
			x = pos_x
			y = pos_y
		}
		
		private function mustBeTile(_toAnlyze:String):Boolean 
		{
			var _isTile:Boolean	= false			
			var get_tile:Array  = _toAnlyze.split("_")
				
			if(get_tile[0] == "tile") {
				_isTile = true
			}
			
			return _isTile
		}
		
		private function dropBuildingHolder(me:MouseEvent):void 
		{
			var _targetTile = dropTarget.parent.parent.parent.name
			
			if(ON_WORLD) {
				if(mustBeTile(_targetTile)) {
					
					if(TOTAL_SIZE == OCCUPIED_COUNT) {
						
						
						
						stopDraggingBuildingHolder();
						inheritConfirmBuyModel();
						
						
					} else {
						releaseBuildingHolder();
					}
					
				} else {
					releaseBuildingHolder();
				}				
			} else {
				releaseBuildingHolder();
			}
		}
		
		public function inheritConfirmBuyModel():void 
		{
			_confirmBuyBuildignModel = new ConfirmBuyPopup;
			_confirmBuyBuildignModel.name = "_confirmBuyBuildignModel";
			addChild(_confirmBuyBuildignModel);	
		}
		
		public function removeConfirmBuy():void 
		{
			removeChild(_confirmBuyBuildignModel)
		}
		
		private function processFieldArea(_startingTile:String):void 
		{
			resetOccupiedCount(0);
			
			var _startingTileArray:Array = _startingTile.split("_")
			var _startingTileX:Number = _startingTileArray[0]
			var _startingTileY:Number = _startingTileArray[1]
			var _tileWidth:Number = _startingTileX + W_SIZE
			var _tileHeight:Number = _startingTileY + H_SIZE
			
			for (var iy:Number=_startingTileY; iy<_tileHeight; iy++) {				
				for (var ix:Number=_startingTileX; ix<_tileWidth; ix++) {
					
					setFieldArea(ix + "_" + iy);	
					processTileToOccupy(ix,iy,true);					
					
				}
			}
			
			
		}
		
		private function analyzeBaseStatus(_tileModel:Object):void 
		{
			if(TOTAL_SIZE == OCCUPIED_COUNT) {
				setBase("good")				
			} else {
				setBase("bad")
			}
		}
		
		private function resetOccupiedCount(value:Number):void 
		{
			OCCUPIED_COUNT = value
		}
		
		private function processTileToOccupy(ix:Number,iy:Number,value:Boolean):void 
		{
			var _worldView:Object = parent.parent	
			var _tileGroupModel:Object = _worldView.getChildByName("_tileGroupModel")
			var _tileModel:Object = _tileGroupModel.getChildByName("tile_" + ix + "_" + iy)
			
			if(_tileModel != null) {
				if(_tileModel.OCCUPIED == false) {
					setOccupiedCount();
				}
			}
		}
		
		private function setOccupiedCount():void 
		{
			OCCUPIED_COUNT += 1
		}
		
		private function setFieldArea(_tileArea:String):void 
		{
			FIELD_AREA.push(_tileArea)
		}
		
		private function stopDraggingBuildingHolder():void 
		{
			stopDrag();
		}
		
		private function stopPrecisHitTest():void 
		{
			clearInterval(_hitInt)
		}
		
		public function releaseBuildingHolder():void 
		{
			stopPrecisHitTest();			
			removeBuildingHolder();
		}
		private function removeBuildingHolder():void 
		{
			var _parent:Object = parent
			_parent.removeChild(this)
		}
		
		
	}
}