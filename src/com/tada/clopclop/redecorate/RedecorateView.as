package com.tada.clopclop.redecorate
{
	import com.tada.clopclop.events.NavigationEvent;
	import com.tada.engine.TEngine;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	

	public class RedecorateView extends Sprite
	{
		private var _redecorateUI:RedecorateUI;
		private var _itemBoxModel:ItemBoxModel;
		
		public var BUILD_LIST:Object = []
		
		private var animateButtonArray:Array = [
			"newi",
			"building",
			"tile",
			"gardening",
			"fence",
			"structure",
			"decoration" 
		]
		
		public function RedecorateView():void
		{
		}
		
		public function initRedecorateView():void 
		{
			inheritRedecorateUI();
			
			initializePosition(0,527);	
			
			visibility(false);
			
			initializeObjects();
			
			startItemBoxModels();
			
			addListeners();
			
			selectItem("building");
		}
		private function inheritRedecorateUI():void 
		{
			_redecorateUI = new RedecorateUI;
			_redecorateUI.name = "_redecorateUI";
			addChild(_redecorateUI);
			
			
		}
		
		
		
		public function startItemBoxModels():void 
		{
			for (var i:Number = 0; i<6; i++) 
			{
				inheritItemBox(i);				
			}
		}
		
		public function clearItemBoxModels():void 
		{
			for (var i:Number = 0; i<6; i++) 
			{
				clearItemBox(i);				
			}
		}
		private function clearItemBox(id:Number):void 
		{
				
			var _itemBoxModel:DisplayObject = _redecorateUI.getChildByName("item_box_" + id)
			_redecorateUI.removeChild(_itemBoxModel);			
		}
		
		private function inheritItemBox(id:Number):void 
		{
			_itemBoxModel = new ItemBoxModel(id);
			_itemBoxModel.name = "item_box_" + id;
			_redecorateUI.addChild(_itemBoxModel);			
		}
		
		
		public function testValue(value:String):void 
		{
			if(value != null) {
				_redecorateUI.tester.text = value
			} else {
				_redecorateUI.tester.text = "temp"
			}
		}
		
		private function selectItem(selected:String):void 
		{
			var _redecorateController:Object = _redecorateUI.parent.parent.getChildByName("_redecorateController");
			var selected_animate:Object = _redecorateUI.getChildByName(selected + "_animate");
			var selected_button:Object = _redecorateUI.getChildByName(selected + "_button");
			var current_animate:Object = _redecorateUI.getChildByName(_redecorateController.CURRENT_SELECTED + "_animate");
			var current_button:Object = _redecorateUI.getChildByName(_redecorateController.CURRENT_SELECTED + "_button");
			
			selected_animate.visible = true;
			selected_button.visible = false;	
			
			if(current_animate != null) 
			{
				current_animate.visible = false;
				current_button.visible = true;
			}
			
			_redecorateController.CURRENT_SELECTED = selected
			_redecorateController.CURRENT_NAVIGATION = 0
			_redecorateController.MAX_ITEMS = getMaxItem(selected)
				
			clearItemBoxModels();
			startItemBoxModels();
			updateItemBoxes(selected,_redecorateController.CURRENT_NAVIGATION)
			
		}
		public function getMaxItem(selected:String):Number 
		{
			var _redecorateController:Object = _redecorateUI.parent.parent.getChildByName("_redecorateController");
			var getMax:Number;
			
			switch (selected) 
			{
				case "newi" :
					getMax = _redecorateController.NEWI_COUNT
					break;
				case "building" :
					getMax = _redecorateController.BUILDING_COUNT
					break;
				case "tile" :
					getMax = _redecorateController.TILE_COUNT
					break;
				case "gardening" :
					getMax = _redecorateController.GARDENING_COUNT
					break;
				case "fence" :
					getMax = _redecorateController.FENCE_COUNT
					break;
				case "structure" :
					getMax = _redecorateController.STRUCTURE_COUNT
					break;
				case "decoration" :
					getMax = _redecorateController.DECORATION_COUNT
					break;
			}
			return getMax;
		}
		
		public function updateItemBoxes(selected:String,navigation:Number):void 
		{	
			
				
			for (var i:Number=0; i<=5; i++) 
			{
				var _itemBoxModel:Object = _redecorateUI.getChildByName("item_box_" + i)
				if(_itemBoxModel != null) 
				{	
					//var _redecorateController:Object = _redecorateUI.parent.parent.getChildByName("_redecorateController");
					//var idx:Number = _redecorateController.BUILD_LIST[i]['build_base_idx']
					_itemBoxModel.placeItem((i),selected,navigation);
				}
			}
		}
		
		
		
		private function initializeObjects():void {
			resetAnimateButtons(false);
		}
		
		private function resetAnimateButtons(value:Boolean):void
		{
			for (var i:Number=0; i<animateButtonArray.length; i++) 
			{
				var getAnimateButton:Object = _redecorateUI.getChildByName(animateButtonArray[i] + "_animate")
				getAnimateButton.visible = value
			}
		}
		
		public function visibility(value:Boolean):void 
		{
			visible = value
		}
		
		private function addListeners():void 
		{
			//click listeners
			_redecorateUI.DoneButton.addEventListener(MouseEvent.CLICK,clickDoneButton)
			_redecorateUI.browseRightButton.addEventListener(MouseEvent.CLICK,navigateRight)
			_redecorateUI.browseLeftButton.addEventListener(MouseEvent.CLICK,navigateLeft)
				
			_redecorateUI.newi_button.addEventListener(MouseEvent.CLICK,clickNewButton)
			_redecorateUI.building_button .addEventListener(MouseEvent.CLICK,clickBuildingButton)
			_redecorateUI.tile_button.addEventListener(MouseEvent.CLICK,clickTileButton)
			_redecorateUI.gardening_button.addEventListener(MouseEvent.CLICK,clickGardeningButton)
			_redecorateUI.fence_button.addEventListener(MouseEvent.CLICK,clickFenceButton)
			_redecorateUI.structure_button.addEventListener(MouseEvent.CLICK,clickStructureButton)
			_redecorateUI.decoration_button.addEventListener(MouseEvent.CLICK,clickDecorationButton)
		}
		
		//navigate functions
		public function navigateLeft(me:MouseEvent):void 
		{
			var _redecorateController:Object = parent.getChildByName("_redecorateController")
			_redecorateController.navigateLeft();
		}
		public function navigateRight(me:MouseEvent):void 
		{
			var _redecorateController:Object = parent.getChildByName("_redecorateController")
			_redecorateController.navigateRight();
			
		}
		
		//listener functions
		private function clickDoneButton(me:MouseEvent):void 
		{
			/*
			var _clopClopMainController:Object = parent.getChildByName("_clopclopMainController");
			var _worldController:Object = parent.getChildByName("_worldController")
				
			_clopClopMainController.changeMode("social")
			_clopClopMainController.visibilityUI("_redecorateController",false)
			_clopClopMainController.visibilityUI("_socialController",true)
				
			_worldController.changeMode("social");
			_worldController.removePopupInfos();*/
			TEngine.mainClass.dispatchEvent(new NavigationEvent(NavigationEvent.REDECORATE_DONE));
		}
		
		private function clickNewButton(me:MouseEvent):void 
		{
			selectItem("newi");
		}
		private function clickBuildingButton(me:MouseEvent):void 
		{
			selectItem("building");
		}
		private function clickTileButton(me:MouseEvent):void 
		{
			selectItem("tile");
		}
		private function clickGardeningButton(me:MouseEvent):void 
		{
			selectItem("gardening");
		}
		private function clickFenceButton(me:MouseEvent):void 
		{
			selectItem("fence");
		}
		private function clickStructureButton(me:MouseEvent):void 
		{
			selectItem("structure");
		}
		private function clickDecorationButton(me:MouseEvent):void 
		{
			selectItem("decoration");
		}
		
		private function initializePosition(pos_x:Number,pos_y:Number):void 
		{
			x = pos_x;
			y = pos_y;
		}
	}
}