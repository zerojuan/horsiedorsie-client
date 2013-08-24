package com.tada.clopclop.mail
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class MailView
	{
		private var _mailViewUI:MailViewUI;
		private var CURRENT_ITEM:String
		
		public function MailView()
		{
		}
		
		public function initMailView():void 
		{
			inheritMailViewUI();
			
			initializePosition(0,527);	
			
			visibility(false);
			
			initializeObjects();
			
			selectItem("");
			
			addListeners();
		}
		private function inheritMailViewUI():void
		{
			_mailViewUI = new MailViewUI;
			_mailViewUI.name = "_mailViewUI";
			addChild(_mailViewUI);
		}
		private function selectItem(selected:String):void 
		{
			var selected_animate:Object = _redecorateUI.getChildByName(selected + "_animate");
			var selected_button:Object = _redecorateUI.getChildByName(selected + "_button");
			var current_animate:Object = _redecorateUI.getChildByName(CURRENT_ITEM + "_animate");
			var current_button:Object = _redecorateUI.getChildByName(CURRENT_ITEM + "_button");
			
			selected_animate.visible = true;
			selected_button.visible = false;	
			
			if(current_animate != null) 
			{
				current_animate.visible = false;
				current_button.visible = true;
			}
			
			CURRENT_ITEM = selected
		}
		private function initializeObjects():void {
			resetAnimateButtons(false);
		}
		
		private function resetAnimateButtons(value:Boolean):void
		{
			for (var i:Number=0; i<animateButtonArray.length; i++) 
			{
				var getAnimateButton:Object = _traceUI.getChildByName(animateButtonArray[i] + "_animate")
				getAnimateButton.visible = value
			}
		}
		
		public function visibility(value:Boolean):void 
		{
			visible = value
		}
		
		private function addListeners():void 
		{
			//click listeners
			_mailViewUI.DoneButton.addEventListener(MouseEvent.CLICK,clickDoneButton)
			
		}
		private function clickDoneButton(me:MouseEvent):void 
		{
			var _clopClopMainController:Object = parent.getChildByName("_clopClopMainController");
			_clopClopMainController.hideTraceView();
			_clopClopMainController.showSocial();
		}
		private function initializePosition(pos_x:Number,pos_y:Number):void 
		{
			x = pos_x;
			y = pos_y;
		}
	}
}