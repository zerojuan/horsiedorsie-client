package com.tada.clopclop.swing
{
	import com.tada.clopclop.swing.decorator.DefaultClopClopBG;
	import com.tada.clopclop.test.type.Horse;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import org.aswing.BorderLayout;
	import org.aswing.EmptyLayout;
	import org.aswing.FrameTitleBarLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import org.aswing.JWindow;
	import org.aswing.geom.IntRectangle;

	public class ClopClopWindow extends JFrame
	{
		private var _closeButton:JButton;
		
		public function ClopClopWindow(owner:* = null, modal:Boolean = false) 
		{
			//super(owner, modal);
			super(owner, "", modal);
			setBackgroundDecorator(new DefaultClopClopBG());
			
			getContentPane().append(initUI());
			
			
		}
		
		private function initUI():JPanel{
			var _panel:JPanel = new JPanel();
			
			_closeButton = new JButton();
			_closeButton.wrapSimpleButton(new SkinCloseBtn);

												
			
			_closeButton.addActionListener(onClose);			
									
			getTitleBar().setCloseButton(_closeButton);
			var horse:HorseEquipName = new HorseEquipName();
			_panel.addChild(horse);
			horse.x = 20;
			
			return _panel;
		}
		
		private function onClose(evt:Event):void{
			this.dispose();
		}
	}
}