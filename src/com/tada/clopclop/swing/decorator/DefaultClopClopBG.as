package com.tada.clopclop.swing.decorator
{
	import flash.display.DisplayObject;
	
	import org.aswing.Component;
	import org.aswing.GroundDecorator;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	
	public class DefaultClopClopBG implements GroundDecorator
	{
		private var _skinBackground:SkinBackground;
		
		public function DefaultClopClopBG()
		{
			_skinBackground = new SkinBackground();			
		}
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return _skinBackground;
		}
	}
}