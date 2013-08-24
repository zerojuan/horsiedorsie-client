package com.tada.clopclop.redecorate
{
	import com.tada.clopclop.common.assets.BuildingHolderModel;
	import com.tada.clopclop.common.popups.ItemInfoModel;
	import com.tada.clopclop.declarations.ThumbDeclaration;
	import com.tada.clopclop.events.ItemEvent;
	import com.tada.engine.TEngine;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	public class ItemBoxModel extends Sprite
	{
		private var _itemBox:ItemBox
		private var _itemInfoModel:ItemInfoModel
		private var _thumbDeclarations:ThumbDeclaration
		private var _redecorateController:Object
		
		//properties		
		public var ID:Number
		public var ITEM:String
		public var BUILD_NAME:String
		public var BUILD_BASE_IDX:Number
		
		private var MOUSE_IS_DOWN:Boolean
		
		
		public function ItemBoxModel(id:Number)
		{
			initializeItemBox(id);
		}
		
		private function initializeItemBox(id:Number):void 
		{
			
			inheritItemBox(id);
			
			initializePosition(id)
			
			addListeners();
			
			
		}
		
		
		
		private function addListeners():void 
		{
			
			addEventListener(MouseEvent.MOUSE_OVER, overItemBox)
			
			addEventListener(MouseEvent.MOUSE_OUT, outItemBox)
			
			addEventListener(MouseEvent.CLICK, clickItemBox)
			
			addEventListener(MouseEvent.MOUSE_DOWN, downItemBox)
			
			addEventListener(MouseEvent.MOUSE_UP, upItemBox)
			
		}
		
		private function upItemBox(me:MouseEvent):void 
		{
			setMouseDown(false)
		}
		
		private function downItemBox(me:MouseEvent):void 
		{
			setMouseDown(true)
			
			setItemInfo(_redecorateController.CURRENT_SELECTED,ID)
			//startDragItem(ITEM,ID);
			
			_redecorateController.CURRENT_ID = ID
						
			//TEngine.mainClass.dispatchEvent(new ItemEvent(ItemEvent.ITEM_SELECTED, ID, ITEM));
		}
		
		private function setMouseDown(value:Boolean):void 
		{
			MOUSE_IS_DOWN = value
		}
		
		private function overItemBox(me:MouseEvent):void 
		{
			_redecorateController = parent.parent.parent.getChildByName("_redecorateController")
				
			animateOver();
			inheritItemInfoModel();
			
		}
		
		private function inheritItemInfoModel():void 
		{
			/*
			var build_name:String = _redecorateController.BUILD_LIST[ID-1]['build_name']
			var build_time:String = processBuildTime(_redecorateController.BUILD_LIST[ID-1]['build_time'])
			var user_level:String = processUserLevel(_redecorateController.BUILD_LIST[ID-1]['user_level'])
				
			_itemInfoModel = new ItemInfoModel(build_name,build_time,"under construction",user_level);
			_itemInfoModel.name = "_itemInfoModel";
			addChild(_itemInfoModel);*/	
		}
		
		private function processBuildTime(getSecond:Number):String 
		{
			var getMinute:int = Math.floor(getSecond/60)
			var getHour:int = Math.floor(getMinute/60)
			
			var remHour:int = Math.floor(getMinute/60)
			var remMinute:int = getMinute - (getHour * 60)
			var remSecond:int = getSecond - (getMinute * 60)
			
			var strHour:String = remHour + "h"
			var strMinute:String = remMinute + "m"
			var strSecond:String = remSecond + "s"
				
			var retStr:String = strHour
			if(remHour == 0) {
				retStr = strMinute
				if(remMinute == 0){
					retStr = strSecond
				}					
			} 
			
			return retStr
		}
		
		private function processUserLevel(getUserLevel:Number):String 
		{
			var strUserLevel:String = "Ranch level " + getUserLevel
			return strUserLevel
		}
		
		
		
		private function outItemBox(me:MouseEvent):void 
		{
			//DITO
			
			animateOut();
			removeItemInfoModel();
			
		}
		private function removeItemInfoModel():void 
		{
			//removeChild(_itemInfoModel)
		}
		
		private function startDragItem(item:String, id:Number):void 
		{
			var _view:Object = parent.parent.parent
			var _redecorateController:Object = parent.parent.parent.getChildByName("_redecorateController")
			/*var _buildingHolderModel:BuildingHolderModel = new BuildingHolderModel(item + "_" + id,false,"bydrag")
				
			_buildingHolderModel.name = "_buildingHolderModel"			
			_view.addChild(_buildingHolderModel)
				
			_buildingHolderModel.setWSize(_redecorateController.BUILD_LIST[ID-1]['w_size'])
			_buildingHolderModel.setHSize(_redecorateController.BUILD_LIST[ID-1]['h_size'])
			*/	
			
		}
		
		
		
		private function clickItemBox(me:MouseEvent):void 
		{
			
		}
		
		private function animateOver():void 
		{
			_itemBox.gotoAndStop(2);
		}
		private function animateOut():void 
		{
			_itemBox.gotoAndStop(1);
		}
		
		private function inheritItemBox(id:Number):void 
		{
			_itemBox = new ItemBox;
			_itemBox.name = "item_box";
			_itemBox.mouseEnabled = false
			addChild(_itemBox);			
			
			
		}
		
		
		
		
		public function placeItem(id:Number,selected:String,navigation:Number):void 
		{
			var new_nav:Number = (id+navigation) + 1
			var _item:MovieClip = new (getDefinitionByName(selected + "_thumb_" + new_nav) as Class)();			
			_item.name = selected + "_thumb_" + (new_nav);
			addChild(_item);
			
			setItem(selected)
			setId(new_nav)
			
		}
		
		private function setId(id:Number):void 
		{
			
			
			ID = id
			
		}
		private function setItem(item:String):void 
		{
			ITEM = item
		}
		
		
		private function setItemInfo (selected:String, id:Number):void 
		{			
			
			
			switch (selected) {
				case "newi" :
					//ITEM = newiArray[id]					
					break;
				case "building" :
					//BUILD_BASE_IDX = BUILD_LIST[ID]['build_base_idx']
					//BUILD_NAME = BUILD_LIST[ID]['build_name']
					
					break;
				case "tile" :
					//ITEM = tileArray[id]
					break;
				case "gardening" :
					//ITEM = gardeningArray[id]
					break;
				case "fence" :
					//ITEM = fenceArray[id]
					break;
				case "structure" :
					//ITEM = structureArray[id]
					break;
				case "decoration" :
					//ITEM = decorationArray[id]
					break;
				
			}
			
			
		}
		
		private function setItemName (value:String):void 
		{
			BUILD_NAME = value
		}
		private function setItemId (value:Number):void 
		{
			BUILD_BASE_IDX = value
		}
		
		public function initializePosition(id:Number):void 
		{
			x = (id * width) + 190
			y = 110
		}
		
	}
}