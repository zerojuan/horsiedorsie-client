package com.tada.clopclop.ui.miscellaneous {
	import com.tada.clopclop.Constants;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class SelectionInfo {
		[Embed(source="../lib/debussy.TTF", fontName="hahah", fontFamily="hahah", embedAsCFF="false")]
		protected var junk:String;
		
		public var id:int;
		public var name:String;
		public var amount:int;
		public var currencyType:String;
		public var index:int;
		public var buttonReference:DisplayObject;
		
		private var _image:DisplayObject;
		private var _icon:DisplayObject;
		private var _amountDisplay:TextField;
		
		private var _textFormat:TextFormat = new TextFormat("hahah", 14, 0x2BD92A, true, null, null, null, null, TextFormatAlign.CENTER);
		private var _glow:GlowFilter = new GlowFilter(0x000000, 1, 5, 5, 10, 1);
		
		public function SelectionInfo(image:DisplayObject, name:String, currencyType:String, amount:int, id:int = -1) {
			this.id = id;
			this._image = image;
			if (_image is InteractiveObject) {
				(_image as InteractiveObject).mouseEnabled = false;
			}
			this.name = name;
			this.currencyType = currencyType;
			this.index = index;
			this.amount = amount;
			if (currencyType == Constants.CASH) {
				_icon = new IconCash;
				_textFormat.color = 0xF7F392;
			}
			else if (currencyType == Constants.ENERGY) {
				_icon = new IconEnergy;
				_textFormat.color = 0x5CF048;
			}
			_amountDisplay = new TextField;
			_amountDisplay.embedFonts = true;
			_amountDisplay.defaultTextFormat = _textFormat;
			_amountDisplay.mouseEnabled = false;
			_amountDisplay.text = String(this.amount);
			_amountDisplay.filters = [_glow];
		}
		
		public function addSelectionToButton(button:DisplayObject):void {
			buttonReference = button;
			var parent:DisplayObjectContainer = buttonReference.parent;
			if (parent) {
				parent.addChild(_image);
				_image.x = buttonReference.x;
				_image.y = buttonReference.y;
				//_image.x = buttonReference.x + (buttonReference.width / 2) - (_image.width / 2);
				//_image.y = buttonReference.y + (buttonReference.height / 2) - (_image.height / 2);
				parent.addChild(_amountDisplay);
				_amountDisplay.x = buttonReference.x + (buttonReference.width / 2) - (_amountDisplay.width / 2);
				_amountDisplay.y = buttonReference.y + (buttonReference.width / 2) + 15;
				if (currencyType == Constants.CASH || currencyType == Constants.ENERGY) {
					parent.addChild(_icon);
					_icon.x = buttonReference.x + (buttonReference.width / 4);
					_icon.y = buttonReference.y + (buttonReference.width / 2) + 25;
					_amountDisplay.x+= buttonReference.width / 7;	
				}
			}
		}
		
		public function removeSelection():void {
			if (buttonReference) {
				buttonReference = null;
				if (_image.parent) {
					_image.parent.removeChild(_image);
				}
				if (_amountDisplay.parent) {
					_amountDisplay.parent.removeChild(_amountDisplay);
				}
				if (currencyType == Constants.CASH || currencyType == Constants.ENERGY) {
					if (_icon.parent) {
						_icon.parent.removeChild(_icon);
					}
				}
			}
		}
	}
}