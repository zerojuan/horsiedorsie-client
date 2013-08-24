package com.tada.clopclop.screen
{
	import com.tada.clopclop.toolsets.clopclopconnection.ClopClopConnection;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.*;
	

	public class ScreenView extends Sprite
	{
		private var _screenUI:ScreenUI;
		
		private var _coinModel:CoinModel;
		private var _cashModel:CashModel;
		private var _levelModel:LevelModel;
		
		public var COIN:Number = 0
		
		public function ScreenView()
		{
		}
		
		public function startScreenView():void 
		{
			inheritScreenUI(0,0);
			
			startCoinModel(10,10);
			startCashModel(240,10);
			startLevelModel(470,15);
		}
		
		public function deductCoins(value:Number):void 
		{
			var current_value:Number = _coinModel.getCurrentValue()
			var new_value:Number = current_value - value
			_coinModel.changeValue(new_value)
		}
		
		private function startCoinModel(pos_x:Number, pos_y:Number):void 
		{
			_coinModel = new CoinModel
			_coinModel.name = "_coinModel"
			addChild(_coinModel)
			_coinModel.inheritCoinUI(pos_x, pos_y);
		}
		private function startCashModel(pos_x:Number, pos_y:Number):void 
		{
			_cashModel = new CashModel
			_cashModel.name = "_cashModel"
			addChild(_cashModel)
			_cashModel.inheritCashUI(pos_x, pos_y);
		}
		private function startLevelModel(pos_x:Number, pos_y:Number):void 
		{
			_levelModel = new LevelModel
			_levelModel.name = "_levelModel"
			addChild(_levelModel)
			_levelModel.inheritLevelUI(pos_x, pos_y);
		}
		
		
		public function updateScreenValue (get_screen:String,value:Number):void 
		{
			var _model:Object = getChildByName(get_screen + "Model")
			_model.changeValue(value)	
		}
		
		
		
		private function inheritScreenUI (pos_x:Number,pos_y:Number):void 
		{
			_screenUI = new ScreenUI;
			_screenUI.name = "_screenUI";
			addChild(_screenUI);
			
			x = pos_x;
			y = pos_y;
		}
		
	}
}