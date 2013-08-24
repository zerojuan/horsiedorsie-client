package com.tada.clopclop.test.type.dfcomponents
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.test.type.dfcomponents.look.HLookPanel;
	import com.tada.clopclop.test.type.dfcomponents.parameter.ParameterPanel;
	import com.tada.clopclop.test.type.dfcomponents.tab.HorseTabPanel;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.ui.UIMainFrame;
	
	import flash.display.Sprite;
	import flash.events.Event;


	[SWF (width = "700", height = "700", backgroundColor = "0xF4A0AA")] 
	
	public class dfmain extends Sprite
	{	
		private var _view:View3D;
		private var _camera:CameraHover;
		
		private var _lookPanel:HLookPanel;
		private var _tabPanel:HorseTabPanel;
		private var _paraPanel:ParameterPanel;
		
		public function dfmain()
		{
			initialization();
			setTestParameter();
			addComponent();
			setProperties();
			setFrame();
			addListener();
			
		}
		private function initialization():void{					
			
			_camera = new CameraHover(stage);
			_camera.setCameraPreset(CameraHover.CAMHOVER_MOUSEDRIVEN);
			
			_view = new View3D;
			_view.camera = _camera;	
			
			_lookPanel = new HLookPanel(_view);
			_tabPanel = new HorseTabPanel;		
			_paraPanel = new ParameterPanel;
			
		}
		private function setTestParameter():void{
			_lookPanel.setEquipHorse("E","Wing",0)
		}
		
		private function addComponent():void{
			
		
		}
		
		private function setProperties():void{
				
			
		}
		
		private function setFrame():void{
			var uiFrame:UIMainFrame = new UIMainFrame(new SkinFrame, new LabelHorseEquipment);				
			
			uiFrame.addComponent("TabPanel", _tabPanel, (uiFrame.width /2) - (_tabPanel.width / 2), 320);
			uiFrame.addComponent("LookPanel", _lookPanel, 50, 50);
			uiFrame.addComponent("ParameterPanel",_paraPanel, 100, 100);			
			
			uiFrame.showUI(this);			
		}
		
		private function addListener():void{
			this.addEventListener(Event.ENTER_FRAME, onEnter);			
		}
		private function onEnter(e:Event):void{
			_view.render();				
		}
	}
}