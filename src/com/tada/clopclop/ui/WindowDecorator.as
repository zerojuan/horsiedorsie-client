package com.tada.clopclop.ui
{
	import flash.display.DisplayObject;
	
	import org.aswing.Component;
	import org.aswing.GroundDecorator;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	
	public class WindowDecorator implements GroundDecorator
	{
		private var _backgroundUI:RedecorateUI;
		
		public function WindowDecorator()
		{
			_backgroundUI = new RedecorateUI();
		}
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return _backgroundUI;
		}
	}
}