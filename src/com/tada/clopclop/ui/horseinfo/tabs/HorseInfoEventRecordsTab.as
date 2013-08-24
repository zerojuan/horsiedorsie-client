package com.tada.clopclop.ui.horseinfo.tabs {
	
	import com.tada.clopclop.ui.components.ButtonTypeComponent;
	import com.tada.clopclop.ui.components.FrameComponent;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	public class HorseInfoEventRecordsTab extends FrameComponent {
		private const DAILY_BUTTON:String = "dailyButton";
		private const MONTHLY_BUTTON:String = "monthlyButton";
		
		public function HorseInfoEventRecordsTab() {
			addComponent(DAILY_BUTTON, new ButtonTypeComponent(new BtnDailyLeague, onDailyClick));
			addComponent(MONTHLY_BUTTON, new ButtonTypeComponent(new BtnMonthlyLeague, onMonthlyClick), getComponent(DAILY_BUTTON).displayObject.width + 2, 0);
			var background:DisplayObject = new SkinEventRaceRecords;
			background.y = getComponent(DAILY_BUTTON).displayObject.height + 5;
			addChild(background);
		}
		
		private function onDailyClick(e:MouseEvent):void {
			trace("daily clicked!");
		}
		
		private function onMonthlyClick(e:MouseEvent):void {
			trace("monthly clicked!");
		}
	}
}