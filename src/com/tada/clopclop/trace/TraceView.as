package com.tada.clopclop.trace
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TraceView
	{
		var _traceViewUI:TraceViewUI;
		
		var currentItem:String;
		
		private var animateButtonArray:Array = [
			
		]
		public function TraceView()
		{
			
		}
		public function initTraceView():void 
		{
			inheritTraceViewUI();
			
			initializePosition(0,527);	
			
			visibility(false);
			
			initializeObjects();
			
			selectItem("");
			
			addListeners();
		}
		private function inheritTraceViewUI():void
		{
			_traceViewUI = new TraceViewUI;
			_traceViewUI.name = "_traceViewUI";
			addChild(_traceViewUI);
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
				var getAnimateButton:Object = _traceViewUI.getChildByName(animateButtonArray[i] + "_animate")
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
			_traceViewUI.DoneButton.addEventListener(MouseEvent.CLICK,clickDoneButton)
			
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