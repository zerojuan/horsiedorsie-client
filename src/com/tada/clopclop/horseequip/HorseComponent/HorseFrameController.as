package com.tada.clopclop.horseequip.HorseComponent
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.datamodels.Character;
	import com.tada.clopclop.dataproviders.CharacterDataProvider;
	import com.tada.clopclop.horseequip.HorseComponent.look.HorseLookPanel;
	import com.tada.clopclop.horseequip.HorseComponent.parameter.ParamPanel;
	import com.tada.clopclop.horseequip.HorseComponent.tab.HorseTabbedPanel;
	import com.tada.clopclop.horseequip.tool.itemInfoDisplay;
	import com.tada.clopclop.horseequip.tool.ComboBoxClop;
	import com.tada.clopclop.horseequip.tool.EquipBox;
	import com.tada.clopclop.horseequip.tool.EquipHorse;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.ui.UIMainFrame;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	[SWF (width = "700", height = "700", backgroundColor = "0xF4A0AA")] 
	public class HorseFrameController extends UIMainFrame
	{
		//cons main buttons
		public static const _STORAGE:String = "storage";
		public static const _SHOP:String = "shop";
		
		public static const _NEW:String = "N";
		public static const _BODY:String = "B";
		public static const _EQUIP:String = "E";
		
		private var _parent:DisplayObjectContainer;
		
		private var _view:View3D;
		private var _camera:CameraHover;
		
		private var _lookPanel:HorseLookPanel;
		private var _tabPanel:HorseTabbedPanel;
		private var _paraPanel:ParamPanel;
		
		private var _combo:ComboBoxClop;
		
		//CENTER alighnment
		public var _centerW:int;
		public var _centerH:int;
				
		private var _defaultX:int;
		private var _defaultY:int;
		
		private var _BE:String;
		private var _part:String;
		private var _type:int;
		
		private var _characterDataProvider:CharacterDataProvider;
		
		//set horse asset
		private var _equipHorse:EquipHorse;	
		
		//set equipbox icon
		private var _currentIconIndex:int;
		
		private var _itemInfo:Array= [];
		
		public function HorseFrameController(characterDataProvider:CharacterDataProvider, _topLayer:DisplayObjectContainer, defaultX:int = 0, defaultY:int = 0)
		{
			super(new SkinFrame, new LabelHorseEquipment); 
			//_topLayer:DisplayObjectContainer		
			
			_characterDataProvider = characterDataProvider;
			_parent = _topLayer;
			_defaultX = defaultX;
			_defaultY = defaultY;

			_centerW = this.width
			_centerH = this.height;
			
			initialization();		
			setProperties();								
			addListener();
			
			addComboItem("Horse item#1");	
			addComboItem("Horse item#2");	
			addComboItem("Horse item#3");	
			addComboItem("Horse item#4");	
			addComboItem("Horse item#5");	
		

			//visibility(true);
			//startHorseEquipController();
			
			//test initial value for paramPanel
			_paraPanel.setLevel(Math.random()*100);
			
			_paraPanel.setSpeed(Math.random()*100, 30);
			_paraPanel.setStamina(Math.random()*100,30);
			_paraPanel.setStrenght(Math.random()*100,30);
			_paraPanel.setLuck(Math.random()*100, 30);
			_paraPanel.setBalance(Math.random()*100, 30);
			
		}
		public function visibility(_value:Boolean):void{
			if(_value){
				showUI(_parent, _defaultX, _defaultY);
			}
			else{
				hideUI();
			}
		}			
		
		private function initialization():void{	
		
			_camera = new CameraHover(stage);
			_camera.setCameraPreset(CameraHover.CAMHOVER_MOUSEDRIVEN);
			_camera.fov = 60;
			_view = new View3D;
			_view.camera = _camera;	
			
			_equipHorse = new EquipHorse(_view);
			
			_lookPanel = new HorseLookPanel(_view);
			_tabPanel = new HorseTabbedPanel(_characterDataProvider);		
			_paraPanel = new ParamPanel;
			
			//set combo
			_combo = new ComboBoxClop(new SkinComboBoxHorseTop,new SkinComboBoxHorseMid,new SkinComboBoxHorseBottom,new SkinComboBoxHorseHighlight,new BtnNameArrowUp);
			
		}		
		public function startHorseEquipController():void{			
			displayComponent();				
		}
		
		private function displayComponent():void{
			
			addComponent("ParameterPanel",_paraPanel,_lookPanel.width + 80, 50);
			addComponent("TabPanel", _tabPanel, (_tabPanel, this.width /2) - (_tabPanel.width/2),_lookPanel.height + 80);
			addComponent("LookPanel", _lookPanel, 50, 40);
			addComponent("ComboBox", _combo, ((_lookPanel.width/2) - (_combo.width/2))+ 50, (_lookPanel.height -_combo.height/2 ) + 40);
			
		}
		
		//methods for lookpanel and combobox
		public function setEquipHorse(part:String, type:int, mesh:int):void{			
			_equipHorse.itemEquip(part,type, mesh);
		}
		
		private function addComboItem(item:String):void{			
			_combo.addItem(item);			
		}
		
		private function setProperties():void{
			
		}
		
		private function addListener():void{			
			this.addEventListener(Event.ENTER_FRAME, onEnter);	
			
			//equipbox
			_tabPanel.addEventListener(HorseEquipEvent.CLICKED_BOX0, onBox0);
			_tabPanel.addEventListener(HorseEquipEvent.CLICKED_BOX1, onBox1);
			_tabPanel.addEventListener(HorseEquipEvent.CLICKED_BOX2, onBox2);
			_tabPanel.addEventListener(HorseEquipEvent.CLICKED_BOX3, onBox3);
			_tabPanel.addEventListener(HorseEquipEvent.CLICKED_BOX4, onBox4);
		}	
		
		private function onBox0(e:HorseEquipEvent):void{
			_type = _currentIconIndex;
			setEquipHorse(_tabPanel._part, _tabPanel._type, _tabPanel._mesh);		
		}		
		private function onBox1(e:HorseEquipEvent):void{
			_type = _currentIconIndex+1;
			setEquipHorse(_tabPanel._part, _tabPanel._type, _tabPanel._mesh);
		}
		private function onBox2(e:HorseEquipEvent):void{
			_type =  _currentIconIndex+2;
			setEquipHorse(_tabPanel._part, _tabPanel._type, _tabPanel._mesh);
		}
		private function onBox3(e:HorseEquipEvent):void{
			_type =  _currentIconIndex+3;	
			setEquipHorse(_tabPanel._part, _tabPanel._type, _tabPanel._mesh);
		}
		private function onBox4(e:HorseEquipEvent):void{
			_type =  _currentIconIndex+4;
			setEquipHorse(_tabPanel._part, _tabPanel._type, _tabPanel._mesh);
		}
		
		private function onEnter(e:Event):void{
			_view.render();				
		}	
	}
}