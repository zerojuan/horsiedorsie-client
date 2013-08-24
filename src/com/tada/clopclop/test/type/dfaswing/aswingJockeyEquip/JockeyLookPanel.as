package com.tada.clopclop.test.type.dfaswing.aswingJockeyEquip
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.horseequip.tool.EquipHorse;
	import com.tada.clopclop.jockeyequip.tool.EquipJockey;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
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
	import org.aswing.JLoadPane;
	import org.aswing.JPanel;
	import org.aswing.JTextArea;
	import org.aswing.StyleTune;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;

	public class JockeyLookPanel extends JPanel
	{		
		private var cHeight:int = 220;
		private var cWidth:int =200;
		private var _equipJockey:EquipJockey;
		private var _view:View3D
		private var view3dPane:AssetPane;
		
		private var _buttonReset:JButton;	
		private var _comboBox:JComboBox;
		
		private var _panelButton:JPanel;
		private var _panelCombo:JPanel;
		private var _panelMain:JPanel;
		
		private var carray:Array = [];
		private var pt:IntPoint;		
		
		private var loader:JLoadPane;
		private var viewLoader:JPanel;
		
		public function JockeyLookPanel(view:View3D)
		{
			_view = view;			
			
			setProperties();
			initialization();			
			addComponent();	
			addListener();						
		}		
		
		private function setProperties():void{
			setSize(new IntDimension(cWidth +10,cHeight));
			setPreferredSize(new IntDimension(cWidth + 10,cHeight));	
			//this.setSize(new IntDimension(800,400));
			//setBackgroundDecorator(new lookBG);	
			setOpaque(true);
			setBackground(ASColor.BLUE);			
		}
		
		private function initialization():void{
						
			//jloadPane
			loader = new JLoadPane;
			loader.load(new URLRequest("http://3.bp.blogspot.com/_UUA1Syr3LZc/TUwCUqVmnqI/AAAAAAAAEns/gagq6oq7oCE/s320/no%2Bmeow.gif"));
			loader.setPreferredSize(new IntDimension(40,40));
			
			//viewLoader
			viewLoader = new JPanel;		
			viewLoader.setPreferredSize(new IntDimension(50,50));
			
			//point
			pt = new IntPoint(0,0);
			
			//horse asset
			_equipJockey = new EquipJockey(_view);
			
			//AssetPane
			view3dPane = new AssetPane(_view);
			view3dPane.setOffsetX(-100);
			view3dPane.setOffsetY(-120);			
			view3dPane.setPreferredSize(new IntDimension(cWidth,360));			
			
			//jButton
			_buttonReset = new JButton("Reset");				
			_buttonReset.setPreferredSize(new IntDimension(50,25));				
			
			//JPane			
			_panelMain = new JPanel();				
			_panelMain.setPreferredSize(new IntDimension(cWidth,cHeight - 65));	
			
			_panelButton = new JPanel();				
			_panelButton.setPreferredSize(new IntDimension(cWidth - 55,30));
			
			_panelCombo = new JPanel();				
			_panelCombo.setPreferredSize(new IntDimension(cWidth,30));			
			//background decorator							
		}			
		
		private function addComponent():void{				
		
			viewLoader.append(loader);
			
			append(viewLoader);
			append(_panelButton);		
			append(_panelMain);				
			
			_panelButton.setLocation(new IntPoint(500,0));
			//_panelMain.invalidate()
			//_panelMain.setLocation(pt);		
			//_panelMain.validate();			
			
			//set color
			_panelButton.setOpaque(true);
			_panelButton.setBackground(new ASColor(0xF4A0AA));
			
			_panelMain.setOpaque(true);
			_panelMain.setBackground(new ASColor(0xF4A0AA));			
			
			viewLoader.setOpaque(true);
			viewLoader.setBackground(new ASColor(0xF4A0AA));	
				
			//set lay out center
			_panelButton.setLayout(new FlowLayout(FlowLayout.CENTER));
			_panelCombo.setLayout(new FlowLayout(FlowLayout.CENTER));			
			_panelMain.setLayout(new FlowLayout(FlowLayout.CENTER));
			
			//append each component to each jpanel
			_panelButton.append(_buttonReset);								
			_panelMain.append(view3dPane);			
		}	
		
		private function addListener():void{
					
		}		
	}
}