package com.tada.clopclop.redecorate
{
	import com.tada.clopclop.toolsets.clopclopconnection.ClopClopConnection;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class RedecorateController extends Sprite
	{
		private var _redecorateView:RedecorateView
		private var _view:MovieClip
		
		public var CURRENT_SELECTED:String
		public var CURRENT_ID:Number
		public var CURRENT_NAVIGATION:Number = 0
		public var MAX_ITEMS:Number = 8
			
		public var NEWI_COUNT:Number = 5
		public var BUILDING_COUNT:Number = 8
		public var TILE_COUNT:Number = 29
		public var GARDENING_COUNT:Number = 17
		public var FENCE_COUNT:Number = 24
		public var STRUCTURE_COUNT:Number = 7
		public var DECORATION_COUNT:Number = 8
			
		public var BUILD_LIST:Object = []
		
		public function RedecorateController(view:MovieClip)
		{
			_view = view
			this.name = "_redecorateController"
			_view.addChild(this)
				
			
		}
		
		public function connectToClopclop():void 
		{			
			ClopClopConnection.instance.getBuildingList(onBuildingListResponse);		
		}
		
		private function onBuildingListResponse(result:Array):void{
			BUILD_LIST = result;
		}
		
		public function startRedecorateController():void 
		{
			_redecorateView = new RedecorateView();			
			_redecorateView.name = "_redecorateView";
			_view.addChild(_redecorateView);
			
			_redecorateView.initRedecorateView();			
		}
		
		
		public function visibility(value:Boolean):void 
		{
			_redecorateView.visibility(value);
		}
		
		public function addListeners():void 
		{
		}
		
		public function navigateLeft():void 
		{
			if(CURRENT_NAVIGATION > 0) 
			{
				CURRENT_NAVIGATION -= 1
				_redecorateView.clearItemBoxModels();
				_redecorateView.startItemBoxModels();
				_redecorateView.updateItemBoxes(CURRENT_SELECTED,CURRENT_NAVIGATION)
			}
		}
		public function navigateRight():void 
		{
			if(CURRENT_NAVIGATION < (MAX_ITEMS-5)) 
			{
				CURRENT_NAVIGATION += 1
				_redecorateView.clearItemBoxModels();
				_redecorateView.startItemBoxModels();
				_redecorateView.updateItemBoxes(CURRENT_SELECTED,CURRENT_NAVIGATION)
			}
		}
	}
}