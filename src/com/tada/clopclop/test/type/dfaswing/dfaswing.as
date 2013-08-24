package com.tada.clopclop.test.type.dfaswing
{
	 	import com.away3d.containers.View3D;
	 	import com.tada.clopclop.horseequip.tool.EquipHorse;
	 	import com.tada.clopclop.test.type.dfaswing.aswingHorseEquip.HorseLookPanel;
	 	import com.tada.clopclop.test.type.dfaswing.aswingHorseEquip.aswingHorseEquip;
	 	import com.tada.clopclop.test.type.dfaswing.aswingJockeyEquip.JockeyLookPanel;
	 	import com.tada.clopclop.test.type.dfaswing.aswingTool.MainFrame;
	 	import com.tada.clopclop.test.type.dfaswing.temp.dfTabHorseEquip;
	 	import com.tada.clopclop.toolsets.camera.CameraHover;
	 	import com.tada.clopclop.toolsets.character.horse.HorseAsset;
	 	
	 	import flash.display.DisplayObject;
	 	import flash.display.Sprite;
	 	import flash.events.Event;
	 	import flash.events.MouseEvent;
	 	import flash.net.URLRequest;
	 	
	 	import org.aswing.ASColor;
	 	import org.aswing.BorderLayout;
	 	import org.aswing.FlowLayout;
	 	import org.aswing.GridLayout;
	 	import org.aswing.Insets;
	 	import org.aswing.JButton;
	 	import org.aswing.JFrame;
	 	import org.aswing.JLabel;
	 	import org.aswing.JLoadPane;
	 	import org.aswing.JPanel;
	 	import org.aswing.JTabbedPane;
	 	import org.aswing.border.EmptyBorder;
	 	import org.aswing.geom.IntDimension;
	 	import org.aswing.geom.IntPoint;
		
		[SWF(height = "800", width= "800")]	
		
		public class dfaswing extends Sprite
		{
			private var _view:View3D;
			private var _equipHorse:EquipHorse;
			private var _horseAsset:HorseAsset;
			
		
			private var label : JLabel;
			private var label2:JLabel;
			private var tab:dfTabHorseEquip;
			
			private var lookPanelHorse:HorseLookPanel;
			private var lookPanelJockey:JockeyLookPanel;
			private var horseTab:dfTabHorseEquip;
			
			private var loader:JLoadPane;
			private var camera:CameraHover;			
			
			//[Embed(source = '..\dfBG.png')]
			//private var pic:Class;
			
			//private var _bg:DisplayObject = new pic;
			public function dfaswing(){				
				
				initialization();
				callFrame();				
				addListener();
				
			}
			private function initialization():void{
				_view = new View3D;				
				camera = new CameraHover(stage);
				_view.camera = camera;
				camera.setCameraPreset(CameraHover.CAMHOVER_MOUSEDRIVEN);				
				
			}
			
			private function addListener():void{
				stage.addEventListener(Event.ENTER_FRAME, onEnter);
			}
			
			private function callFrame() : void{
				var frame:aswingHorseEquip = new aswingHorseEquip(this);					
				frame.show();
			}			
			
			private function onEnter(e:Event):void{
				_view.render();				
			}
		}
	}