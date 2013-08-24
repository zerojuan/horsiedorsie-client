package com.tada.clopclop.jockeyequip.JockeyComponent
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.dataproviders.CharacterDataProvider;
	import com.tada.clopclop.horseequip.tool.ComboBoxClop;
	import com.tada.clopclop.horseequip.tool.EquipBox;
	import com.tada.clopclop.jockeyequip.JockeyComponent.MatchPanel.MatchPanel;
	import com.tada.clopclop.jockeyequip.JockeyComponent.look.JockeyLookPanel;
	import com.tada.clopclop.jockeyequip.JockeyComponent.tab.JockeyTabbedPanel;
	import com.tada.clopclop.jockeyequip.tool.EquipJockey;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.ui.UIMainFrame;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	[SWF (width = "700", height = "700", backgroundColor = "0xF4A0AA")] 
	public class JockeyFrameController extends UIMainFrame		
	{		
		private var _parent:DisplayObjectContainer;
		
		private var _view:View3D;
		private var _camera:CameraHover;
		
		private var _lookPanel:JockeyLookPanel;
		private var _tabPanel:JockeyTabbedPanel;
		private var _matchPanel:MatchPanel
		
		private var _combo:ComboBoxClop;
		
		//set jockey asset
		private var _equipJockey:EquipJockey;		
		
		private var _defaultX:int;
		private var _defaultY:int;	
		
		private var _characterDataProvider:CharacterDataProvider;
		
		public function JockeyFrameController(characterDataProvider:CharacterDataProvider,_topLayer:DisplayObjectContainer, defaultX:int = 0, defaultY:int = 0)
		{
			super(new SkinFrame, new LabelJockeyEquipment);			
			//_topLayer:DisplayObjectContainer	
			_characterDataProvider = characterDataProvider;
			_parent = _topLayer;	
			
			_defaultX = defaultX;
			_defaultY = defaultY;
			initialization();					
			addListener();
			
			//test initial value
			addComboItem("Jockey item#1");
			addComboItem("Jockey item#2");
			addComboItem("Jockey item#3");
			addComboItem("Jockey item#4");
			addComboItem("Jockey item#5");
			_matchPanel.setBarValue(Math.random()*100, 30);
		}
		
		public function visibility(_value:Boolean):void{
			if(_value){
				showUI(_parent, _defaultX, _defaultY);
			}
			else{
				hideUI();
			}
		}	
		public function startJockeyEquipController():void{				
			displayComponent();		
		}
		
		private function initialization():void{				
			_camera = new CameraHover(stage);
			_camera.setCameraPreset(CameraHover.CAMHOVER_MOUSEDRIVEN);
			_camera.fov = 60;
			_view = new View3D;
			_view.camera = _camera;	
			
			_equipJockey = new EquipJockey(_view);
			
			_lookPanel = new JockeyLookPanel(_view);
			_tabPanel = new JockeyTabbedPanel(_characterDataProvider);		
			_matchPanel = new MatchPanel;
			
			//set combo
			_combo = new ComboBoxClop(new SkinComboBoxJockeyTop,new SkinComboBoxJockeMid,new SkinComboBoxJockeyBottom,new SkinComboBoxJockeyHighlight,new BtnNameArrowUp);
					
		}		
		
		private function displayComponent():void{
			addComponent("TabPanel", _tabPanel, (this.width /2) - (_tabPanel.width / 2), this.height - (_tabPanel.height  + 70));
			addComponent("LookPanel", _lookPanel, 50, 40);
			addComponent("MatchPanel",_matchPanel, _lookPanel.width + _lookPanel.x + 10, 70);
			addComponent("ComboBox", _combo, ((_lookPanel.width/2) - (_combo.width/2))+ 50, (_lookPanel.height -_combo.height/2 ) + 40);
			
	}
		
		//methods for lookpanel and combobox
		public function setEquipJockey(part:String, type:int, mesh:int):void{				
			_equipJockey.itemEquip(part,type,mesh );
		}
		
		private function addComboItem(item:String):void{			
			_combo.addItem(item);			
		}
		
		private function addListener():void{			
			this.addEventListener(Event.ENTER_FRAME, onEnter);	
			
			
			//equipbox
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_BOX0, onBox0);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_BOX1, onBox1);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_BOX2, onBox2);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_BOX3, onBox3);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_BOX4, onBox4);
		
		}	
		
		private function onBox0(e:JockeyEquipEvent):void{			
			setEquipJockey(_tabPanel._part, _tabPanel._type, _tabPanel._mesh);		
		}		
		private function onBox1(e:JockeyEquipEvent):void{
			setEquipJockey(_tabPanel._part, _tabPanel._type, _tabPanel._mesh);
		}
		private function onBox2(e:JockeyEquipEvent):void{		
			setEquipJockey(_tabPanel._part, _tabPanel._type, _tabPanel._mesh);
		}
		private function onBox3(e:JockeyEquipEvent):void{		
			setEquipJockey(_tabPanel._part, _tabPanel._type, _tabPanel._mesh);
		}
		private function onBox4(e:JockeyEquipEvent):void{		
			setEquipJockey( _tabPanel._part, _tabPanel._type, _tabPanel._mesh);
		}
		
		private function onEnter(e:Event):void{
			_view.render();				
		}	
	}
}