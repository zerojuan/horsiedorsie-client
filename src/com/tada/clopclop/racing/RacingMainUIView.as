package com.tada.clopclop.racing
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;

	public class RacingMainUIView extends Sprite
	{
		private var _racingMainUI:RacingMainUI;
		
		public function RacingMainUIView()
		{
			
		}
		
		public function init():void{
			initAssets();	
		}
		
		private function initAssets():void{
			_racingMainUI = new RacingMainUI();
			addChild(_racingMainUI);
			TweenLite.to(_racingMainUI.ClpoClopRacingView, 1, {alpha:0});
		}
		
		public function removeListeners():void{
			
		}
	}
}