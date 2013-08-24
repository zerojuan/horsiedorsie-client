package com.tada.clopclop
{
	import com.tada.clopclop.buildables.BuildableFactory;
	import com.tada.clopclop.datamodels.Building;
	import com.tada.clopclop.dataproviders.BuildingDataProvider;
	import com.tada.clopclop.dataproviders.CharacterDataProvider;
	import com.tada.clopclop.events.HorseWorldEvent;
	import com.tada.clopclop.events.ItemEvent;
	import com.tada.clopclop.events.NavigationEvent;
	import com.tada.clopclop.events.RedecorateEvent;
	import com.tada.clopclop.horseequip.HorseComponent.HorseFrameController;
	import com.tada.clopclop.jockeyequip.JockeyComponent.JockeyFrameController;
	import com.tada.clopclop.popups.PopupManager;
	import com.tada.clopclop.redecorate.RedecorateController;
	import com.tada.clopclop.screen.ScreenController;
	import com.tada.clopclop.social.SocialController;
	import com.tada.clopclop.ui.HorseManagementControls;
	import com.tada.clopclop.ui.RedecorateControls;
	import com.tada.clopclop.ui.events.HorseManagementEvent;
	import com.tada.clopclop.world.RanchController;
	import com.tada.clopclop.world.WorldController;
	import com.tada.engine.TEngine;
	import com.tada.utils.debug.Logger;
	
	import flash.display.Sprite;

	public class ClopClopMainController{		
		//Data Providers
		private var _buildingDataProvider:BuildingDataProvider;
		private var _characterDataProvider:CharacterDataProvider;
		
		private var _ranch:RanchController;
		
		private var _worldController:WorldController;
		private var _socialController:SocialController;
		private var _redecorateController:RedecorateController;
		private var _horseFrameController:HorseFrameController;
		private var _jockeyFrameController:JockeyFrameController;
		private var _screenController:ScreenController;
		
		private var _redecorateControl:RedecorateControls; 
		private var _horseManagementControl:HorseManagementControls;	
		
		private var _worldLayer:Sprite;
		private var _panels:Sprite;
		private var _hud:Sprite;
		private var _topLayer:Sprite;
		
		private var _mainApp:Sprite;				
		
		public function ClopClopMainController(mainApp:Sprite){
			_mainApp = mainApp;
			initLayers();
			
		}
		
		public function startClopClopMainController(buildingDataProvider:BuildingDataProvider, characterDataProvider:CharacterDataProvider):void 
		{
			_buildingDataProvider = buildingDataProvider;
			_characterDataProvider = characterDataProvider;
			//TODO: Add getting variables from flash vars
			initializeUIs();
			BuildableFactory.instance.loadAssets();
			
			addEventListeners();
			
			PopupManager.instance.root = _topLayer;
			PopupManager.instance.ranchController = _ranch;
			//var frame:ClopClopWindow = new ClopClopWindow(_topLayer);
			//frame.setSize(new IntDimension(620, 615));
			//frame.show();
			
			//frame.x = 100;
		}
		
		private function initLayers():void{
			_worldLayer = new Sprite();
			_worldLayer.name = "WorldLayer";
			
			_panels = new Sprite();
			_panels.name = "PanelLayer";
			
			_hud = new Sprite();
			_hud.name = "HUDLayer";
			
			_topLayer = new Sprite();
			_topLayer.name = "TopLayer";
			
			_mainApp.addChild(_worldLayer);
			_mainApp.addChild(_panels);
			_mainApp.addChild(_hud);
			_mainApp.addChild(_topLayer);
		}
		
		
		private function addEventListeners():void{
			TEngine.mainClass.addEventListener(NavigationEvent.REDECORATE, onRedecorateClicked);
			TEngine.mainClass.addEventListener(NavigationEvent.REDECORATE_DONE, onRedecorateDone);
			TEngine.mainClass.addEventListener(RedecorateEvent.ROTATE, onRedecorateEvent);
			TEngine.mainClass.addEventListener(RedecorateEvent.SELL, onRedecorateEvent);
			TEngine.mainClass.addEventListener(RedecorateEvent.STORAGE, onRedecorateEvent);
			TEngine.mainClass.addEventListener(ItemEvent.ITEM_BOUGHT, onItemBought);
			TEngine.mainClass.addEventListener(ItemEvent.ITEM_SOLD, onItemSold);
			
			TEngine.mainClass.addEventListener(NavigationEvent.HORSE_EQUIP, onHorseEquip);
			TEngine.mainClass.addEventListener(NavigationEvent.JOCKEY_EQUIP, onJockeyEquip);
			TEngine.mainClass.addEventListener(NavigationEvent.JOCKEY_EQUIP_DONE, onJockeyEquipDone);
			TEngine.mainClass.addEventListener(NavigationEvent.HORSE_EQUIP_DONE, onHorseEquipDone);
			
			TEngine.mainClass.addEventListener(HorseWorldEvent.HORSE_CLICKED, onHorseClicked);
			
			_horseManagementControl.addEventListener(HorseManagementEvent.CLOSE, onHorseManagementClose);
		}	
		
		private function onJockeyEquip(evt:NavigationEvent):void{
			PopupManager.instance.hide();
			visibilityUI("_jockeyEquipController",true);
		}
		
		private function onJockeyEquipDone(evt:NavigationEvent):void{
			visibilityUI("_jockeyEquipController", false);
		}
		
		private function onHorseEquip(evt:NavigationEvent):void{
			PopupManager.instance.hide();
			visibilityUI("_horseEquipController",true);
		}
		
		private function onHorseEquipDone(evt:NavigationEvent):void{
			visibilityUI("_horseEquipController", false);
		}
		
		private function initializeUIs():void 
		{
			initWorldController();
			
			initSocialController();
			
			initScreenController();
						
			initRedecorateController();
			
			initHorseEquipController();
			
			initJockeyEquipController();
				
		}
						
		//init functions of UIs		
		private function initWorldController():void 
		{			
			_ranch = new RanchController(_worldLayer);
			_ranch.start(_worldLayer, _buildingDataProvider);
		}
		
		private function initSocialController():void 
		{
			_socialController = new SocialController(_panels);
			_socialController.startSocialController();
		}
		private function initRedecorateController():void 
		{
			_redecorateControl = new RedecorateControls(_buildingDataProvider);
			_horseManagementControl = new HorseManagementControls();
		}
		private function initHorseEquipController():void 
		{
			_horseFrameController = new HorseFrameController(_characterDataProvider, _topLayer, 100, 50);
			_horseFrameController.startHorseEquipController();			
		}
		private function initJockeyEquipController():void 
		{
			_jockeyFrameController = new JockeyFrameController(_characterDataProvider,_topLayer, 100, 50);
			_jockeyFrameController.startJockeyEquipController();
		}		
		private function initScreenController():void 
		{
			_screenController = new ScreenController(_hud);
			_screenController.startScreenController();
		}
		
		private function onRedecorateClicked(evt:NavigationEvent):void{
			_redecorateControl.showRedecorateControls(_panels, RedecorateControls.NEWI);
			visibilityUI("_socialController", false);
			//visibilityUI("_redecorateController", true);
		}		
		private function onRedecorateDone(evt:NavigationEvent):void{
			_redecorateControl.hideRedecorateControls();
			//visibilityUI("_redecorateController",false);
			visibilityUI("_socialController",true);						
		}
		private function onRedecorateEvent(evt:RedecorateEvent):void{
			//_redecorateControl.showRedecorateControls(_view, RedecorateControls.NEWI);
			//visibilityUI("_socialController", false);			
		}
		private function onItemBought(evt:ItemEvent):void{
			var model:Building = evt.model as Building;
			Logger.print(this, "Item Bought: " + model.getPrice() + " x " + evt.count);
			if(model.getCurrency() == Constants.CASH){
				PlayerGlobalData.cash -= model.getPrice() * evt.count;
				_screenController.getCurrentValueOfScreenModel("_cash", PlayerGlobalData.cash);
			}else{
				PlayerGlobalData.coin -= model.getPrice() * evt.count;
				_screenController.getCurrentValueOfScreenModel("_coin", PlayerGlobalData.coin);
			}
		}
		
		private function onItemSold(evt:ItemEvent):void{
			Logger.print(this, "Item Sold: " + (evt.model as Building).sellPrice);
			PlayerGlobalData.coin += (evt.model as Building).sellPrice;
			_screenController.getCurrentValueOfScreenModel("_coin", PlayerGlobalData.coin);
		}
		
		private function onHorseClicked(evt:HorseWorldEvent):void{
			//PopupManager.instance.hide();
			_horseManagementControl.showHorseManagement(_panels, 0, 527, HorseManagementControls.FEEDING_VIEW);
			visibilityUI("_socialController", false);
		}
		
		private function onHorseManagementClose(evt:HorseManagementEvent):void{	
			PopupManager.instance.hide();
			visibilityUI("_socialController", true);
		}
		
		//show/hide UI functions
		public function visibilityUI(controller:String, value:Boolean):void{
			switch(controller){
				case "_socialController":
					var _getController:Object = _panels.getChildByName(controller);
					_getController.visibility(value);
					break;
				case "_horseEquipController":					
					_horseFrameController.visibility(value);
					break;
				case "_jockeyEquipController":
					_jockeyFrameController.visibility(value);
					break;
			}
			
			
		}
	}
}