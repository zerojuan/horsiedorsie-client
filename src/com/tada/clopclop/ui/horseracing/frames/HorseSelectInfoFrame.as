package com.tada.clopclop.ui.horseracing.frames {
	import com.tada.clopclop.ui.components.FrameComponent;
	import com.tada.clopclop.ui.components.LevelDisplayComponent;
	import com.tada.clopclop.ui.components.RankDisplayComponent;
	
	import flash.display.DisplayObject;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class HorseSelectInfoFrame extends FrameComponent	{
		[Embed(source="../lib/debussy.TTF", fontName="dbsy", fontFamily="dbsy", embedAsCFF="false")]
		private var catcher:Class;
		
		private const RANK_DISPLAY:String = "rankDisplay";
		private const LEVEL_TEXT:String = "levelText";
		
		private var _horseNameText:TextField;
		private var _winningRateText:TextField;
		private var _topText:TextField;
		
		public function HorseSelectInfoFrame() {
			var textBubble:DisplayObject = new SkinHorseSelectHorseIdentifier;
			addChild(textBubble);
			
			initObjects();
		}
		
		public function initObjects():void {
			var winRate:DisplayObject = new LabelWinningRate;
			addDisplayObject(winRate, 260, 25);
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
			
			_horseNameText = new TextField;
			_horseNameText.embedFonts = true;
			_horseNameText.height = _winningRateText.height;
			_horseNameText.width = _winningRateText.width * 3;
			_horseNameText.defaultTextFormat = new TextFormat("dbsy", winRate.height * .7, 0xFFFFFF, true, false, false, null, null, TextFormatAlign.LEFT);
			_horseNameText.filters = _winningRateText.filters;
			_horseNameText.mouseEnabled = false;
			_horseNameText.text = "Richie the Horsie";
			addDisplayObject(_horseNameText, 30, top.y);
			
			addComponent(RANK_DISPLAY, new RankDisplayComponent(new IconRankBig), _horseNameText.x, winRate.y - 5);
			addComponent(LEVEL_TEXT, new LevelDisplayComponent(new LabelLvl, new LabelGradientBlueDebussy, new LabelGradientBlueDebussy, -5), getComponent(RANK_DISPLAY).getPosition().x + getComponent(RANK_DISPLAY).displayObject.width + 10, winRate.y + 5);
		}
		
		private function addDisplayObject(object:DisplayObject, X:int = 0, Y:int = 0):void {
			addChild(object);
			object.x = X;
			object.y = Y;
		}
		
		public function setWinningRateValue(value:Number):void {
			_winningRateText.text = value.toFixed(1) + "%";
		}
		
		public function setTopValue(value:Number):void {
			_topText.text = value.toFixed(1) + "%";
		}
		
		public function setHorseName(name:String):void {
			_horseNameText.text = name;
		}
		
		public function setRankDisplay(rank:int):void {
			RankDisplayComponent(getComponent(RANK_DISPLAY)).setRank(rank);
		}
		
		public function setLevelDisplayValue(value:int):void {
			LevelDisplayComponent(getComponent(LEVEL_TEXT)).setLevel(value);
		}
	}
}