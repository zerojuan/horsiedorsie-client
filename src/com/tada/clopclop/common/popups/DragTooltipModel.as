package com.tada.clopclop.common.popups
{
	import flash.display.Sprite;
	
	public class DragTooltipModel extends Sprite
	{
		
		private var _dragTooltip:DragTooltip;
		
		public function DragTooltipModel()
		{
			inheritDragTooltip();
		}
		private function inheritDragTooltip():void
		{
			_dragTooltip = new DragTooltip();
			_dragTooltip.name = "_DragTooltip";
			addChild(_dragTooltip);
		}
	}
}