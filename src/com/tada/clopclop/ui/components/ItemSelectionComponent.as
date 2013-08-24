package com.tada.clopclop.ui.components {
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class ItemSelectionComponent extends FrameComponent {
		protected var _displayIndex:int = 0;
		[ArrayElementType("IItemComponent")]
		protected var _itemArray:Array = [];
		protected var _buttons:Array = [];
		protected const LEFT_BUTTON:String = "leftButton";
		protected const RIGHT_BUTTON:String = "rightButton";
		protected var ButtonComponentClass:Class;
		protected var _callBack:Function;
		
		public function ItemSelectionComponent(leftButton:InteractiveObject, rightButton:InteractiveObject, ItemButton:Class, callBack:Function, buttonCount:int = 4, buttonGap:int = 10) {
			_callBack = callBack;
			addComponent(LEFT_BUTTON, new ButtonTypeComponent(leftButton, onLeftClick));
			var buttonReference:DisplayObject = DisplayObject(new ItemButton);
			const X_INIT:Number = leftButton.width + buttonGap;
			const X_ADJ:Number = buttonReference.width + buttonGap;
			
			if (buttonReference is MovieClip) {
				ButtonComponentClass = SpecialButtonComponent;
			}
			else {
				ButtonComponentClass = ButtonTypeComponent;
			}
			
			for (var a:int = 0; a < buttonCount; a++) {
				_buttons[a] = "button" + a;
				addComponent(_buttons[a], IComponent(new ButtonComponentClass(new ItemButton, onItemClick)), X_INIT + (X_ADJ * a), 0);
			}
			
			leftButton.y = buttonReference.height / 2 - (leftButton.height / 2);
			
			if (rightButton == null) {
				var ButtonClass:Class = Class(getDefinitionByName(getQualifiedClassName(leftButton)));
				rightButton = new ButtonClass;
				rightButton.scaleX = -1;
			}
			addComponent(RIGHT_BUTTON, new ButtonTypeComponent(rightButton, onRightClick));
			rightButton.x = X_INIT + (X_ADJ * buttonCount);
			if (rightButton.scaleX < 0) {
				rightButton.x+= rightButton.width;
			}
			rightButton.y = buttonReference.height / 2 - (rightButton.height / 2);
		}
		
		public function addItem(item:IItemComponent):void {
			_itemArray.push(item);
		}
		
		public function clearItemList():void {
			removeItemsFromButtons();
			_itemArray = [];
			_displayIndex = 0;
		}
		
		public function displayItemsToButtons():void {
			var buttonCount:int = 0;
			for (var a:int = _displayIndex; a < _itemArray.length && a < (_displayIndex + _buttons.length); a++) {
				_itemArray[a].displayItem(getComponent(_buttons[buttonCount]).displayObject as InteractiveObject);
				buttonCount++;
			}
		}
		
		public function removeItemsFromButtons():void {
			for (var a:int = 0; a < _itemArray.length; a++) {
				_itemArray[a].removeItem();
			}
		}
		
		protected function onLeftClick(e:MouseEvent):void {
			if (_displayIndex > 0) {
				_displayIndex-= _buttons.length;
				if (_displayIndex < 0) {
					_displayIndex = 0;
				}
				removeItemsFromButtons();
				displayItemsToButtons();
				deactivateButtons();
			}
		}
		
		protected function onRightClick(e:MouseEvent):void {
			if (_displayIndex < _itemArray.length - _buttons.length) {
				_displayIndex+= _buttons.length;
				if (_displayIndex > (_itemArray.length - _buttons.length)) {
					_displayIndex = _itemArray.length - _buttons.length;
				}
				if (_displayIndex < 0) {
					_displayIndex = 0;
				}
				removeItemsFromButtons();
				displayItemsToButtons();
				deactivateButtons();
			}
		}
		
		protected function onItemClick(e:MouseEvent):void {
			deactivateButtons();
			for (var a:int = 0; a < _itemArray.length; a++) {
				if (_itemArray[a].buttonReference == e.target) {
					_callBack(_itemArray[a]);
					return;
				}
			}
			_callBack(null);
		}
		
		public function deactivateButtons():void {
			if (ButtonComponentClass == SpecialButtonComponent) {
				for (var a:int = 0; a < _buttons.length; a++) {
					SpecialButtonComponent(getComponent(_buttons[a])).setToInactive();
				}
			}
		}
	}
}