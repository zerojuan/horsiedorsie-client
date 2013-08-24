package com.tada.clopclop.ui.horseracing.pages {
	
	import com.away3d.containers.View3D;
	import com.tada.clopclop.horseequip.HorseComponent.look.HorseLookPanel;
	import com.tada.clopclop.ui.components.ButtonTypeComponent;
	import com.tada.clopclop.ui.components.FrameComponent;
	import com.tada.clopclop.ui.horseracing.frames.HorseSelectInfoFrame;
	import com.tada.clopclop.ui.horseracing.frames.HorseSelectTabsFrame;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	public class HorseRacingHorseSelectPage extends FrameComponent {
		private const HORSE_VIEW:String = "horseView";
		private const HORSE_INFO:String = "horseInfo";
		private const HORSE_TABS:String = "horseTabs";
		private const LEFT_SELECT_BUTTON:String = "leftSelectButton";
		private const RIGHT_SELECT_BUTTON:String = "rightSelectButton";
		
		public function HorseRacingHorseSelectPage() {
			initFrames();
		}
		
		private function initFrames():void {
			var horseInfoFrame:FrameComponent = new HorseSelectInfoFrame;
			addComponent(HORSE_INFO, horseInfoFrame);
			var horseViewFrame:HorseLookPanel = new HorseLookPanel(new View3D);
			addComponent(HORSE_VIEW, horseViewFrame, (horseInfoFrame.width / 2) - (horseViewFrame.width / 2), 0);
			initHorseSelectButtons(horseViewFrame);
			horseInfoFrame.y = horseViewFrame.height;
			var horseTabFrame:FrameComponent = new HorseSelectTabsFrame;
			addComponent(HORSE_TABS, horseTabFrame, (horseInfoFrame.width / 2) - (horseTabFrame.width / 2), horseInfoFrame.y + horseInfoFrame.height + 10);
		}
		
		private function initHorseSelectButtons(horseDisplay:DisplayObject):void {
			const X_GAP:Number = (horseDisplay.width / 2) + 50;
			const X_BASE:Number = horseDisplay.x + (horseDisplay.width / 2);
			const Y_BASE:Number = horseDisplay.y + (horseDisplay.height / 2);
			var button:ButtonTypeComponent;
			button = new ButtonTypeComponent(new BtnLeftBig, onSelectClick);
			addComponent(LEFT_SELECT_BUTTON, button, X_BASE - X_GAP, Y_BASE - (button.displayObject.height / 2));
			button = new ButtonTypeComponent(new BtnLeftBig, onSelectClick);
			button.displayObject.scaleX = -1;
			addComponent(RIGHT_SELECT_BUTTON, button, X_BASE + X_GAP, Y_BASE - (button.displayObject.height / 2));
		}
		
		private function onSelectClick(e:MouseEvent):void {
			switch (e.target) {
				case getComponent(LEFT_SELECT_BUTTON).displayObject:
					break;
				case getComponent(RIGHT_SELECT_BUTTON).displayObject:
					break;
			}
		}
		
		public function get horseInfo():HorseSelectInfoFrame {
			return HorseSelectInfoFrame(getComponent(HORSE_INFO));
		}
		
		public function get horseTabs():HorseSelectTabsFrame {
			return HorseSelectTabsFrame(getComponent(HORSE_TABS));
		}
	}
}