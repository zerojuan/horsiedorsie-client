package com.tada.clopclop.ui.horseracing.miscellaneous {
	import com.tada.clopclop.ui.components.IItemComponent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class LeagueItem implements IItemComponent {
		[Embed(source="../lib/debussy.TTF", fontName="dbsy", fontFamily="dbsy", embedAsCFF="false")]
		private var catcher:Class;
		
		private var _buttonReference:InteractiveObject;
		private var _name:String;
		private var _nameDisplay:TextField;
		private var _leagueType:String;
		private var _image:DisplayObject;
		private var _lock:DisplayObject;
		private var _active:Boolean = false;
		private var _enabled:Boolean;
		private var _glowFilter:GlowFilter = new GlowFilter(0x000000, 1, 4, 4, 20);
		
		
		public function LeagueItem(name:String, image:DisplayObject, enabled:Boolean = true) {
			_name = name;
			_image = image;
			if (_image is InteractiveObject) {
				InteractiveObject(_image).mouseEnabled = false;
			}
			_lock = new IconLockedAbilitySlotBig;
			if (_lock is InteractiveObject) {
				InteractiveObject(_lock).mouseEnabled = false;
			}
			
			_nameDisplay = new TextField;
			_nameDisplay.mouseEnabled = false;
			_nameDisplay.embedFonts = true;
			_nameDisplay.multiline = true;
			_nameDisplay.wordWrap = true;
			_nameDisplay.defaultTextFormat = new TextFormat("dbsy", 15, 0xBAFF32, false, false, false, null, null, TextFormatAlign.CENTER);
			_nameDisplay.filters = [_glowFilter];
			_nameDisplay.height = 50;
			_nameDisplay.width = 100;
			_nameDisplay.text = name;
			
			_enabled = enabled;
			if (_enabled == false) {
				setToDisabled();
			}
		}
		
		public function displayItem(buttonReference:InteractiveObject):void {
			_buttonReference = buttonReference;
			var parent:DisplayObjectContainer = _buttonReference.parent;
			if (parent) {
				_nameDisplay.x = _buttonReference.x + (_buttonReference.width / 2) - (_nameDisplay.width / 2);
				_nameDisplay.y = _buttonReference.y + ((_buttonReference.height / 4) * 3);
				parent.addChild(_nameDisplay);
				
				_image.x = _buttonReference.x + (_buttonReference.width / 2) - (117 / 2);
				_image.y = _buttonReference.y + (_buttonReference.height / 3) - (117 / 2);
				parent.addChild(_image);
				
				addLock();
			}
		}
		
		public function removeItem():void {
			_buttonReference = null;
			removeObject(_image);
			removeObject(_nameDisplay);
			removeObject(_lock);
		}
		
		public function get buttonReference():InteractiveObject {
			return _buttonReference;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function setToInactive():void {
			if (_enabled) {
				_active = false;
				_nameDisplay.filters = [_glowFilter];
			}
		}
		
		public function setToActive():void {
			if (_enabled) {
				_active = true;
				var colorMatrix:Array = [
					1, 0, 0, 0, 0,
					0, 1, 0, 0, 0,
					0, 0, 5, 0, 0,
					0, 0, 0, 1, 0
				];
				var colorFilter:ColorMatrixFilter = new ColorMatrixFilter(colorMatrix);
				var glowFilter:GlowFilter = new GlowFilter(0x0000FF, 1, 4, 4, 20);
				_nameDisplay.filters = [glowFilter, colorFilter];
			}
		}
		
		public function setToEnabled():void {
			_enabled = true;
			_image.filters = [];
			_nameDisplay.filters = [_glowFilter];
			removeObject(_lock);
		}
		
		public function setToDisabled():void {
			_enabled = false;
			var colorMatrix:Array = [
				.4, .4, .4, 0, 0,
				.4, .4, .4, 0, 0,
				.4, .4, .4, 0, 0,
				0, 0, 0, .8, 0
			];
			var colorFilter:ColorMatrixFilter = new ColorMatrixFilter(colorMatrix);
			_image.filters = [colorFilter];
			_nameDisplay.filters = [_glowFilter, colorFilter];
			addLock();
		}
		
		private function addLock():void {
			if (buttonReference && _enabled == false) {
				var parent:DisplayObjectContainer = buttonReference.parent;
				if (parent) {
					_lock.x = _image.x + (117 / 2) - (_lock.width / 2);
					_lock.y = _image.y + (117 /2 ) - (_lock.height / 2);
					parent.addChild(_lock);
				}
			}
		}
		
		private function removeObject(object:DisplayObject):void {
			var parent:DisplayObjectContainer = object.parent;
			if (parent) {
				parent.removeChild(object);
			}
		}
		
		public function get active():Boolean {
			return _active;
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
	}
}