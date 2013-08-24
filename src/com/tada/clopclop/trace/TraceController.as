package com.tada.clopclop.trace
{
	import flash.display.MovieClip;
	
	public class TraceController
	{
		//base decalrtion
		private var _view:MovieClip;
		
		private var _traceView:TraceView
		
		public function TraceController(view:MovieClip)
		{
			_view = view;
		}
		
		public function startTraceController()void:
		{
			_traceView = new TraceView();
			_traceView.name = "_traceView";
			_view.addChild(_traceView);
			_traceView.initTraceView();
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