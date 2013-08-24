package com.tada.clopclop.ui.horseinfo.frames
{
	import com.tada.clopclop.ui.components.FrameComponent;
	
	import flash.display.DisplayObject;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class HorseInfoWinRateFrame extends FrameComponent {
		[Embed(source="../lib/debussy.TTF", fontName="dbsy", fontFamily="dbsy", embedAsCFF="false")]
		private var catcher:Class;
		
		private var _winningRateText:TextField;
		private var _topText:TextField;
		
		public function HorseInfoWinRateFrame() {
			var winRate:DisplayObject = new LabelWinningRate;
			addDisplayObject(winRate, 0, 0);
			
			var top:DisplayObject = new LabelTop;
			addDisplayObject(top, winRate.x + (winRate.width / 2) - (top.width / 2), winRate.y + winRate.height + 5);
			
			_winningRateText = new TextField;
			_winningRateText.embedFonts = true;
			_winningRateText.height = winRate.height;
			_winningRateText.width = 80;
			_winningRateText.defaultTextFormat = new TextFormat("dbsy", winRate.height * .7, 0xFFFFFF, true, false, false, null, null, TextFormatAlign.RIGHT);
			_winningRateText.filters = [new GlowFilter(0x000000, 1, 4, 4, 20)];
			_winningRateText.mouseEnabled = false;
			_winningRateText.text = "00.0%";
			addDisplayObject(_winningRateText, winRate.x + winRate.width + 10, winRate.y);
			
			_topText = new TextField;
			_topText.embedFonts = true;
			_topText.height = _winningRateText.height;
			_topText.width = _winningRateText.width;
			_topText.defaultTextFormat = _winningRateText.defaultTextFormat;
			_topText.filters = _winningRateText.filters;
			_topText.mouseEnabled = false;
			_topText.text = _winningRateText.text;
			addDisplayObject(_topText, _winningRateText.x, top.y);
		}
		
		public function setWinningRateValue(value:Number):void {
			_winningRateText.text = value.toFixed(1) + "%";
		}
		
		public function setTopValue(value:Number):void {
			_topText.text = value.toFixed(1) + "%";
		}
		
		private function addDisplayObject(object:DisplayObject, X:int = 0, Y:int = 0):void {
			addChild(object);
			object.x = X;
			object.y = Y;
		}
	}
}