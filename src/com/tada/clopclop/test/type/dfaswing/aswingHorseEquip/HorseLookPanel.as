package com.tada.clopclop.test.type.dfaswing.aswingHorseEquip
{
	import com.away3d.cameras.HoverCamera3D;
	import com.away3d.cameras.lenses.PerspectiveLens;
	import com.away3d.containers.View3D;
	import com.away3d.events.MouseEvent3D;
	import com.tada.clopclop.horseequip.tool.EquipHorse;
	import com.tada.clopclop.test.type.dfaswing.aswingTool.lookBG;
	import com.tada.engine.TEngine;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.managers.LayoutManager;
	
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.AssetPane;
	import org.aswing.BorderLayout;
	import org.aswing.BoxLayout;
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.JComboBox;
	import org.aswing.JPanel;
	import org.aswing.JTextArea;
	import org.aswing.StyleTune;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;

	public class HorseLookPanel extends JPanel
	{		
		private var _equipHorse:EquipHorse;
		private var _view:View3D
		private var view3dPane:AssetPane;
		private var camera:HoverCamera3D;
		
		//private var _buttonReset:JButton;	
		private var _buttonReset:AssetPane;
		private var _comboBox:JComboBox;
		
		private var _panelButton:JPanel;
		private var _panelCombo:JPanel;
		private var _panelMain:JPanel;
		
		private var carray:Array = [];
		private var pt:IntPoint;	
		
		private var cHeight:int = 260;
		private var cWidth:int =270;
		
		public function HorseLookPanel(view:View3D)		{		
			//_stage = TEngine.mainStage;				
			_view = view;			
						
			initialization();							
			setProperties();
			addComponent();
			setSkinBackground();
		
			fillCombo();
		}		
		
		private function setProperties():void{
			setSize(new IntDimension(cWidth +15,cHeight +20));
			setPreferredSize(new IntDimension(cWidth + 15,cHeight +5));	
			//this.setSize(new IntDimension(800,400));
			//setBackgroundDecorator(new lookBG);	
			
		}
		
		private function initialization():void{
			var buttonH:int = 45, buttonW:int = 80;
			
			//point
			pt = new IntPoint(0,0);
			
			//horse asset
			_equipHorse = new EquipHorse(_view);
			
			//AssetPane
			view3dPane = new AssetPane(_view);
			view3dPane.setOffsetX(-100);
			view3dPane.setOffsetY(-130);			
			view3dPane.setPreferredSize(new IntDimension(cWidth,360));			
			
			//jButton
			//_buttonReset = new JButton("Reset");				
			//_buttonReset.setPreferredSize(new IntDimension(50,25));	
			
			_buttonReset= new AssetPane(new SkinResetBtn);
			_buttonReset.setPreferredSize(new IntDimension(buttonW,buttonH));
			
			_buttonReset.setLocation(new IntPoint(50,50));
			//JComboBox
			_comboBox = new JComboBox();
			_comboBox.setPreferredSize(new IntDimension(150,25));			
			
			//JPane			
			_panelMain = new JPanel();				
			_panelMain.setPreferredSize(new IntDimension(cWidth,cHeight - 80));	
			
			_panelButton = new JPanel();				
			_panelButton.setPreferredSize(new IntDimension(cWidth,buttonH));
			
			_panelCombo = new JPanel();				
			_panelCombo.setPreferredSize(new IntDimension(cWidth,buttonH));			
			//background decorator			
			
		}	
		
		private function fillCombo():void{			
			carray[0] = "Kabayo1";
			carray[1] = "Kabayo2";
			carray[2] = "Kabayo3";
			
			_comboBox.setListData(carray);
		}
		
		private function addComponent():void{				
		
			append(_panelButton);		
			append(_panelMain);	
			append(_panelCombo);
			
			_panelButton.setLocation(new IntPoint(500,0));			
			
			//set lay out center
			_panelButton.setLayout(new FlowLayout(FlowLayout.CENTER));
			_panelCombo.setLayout(new FlowLayout(FlowLayout.CENTER));			
			_panelMain.setLayout(new FlowLayout(FlowLayout.CENTER));
			
			//append each component to each jpanel
			_panelButton.append(_buttonReset);			
			_panelCombo.append(_comboBox);			
			_panelMain.append(view3dPane);			
		}	
		
		private function setSkinBackground():void{
			//set color
			
			//_panelButton.setOpaque(true);
			//_panelButton.setBackground(new ASColor(0xF4A0AA));
			
			//_panelMain.setOpaque(true);
			//_panelMain.setBackground(new ASColor(0xF4A0AA));
			
			//_panelCombo.setOpaque(true);
			//_panelCombo.setBackground(new ASColor(0xF4A0AA));
			
			//set skin
			this.setBackgroundDecorator(new lookBG(new View3DPanel, 0,10));		
			//_buttonReset.setBackgroundDecorator(new lookBG(new SkinResetBtn));
		}
		
		
	}
}