package com.tada.clopclop.ui
{
	import com.tada.clopclop.Constants;
	import com.tada.clopclop.datamodels.Building;
	import com.tada.clopclop.dataproviders.IDataProvider;
	import com.tada.clopclop.events.ItemEvent;
	import com.tada.clopclop.events.NavigationEvent;
	import com.tada.clopclop.ui.miscellaneous.SelectionInfo;
	import com.tada.engine.TEngine;
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;

	public class RedecorateControls extends EventDispatcher{
		private var _redecorateUI:RedecorateUI;
		private var _activeButton:MovieClip;
		private var _activeType:String;
		private var _selectionItems:Array;
		private var _currentSelectionIndex:int;
		private var _currentMode:String;
		private var _currentMainFunction:MovieClip;			
		
		public static const STORAGE:String = "storage";
		public static const SHOP:String = "store";
		public static const HORSE_INVENTORY:String = "horseInventory";
		
		public static const NEWI:String = "newi";
		public static const BUILDINGS:String = "buildings";
		public static const TILES:String = "tiles";
		public static const GARDENING:String = "gardening";
		public static const FENCES:String = "fences";
		public static const STRUCTURE:String = "structure";
		public static const DECORATION:String = "decoration";
		
		private var _buildingDataProvider:IDataProvider;
		
		public function RedecorateControls(dataProvider:IDataProvider = null){
			_buildingDataProvider = dataProvider;
			_redecorateUI = new RedecorateUI();
			initializeObjects();
		}
		
		public function set dataProvider(dp:IDataProvider):void{
			_buildingDataProvider = dp;
		}
		
		public function get dataProvider():IDataProvider{
			return _buildingDataProvider;
		}
		
		public function showRedecorateControls(parent:DisplayObjectContainer, type:String):void{
			hideRedecorateControls();
			parent.addChild(_redecorateUI);
			switchViewType(type);
			_redecorateUI.x = 0;
			_redecorateUI.y = 527;
			addListeners();
		}
		
		public function hideRedecorateControls():void{
			if(_redecorateUI.parent){
				_redecorateUI.parent.removeChild(_redecorateUI);
			}
			removeListeners();
		}
		
		private function addListeners():void{
			_redecorateUI.browseLeftButton.addEventListener(MouseEvent.CLICK, onLeftClick);
			_redecorateUI.browseRightButton.addEventListener(MouseEvent.CLICK, onRightClick);
			
			_redecorateUI.newi_button.addEventListener(MouseEvent.CLICK, onNewiClicked);
			_redecorateUI.building_button.addEventListener(MouseEvent.CLICK, onBuildingClicked);
			_redecorateUI.tile_button.addEventListener(MouseEvent.CLICK, onTileClicked);
			_redecorateUI.gardening_button.addEventListener(MouseEvent.CLICK, onGardeningClicked);			
			_redecorateUI.fence_button.addEventListener(MouseEvent.CLICK, onFencesClicked);
			_redecorateUI.structure_button.addEventListener(MouseEvent.CLICK, onStructureClicked);
			_redecorateUI.decoration_button.addEventListener(MouseEvent.CLICK, onDecorationClicked);
			
			_redecorateUI.button1.addEventListener(MouseEvent.CLICK, onWindowClick);
			_redecorateUI.button2.addEventListener(MouseEvent.CLICK, onWindowClick);
			_redecorateUI.button3.addEventListener(MouseEvent.CLICK, onWindowClick);
			_redecorateUI.button4.addEventListener(MouseEvent.CLICK, onWindowClick);
			_redecorateUI.button5.addEventListener(MouseEvent.CLICK, onWindowClick);
			_redecorateUI.button6.addEventListener(MouseEvent.CLICK, onWindowClick);
			
			_redecorateUI.DoneButton.addEventListener(MouseEvent.CLICK, onDoneButton);
			
			_redecorateUI.shopButton.addEventListener(MouseEvent.CLICK, onModeClicked);
			_redecorateUI.storageInventoryButton.addEventListener(MouseEvent.CLICK, onModeClicked);
			_redecorateUI.horseInventoryButton.addEventListener(MouseEvent.CLICK, onModeClicked);
			_redecorateUI.shopButton.addEventListener(MouseEvent.MOUSE_OVER, onModeMouseOver);
			_redecorateUI.storageInventoryButton.addEventListener(MouseEvent.MOUSE_OVER, onModeMouseOver);
			_redecorateUI.horseInventoryButton.addEventListener(MouseEvent.MOUSE_OVER, onModeMouseOver);
			_redecorateUI.shopButton.addEventListener(MouseEvent.MOUSE_OUT, onModeMouseOut);
			_redecorateUI.storageInventoryButton.addEventListener(MouseEvent.MOUSE_OUT, onModeMouseOut);
			_redecorateUI.horseInventoryButton.addEventListener(MouseEvent.MOUSE_OUT, onModeMouseOut);
		}
		
		private function removeListeners():void{
			_redecorateUI.browseLeftButton.removeEventListener(MouseEvent.CLICK, onLeftClick);
			_redecorateUI.browseRightButton.removeEventListener(MouseEvent.CLICK, onRightClick);
			
			_redecorateUI.newi_button.removeEventListener(MouseEvent.CLICK, onNewiClicked);
			_redecorateUI.building_button.removeEventListener(MouseEvent.CLICK, onBuildingClicked);
			_redecorateUI.tile_button.removeEventListener(MouseEvent.CLICK, onTileClicked);
			_redecorateUI.gardening_button.removeEventListener(MouseEvent.CLICK, onGardeningClicked);			
			_redecorateUI.fence_button.removeEventListener(MouseEvent.CLICK, onFencesClicked);
			_redecorateUI.structure_button.removeEventListener(MouseEvent.CLICK, onStructureClicked);
			_redecorateUI.decoration_button.removeEventListener(MouseEvent.CLICK, onDecorationClicked);
			
			_redecorateUI.button1.removeEventListener(MouseEvent.CLICK, onWindowClick);
			_redecorateUI.button2.removeEventListener(MouseEvent.CLICK, onWindowClick);
			_redecorateUI.button3.removeEventListener(MouseEvent.CLICK, onWindowClick);
			_redecorateUI.button4.removeEventListener(MouseEvent.CLICK, onWindowClick);
			_redecorateUI.button5.removeEventListener(MouseEvent.CLICK, onWindowClick);
			_redecorateUI.button6.removeEventListener(MouseEvent.CLICK, onWindowClick);
			
			_redecorateUI.DoneButton.removeEventListener(MouseEvent.CLICK, onDoneButton);
			
			_redecorateUI.shopButton.removeEventListener(MouseEvent.CLICK, onModeClicked);
			_redecorateUI.storageInventoryButton.removeEventListener(MouseEvent.CLICK, onModeClicked);
			_redecorateUI.horseInventoryButton.removeEventListener(MouseEvent.CLICK, onModeClicked);
			_redecorateUI.shopButton.removeEventListener(MouseEvent.MOUSE_OVER, onModeMouseOver);
			_redecorateUI.storageInventoryButton.removeEventListener(MouseEvent.MOUSE_OVER, onModeMouseOver);
			_redecorateUI.horseInventoryButton.removeEventListener(MouseEvent.MOUSE_OVER, onModeMouseOver);
			_redecorateUI.shopButton.removeEventListener(MouseEvent.MOUSE_OUT, onModeMouseOut);
			_redecorateUI.storageInventoryButton.removeEventListener(MouseEvent.MOUSE_OUT, onModeMouseOut);
			_redecorateUI.horseInventoryButton.removeEventListener(MouseEvent.MOUSE_OUT, onModeMouseOut);
		}
		
		private function onRightClick(e:MouseEvent):void {
			_currentSelectionIndex+= 4;
			if (_currentSelectionIndex > (_selectionItems.length - 4)) {
				_currentSelectionIndex = _selectionItems.length - 4;
			}
			if (_currentSelectionIndex < 0) {
				_currentSelectionIndex = 0;
			}
			clearSelectionWindows();
			displaySelectionItems();
		}
		
		
		private function onLeftClick(e:MouseEvent):void {
			_currentSelectionIndex-= 4;
			if (_currentSelectionIndex < 0) {
				_currentSelectionIndex = 0;
			}
			clearSelectionWindows();
			displaySelectionItems();
		}
		
		private function onWindowClick(evt:MouseEvent):void{
			for each (var selection:SelectionInfo in _selectionItems) {
				if (selection.buttonReference == evt.target) {
					var params:Object = new Object;
					params.name = selection.name;
					params.currencyType = selection.currencyType;
					params.amount = selection.amount;
					if(selection.id >= 0){						
						TEngine.mainClass.dispatchEvent(new ItemEvent(ItemEvent.ITEM_SELECTED, _buildingDataProvider.getModelById(selection.id)));
					}										
					break;
				}
			}
		}
		
		private function onNewiClicked(evt:MouseEvent):void{
			switchViewType(NEWI);
		}
		private function onTileClicked(evt:MouseEvent):void{
			switchViewType(TILES);
		}
		private function onBuildingClicked(evt:MouseEvent):void{
			switchViewType(BUILDINGS);
		}
		private function onGardeningClicked(evt:MouseEvent):void{
			switchViewType(GARDENING);
		}
		private function onFencesClicked(evt:MouseEvent):void{
			switchViewType(FENCES);
		}
		private function onStructureClicked(evt:MouseEvent):void{
			switchViewType(STRUCTURE);
		}
		private function onDecorationClicked(evt:MouseEvent):void{
			switchViewType(DECORATION);
		}
		
		private function initSelectionItems(type:String):void{
			var currency:String = Constants.COIN;
			_currentSelectionIndex = 0;
			_selectionItems = [];
			var typeInt:int = 0;
			if(type == NEWI){
				//var newBuildables:Array = BuildableFactory.instance.getNewBuildableModels();
				var queryArray:Array = [];
				queryArray["isNew"] = 1;
				var newBuildables:Array = _buildingDataProvider.getModelsByCategory(queryArray); 
				for each(var buildable:Building in newBuildables){
					var loader:Loader = new Loader();
					var url2:String = buildable.thumbnailURL;
					if(!buildable.thumbnailURL){
						url2 =  "/building/stable_thumb.png";
					}
					Logger.debug(this, "initSelectionItems", "URL of " + buildable.id + " is " + url2);
					loader.load(new URLRequest("./assets"+ url2));
					if(buildable.getCurrency() != null){
						_selectionItems.push(new SelectionInfo(loader, buildable.buildName, buildable.getCurrency(), buildable.getPrice(), buildable.id));
					}					
				}
			}else{
				switch (type){				
					case BUILDINGS:
						typeInt = 0;
						break;
					case TILES:
						typeInt = 1;
						break;
					case GARDENING:
						typeInt = 2;
						break;
					case FENCES:
						typeInt = 3;
						break;
					case STRUCTURE:
						typeInt = 4;
						break;
					case DECORATION:
						typeInt = 5;
						break;
				}
				var queryArray:Array = [];
				queryArray["category"] = typeInt;
				var buildablesByType:Array = _buildingDataProvider.getModelsByCategory(queryArray);
				for each(var buildable2:Building in buildablesByType){
					var loader2:Loader = new Loader();
					var url:String = buildable2.thumbnailURL;
					if(!buildable2.thumbnailURL){
						url =  "/building/stable_thumb.png"; //default asset if database leaves this value blank
					}
					Logger.debug(this, "initSelectionItems", "URL of " + buildable2.id + " is " + url);
					loader2.load(new URLRequest("./assets"+ url));
					if(buildable2.getCurrency() != null){
						_selectionItems.push(new SelectionInfo(loader2, buildable2.buildName, buildable2.getCurrency(), buildable2.getPrice(), buildable2.id));
					}
					
				}
			}
			
			displaySelectionItems();
		}
		
		private function displaySelectionItems():void{
			var windowNum:int = 1;
			for(var a:int = _currentSelectionIndex; a < _selectionItems.length && a < (_currentSelectionIndex + 6); a++){				
				_selectionItems[a].addSelectionToButton(_redecorateUI["button"+windowNum]);
				windowNum++;
			}
		}
		
		private function clearSelectionWindows():void{
			if (_selectionItems) {
				for (var a:int = 0; a < _selectionItems.length; a++) {
					_selectionItems[a].removeSelection(); 
				}
			}
		}
		
		private function onDoneButton(evt:MouseEvent):void{
			TEngine.mainClass.dispatchEvent(new NavigationEvent(NavigationEvent.REDECORATE_DONE));
		}
			
		
		private function onModeClicked(evt:MouseEvent):void{
			if(evt.target != _currentMainFunction){
				setNewMode(evt.target as MovieClip);
				
				_currentMainFunction.gotoAndStop(1);
				_currentMainFunction = (evt.target as MovieClip);
				_currentMainFunction.gotoAndStop(2);				
			}
		}
		
		private function setNewMode(modeMC:MovieClip):void{
			if(modeMC == _redecorateUI.shopButton){
				_currentMode = SHOP;
				switchViewType(_activeType);
			}else if(modeMC == _redecorateUI.storageInventoryButton){
				_currentMode = STORAGE;
				hideShopButtons();
			}else if(modeMC == _redecorateUI.horseInventoryButton){
				_currentMode = HORSE_INVENTORY;
				hideShopButtons();
			}
		}
		
		private function onModeMouseOver(evt:MouseEvent):void{
			(evt.target as MovieClip).gotoAndStop(2);
		}
		
		private function onModeMouseOut(evt:MouseEvent):void{
			if(evt.target != _currentMainFunction){
				(evt.target as MovieClip).gotoAndStop(1);
			}
		}
		
		private function switchViewType(type:String):void{
			stopAllButtons();
			clearSelectionWindows();
			initSelectionItems(type);
			//correctLevelPosition(type);
			_activeType = type;
			switch(type){
				case NEWI:
					_activeButton = _redecorateUI.newi_animate;
					_redecorateUI.newi_button.visible = false;
					_redecorateUI.newi_animate.visible = true;
					break;
				case BUILDINGS:
					_activeButton = _redecorateUI.building_animate;
					_redecorateUI.building_button.visible = false;
					_redecorateUI.building_animate.visible = true;
					break;
				case TILES:
					_activeButton = _redecorateUI.tile_animate;
					_redecorateUI.tile_button.visible = false;
					_redecorateUI.tile_animate.visible = true;
					break;
				case GARDENING:
					_activeButton = _redecorateUI.gardening_animate;
					_redecorateUI.gardening_button.visible = false;
					_redecorateUI.gardening_animate.visible = true;
					break;
				case FENCES:
					_activeButton = _redecorateUI.fence_animate;
					_redecorateUI.fence_button.visible = false;
					_redecorateUI.fence_animate.visible = true;
					break;
				case STRUCTURE:
					_activeButton = _redecorateUI.structure_animate;
					_redecorateUI.structure_button.visible = false;
					_redecorateUI.structure_animate.visible = true;
					break;
				case DECORATION:
					_activeButton = _redecorateUI.decoration_animate;
					_redecorateUI.decoration_button.visible = false;
					_redecorateUI.decoration_animate.visible = true;
					break;
			}
			
		}
	
		
		private function stopAllButtons():void{
			_redecorateUI.gardening_button.visible = true;
			_redecorateUI.building_button.visible = true;
			_redecorateUI.newi_button.visible = true;
			_redecorateUI.decoration_button.visible = true;
			_redecorateUI.fence_button.visible = true;
			_redecorateUI.tile_button.visible = true;
			_redecorateUI.structure_button.visible = true;
			
			_redecorateUI.gardening_animate.visible = false;
			_redecorateUI.building_animate.visible = false;
			_redecorateUI.newi_animate.visible = false;
			_redecorateUI.decoration_animate.visible = false;
			_redecorateUI.fence_animate.visible = false;
			_redecorateUI.tile_animate.visible = false;
			_redecorateUI.structure_animate.visible = false;
						
		}
		
		private function hideShopButtons():void{
			_redecorateUI.gardening_button.visible = false;
			_redecorateUI.building_button.visible = false;
			_redecorateUI.newi_button.visible = false;
			_redecorateUI.decoration_button.visible = false;
			_redecorateUI.fence_button.visible = false;
			_redecorateUI.tile_button.visible = false;
			_redecorateUI.structure_button.visible = false;
			
			_redecorateUI.gardening_animate.visible = false;
			_redecorateUI.building_animate.visible = false;
			_redecorateUI.newi_animate.visible = false;
			_redecorateUI.decoration_animate.visible = false;
			_redecorateUI.fence_animate.visible = false;
			_redecorateUI.tile_animate.visible = false;
			_redecorateUI.structure_animate.visible = false;
		}
		
		private function initializeObjects():void{
			_currentMainFunction = _redecorateUI.shopButton;
			_redecorateUI.shopButton.gotoAndStop(2);
			_redecorateUI.shopButton.buttonMode = true;
			_redecorateUI.shopButton.mouseChildren = false;
			_redecorateUI.storageInventoryButton.stop();
			_redecorateUI.storageInventoryButton.buttonMode = true;
			_redecorateUI.storageInventoryButton.mouseChildren = false;
			_redecorateUI.horseInventoryButton.stop();
			_redecorateUI.horseInventoryButton.buttonMode = true;
			_redecorateUI.horseInventoryButton.mouseChildren = false;
		}
	}
}