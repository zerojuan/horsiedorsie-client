package com.tada.clopclop.world
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class WorldController extends Sprite
	{
		//base decalrtion
		private var _view:MovieClip;
		private var _worldView:WorldView
		
		public var MY_BUILDING:Object
		
		public function WorldController(view:MovieClip)
		{
			_view = view
			this.name = "_worldController"
			_view.addChild(this)
		}
		
		public function startWorldController():void
		{	
			
			_worldView = new WorldView();
			_worldView.name = "_worldView";
			_view.addChild(_worldView);	
			_worldView.initWorldView();
			
			
			
		}
		
		public function removePopupInfos():void 
		{
			_worldView.removePopupInfos()
		}
		
		public function rebuildWorld(myBuilding:Object):void 
		{
			/*
			setMyBuilding(myBuilding)
			
			var _worldView:Object = parent.getChildByName("_worldView")
			var _assetGroupModel:Object = _worldView.getChildByName("_assetGroupModel")	
			var _redecorateController:Object = parent.getChildByName("_redecorateController")
			
			for(var i:Number=0; i<MY_BUILDING.length; i++) {
				//just for buildings
				
				var _idx:Number = MY_BUILDING[i]['build_base_idx']
				var _hSize:Number = _redecorateController.BUILD_LIST[_idx-1]['h_size']
				var _wSize:Number = _redecorateController.BUILD_LIST[_idx-1]['w_size']
				
				
				var _item:String = "building_" + MY_BUILDING[i]['build_base_idx']
				var _fieldArea:String = MY_BUILDING[i]['field_area']
				_assetGroupModel.placeBuildingOnWorld(_item,"by_rebuild",_fieldArea,_idx,_hSize,_wSize);
				
			}
			
			//adding of horse
			_assetGroupModel.placeHorseOnWorld(8,8)
			_assetGroupModel.organizeOrder();*/
		}
		
		public function organizeOrder():void 
		{
			var _worldView:Object = parent.getChildByName("_worldView")
			var _assetGroupModel:Object = _worldView.getChildByName("_assetGroupModel")
				
			_assetGroupModel.organizeOrder();
		}
		
		private function setMyBuilding(myBuilding:Object):void 
		{
			MY_BUILDING = myBuilding
		}
		
		public function changeMode(value:String):void 
		{
			var _worldView:Object = parent.getChildByName("_worldView")
				
			//_worldView.changeMode(value)
		}
		
		
		
		
		public function startTileCreation(ranch_size:Number):void 
		{
			//_worldView.createTileGroup(ranch_size)
			
		}
		
	}
}