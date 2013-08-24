package com.tada.clopclop.ui.components {
	import com.greensock.TweenLite;
	import com.tada.clopclop.ui.textdisplay.AttributeDisplayer;
	import com.tada.clopclop.ui.textdisplay.ITextDisplayer;
	import com.tada.clopclop.ui.textdisplay.RatioDisplayer;
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ProgressBarComponent extends Sprite implements IComponent {
		[Embed(source="../lib/debussy.TTF", fontName="dbsy", fontFamily="dbsy", embedAsCFF="false")]
		private var catcher:Class;
		
		public var textDisplayer:ITextDisplayer;
		
		protected var _bar:DisplayObject;
		protected var _maxPosition:Number;
		protected var _minPosition:Number;
		protected var _currentValue:int;
		protected var _maxValue:int;
		
		protected var _secondBar:DisplayObject;
		protected var _secondValue:int;
		
		protected var _valueDisplay:TextField;
		protected var _valueAmountPrimary:int;
		protected var _valueAmountSecondary:int;
		protected var _currentTweening:Boolean = false;
		
		protected var _icon:MovieClip;
		
		protected const ANIMATION_TIME:Number = 1; //in seconds
		
		public function ProgressBarComponent(background:DisplayObject, bar:DisplayObject, mask:DisplayObject, secondBar:DisplayObject = null, maxLockIcon:Boolean = false, initialValue:int = 0, maxValue:int = 100, textColor:uint = 0xFFFFFF) {
			addChild(background);
			
			_bar = bar;
			_bar.x = (background.width / 2) - (_bar.width / 2);
			_bar.y = (background.height / 2) - (_bar.height / 2);
			addChild(_bar);
			
			mask.x = _bar.x;
			mask.y = _bar.y;
			addChild(mask);
			_bar.mask = mask;
			
			_maxPosition = _bar.x;
			_minPosition = _bar.x - _bar.width;			
			_maxValue = maxValue;
			_currentValue = initialValue;
			_bar.x = _minPosition + ((_currentValue / _maxValue) * (_maxPosition - _minPosition));
			
			if (secondBar) {
				var tempBarHolder:Sprite = new Sprite;
				addChild(tempBarHolder);
				
				_secondBar = secondBar;
				_secondValue = 0;
				_valueAmountSecondary = 0;
				_secondBar.x = _bar.x;
				_secondBar.y = _bar.y;
				
				tempBarHolder.addChild(_secondBar);
				tempBarHolder.addChild(_bar);
				tempBarHolder.mask = mask;
			}
			
			if(!_secondBar){
				textDisplayer = new RatioDisplayer();
			}else{
				textDisplayer = new AttributeDisplayer();
			}
			
			_valueDisplay = new TextField();
			_valueDisplay.mouseEnabled = false;
			_valueDisplay.embedFonts = true;
			var textSize:int = Math.floor(_bar.height * .9); 
			_valueDisplay.defaultTextFormat = new TextFormat("dbsy", textSize, textColor, true, null, null, null, null, TextFormatAlign.CENTER);
			var glowThickness:int = textSize / 4;
			_valueDisplay.filters = [new GlowFilter(0x000000, 1, glowThickness, glowThickness, 20)];
			setDisplayText(_currentValue);
			_valueDisplay.width = background.width;
			_valueDisplay.height = background.height;
			_valueDisplay.x = 0;
			_valueDisplay.y = _bar.y - (_bar.height * .15); //(background.height / 2) - (_valueDisplay.textHeight / 2);
			addChild(_valueDisplay);
			
			if (maxLockIcon) {
				_icon = new IconMaxOrLock;
				_icon.gotoAndStop(1);
				_icon.x = background.width - (_icon.width / 2);
				_icon.y = background.height / 2;
			}
		}
		
		public function setCurrentValue(value:int):void {
			_currentTweening = true;
			_currentValue = value;
			if (_currentValue != _maxValue && _icon != null) {
				hideIcon();
			}
			var targetPosition:Number = _minPosition + ((_currentValue / _maxValue) * (_maxPosition - _minPosition));
			TweenLite.to(_bar, ANIMATION_TIME, {
				x: targetPosition,
				onUpdate: function():void {
					_valueAmountPrimary = ((_bar.x - _minPosition) / (_maxPosition - _minPosition)) * _maxValue;
					if (!_secondBar) {
						setDisplayText(_valueAmountPrimary);
					}
				},
				onComplete: function():void {
					_currentTweening = false;
					_valueAmountPrimary = _currentValue;
					if (!_secondBar) {
						setDisplayText(_valueAmountPrimary);
					}
					if (_currentValue == _maxValue && _icon != null) {
						showMaxIcon();
					}
				}
			});
			if (_secondBar) {
				setSecondValue(_secondValue);
			}
		}
		
		public function getCurrentValue():int {
			return _currentValue;
		}
		
		public function setSecondValue(value:int):void {
			if (_secondBar) {
				_secondValue = value;
				var primaryBarPosition:Number = _minPosition + ((_currentValue / _maxValue) * (_maxPosition - _minPosition));
				var targetPosition:Number = primaryBarPosition + ((_secondValue / _maxValue) * (_maxPosition - _minPosition));
				TweenLite.to(_secondBar, ANIMATION_TIME, {
					x: targetPosition,
					onUpdate: function():void {
						if (!_currentTweening) {
							_valueAmountSecondary = ((_secondBar.x - _bar.x) / (_maxPosition - _minPosition)) * _maxValue;
						}
						setDisplayText(_valueAmountPrimary, _valueAmountSecondary);
					},
					onComplete: function():void {
						_valueAmountSecondary = _secondValue;
						setDisplayText(_valueAmountPrimary, _valueAmountSecondary);
					}
				});
			}
			else {
				Logger.error(this, "setSecondValue", "Function can only be used when there is a second bar available!");
			}
		}
		
		public function setMaxValue(value:int):void {
			_maxValue = value;
		}
		
		public function setTextColor(textColor:uint):void {
			var textFormat:TextFormat = new TextFormat("dbsy", Math.floor(_bar.height * .9), textColor, true, null, null, null, null, TextFormatAlign.CENTER);
			_valueDisplay.defaultTextFormat = textFormat;
			_valueDisplay.setTextFormat(textFormat);
		}
		
		protected function setDisplayText(currentValue:int, secondValue:int = 0):void {
			_valueDisplay.text = textDisplayer.getText(currentValue, secondValue);			
		}
		
		public function getSecondValue():int {
			if (_secondBar) {
				return _secondValue;
			}
			else {
				Logger.error(this, "getSecondValue", "Function can only be used when there is a second bar available!");
			}
			return 0;
		}
		
		public function showLockIcon():void {
			if (_icon) {
				addChild(_icon);
				_icon.gotoAndStop(1);
			}
			else {
				Logger.error(this, "showLockIcon", "Icon does not exist! Please set the maxLockIcon parameter to true during the ProgressBarComponent initialization!");
			}
		}
		
		public function showMaxIcon():void {
			if (_icon) {
				addChild(_icon);
				_icon.gotoAndStop(2);
			}
			else {
				Logger.error(this, "showMaxIcon", "Icon does not exist! Please set the maxLockIcon parameter to true during the ProgressBarComponent initialization!");
			}
		}
		
		public function hideIcon():void {
			if (_icon) {
				if (_icon.parent) {
					_icon.parent.removeChild(_icon);
				}
			}
			else {
				Logger.error(this, "hideLockIcon", "Icon does not exist! Please pass a DisplayObject on the icon parameter during the ProgressBarComponent initialization!");
			}
		}
		
		public function addListeners():void {
		}
		
		public function removeListeners():void {
		}
		
		public function setPosition(X:Number, Y:Number):void {
			this.x = X;
			this.y = Y;
		}
		
		public function getPosition():Point {
			return new Point(this.x, this.y);
		}
		
		public function get displayObject():DisplayObject {
			return this;
		}
	}
}