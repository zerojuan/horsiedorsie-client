package com.tada.clopclop.racing
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;

	public class RacingController extends EventDispatcher
	{
		private var _racingMainUIView:RacingMainUIView;
		private var _racing3DView:Racing3DView;
		
		private var _mainApp:Sprite;
		
		public function RacingController(mainApp:Sprite)
		{
			_mainApp = mainApp;		
		}
		
		public function startRacingController():void{
			initRacing3DView();
			initMainUIView ()
			addListeners();
		}
		
		private function addListeners():void{
			
		}
		
		private function removeListeners():void{
			
		}
		
		////////////////////////////////////////////////////////////////////////////////// 
		//Racing Main UI View functions
		
		private function initMainUIView():void{
			if (!_racingMainUIView || _racingMainUIView == null){
				showRacingMainUIView();
			} else {
				hideRacingMainUIView();
			}
		}
		
		private function showRacingMainUIView():void{
			_racingMainUIView = new RacingMainUIView();
			_mainApp.addChild(_racingMainUIView);
			_racingMainUIView.init();
			_racingMainUIView.alpha = 0;	
			TweenLite.to(_racingMainUIView, .5, {alpha:1, onComplete:onRacingMainUIShowComplete});
		}
		
		private function onRacingMainUIShowComplete ():void{
			
		}
		
		private function hideRacingMainUIView():void{
			TweenLite.to(_racing3DView, .5, {alpha:0, onComplete:onRacingMainUIViewHideComplete});
		}
		
		private function onRacingMainUIViewHideComplete():void{
			_racingMainUIView.removeListeners();
		}
		
		////////////////////////////////////////////////////////////////////////////////// 
		
		////////////////////////////////////////////////////////////////////////////////// 
		//Racing 3D View functions
		
		private function initRacing3DView():void{
			if (!_racing3DView || _racing3DView == null){
				showRacing3DView();
			} else {
				hideRacing3DView();
			}
		}
		
		private function showRacing3DView():void{
			_racing3DView = new Racing3DView();
			_mainApp.addChild(_racing3DView);
			_racing3DView.init();
			_racing3DView.alpha = 0;
			TweenLite.to(_racing3DView, .5, {alpha:1, onComplete:onRacing3DViewShowComplete});
		}
		
		private function onRacing3DViewShowComplete():void{
			
		}
		
		private function hideRacing3DView():void{
			TweenLite.to(_racing3DView, .5, {alpha:0, onComplete:onRacing3DViewHideComplete});
		}
		
		private function onRacing3DViewHideComplete():void{
			_racing3DView.removeListeners();
		}
		//////////////////////////////////////////////////////////////////////////////////
										 
	}
}