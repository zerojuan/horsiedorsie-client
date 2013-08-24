package com.tada.clopclop.test.type.dfaswing.aswingHorseEquip
{
	import org.aswing.JPanel;
	import org.aswing.geom.IntDimension;

	public class HorseParameterPanel extends JPanel
	{
		
		//Width Height
		private var mainWidth:int = 200;
		private var mainHeight:int;
		
		public function HorseParameterPanel()
		{
			setProperties();
			initialization();			
			addComponent();
			setSkinBackground();
		}
		private function setProperties():void{
			this.setPreferredSize(new IntDimension());
		}
		private function initialization():void{
			
		}			
		private function addComponent():void{
			
		}
		private function setSkinBackground():void{
			
		}
	}
}