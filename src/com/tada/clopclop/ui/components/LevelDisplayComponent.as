package com.tada.clopclop.ui.components
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class LevelDisplayComponent extends Sprite implements IComponent {
		protected var _firstDigit:MovieClip;
		protected var _secondDigit:MovieClip;
		protected var _levelValue:int;
		
		public function LevelDisplayComponent(levelText:DisplayObject, firstDigit:MovieClip, secondDigit:MovieClip, textGapAdjustment:int = 0, initialLevel:int = 0) {
			addChild(levelText);
			_firstDigit = firstDigit;
			_firstDigit.x = levelText.x + levelText.width;
			_firstDigit.y = (levelText.height / 2) - (_firstDigit.height / 2); 
			addChild(_firstDigit);
			_secondDigit = secondDigit;
			_secondDigit.x = _firstDigit.x + _firstDigit.getChildAt(0).width + textGapAdjustment;
			_secondDigit.y = _firstDigit.y;
			addChild(_secondDigit);
			setLevel(initialLevel);
		}
		
		public function setLevel(level:int):void {
			_levelValue = level;
			var firstDigit:int = Math.floor((level - (level % 10)) / 10) + 1;
			_firstDigit.gotoAndStop(firstDigit);
			var secondDigit:int = Math.floor(level % 10) + 1;
			_secondDigit.gotoAndStop(secondDigit);
		}
		
		public function getLevel():int {
			return _levelValue;
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