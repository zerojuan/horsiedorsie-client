package com.tada.clopclop.jockeyequip.JockeyComponent
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.jockeyequip.JockeyComponent.look.JockeyLookPanel;
	import com.tada.clopclop.jockeyequip.JockeyComponent.tab.JockeyTabbedPanel;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.ui.UIMainFrame;
	
	import flash.display.Sprite;
	import flash.events.Event;


	[SWF (width = "700", height = "700", backgroundColor = "0xF4A0AA")] 
	
	public class JockeyEquipmentFrame extends Sprite
	{	
		private var _view:View3D;
		private var _camera:CameraHover;
		
		private var _tabPanel:JockeyTabbedPanel;
		private var _lookPanel:JockeyLookPanel;
		
		public function JockeyEquipmentFrame()
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
			_camera.fov = 60;
			_view = new View3D;
			_view.camera = _camera;	
			
			_lookPanel = new JockeyLookPanel(_view);;
			_tabPanel = new JockeyTabbedPanel;		
			//_paraPanel = new ParamPanel;
			
		}
		private function setTestParameter():void{
			_lookPanel.setEquipJockey("B","Top",3)
		}
		
		private function addComponent():void{
			
		
		}
		
		private function setProperties():void{
				
			
		}
		
		private function setFrame():void{
			var uiFrame:UIMainFrame = new UIMainFrame(new SkinFrame, new LabelJockeyEquipment);			
				
			uiFrame.addComponent("TabPanel", _tabPanel, (uiFrame.width /2) - (_tabPanel.width / 2), uiFrame.height - (_tabPanel.height  + 70) );
			//uiFrame.addComponent("ParameterPanel",_paraPanel, uiFrame.width - _paraPanel.width + 150,50);
			uiFrame.addComponent("LookPanel", _lookPanel, 50, 50);
				
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