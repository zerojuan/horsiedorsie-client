package com.tada.clopclop.screen
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;

	public class LevelModel extends Sprite
	{
		private var _levelUI:LevelUI
		
		public function LevelModel()
		{
		}
		public function inheritLevelUI (pos_x:Number, pos_y:Number):void 
		{
			_levelUI = new (getDefinitionByName("LevelUI") as Class)();
			_levelUI.name = "_levelUI";
			_levelUI.x += pos_x
			_levelUI.y += pos_y
			addChild(_levelUI);			
		}
		public function changeValue(value:Number):void 
		{	
			_levelUI.levelNumber.text = value.toString();	
		}
	}
}