package com.tada.clopclop.screen
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;

	public class CoinModel extends Sprite
	{
		private var _coinUI:CoinUI
		
		public function CoinModel()
		{
		}
		
		public function inheritCoinUI (pos_x:Number, pos_y:Number):void 
		{
			_coinUI = new (getDefinitionByName("CoinUI") as Class)();
			_coinUI.name = "_coinUI";
			_coinUI.x += pos_x
			_coinUI.y += pos_y
			addChild(_coinUI);
			
			
		}
		
		public function getCurrentValue():Number 
		{
			return Number(_coinUI.coins.text)
			
		}
		
		public function changeValue(value:Number):void 
		{				
			_coinUI.coins.text = value.toString();	
		}
	}
}