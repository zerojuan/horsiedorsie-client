package com.tada.clopclop.test.type.dfaswing.aswingTool
{
	import com.tada.clopclop.test.type.dfaswing.aswingHorseEquip.HorseLookPanel;
	import com.tada.clopclop.test.type.dfaswing.aswingHorseEquip.aswingHorseEquip;
	
	import org.aswing.ASColor;
	import org.aswing.AssetPane;
	import org.aswing.FlowLayout;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;

	public class MainFrame extends JFrame
	{			
		private var _mainPanel:JPanel;
		private var _primaryPanel:JPanel;
		private var _primaryTabPanel:JPanel;
		
		//containder panels
		private var _title:AssetPane;
		private var _shadow:AssetPane;
		private var _close:AssetPane;
		private var _done:AssetPane;		
		
		//jpanel
		private var _panelTitle:JPanel;
		private var _panelClose:JPanel;
		private var _panelDone:JPanel
		private var _panelBody:JPanel;
		private var _panelTab:JPanel;
		
		//small panel to format layout closebutton and title panel
		private var _panelSubClose:JPanel;
		private var _panelShadow:JPanel;
		
		//group panels
		private var _panelGroupTitle:JPanel;
		private var _panelGroupClose:JPanel;
	
		//main size
		private var mainWidth:int = 700;
		private var mainHeight:int = 700;
		
		private var closeWidth:int = 60;
		private var closeHeight:int = 80;
		
		private var titleWidth:int = mainWidth - 130;
		private var titleHeight:int = 350;
		
		private var tabWidth:int = mainWidth;
		private var tabHeight:int = 240;
		
		private var doneWidth:int = mainWidth - 100;
		private var doneHeight:int = 100;
		
		public function MainFrame(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner);			
			initialization();				
				
			setProperties();
			addComponent();
			setSkinBackground();
		}
		
		private function initialization():void{
			_mainPanel = new JPanel;
			_mainPanel.setPreferredSize(new IntDimension(mainWidth, mainHeight));	
			
			_panelClose = new JPanel;
			_panelClose.setPreferredSize(new IntDimension(closeWidth,closeHeight));			
			
			_panelBody = new JPanel;
			_panelBody.setPreferredSize(new IntDimension(mainWidth,mainHeight - 100)); // total height of shadow/close and done
			
			_panelTab = new JPanel;
			_panelTab.setPreferredSize(new IntDimension(tabWidth,tabHeight));
			
			_panelDone = new JPanel;
			_panelDone.setPreferredSize(new IntDimension(doneWidth,doneHeight));
						
			
			//prepare assets for panel placement			
			_close = new AssetPane(new SkinCloseBtn);
			_close.setPreferredSize(new IntDimension(closeWidth,closeHeight));
			
			_done = new AssetPane(new SkinDoneBtn);
			_done.setPreferredSize(new IntDimension(closeWidth + 50,closeHeight));
			
			_panelSubClose = new JPanel;
			_panelSubClose.setPreferredSize(new IntDimension(closeWidth,20));	
			
			//set group panels
			_panelGroupTitle = new JPanel;
			_panelGroupTitle.setPreferredSize(new IntDimension(titleWidth,titleHeight));
			
			_panelGroupClose = new JPanel;	
			_panelGroupClose.setPreferredSize(new IntDimension(closeWidth + 40,titleHeight));
		}
		
		private function addComponent():void{			
			_panelClose.append(_close);
			_panelDone.append(_done);		
			
			_panelGroupTitle.append(_panelBody);
			
			_panelGroupClose.append(_panelSubClose);
			_panelGroupClose.append(_panelClose);			
			
			//start add panels to mainPanel
			_mainPanel.append(_panelGroupTitle);	
			_mainPanel.append(_panelGroupClose);		
			_mainPanel.append(_panelTab);	
			_mainPanel.append(_panelDone);
							
			
			//center layout				
			_panelClose.setLayout(new FlowLayout(FlowLayout.CENTER));
			_panelBody.setLayout(new FlowLayout(FlowLayout.CENTER));			
			_panelTab.setLayout(new FlowLayout(FlowLayout.CENTER));
			_panelDone.setLayout(new FlowLayout(FlowLayout.CENTER));
			
			this.getContentPane().append(_mainPanel);
		}			
			
		private function setProperties():void{
			setSize(new IntDimension(mainWidth, mainHeight));			
			setClosable(false);	
			
			this.setOpaque(false);
			_mainPanel.setBackgroundDecorator(new lookBG(new SkinFrame, 0 , 40));	
		}
		
		public function changePrimaryPanel(primaryPanel:JPanel):void{
			_primaryPanel = primaryPanel		
			_panelBody.append(_primaryPanel);
		}
		
		public function changeTabPanel(primaryTabPanel:JPanel):void{
			_primaryTabPanel = primaryTabPanel
			_panelTab.append(_primaryTabPanel);
		}
		
		private function setSkinBackground():void{
		
			//_panelClose.setOpaque(true);
			//_panelClose.setBackground(new ASColor(0xF4A0AA));
			
			//_panelSubClose.setOpaque(true);
			//_panelSubClose.setBackground(new ASColor(0xF4A0AA));
			
			//_panelGroupTitle.setOpaque(true);
			//_panelGroupTitle.setBackground(new ASColor(0xF4A0AA));
			
			//_panelGroupClose.setOpaque(true);
			//_panelGroupClose.setBackground(new ASColor(0xF4A0AA));
			
			//_panelTab.setOpaque(true);
			//_panelTab.setBackground(new ASColor(0xF4A0AA));
			
			//_mainPanel.setOpaque(true);
			//_mainPanel.setBackground(ASColor.BLUE);
		}
	}
}