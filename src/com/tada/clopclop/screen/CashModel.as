package com.tada.clopclop.screen
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	
	public class CashModel extends Sprite
	{
		private var _cashUI:CashUI
		
		
		
		public function CashModel()
		{
		}
		
		public function inheritCashUI (pos_x:Number, pos_y:Number):void 
		{
			_cashUI = new (getDefinitionByName("CashUI") as Class)();
			_cashUI.name = "_cashUI";
			_cashUI.x += pos_x
			_cashUI.y += pos_y
			addChild(_cashUI);
			
		}
		
		public function changeValue(value:Number):void 
		{	
			_cashUI.cash.text = value.toString();	
		}
		
		
	}
}