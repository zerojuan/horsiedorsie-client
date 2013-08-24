package com.tada.clopclop.jockeyequip.old
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.jockeyequip.tool.EquipJockey;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class JockeyEquipController extends Sprite
	{	
		
		private var ring:EquipRotateMouseOver;
		//private var _jockeyEquipView:JockeyEquipView
		private var _view:Sprite;
		
		private var _EquipJockey:EquipJockey;
		
		//df test Jockey Equip, needs view3D and camera
		private var view:View3D;
		private var camera:CameraHover;
		
		private var _move:Boolean;
		private var _lastX:Number;
		private var _lastY:Number;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _mouseSpeed:Number = 0.5;
		private var _isMouseMovable:Boolean = false;
		
		//total number of frames of ring, preparation for reverse rotation
		private var ringFrame:int = 20;
		private var rotRight:Boolean;
		private var temp:int;
		
		private var _jockeyEquipView:JockeyView;
		
		private var cname1:String = "";
		private var cname2:String = "";
		private var ctype:int = 0;
		
		public function JockeyEquipController(view:Sprite)
		{
			_view = view;
			this.name = "_jockeyEquipController"
			_view.addChild(this)			
		}
		
		public function startJockeyEquipController():void
		{
			view = new View3D;
			
			camera = new CameraHover(stage);
			view.camera = camera;		
			camera.setCameraPreset(CameraHover.CAMHOVER_MOUSEDRIVEN);	
			
			//_jockeyEquipView = new JockeyEquipView(view)
			//_jockeyEquipView.name = "_jockeyEquipView";
			//_view.addChild(_jockeyEquipView);
			//_jockeyEquipView.initJockeyEquipView();	
			
			_jockeyEquipView = new JockeyView(view, this);			
			//_view.addChild(_jockeyEquipView);			
			////_jockeyEquipView.visibility(false);
			
			initializeSprite();			
			addListeners();			
		}
		
		private function addListeners():void 
		{
			addEventListener(Event.ENTER_FRAME, onEnter);			
		}
		
		public function visibility(value:Boolean):void 
		{			
			_jockeyEquipView.visibility(value);
			if(value){
				_view.addChild(_jockeyEquipView);
			}else{
				if(_view.contains(_jockeyEquipView)){
					_view.removeChild(_jockeyEquipView);
				}
			}
		}
		
		private function initializeSprite():void{
			
			_jockeyEquipView.addChild(view);			
			_EquipJockey = new EquipJockey(view);			
		}
		
		public function update():void{				
			cname1 = _jockeyEquipView.name1;
			cname2 = _jockeyEquipView.name2;
			ctype = _jockeyEquipView.type;			
			
			_EquipJockey.itemEquip(cname1, cname2, ctype);				
		}
		
		private function onEnter(e:Event):void{					
			//if(_jockeyEquipView.visible == true){
				view.render();		
				camera.hover();
			//}
		}		
	}
}