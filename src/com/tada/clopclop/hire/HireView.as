package com.tada.clopclop.hire
{
	import com.tada.clopclop.ClopClopMainController;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class HireView
	{
		private var _hireUI:HireView
		
		public function HireView()
		{
			
		}
		
		public function initHireView ():void;
		{
			inheritHireUI();
			initializePosition(0,522);
			visibility(false);
			initializeObjects();
			addListeners();
		}
import flash.events.MouseEvent;
		
		private function inheritHireUI():void 
		{
			_hireUI = new HireUI;
			_hireUI.name = "_hireUI";
			addChild(_hireUI);
		}
		
		private function selectItem(selected:String):void
		{
			
		}
		
		private function initializeObjects():void {
			resetAnimateButtons(false);
		}
		
		private function resetAnimateButtons(value:Boolean):void
		{
			for (var i:Number=0; i<animateButtonArray.length; i++) 
			{
				var getAnimateButton:Object = _hireViewUI.getChildByName(animateButtonArray[i] + "_animate")
				getAnimateButton.visible = value
			}
		}
		
		public function visibility(value:Boolean):void 
		{
			visible = value
		}
		
		private function addListeners():void;
		{
			//click Listeners
			_hireUI.addEventListeners(MouseEvent.CLICK
		}
		
		private function clickDoneButton(me:MouseEvent):void
		{
			var _clopClopMainController:Object = parent.getChildByName("_clopClopMainController");
			_clopClopMainController.hideHire();
			_clopClopMainController.showSocial();
			
		}
		
		private function initializePosition(pos_x:Number,pos_y:Number):void 
		{
			x = pos_x;
			y = pos_y;
		}

	}
}