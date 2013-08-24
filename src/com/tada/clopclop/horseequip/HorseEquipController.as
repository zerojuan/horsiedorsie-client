package com.tada.clopclop.horseequip
{
	
	import com.away3d.containers.View3D;
	import com.tada.clopclop.horseequip.tool.EquipHorse;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class HorseEquipController extends Sprite
	{				
		//base declaration
		private var _view:Sprite;
		private var _horseEquipView:HorseView;			
		
		//df test Jockey Equip, needs view3D and camera
		private var view:View3D;
		
		//camera settings
		private var camera:CameraHover;		
		//private var camera:HoverCamera3D;				
		
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
		
		private var _EquipHorse:EquipHorse;
		
		private var cname1:String = "";
		private var cname2:String = "";
		private var ctype:int = 0;
		
		public function HorseEquipController(viewMC:Sprite)
		{
			_view = viewMC;
			this.name = "_horseEquipController"
			_view.addChild(this)
		}
		
		public function startHorseEquipController():void
		{
			view = new View3D;
			
			camera = new CameraHover(stage);;
			view.camera = camera;				
			camera.setCameraPreset(CameraHover.CAMHOVER_MOUSEDRIVEN);			
		
			/*
			_horseEquipView = new HorseEquipView(view);
			_horseEquipView.name = "_horseEquipView";
			_view.addChild(_horseEquipView);
			_horseEquipView.initHorseEquipView();
			*/
			
			_horseEquipView = new HorseView(view, this);			
			//_view.addChild(_horseEquipView);
				
			initializeSprite();
			addListeners();			
		}
		
		public function visibility(value:Boolean):void 
		{			
			_horseEquipView.visibility(value);
			if(value){
				_view.addChild(_horseEquipView);
			}else{
				if(_view.contains(_horseEquipView)){
					_view.removeChild(_horseEquipView);
				}
			}
		}
		
		private function addListeners():void{
			addEventListener(Event.ENTER_FRAME, onEnter);			
		}		
		
		private function initializeSprite():void{						
			_horseEquipView.addChild(view);			
			_EquipHorse = new EquipHorse(view);			
		}
		
		public function update():void{				
			cname1 = _horseEquipView.name1;
			cname2 = _horseEquipView.name2;
			ctype = _horseEquipView.type;			
			
			_EquipHorse.itemEquip(cname1, cname2, ctype);	
			//_EquipHorse.itemEquip("E", "Wing", 0);		
		}		
				
		private function onEnter(e:Event):void{			
				view.render();		
				camera.hover();		
		}			
	}
}