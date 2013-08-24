package com.tada.clopclop.ui.miscellaneous
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	public class BarInfo {
		private var currentValue:Number;
		private var lowestX:Number;
		private var highestX:Number;
		private var bar:DisplayObject;
		private var type:String;
		private var indicator:DisplayObject;
		
		public static const LUCK:String = "luck";
		public static const BALANCE:String = "balance";
		public static const STRENGTH:String = "strength";
		public static const STAMINA:String = "stamina";
		public static const SPEED:String = "speed";
		
		public static const SHOWER:String = "shower";
		public static const FEEDING:String = "feeding";
		
		public static const ENERGY:String = "energy";
		public static const PARTNERSHIP:String = "partnership";
		
		public static const LEVEL:String = "level";
		
		
		public function BarInfo(bar:DisplayObject, type:String, indicator:DisplayObject = null) {
			this.bar = bar;
			this.type = type;
			highestX = bar.x;
			lowestX = highestX - (bar.width * .95);
			bar.x = lowestX;
			if (bar is MovieClip) {
				(bar as MovieClip).gotoAndStop(1);
			}
			if (indicator) {
				this.indicator = indicator;
				(indicator as MovieClip).gotoAndStop(1);
				indicator.visible = false;
			}
		}
		
		public function setBar(value:int):void {
			TweenLite.to(bar, 1, {
				x: ((highestX - lowestX) * (value / 100)) + lowestX,
				onComplete: function():void {
					if (bar is MovieClip) {
						if (value == 100) {
							(bar as MovieClip).gotoAndStop(2);
							if (indicator) {
								(indicator as MovieClip).gotoAndStop(2);
								indicator.visible = true;
							}
						}
						else {
							(bar as MovieClip).gotoAndStop(1);
						}
					}
				}
			});
		}
	}
}