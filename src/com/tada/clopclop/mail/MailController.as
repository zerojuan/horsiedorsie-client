package com.tada.clopclop.mail
{
	import flash.display.MovieClip;
	
	public class MailController
	{
		private var _view:MovieClip;
		
		private var _mailView:MailView
		
		public function MailController(view:MovieClip)
		{
			_view = view;			
		}
		public function startMailController():void{			
			_mailView = new MailView();
			_mailView.name = "_maillView";
			_view.addChild(_mailView);
			_mailView.initMaillView();
			addListeners();
		}
		
		public function visibility(value:Boolean):void 
		{
			_socialView.visibility(value);
		}
				
		private function addListeners():void 
		{
			
		}
	}
}