package com.tada.clopclop.ui {
	
	import com.tada.clopclop.ui.components.ButtonTypeComponent;
	import com.tada.clopclop.ui.components.FrameComponent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	
	public class UIMainFrame extends FrameComponent {
		protected var _backgroundDisplay:DisplayObject;
		protected var _titleDisplay:DisplayObject;
		
		protected const DONE_BUTTON:String = "doneButton";
		protected const CLOSE_BUTTON:String = "closeButton";
		
		public function UIMainFrame(backgroundDisplay:DisplayObject, titleDisplay:DisplayObject = null) {
			_backgroundDisplay = backgroundDisplay;
			_backgroundDisplay.x = 0;
			_backgroundDisplay.y = 0;
			addChild(_backgroundDisplay);
			
			if (titleDisplay) {
				_titleDisplay = titleDisplay;
				_titleDisplay.x = _backgroundDisplay.x + (_backgroundDisplay.width / 2) - (_titleDisplay.width / 2);
				_titleDisplay.y = _backgroundDisplay.y - (_titleDisplay.height / 4);
				addChild(_titleDisplay);
			}
			
			initObjects();
		}
		
		public function showUI(parent:DisplayObjectContainer, X:int = 0, Y:int = 0):void {
			parent.addChild(this);
			this.x = X;
			this.y = Y;
			addListeners();
		}
		
		public function hideUI(obj:Object = null):void {
			var parent:DisplayObjectContainer = this.parent as DisplayObjectContainer;
			if (parent) {
				parent.removeChild(this as DisplayObject);
			}
			removeListeners();
		}
		
		protected function initObjects():void {
			var closeButton:InteractiveObject = new BtnClose;
			addComponent(CLOSE_BUTTON, new ButtonTypeComponent(closeButton, hideUI), _backgroundDisplay.width - closeButton.width, closeButton.height / 4);
			var doneButton:InteractiveObject = new BtnDone;
			addComponent(DONE_BUTTON, new ButtonTypeComponent(doneButton, hideUI), (_backgroundDisplay.width / 2) - (doneButton.width / 2), _backgroundDisplay.height - doneButton.height + (doneButton.height / 4));
		}
	}
}