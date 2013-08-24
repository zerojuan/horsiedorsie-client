package com.tada.clopclop.test.type.dfaswing.aswingHorseEquip
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.test.type.dfaswing.aswingTool.MainFrame;
	
	import org.aswing.ASColor;
	import org.aswing.AssetPane;
	import org.aswing.FlowLayout;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.geom.IntDimension;

	public class aswingHorseEquip extends MainFrame
	{		
		private var _view:View3D;
		private var lookPanel:HorseLookPanel;
		private var tabPanel:JPanel; //TabbPanel Class
		private var _parameterPanel:JPanel; //Parameter panel class
		
		private var _mainPanel:JPanel;
		
		//layout panel
		private var _top:JPanel;
		private var _vertical1:JPanel;
		private var _vertical2:JPanel;
	
		private var _right:JPanel;
		private var _bottom:JPanel;		
		private var _mid:JPanel;
		private var _title:AssetPane;
		private var _titleSubPanel:JPanel;
		//container panel
		private var _titlePanel:JPanel;	
		private var _tabPanel:JPanel;
		
		//height width
		private var mainWidth:int = 720;
		private var mainHeight:int = 800;
		
		private var lookPanelHeight:int;	
		
		private var titleWidth:int;
		private var titleHeight:int = 50;
				
		private var v1Width:int = 30;
		private var v1Height:int;
		
		private var v2Width:int = 30;
		private var v2Height:int;
		
		private var paraWidth:int = 200;
		private var paraHeight:int;
		
		private var tabWidth:int = 700;
		private var tabHeight:int = 240;
		
		private var titleSubWidth:int = 120;
					
		public function aswingHorseEquip(owner:*=null, title:String="", modal:Boolean=false)
		{			
			_view = new View3D;
			this.title = title;
			super(owner);	
			initializePanel();
			initialization();			
			createUI();	
			addComponent();
			setSkinBackground();
			show();
		}	
		
		private function initializePanel():void{
			lookPanel = new HorseLookPanel(_view);	
			lookPanelHeight = lookPanel.height;	
			
			trace(lookPanel.height);
			
			tabPanel = new JPanel;
			tabPanel.setPreferredSize(new IntDimension(tabWidth,tabHeight));	
			
			_parameterPanel = new JPanel;			
			_parameterPanel.setPreferredSize(new IntDimension(paraWidth,  lookPanelHeight));			
		}
		
		
		private function initialization():void{		
			
			_title = new AssetPane(new LabelHorseEquipment);							
			_title.setPreferredSize(new IntDimension(380,80));	
			
			_titleSubPanel = new JPanel;
			_titleSubPanel.setPreferredSize(new IntDimension(titleSubWidth,80));		
				
			titleWidth = mainWidth;	//_panelGroupClose.width = 60
				
			paraHeight = lookPanelHeight;
			v1Height = lookPanelHeight;
			v2Height = lookPanelHeight;
			
			_mainPanel = new JPanel;
			_mainPanel.setPreferredSize(new IntDimension(mainWidth,mainHeight));				
			
			//layout panel	
			_titlePanel = new JPanel;
			_titlePanel.setPreferredSize(new IntDimension(titleWidth,titleHeight));	
			
			_vertical1 = new JPanel;
			_vertical1.setPreferredSize(new IntDimension(v1Width,v1Height));				
			
			_vertical2 = new JPanel;
			_vertical2.setPreferredSize(new IntDimension(v2Width,v2Height));				
		}		
		
		private function createUI():void{
			//getContentPane().append(_mainPanel);	
			this.changePrimaryPanel(_mainPanel);
			this.changeTabPanel(tabPanel);
		}
		private function addComponent():void{	
			//append panel to containers	
			_titlePanel.append(_titleSubPanel);
			_titlePanel.append(_title);
			
			_mainPanel.append(_titlePanel);
			_mainPanel.append(_vertical1);
			_mainPanel.append(lookPanel);
			_mainPanel.append(_vertical2);
			_mainPanel.append(_parameterPanel);		
			//_mainPanel.append(_tabPanel);				
		}		
		private function setSkinBackground():void{
			//_titlePanel.setOpaque(true);
			//_titlePanel.setBackground(new ASColor(0xF4A0AA));
			
			_vertical1.setOpaque(true);
			_vertical1.setBackground(new ASColor(0xF4A0AA));
			
			_vertical2.setOpaque(true);
			_vertical2.setBackground(new ASColor(0xF4A0AA));
			
			_parameterPanel.setOpaque(true);
			_parameterPanel.setBackground(new ASColor(0xF4A0AA));
			
			tabPanel.setOpaque(true);
			tabPanel.setBackground(new ASColor(0xF4A0AA))
		}
	}
}