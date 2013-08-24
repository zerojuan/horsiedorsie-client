package com.tada.clopclop.horseequip.HorseComponent
{
	import com.tada.clopclop.ui.UIMainFrame;
	import com.tada.clopclop.ui.components.IComponent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;


	[SWF (width = "700", height = "700", backgroundColor = "0xF4A0AA")] 
	
	public class HorseEquipmentFrame extends UIMainFrame
	{						
		
		public function HorseEquipmentFrame()
		{				
			setFrame();			
		}		
		
		public function Show(_parent:DisplayObjectContainer):void{
			uiFrame.showUI(_parent);	
		}
		public function Hide():void{
			uiFrame.hideUI();
		}
		private function setFrame():void{
			uiFrame = new UIMainFrame(new SkinFrame, new LabelHorseEquipment);			
		}
		
		public function addComponent(_name:String, _component:IComponent, X:int, Y:int):void{
			uiFrame.addComponent(_name,_component, X, Y);			
		}
		
		public function get centerWidthUI():int{
			return uiFrame.width/2;			
		}
		public function get centerHeightUI():int{
			return uiFrame.height/2;			
		}		
			
	}
}