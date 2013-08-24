package com.tada.clopclop.popups
{
	import com.tada.clopclop.test.type.Horse;
	import com.tada.clopclop.world.RanchController;
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	/**
	 * Manages popups
	 */
	public class PopupManager
	{
		public static const HORSE:String = "horse";
		public static const BUILDING:String = "building";
		
		private static var _instance:PopupManager;
		private static var _allowInstantiation:Boolean;
		
		private var horsePopup:HorseManagementPopup;
		private var buildingManagementPopup:BuildingManagementPopup;
		
		private var currTarget:DisplayObjectContainer;
		private var currPopup:IPopup;
		
		private var _container:DisplayObjectContainer;
		private var _ranchControl:RanchController;
		
		public static function get instance():PopupManager{
			if(!_instance){
				_allowInstantiation = true;
				_instance = new PopupManager();
				_allowInstantiation = false;
			}
			return _instance;
		}
		
		public function PopupManager(){
			if(!_allowInstantiation){
				throw new Error("Cannot instantiate singleton PopupManager");
			}
			initPopupPool();
		}
					
		public function showPopup(target:DisplayObjectContainer, type:String, callBack:Function):void{
			if(_ranchControl.isDraggingAnItem){
				return;
			}
			if(currTarget == target){
				currPopup.hide();
				currTarget = null;
			}else{
				currTarget = target;
				switch(type){
					case HORSE: //Create new horse popup
						currPopup = horsePopup;
						break;
					case BUILDING: //Create new building management popup
						currPopup = buildingManagementPopup;
						break;
				}
				var x:Number = target.parent.x + _ranchControl.scrollX + target.x;
				var y:Number = target.parent.y + _ranchControl.scrollY + target.y;
				Logger.print(this, "PopupXY: " + x + ", " + y);
				currPopup.show(_container, callBack, x, y);
			}
		}
		
		public function hide():void{
			Logger.print(this, "Hide popup");
			currTarget = null;
			if(currPopup)
				currPopup.hide();
		}
		
		public function set ranchController(world:RanchController):void{
			_ranchControl = world;
		}
		
		public function set root(container:DisplayObjectContainer):void{
			_container = container;
		}
		
		private function initPopupPool():void{
			horsePopup = new HorseManagementPopup();
			buildingManagementPopup = new BuildingManagementPopup();
		}
	}
}