package com.tada.clopclop.screen
{
	
	import com.tada.clopclop.PlayerGlobalData;
	
	import flash.display.Sprite;
	
	public class ScreenController extends Sprite
	{
		//base decalrtion
		private var _view:Sprite;
		private var _screenView:ScreenView
		
		public var USER_INFO:Object		
		public var MY_BUILDING:Object
		
		public function ScreenController(view:Sprite)
		{
			_view = view
			this.name = "_screenController"
			_view.addChild(this)
		}
		
		public function deductCoins(value:Number):void 
		{
			_screenView.deductCoins(value)
		}
		
		public function startScreenController():void 
		{
			_screenView = new ScreenView();
			_screenView.name = "_screenView";
			_view.addChild(_screenView);			
			_screenView.startScreenView();
			
			updateLocalValues();
			
		}
		
		private function updateLocalValues():void 
		{
			getCurrentValueOfScreenModel("_coin",PlayerGlobalData.coin);
				
			//_clopclopConnection.getCoin();
			getCurrentValueOfScreenModel("_cash",PlayerGlobalData.cash);	
			
			//_clopclopConnection.getCash();
			//getCurrentValueOfScreenModel("_cash",CASH)	
			
			//_clopclopConnection.getLevel();
			getCurrentValueOfScreenModel("_level",PlayerGlobalData.level)	
						
		}
						
		
		public function getCurrentValueOfScreenModel(get_screen:String,value:Number):void 
		{
			var _screenView:Object = _view.getChildByName("_screenView")
			_screenView.updateScreenValue(get_screen,value);
			
		}
		
		
		
		
	}
}