package com.tada.clopclop.world
{
	import com.greensock.TweenLite;
	import com.tada.clopclop.PlayerGlobalData;
	import com.tada.clopclop.datamodels.Building;
	import com.tada.clopclop.dataproviders.BuildingDataProvider;
	import com.tada.clopclop.events.ItemEvent;
	import com.tada.clopclop.popups.ConfirmBuyPopup;
	import com.tada.clopclop.toolsets.clopclopconnection.ClopClopConnection;
	import com.tada.engine.TEngine;
	import com.tada.engine.iso.Coordinate;
	import com.tada.engine.rendering.SwfVectorCache;
	import com.tada.engine.resource.Resource;
	import com.tada.utils.GameUtil;
	import com.tada.utils.debug.Logger;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class RanchView extends Sprite
	{
		public var ranchControl:RanchController;
		
		public var tileWidth:Number;
		public var tileHeight:Number;
		
		public var origin:Point = new Point(800,200);
		
		private var _currMouseGrid:Coordinate = new Coordinate();
		private var _currItemGrid:Coordinate = new Coordinate();
		
		//flag, so we don't immediately show a popup. 
		//Since the mouse up listener might confuse the click from the build icons as a click to confirm
		private var _underBufferTime:Boolean = true; 
		private var _waitingForConfirm:Boolean = false;
		
		//layers
		private var _background:World;
		private var _gridLayer:Sprite;
		private var _tileLayer:Bitmap;
		private var _tileDragLayer:Bitmap;
		private var _objectsLayer:Sprite;
		private var _dragLayer:Sprite;
		
		//Flag if the object i'm dragging is already bought or not 
		private var _isBought:Boolean; 
		
		//the tile being added
		private var _tileItem:BuildingItem;
		private var _tileBuildingPhase:int = 0;
		private var _tempTileArray:Array = [];
		private var _tileAddOrigin:Point = new Point();
		private var _tileAddEnd:Point = new Point();
		
		//the current item that is on the dragLayer
		private var _currentItem:BuildingItem;
		
		//the item on limbo (waiting for the reply from server)
		private var _pendingItem:BuildingItem;
		
		//TODO: Create a popup manager for things like this
		private var _confirmBuyPopup:ConfirmBuyPopup;
		
		//Limits for the screen	
		private static const LIMIT_X_LF:Number = -52;
		private static const LIMIT_X_RT:Number = -2340;
		private static const LIMIT_Y_UP:Number = -40;
		private static const LIMIT_Y_DN:Number = -1300;
		
		//variable for dragging
		private var _isDragging:Boolean = false;		
		private var _startDragPosition:Point;
		private var _endDragPosition:Point;
		private var _worldDragged:Boolean = true;
		
		public function RanchView(isoWorld:RanchController){
			this.ranchControl = isoWorld;
		}				
		
		public function start(parent:DisplayObjectContainer):void{
			Logger.print(this, "Tile: " + tileWidth + "x" + tileHeight);
			
			parent.addChild(this);
			
			//create background
			_background = new World();
			_background.horseRacingStadium.addEventListener(MouseEvent.CLICK, onStadiumClicked);
			
			//set the (0,0,0) point in the scene
			origin.x = 1565.6;//_background.width / 2;
			origin.y = 234.3;
			
			//create isometric grid
			_gridLayer = new Sprite();
			_gridLayer.x = origin.x;
			_gridLayer.y = origin.y;			
			
			//create layer for the objects
			_objectsLayer = new Sprite();
			_objectsLayer.x = origin.x;
			_objectsLayer.y = origin.y;
			
			//create the layer for floor tiles
			_tileLayer = new Bitmap();
			//_tileLayer.x = origin.x;
			_tileLayer.y = origin.y;
			_tileLayer.bitmapData = new BitmapData(1000+origin.x, 1000, true, 0x00000000);
			
			//create the layer for temp floor tiles
			_tileDragLayer = new Bitmap();
			//_tileDragLayer.x = origin.x - 500;
			_tileDragLayer.y = origin.y;// - 1000;
			_tileDragLayer.bitmapData = new BitmapData(1000+origin.x, 1000, true, 0x00000000);
			
			//create layer for dragging
			_dragLayer = new Sprite();
			_dragLayer.x = origin.x;
			_dragLayer.y = origin.y;
			
			
			
			changePosition(-1170,-60);
			
			addChild(_background);
			addChild(_gridLayer);
			addChild(_tileLayer);
			addChild(_tileDragLayer);
			addChild(_objectsLayer);
			addChild(_dragLayer);
			
			//TODO: Create a popup manager for these kinds of things
			_confirmBuyPopup = new ConfirmBuyPopup();
			
			_gridLayer.alpha = 0;
			
			//renderTileGrid();
			
			addEventListeners();
		}		
		
		public function redecorateBuilding(buildingItem:BuildingItem, isBought:Boolean):void{
			_isBought = isBought;
			if(_isBought){
				_objectsLayer.removeChild(buildingItem.displayObject);
			}
			buildingItem.displayObject.x = 0;
			buildingItem.displayObject.y = 0;
			showDragItem(buildingItem);
		}				
		
		public function updateBuildingList(objectList:Array):void{			
			GameUtil.removeAllChildren(_objectsLayer);
			
			for(var i:int = 0; i < objectList.length; i++){
				var item:IsoItem = objectList[i];
				var isoCoord:Point = getGlobalFromGridCoord(new Coordinate(item.col, 0, item.row));
				//Adjust the coordinates based on the x and y of the objects layer
				isoCoord.x -= _objectsLayer.x;
				isoCoord.y -= _objectsLayer.y;
				
				item.displayObject.x = isoCoord.x;
				item.displayObject.y = isoCoord.y;
				
				item.displayObject.alpha = 1;
				item.visibleBase = false;
				
				_objectsLayer.addChildAt(item.displayObject, i);
			}
			
		}
		
		public function showRedecorateView():void{
			TweenLite.to(_gridLayer, .2, {alpha: 1});
		}
		
		public function hideRedecorateView():void{
			_confirmBuyPopup.hidePopup();
			hideDragItem();
			TweenLite.to(_gridLayer, .2, {alpha: 0});
		}
		
		public function renderGrid(grid:Array, color:uint = 0xaa0000):void{
			var col:int = grid.length;
			var rows:int = grid[0].length;
			var i:int = 0;
			var j:int = 0;
			var tx:Number;
			var tz:Number;
			var coord:Coordinate;
			var originCoord:Coordinate;						
						
			for(i = 0; i <= col; i++){
				tx = i * tileWidth;
				tz = -col * tileHeight;				
				coord = ranchControl.mapToScreen(tx, 0, tz);
				originCoord = ranchControl.mapToScreen(tx, 0, 0);				
				with(_gridLayer){
					graphics.lineStyle(1, color, .2);	
					graphics.moveTo(originCoord.x, originCoord.y);
					graphics.lineTo(coord.x, coord.y);
				}
			}						
			
			for(j = 0; j <= rows; j++){
				tx = rows * tileWidth;
				tz = -j * tileHeight;				
				coord = ranchControl.mapToScreen(tx, 0, tz);
				originCoord = ranchControl.mapToScreen(0, 0, tz);
				
				with(_gridLayer){
					graphics.lineStyle(1, color, 0.2);	
					graphics.moveTo(originCoord.x, originCoord.y);
					graphics.lineTo(coord.x, coord.y);
				}
			}						
		}
		public function startTileSelect(tile:BuildingItem):void{
			Logger.print(this, "Starting Tile Selection");
			if(_tileItem){
				//_dragLayer.removeChild(_tileItem.displayObject);
				_tileItem = null;
			}
			_tileBuildingPhase = 1; //phase 1 of tile building
			_tileItem = tile;
			_tempTileArray = GameUtil.cloneArray(ranchControl.tilesGrid);
			_underBufferTime = true;
			TweenLite.to(_tileItem.displayObject, .5,  {alpha: .5, onComplete: 
				function():void{
					_underBufferTime = false;
				}});
		}
		
		/**
		 * Show the drag item into the world
		 */
		public function showDragItem(item:BuildingItem):void{			
			if(_currentItem){
				//remove previous item we were dragging
				_dragLayer.removeChild(_currentItem.displayObject);
				_currentItem = null;
			}
			_currentItem = item;			
			_dragLayer.addChild(_currentItem.displayObject);
			_underBufferTime = true;
			TweenLite.to(_currentItem.displayObject, .5,  {alpha: .5, onComplete: 
				function():void{
					_underBufferTime = false;
				}});			
		}
		/**
		 * Hide the dragged item
		 */
		public function hideDragItem():void{
			if(_currentItem){
				_dragLayer.removeChild(_currentItem.displayObject);
				_currentItem = null;
				_waitingForConfirm = false;
				ranchControl.isDraggingAnItem = false;
			}
		}
		
		/**
		 * Converts an isometric coordinate to a grid coordinate
		 */
		public function getGridCoord(coord:Coordinate):Coordinate{			
			return new Coordinate(Math.floor(coord.x / tileWidth), 0, -Math.floor(coord.z / tileHeight));			
		}
		/**
		 * Converts a grid coordinate to an isometric coordinate
		 */
		public function getIsoCoord(coord:Coordinate):Coordinate{
			return new Coordinate(coord.x * tileWidth, 0, -coord.z * tileHeight);
		}
		
		/*--------------------------------------------------------------------------*/
		/*					PRIVATE METHODS											*/
		/*--------------------------------------------------------------------------*/
		private function addEventListeners():void{						
			addEventListener(MouseEvent.MOUSE_DOWN, startDragWorld);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopDragWorld);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function removeEventListeners():void{
			removeEventListener(MouseEvent.MOUSE_DOWN, startDragWorld);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragWorld);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onStadiumClicked(evt:MouseEvent):void{
			Logger.print(this, "Let's go to racing!!");
		}
		private function showBuildConfirmPopup():void{
			_waitingForConfirm = true;
			_confirmBuyPopup.initPopup(_dragLayer, onBuildConfirm, onBuildDeny);
		}
		private function showTileBuildConfirmPopup():void{
			_waitingForConfirm = true;
			_confirmBuyPopup.initPopup(_dragLayer, onTileBuildConfirm, onTileBuildDeny);
		}
		private function onTileBuildConfirm():void{
			_waitingForConfirm = false;
			_confirmBuyPopup.hidePopup();
			//update tile grid
			var fieldInfo:String = "";
			for(var i:int = _tileAddOrigin.x; i <= _tileAddEnd.x; i++){
				for(var j:int = _tileAddOrigin.y; j <= _tileAddEnd.y; j++){
					ranchControl.tilesGrid[i][j] = (_tileItem.model as Building).id;
					fieldInfo += i + "_" + j + ";";
				}
			}
			TEngine.mainClass.dispatchEvent(new ItemEvent(ItemEvent.ITEM_BOUGHT, _tileItem.model, getTileCount(_tileItem)));
			ClopClopConnection.instance.setMyTiles(setMyTileReply, PlayerGlobalData.dbId, (_tileItem.model as Building).id, fieldInfo);
			
			resetTileRedecoration();
		}
		private function onTileBuildDeny():void{
			resetTileRedecoration();
			_waitingForConfirm = false;
			_confirmBuyPopup.hidePopup();
			ranchControl.isDraggingAnItem = false;
			Logger.print(this, "Build Denied");
		}
		private function onBuildConfirm():void{
			_waitingForConfirm = false;
			_confirmBuyPopup.hidePopup();
						
			_currentItem.col = _currItemGrid.x;
			_currentItem.row = _currItemGrid.z;
			
			ranchControl.addBuildingToWorld(_currentItem);
			
			if(!_isBought){
				Logger.print(this, "Attempting to add new building of type: " + _currentItem.typeId);
				_pendingItem = _currentItem; 
				_pendingItem.state = BuildableItem.UNDER_CONSTRUCTION;				
				ClopClopConnection.instance.setMyBuilding(setMyBuildingReply, PlayerGlobalData.dbId, _currentItem.typeId, _currentItem.col +"_" + _currentItem.row);
			}else{
				_pendingItem = _currentItem;
				_pendingItem.state = BuildableItem.FUNCTIONAL;
				ClopClopConnection.instance.setMyBuildingMove(setMyBuildingMove, PlayerGlobalData.dbId, _pendingItem.worldId, _pendingItem.col +"_" + _pendingItem.row, _pendingItem.rotation);
			}
			
			_currentItem = null;
			ranchControl.isDraggingAnItem = false;
		}
		
		private function setMyBuildingMove(results:Object):void{
			_pendingItem = null;
			Logger.debug(this, "setMyBuildingMove", "Reply from setMyBuildingMove: " + results); 
		}
		
		private function setMyBuildingReply(results:Object):void{			
			Logger.print(this, "Building added to DB with id:" + results[0].build_idx);
			TEngine.mainClass.dispatchEvent(new ItemEvent(ItemEvent.ITEM_BOUGHT, _pendingItem.model));
			_pendingItem.worldId = results[0].build_idx;
			_pendingItem.visibleBase = false;
			_pendingItem = null;
			Logger.print(this, "Build Confirmed");
		}
		
		private function setMyTileReply(results:Object):void{
			Logger.print(this, "Successfully Added Tiles");
			//renderTileGrid();
		}
		
		private function resetBuild():void{
			_waitingForConfirm = false;
			_currentItem.loadState();	
			//isoWorld.checkValid(_currentItem);					
			ranchControl.addBuildingToWorld(_currentItem);
			_currentItem.state = BuildableItem.FUNCTIONAL;
			_currentItem.canBuild = true;
			_currentItem = null;
			//_currentItem.visibleBase = false;
		}
		
		private function onBuildDeny():void{
			_waitingForConfirm = false;
			_confirmBuyPopup.hidePopup();
			ranchControl.isDraggingAnItem = false;
			Logger.print(this, "Build Denied");
		}
		
		//mouse listener functions
		private function startDragWorld(me:MouseEvent):void{	
			_isDragging = true;
			
			_startDragPosition = new Point();
			_startDragPosition.x = mouseX;
			_startDragPosition.y = mouseY;
			
			_worldDragged = false;
		}
		
		private function stopDragWorld(me:MouseEvent):void{			
			_isDragging = false;
			if(!_worldDragged){
				if(_currentItem){
					if(_currentItem.canBuild && !_underBufferTime){
						if(_isBought){
							onBuildConfirm();
						}else{
							showBuildConfirmPopup();
						}				
					}else{ //can't build
						if(_isBought){
							resetBuild();
						}
					}
				}else if(_tileItem){ //if i'm dragging a tile
					if(isOutOfBounds(_currMouseGrid.x, _currMouseGrid.z)){
						resetTileRedecoration();
					}
					
					_tileBuildingPhase++;
					if(_tileBuildingPhase == 3){
						showTileBuildConfirmPopup();
					}
				}
			}
			
		}
		
		private function resetTileRedecoration():void{
			_tileBuildingPhase = 0;
			ranchControl.isDraggingAnItem = false;
			_tileDragLayer.bitmapData.fillRect(new Rectangle(0, 0, 3000, 1000), 0x00000000);
			_tileItem = null;
		}
		
		private function getGridCoordFromGlobal():Coordinate{
			var gridCoord:Coordinate = getGridCoord(ranchControl.mapToIsoWorld(_gridLayer.mouseX, _gridLayer.mouseY));
			//gridCoord.y -= 1;
			return gridCoord;			
		}
		
		private function getGlobalFromGridCoord(gridCoord:Coordinate):Point{
			//Get actual ISO coordinate 
			var _isoCoord:Coordinate = getIsoCoord(gridCoord);
			//Convert to screen coordinates
			var _screenCoord:Coordinate = ranchControl.mapToScreen(_isoCoord.x, _isoCoord.y, _isoCoord.z)
			//Get actual screen coordinates based on the gridLayer
			var _layerPoint:Point = _gridLayer.localToGlobal(new Point(_screenCoord.x, _screenCoord.y));
			_layerPoint.x -= x;
			_layerPoint.y -= y;
			
			return _layerPoint;
		}
		
		private function onEnterFrame(evt:Event):void{
			if(_isDragging){
				var endPosition:Point = new Point();
				
				endPosition.x = mouseX;
				endPosition.y = mouseY;
				
				var delta:Point = _startDragPosition.subtract(endPosition);								
				
				//In our dragging, if we actually moved the screen we flag it,
				//so we can distinguish between a click and a drag
				if(!_worldDragged){					
					_worldDragged = !(delta.x == 0 && delta.y == 0);
				}
				
				changePosition(x - delta.x, y - delta.y);
				clampBounds();
			}
			
			if(_currentItem){		
				if(!_waitingForConfirm){
					//Adjust the item's grid so that the mouse is at the center
					_currMouseGrid = getGridCoordFromGlobal();
					
					_currItemGrid.x = _currMouseGrid.x - (Math.floor(_currentItem.cols / 2));
					_currItemGrid.z = _currMouseGrid.z - (Math.floor(_currentItem.rows / 2));
									
					var coord:Point = getGlobalFromGridCoord(_currItemGrid);					
					
					_dragLayer.x = coord.x;
					_dragLayer.y = coord.y;
					_currentItem.col = _currItemGrid.x;
					_currentItem.row = _currItemGrid.z;			
										
					ranchControl.checkValid(_currentItem as BuildingItem);
				}
			}else if(_tileItem){
				if(!_waitingForConfirm){
					
					_currMouseGrid = getGridCoordFromGlobal();
					
					_currItemGrid.x = _currMouseGrid.x - (Math.floor(_tileItem.cols / 2));
					_currItemGrid.z = _currMouseGrid.z - (Math.floor(_tileItem.rows / 2));
					
					var coord2:Point = getGlobalFromGridCoord(_currItemGrid);	
					if(_tileBuildingPhase == 1){ //The user haven't clicked on anything yet
						_tileItem.col = _currItemGrid.x;
						_tileItem.row = _currItemGrid.z;
						updateTempLayer(_currItemGrid.x, _currItemGrid.z, _tileItem); 
					}else if(_tileBuildingPhase == 2){ //User clicked on an initial location
						//TODO: Update the temp layer array, so that it will be rendered
						//TODO: Calculate the amount you'll need	
						_dragLayer.x = coord2.x;
						_dragLayer.y = coord2.y;
						updateTempLayer(_currItemGrid.x, _currItemGrid.z, _tileItem);
						getTileCount(_tileItem);
					}
				}
			}
			renderTileGrid();
			//renderTempTileGrid();
			ranchControl.updateObjects();
		}
		
		private function changePosition(x:Number,y:Number):void{
			this.x = x;
			this.y = y;
			ranchControl.scrollX = x;
			ranchControl.scrollY = y;
		}
		
		private function updateTempLayer(XX:int, YY:int, item:BuildingItem):void{
			var originX:int = 0;
			var originY:int = 0;
			var destX:int = 0;
			var destY:int = 0;
			if(XX > item.col){
				originX = item.col;
				destX = XX;
			}else{
				originX = XX;
				destX = item.col;
			}
			
			if(YY > item.row){
				originY = item.row;
				destY = YY;
			}else{
				originY = YY;
				destY = item.row;
			}
			
			//check bounds			
			if(originX < 0){
				originX = 0;
			}else if(originX >= ranchControl.tilesGrid.length){
				originX = ranchControl.tilesGrid.length - 1;
			}
			
			if(originY < 0){
				originY = 0;
			}else if(originY >= ranchControl.tilesGrid[0].length){
				originY = ranchControl.tilesGrid[0].length - 1;
			}
			
			if(destX < 0){
				destX = 0;
			}else if(destX >= ranchControl.tilesGrid.length){
				destX = ranchControl.tilesGrid.length - 1;
			}
			
			if(destY < 0){
				destY = 0;
			}else if(destY >= ranchControl.tilesGrid[0].length){
				destY = ranchControl.tilesGrid[0].length - 1;
			}
			
			_tileAddOrigin.x = originX;
			_tileAddOrigin.y = originY;
			_tileAddEnd.x = destX;
			_tileAddEnd.y = destY;
			_tileDragLayer.bitmapData.fillRect(new Rectangle(0, 0, 3000, 1000), 0x00000000);
			Logger.print(this, "Origin: " + originX + ", " + originY + " --- Dest: " + destX + ", " + destY); 
			for(var i:int = originX; i <= destX; i++){
				for(var j:int = originY; j <= destY; j++){					
					renderDuplicateTiles(i, -j, item);
				}
			}
		}
		
		private function renderDuplicateTiles(col:int, row:int, item:BuildingItem):void{
			if(item.bitmapContainer){
				var srcBitmap:BitmapData = item.bitmapContainer.bitmapData;
				var coord:Coordinate = ranchControl.mapToScreen(col * ranchControl.tileWidth, 0, (row-1) * ranchControl.tileHeight);
				_tileDragLayer.bitmapData.copyPixels(srcBitmap, new Rectangle(0, 0, 50, 50), new Point(coord.x + origin.x,coord.y - 11), null, null, true);
			}			
			
		}
		
		private function getTileCount(item:BuildingItem):Number{
			var cols:int = _tileAddEnd.x - _tileAddOrigin.x + 1;
			var rows:int = _tileAddEnd.y - _tileAddOrigin.y + 1;
			var size:int = cols * rows;
			//Logger.print(this, "Size: " + cols + "x" + rows + " = " + cols*rows + "\n\t Total Price: " + (item.model as Building).buyCoinPrice * size);
			return size;// * (item.model as Building).buyCoinPrice;
		}
		
		private function renderTileGrid():void{
			_tileLayer.bitmapData.fillRect(new Rectangle(0, 0, 3000, 1000), 0x00000000);
			for(var i:int = 0; i < ranchControl.tilesGrid.length; i++){
				for(var j:int = 0; j < ranchControl.tilesGrid[i].length; j++){
					if(ranchControl.tilesGrid[i][j] != "_blank_"){
						//Logger.print(this, "Rendering tile");
						var building:Building = ranchControl.buildingDP.getModelById(ranchControl.tilesGrid[i][j]) as Building;
						var vectorCache:SwfVectorCache = BitmapAnimationManager.instance.getVectorCache(building.mcClass, BuildingItem.NORMAL_MC);
						if(vectorCache){
							var bmpData:BitmapData = vectorCache.getSourceFrames()[0] as BitmapData;
							var coord:Coordinate = ranchControl.mapToScreen(i * ranchControl.tileWidth, 0, (-j-1) * ranchControl.tileHeight);
							_tileLayer.bitmapData.copyPixels(bmpData, new Rectangle(0, 0, 50, 50), new Point(coord.x + origin.x,coord.y - 11), null, null, true);
						}
					}
				}
			}
		}
		
		private function isOutOfBounds(x:Number, y:Number):Boolean{
			if(x < 0 || x >= ranchControl.tilesGrid.length){
				return true;
			}
			if(y < 0 || y >= ranchControl.tilesGrid[0].length){
				return true;
			}
			return false;
		}
		
		private function clampBounds():void{
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