package com.tada.clopclop.test.type.dfaswing.aswingTool
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import org.aswing.Component;
	import org.aswing.GroundDecorator;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	
	public class lookBG implements GroundDecorator
	{
		private var _skin:MovieClip;
		public function lookBG(skin:MovieClip,locX:int, locY:int)
		{
			_skin = skin;
			_skin.x = locX;
			_skin.y = locY;
		}
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return _skin;
		}
	}
}