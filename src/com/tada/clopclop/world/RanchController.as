package com.tada.clopclop.world
{
	import com.greensock.TweenLite;
	import com.tada.clopclop.PlayerGlobalData;
	import com.tada.clopclop.datamodels.Building;
	import com.tada.clopclop.datamodels.Ranch;
	import com.tada.clopclop.dataproviders.BuildingDataProvider;
	import com.tada.clopclop.events.ItemEvent;
	import com.tada.clopclop.events.NavigationEvent;
	import com.tada.clopclop.events.RedecorateEvent;
	import com.tada.clopclop.popups.BuildingManagementPopup;
	import com.tada.clopclop.toolsets.clopclopconnection.ClopClopConnection;
	import com.tada.engine.TEngine;
	import com.tada.engine.iso.IsoBase;
	import com.tada.engine.iso.IsoObject;
	import com.tada.utils.debug.Console;
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObjectContainer;

	public class RanchController extends IsoBase{
		public static const SIMULATION:String = "SIMULATION";
		public static const REDECORATE:String = "REDECORATE";
		
		public var isDraggingAnItem:Boolean = false;
		
		public var tileWidth:Number;
		public var tileHeight:Number;
		
		public var scrollX:Number;
		public var scrollY:Number;
		
		public var state:String;
		
		private var _worldView:RanchView;
		
		private var _tileWidthOnScreen:int = 64;
		private var _tileHeightOnScreen:int = 32;
		
		private var _isoObjectList:Array;
		private var _3DObjectList:Array;
		
		private var _3DTestObjects:Array;
		private var _horseTest:Iso3DItem;
		private var _jockeyTest:Iso3DItem;
		
		private var _buildingDP:BuildingDataProvider;
		
		private var _ranchModel:Ranch;
		
		public function RanchController(parent:DisplayObjectContainer)
		{
			super(parent);
			
			this.cols = 20;
			this.rows = 20;
			
			initGrid(cols, rows);
									
			_worldView = new RanchView(this);
				
			_worldView.tileWidth = _worldView.tileHeight = mapToIsoWorld(46.40, 0).x;
			
			tileWidth = _worldView.tileWidth;
			tileHeight = _worldView.tileHeight;
			
			_isoObjectList = [];
			_3DObjectList = [];
				
			addListeners();
			
			Console.registerCommand("add3DObjects", addTest3DObjects, "try to add 3d objects to the world");
			Console.registerCommand("remove3DObjects", remove3DTestObject, "try to add 3d objects to the world");
		}	
		
		public function set buildingDP(buildingDP:BuildingDataProvider):void{
			Logger.print(this, "Setting buildingDP to " + buildingDP);
			_buildingDP = buildingDP;
		}
		
		public function get buildingDP():BuildingDataProvider{
			return _buildingDP;
		}
		
		public function get tilesGrid():Array{
			return tilegrid;
		}
		
		public function checkValid(itemB:IsoItem):Boolean{
			var collided:int = 0;
			
			//Check for boundaries
			if(itemB.col < 0 || itemB.row < 0 ||
				(itemB.col + itemB.cols) > cols ||
				(itemB.row + itemB.rows) > rows){
				if(itemB is BuildingItem){
					(itemB as BuildingItem).canBuild = false;
				}
				itemB.visibleBase = true;
				collided++;
			}
			
			//Check for collision with other objects
			for each(var itemA:IsoItem in _isoObjectList){
				if(itemA.col < itemB.col + itemB.cols &&
					itemA.col + itemA.cols > itemB.col &&
					itemA.row < itemB.row + itemB.rows &&
					itemA.row + itemA.rows > itemB.row){						
						if(itemB is BuildingItem){
							(itemB as BuildingItem).canBuild = false;
						}
						itemA.visibleBase = true;						
						collided++;
				}else{
					itemA.visibleBase = false;
					if(itemA is BuildingItem){
						(itemA as BuildingItem).canBuild = true;
					}
				}
			}
			
			if(collided > 0){
				if(itemB is BuildingItem){
					(itemB as BuildingItem).canBuild = false;
				}
				itemB.visibleBase = true;
			}else{
				if(itemB is BuildingItem){
					(itemB as BuildingItem).canBuild = true;
				}
			}
			if(itemB is BuildingItem){
				return (itemB as BuildingItem).canBuild;
			}
			return false;
		}								
		
		public function updateObjects():void{
			for each(var isoItem:IsoItem in _isoObjectList){
				if(isoItem is BuildingItem){
					(isoItem as BuildingItem).update(1);
				}else{
					if(isoItem is Iso3DItem && state != REDECORATE){
						(isoItem as Iso3DItem).update();
					}
				}
			}
		}
		
		public function addBuildingToWorld(isoItem:IsoItem):void{
			Logger.print(this, "Adding Building at: " + isoItem.col + ","+ isoItem.row);						
			_isoObjectList.push(isoItem);			
			//Sort the items
			sortItems();
			_worldView.updateBuildingList(_isoObjectList);
			Logger.print(this, "Update the buildings in the view");
		}
		
		public function add3DToWorld(isoItem:IsoItem):void{
			//Add the iso3d to the world
			_isoObjectList.push(isoItem);
			//Add it to the 3d list so we can remove it later
			_3DObjectList.push(isoItem);
			sortItems();
			_worldView.updateBuildingList(_isoObjectList);
			Logger.print(this, "Adding a 3D object to the world");
		}
		
		public function addTest3DObjects():void{
			_3DTestObjects = [];
			for(var i:int = 0; i < 6; i++){
				var item:Iso3DItem = new Iso3DItem("Horse", 21, i*2, 1, 1);
				var item2:Iso3DItem = new Iso3DItem("Jockey", i*2, 21, 1, 1); 
				add3DToWorld(item);
				add3DToWorld(item2);
				_3DTestObjects.push(item);
				_3DTestObjects.push(item2);
			}
		}
		
		public function remove3DTestObject():void{
			_3DTestObjects = [];
			removeAll3DObjects();
			_3DObjectList = [];
			add3DToWorld(_horseTest);
			add3DToWorld(_jockeyTest);
		}
		
		public function start(parent:DisplayObjectContainer, buildingDP:BuildingDataProvider):void{
			this.buildingDP = buildingDP;
			
			_worldView.start(parent);
			_worldView.renderGrid(tilegrid);
			
			Logger.print(this, "Total Length of Buildings: " + PlayerGlobalData.ranch.buildings.length);
			
			_ranchModel = PlayerGlobalData.ranch;
			for(var i:int = 0; i < _ranchModel.buildings.length; i++){
				var building:Building = _ranchModel.buildings[i];
				var buildable:BuildingItem = new BuildingItem(building);
				
				if(buildable.col < 0 && buildable.row < 0){
					//TODO: Add Item to storage
					Logger.print(this, "Build_ID: " + buildable.worldId + " is sent to storage");
				}else{
					buildable.world = this;
					buildable.initOnWorld();
					
					if(building.category == Building.TILES){
						tilegrid[building.col][building.row] = building.id;
					}else{
						addBuildingToWorld(buildable);
					}
				}	
			}

			_horseTest = new Iso3DItem("Horse", 14, 9, 1, 1);
			_jockeyTest = new Iso3DItem("Jockey", 16, 9, 1,1);
			add3DToWorld(_horseTest);
			add3DToWorld(_jockeyTest);
			//addTest3DObjects();
			
			addListeners();
		}
		
		private function sortItems():void{
			var list:Array = _isoObjectList.slice(0);
			
			_isoObjectList = [];
			
			for (var i:int = 0; i < list.length;++i) {
				var nsi:IsoObject = list[i];
				
				var added:Boolean = false;
				for (var j:int = 0; j < _isoObjectList.length;++j ) {
					var si:IsoObject = _isoObjectList[j];
					
					if (nsi.col <= si.col+si.cols-1 && nsi.row <= si.row+si.rows-1) {
						_isoObjectList.splice(j, 0, nsi);
						added = true;
						break;
					}
				}
				if (!added) {
					_isoObjectList.push(nsi);
				}
			}
		}
		
		private function removeItemFromList(isoItem:IsoItem):void{			
			for(var i:int = 0; i < _isoObjectList.length; i++){
				if(_isoObjectList[i] == isoItem){					
					_isoObjectList.splice(i,1);
					break;
				}
			}						
		}
		
		private function removeAll3DObjects():void{
			for(var i:int = 0; i < _3DObjectList.length; i++){
				Logger.print(this, "Removing 3D object");
				removeItemFromList(_3DObjectList[i]);
			}
		}
		
		private function repushAll3DObjects():void{
			for(var i:int = 0; i < _3DObjectList.length; i++){
				_isoObjectList.push(_3DObjectList[i]);
			}
		}
		
		private function addListeners():void{
			TEngine.mainClass.addEventListener(ItemEvent.ITEM_SELECTED, onItemSelected);
			TEngine.mainClass.addEventListener(NavigationEvent.REDECORATE, onRedecorateMode);
			TEngine.mainClass.addEventListener(NavigationEvent.REDECORATE_DONE, onDoneRedecorate);
			TEngine.mainClass.addEventListener(RedecorateEvent.ROTATE, onRedecorateEvent);
			TEngine.mainClass.addEventListener(RedecorateEvent.SELL, onRedecorateEvent);
			TEngine.mainClass.addEventListener(RedecorateEvent.STORAGE, onRedecorateEvent);
			TEngine.mainClass.addEventListener(RedecorateEvent.MOVE, onRedecorateEvent);
		}
		
		private function onRedecorateEvent(evt:RedecorateEvent):void{
			switch(evt.type){
				case RedecorateEvent.MOVE:
					state = REDECORATE;
					var moveItem:BuildingItem = evt.redecoratedItem;
					evt.redecoratedItem.state = Building.REDECORATING;
					removeItemFromList(moveItem);
					_worldView.showRedecorateView();
					_worldView.redecorateBuilding(moveItem, true);
					moveItem.visibleBase = true; 
					break;
				case RedecorateEvent.ROTATE:
					var item:BuildingItem = evt.redecoratedItem;
					removeItemFromList(item);
					if(checkValid(item)){
						ClopClopConnection.instance.setMyBuildingMove(onItemRotated, PlayerGlobalData.dbId, item.worldId, item.col +"_"+item.row, item.rotation);
						addBuildingToWorld(item);						
					}else{
						state = REDECORATE;
						evt.redecoratedItem.state = BuildableItem.REDECORATING;
						removeItemFromList(item);
						_worldView.showRedecorateView();
						_worldView.redecorateBuilding(item, true);
						
					}					
					break;
				case RedecorateEvent.SELL:
					removeItemFromList(evt.redecoratedItem);
					Logger.print(this, "Selling " + evt.redecoratedItem.worldId);
					TEngine.mainClass.dispatchEvent(new ItemEvent(ItemEvent.ITEM_SOLD, evt.redecoratedItem.model));
					ClopClopConnection.instance.setMyBuildingSell(onItemSold, PlayerGlobalData.dbId, evt.redecoratedItem.worldId);
					TweenLite.to(evt.redecoratedItem.displayObject, .5, {alpha: 0, onComplete: 
						function():void{
							_worldView.updateBuildingList(_isoObjectList);
						}});
					break;
				case RedecorateEvent.STORAGE:
					Logger.print(this, "Removing " + evt.redecoratedItem.worldId);
					ClopClopConnection.instance.setMyBuildingStorage(null, PlayerGlobalData.dbId, evt.redecoratedItem.worldId);
					TweenLite.to(evt.redecoratedItem.displayObject, .5, {alpha: 0, onComplete: 
						function():void{
							_worldView.updateBuildingList(_isoObjectList);
						}});					
					break;				
			}
		}
		
		private function onItemSold(res:Array):void{
			Logger.debug(this, "onItemSold", "Sold! " + res);
		}
		
		private function onItemRotated(res:Array):void{
			Logger.debug(this, "onItemRotated", "Rotated Item!");
		}
		
		private function onRedecorateMode(evt:NavigationEvent):void{
			state = REDECORATE;
			removeAll3DObjects();
			sortItems();
			_worldView.updateBuildingList(_isoObjectList);
			_worldView.showRedecorateView();
		}
		
		private function onDoneRedecorate(evt:NavigationEvent):void{
			state = SIMULATION;			
			repushAll3DObjects();
			sortItems();
			_worldView.updateBuildingList(_isoObjectList);
			_worldView.hideRedecorateView();
		}
		
		private function onItemSelected(evt:ItemEvent):void{
			var model:Building = evt.model.clone() as Building;
			Logger.print(this, "Selected: " + model.buildName + " | THUMB: " + model.thumbnailURL + " | MC: " + model.mcClass);
			var isoItem:BuildingItem;
				
			isoItem = new BuildingItem(model);			
			isoItem.world = this;
			isoItem.initOnWorld();
			
			if(model.category == Building.TILES){
				_worldView.startTileSelect(isoItem);
			}else{
				_worldView.redecorateBuilding(isoItem, false);
			}
			
			isDraggingAnItem = true;
		}
		
	
	}
}