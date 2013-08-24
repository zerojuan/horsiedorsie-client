package com.tada.clopclop.hire
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class HireController extends Sprite
	{
		private var _hireView:HireView;
		private var _view:MovieClip;
		
		public function HireController(_view:MovieClip)
		{
			_view = view;
		}
		public function startHireController():void 
		{
			_hireView = new HireView();
			_hireView.name = "_hireView";
			_view.addChild(_hireView);
			_hireView.initHireView();
			addListeners();
		}
		public function visibility(value:Boolean):void 
		{
			_hireView.visibility(value);
		}
		
		public function addListeners():void 
		{
			
		}
	}
}