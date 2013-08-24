package com.tada.clopclop.ui.horseinfo.frames {
	import com.tada.clopclop.ui.components.FrameComponent;
	import com.tada.clopclop.ui.components.SpecialButtonComponent;
	import com.tada.clopclop.ui.horseinfo.tabs.HorseInfoEventRecordsTab;
	import com.tada.clopclop.ui.horseinfo.tabs.HorseInfoRaceRecordsTab;
	import com.tada.clopclop.ui.horseinfo.tabs.HorseInfoSpecialAbilityTab;
	import com.tada.clopclop.ui.horseinfo.tabs.HorseInfoStatusTab;
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	public class HorseInfoTabsFrame extends FrameComponent {
		private const RACE_BUTTON:String = "raceButton";
		private const EVENT_BUTTON:String = "eventButton";
		private const STATUS_BUTTON:String = "statusButton";
		private const ABILITY_BUTTON:String = "abilityButton";
		private const RACE_TAB:String = "raceTab";
		private const EVENT_TAB:String = "eventTab";
		private const STATUS_TAB:String = "statusTab";
		private const ABILITY_TAB:String = "abilityTab";
		
		public function HorseInfoTabsFrame() {
			var background:DisplayObject = new SkinHorseInfoFrameTab;
			background.y = 35;
			addChild(background);
			initTabButtons(background);
			initTabPanels(background);
			
			hideAllTabs();
			SpecialButtonComponent(getComponent(RACE_BUTTON)).setToActive();
			showComponent(RACE_TAB);
		}
		
		private function initTabButtons(bg:DisplayObject):void {
			addComponent(RACE_BUTTON, new SpecialButtonComponent(new BtnTabRaceRecords, onTabClick), 0, 0);
			const BUTTON_WIDTH:Number = getComponent(RACE_BUTTON).displayObject.width;
			const X_ADJ:Number = BUTTON_WIDTH + ((bg.width - (BUTTON_WIDTH * 4)) / 3);
			addComponent(EVENT_BUTTON, new SpecialButtonComponent(new BtnTabEventRaceRecords, onTabClick), X_ADJ * 1, 0);
			addComponent(STATUS_BUTTON, new SpecialButtonComponent(new BtnTabStatus, onTabClick), X_ADJ * 2, 0);
			addComponent(ABILITY_BUTTON, new SpecialButtonComponent(new BtnTabSpecialAbility, onTabClick), X_ADJ * 3, 0);
		}
		
		private function initTabPanels(bg:DisplayObject):void {
			const BASE_X:Number = bg.x + (bg.width / 2);
			const BASE_Y:Number = bg.y + (bg.height / 2);
			addTab(RACE_TAB, new HorseInfoRaceRecordsTab, BASE_X, BASE_Y);
			addTab(EVENT_TAB, new HorseInfoEventRecordsTab, BASE_X, BASE_Y);
			addTab(STATUS_TAB, new HorseInfoStatusTab, BASE_X, BASE_Y);
			addTab(ABILITY_TAB, new HorseInfoSpecialAbilityTab, BASE_X, BASE_Y);
		}
		
		private function addTab(name:String, component:FrameComponent, baseX:Number, baseY:Number):void {
			addComponent(name, component, baseX - (component.width / 2), baseY - (component.height / 2));
		}
		
		private function onTabClick(e:MouseEvent):void {
			hideAllTabs();
			deactivateAllTabButtons();
			switch (e.target) {
				case getComponent(RACE_BUTTON).displayObject:
					showComponent(RACE_TAB);
					Logger.print(this, RACE_BUTTON + " has been clicked and activated!");
					break;
				case getComponent(EVENT_BUTTON).displayObject:
					showComponent(EVENT_TAB);
					Logger.print(this, EVENT_BUTTON + " has been clicked and activated!");
					break;
				case getComponent(STATUS_BUTTON).displayObject:
					showComponent(STATUS_TAB);
					Logger.print(this, STATUS_BUTTON + " has been clicked and activated!");
					break;
				case getComponent(ABILITY_BUTTON).displayObject:
					showComponent(ABILITY_TAB);
					Logger.print(this, ABILITY_BUTTON + " has been clicked and activated!");
					break;
			}
		}
		
		private function hideAllTabs():void {
			hideComponent(RACE_TAB);
			hideComponent(EVENT_TAB);
			hideComponent(STATUS_TAB);
			hideComponent(ABILITY_TAB);
		}
		
		private function deactivateAllTabButtons():void {
			SpecialButtonComponent(getComponent(RACE_BUTTON)).setToInactive();
			SpecialButtonComponent(getComponent(EVENT_BUTTON)).setToInactive();
			SpecialButtonComponent(getComponent(STATUS_BUTTON)).setToInactive();
			SpecialButtonComponent(getComponent(ABILITY_BUTTON)).setToInactive();
		}
		
		public function get raceTab():HorseInfoRaceRecordsTab {
			return HorseInfoRaceRecordsTab(getComponent(RACE_TAB));
		}
		
		public function get eventTab():HorseInfoEventRecordsTab {
			return HorseInfoEventRecordsTab(getComponent(EVENT_TAB));
		}
		
		public function get statusTab():HorseInfoStatusTab {
			return HorseInfoStatusTab(getComponent(STATUS_TAB));
		}
		
		public function get abilityTab():HorseInfoSpecialAbilityTab {
			return HorseInfoSpecialAbilityTab(getComponent(ABILITY_TAB));
		}
	}
}