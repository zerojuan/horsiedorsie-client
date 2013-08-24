package com.tada.clopclop.ui.horseracing.frames {
	import com.tada.clopclop.ui.components.FrameComponent;
	import com.tada.clopclop.ui.components.SpecialButtonComponent;
	import com.tada.clopclop.ui.horseracing.tabs.HorseRacingAbilityTab;
	import com.tada.clopclop.ui.horseracing.tabs.HorseRacingStatusTab;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	public class HorseSelectTabsFrame extends FrameComponent {
		private const STATUS_BUTTON:String = "statusButton";
		private const ABILITY_BUTTON:String = "abilityButton";
		private const STATUS_TAB:String = "statusTab";
		private const ABILITY_TAB:String = "abilityTab";
		
		public function HorseSelectTabsFrame() {
			var background:DisplayObject = new SkinHorseSelectBottomSubPanel;
			addChild(background);
			initButtons(background);
			initTabs(background);
			
			hideAllTabs();
			SpecialButtonComponent(getComponent(STATUS_BUTTON)).setToActive();
			showComponent(STATUS_TAB);
		}
		
		private function initButtons(bg:DisplayObject):void {
			var button:SpecialButtonComponent;
			button = new SpecialButtonComponent(new BtnStatus, onTabClick);
			const Y_ADJ:Number = bg.y + bg.height - (button.displayObject.height * 1.5);
			const X_GAP:Number = 10;
			const X_INIT:Number = bg.x + (bg.width / 2) - (((button.displayObject.width * 2) + X_GAP) / 2);
			addComponent(STATUS_BUTTON, button, X_INIT, Y_ADJ);
			button = new SpecialButtonComponent(new BtnSpecialAbility, onTabClick);
			addComponent(ABILITY_BUTTON, button, X_INIT + button.displayObject.width + X_GAP, Y_ADJ);
		}
		
		private function initTabs(bg:DisplayObject):void {
			const BASE_X:Number = bg.x + (bg.width / 2);
			const BASE_Y:Number = bg.y + (bg.height / 2) - (getComponent(STATUS_BUTTON).displayObject.height / 2);
			addTab(STATUS_TAB, new HorseRacingStatusTab, BASE_X, BASE_Y);
			addTab(ABILITY_TAB, new HorseRacingAbilityTab, BASE_X, BASE_Y);
		}
		
		private function addTab(name:String, component:FrameComponent, baseX:Number, baseY:Number):void {
			addComponent(name, component, baseX - (component.width / 2), baseY - (component.height / 2));
		}
		
		private function onTabClick(e:MouseEvent):void {
			hideAllTabs();
			deactivateAllTabButtons();
			switch (e.target) {
				case getComponent(STATUS_BUTTON).displayObject:
					showComponent(STATUS_TAB);
					break;
				case getComponent(ABILITY_BUTTON).displayObject:
					showComponent(ABILITY_TAB);
					break;
			}
		}
		
		private function hideAllTabs():void {
			hideComponent(STATUS_TAB);
			hideComponent(ABILITY_TAB);
		}
		
		private function deactivateAllTabButtons():void {
			SpecialButtonComponent(getComponent(STATUS_BUTTON)).setToInactive();
			SpecialButtonComponent(getComponent(ABILITY_BUTTON)).setToInactive();
		}
		
		public function get statusTab():HorseRacingStatusTab {
			return HorseRacingStatusTab(getComponent(STATUS_TAB));
		}
		
		public function get abilityTab():HorseRacingAbilityTab {
			return HorseRacingAbilityTab(getComponent(ABILITY_TAB));
		}
	}
}