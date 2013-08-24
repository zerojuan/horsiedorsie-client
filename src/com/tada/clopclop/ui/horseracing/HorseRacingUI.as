package com.tada.clopclop.ui.horseracing {
	import com.tada.clopclop.ui.UIMainFrame;
	import com.tada.clopclop.ui.components.ButtonTypeComponent;
	import com.tada.clopclop.ui.components.FrameComponent;
	import com.tada.clopclop.ui.horseracing.pages.HorseRacingHorseSelectPage;
	import com.tada.clopclop.ui.horseracing.pages.HorseRacingLeagueSelectPage;
	import com.tada.clopclop.ui.horseracing.pages.HorseRacingPaddockPage;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	public class HorseRacingUI extends UIMainFrame {
		private const HOME_BUTTON:String = "homeButton";
		private const BACK_BUTTON:String = "backButton";
		private const NEXT_BUTTON:String = "nextButton";
		private const START_BUTTON:String = "startButton";
		private const HORSE_SELECT_TITLE:DisplayObject = new LabelHorseSelect;
		private const LEAGUE_SELECT_TITLE:DisplayObject = new LabelLeagueSelect;
		private const PADDOCK_TITLE:DisplayObject = new LabelPaddock;
		private const HORSE_SELECT_PAGE:String = "horseSelectPage";
		private const LEAGUE_SELECT_PAGE:String = "leagueSelectPage";
		private const PADDOCK_PAGE:String = "paddockPage";
		private var _activePage:String;
		
		public function HorseRacingUI() {
			super(new SkinRacingFrame);
		}
		
		public function setTitleDisplay(titleDisplay:DisplayObject):void {
			if (_titleDisplay) {
				if (_titleDisplay.parent) {
					_titleDisplay.parent.removeChild(_titleDisplay);
				}
			}
			_titleDisplay = titleDisplay;
			_titleDisplay.x = _backgroundDisplay.x + (_backgroundDisplay.width / 2) - (_titleDisplay.width / 2);
			_titleDisplay.y = _backgroundDisplay.y - (_titleDisplay.height / 8);
			addChild(_titleDisplay);
		}
		
		override public function addListeners():void {
			super.addListeners();
			showPage(HORSE_SELECT_PAGE, HORSE_SELECT_TITLE, false, true, false);
		}
		
		override protected function initObjects():void {
			initButtons();
			initPages();
		}
		
		private function initButtons():void {
			var button:ButtonTypeComponent;
			button = new ButtonTypeComponent(new BtnHome, hideUI);
			addComponent(HOME_BUTTON, button, _backgroundDisplay.width - (button.displayObject.width * 1.2), _backgroundDisplay.y + (button.displayObject.height * .5));
			button = new ButtonTypeComponent(new BtnBack, onBackClick);
			addComponent(BACK_BUTTON, button, 0, _backgroundDisplay.height - button.displayObject.height);
			button = new ButtonTypeComponent(new BtnNext, onNextClick);
			addComponent(NEXT_BUTTON, button, _backgroundDisplay.width - button.displayObject.width, _backgroundDisplay.height - button.displayObject.height);
			button = new ButtonTypeComponent(new BtnStart, onStartClick);
			addComponent(START_BUTTON, button, _backgroundDisplay.width - button.displayObject.width, _backgroundDisplay.height - button.displayObject.height);
		}
		
		private function initPages():void {
			addPage(HORSE_SELECT_PAGE, new HorseRacingHorseSelectPage);
			addPage(LEAGUE_SELECT_PAGE, new HorseRacingLeagueSelectPage);
			addPage(PADDOCK_PAGE, new HorseRacingPaddockPage);
		}
		
		private function addPage(name:String, component:FrameComponent):void {
			addComponent(name, component, (_backgroundDisplay.width / 2) - (component.width / 2), (_backgroundDisplay.height / 2) - (component.height / 2));
		}
		
		private function hidePages():void {
			hideComponent(HORSE_SELECT_PAGE);
			hideComponent(LEAGUE_SELECT_PAGE);
			hideComponent(PADDOCK_PAGE);
		}
		
		private function onBackClick(e:MouseEvent):void {
			switch (_activePage) {
				case LEAGUE_SELECT_PAGE:
					showPage(HORSE_SELECT_PAGE, HORSE_SELECT_TITLE, false, true, false);
					break;
				case PADDOCK_PAGE:
					showPage(LEAGUE_SELECT_PAGE, LEAGUE_SELECT_TITLE, true, true, false);
					break;
			}
		}
		
		private function onNextClick(e:MouseEvent):void {
			switch (_activePage) {
				case HORSE_SELECT_PAGE:
					showPage(LEAGUE_SELECT_PAGE, LEAGUE_SELECT_TITLE, true, true, false);
					break;
				case LEAGUE_SELECT_PAGE:
					showPage(PADDOCK_PAGE, PADDOCK_TITLE, true, false, true);
					break;
			}
		}
		
		private function onStartClick(e:MouseEvent):void {
			
		}
		
		private function showPage(pageName:String, title:DisplayObject, back:Boolean, next:Boolean, start:Boolean):void {
			hidePages();
			showComponent(pageName);
			setTitleDisplay(title);
			_activePage = pageName;
			if (back) {
				showComponent(BACK_BUTTON);
			}
			else {
				hideComponent(BACK_BUTTON);
			}
			if (next) {
				showComponent(NEXT_BUTTON);
			}
			else {
				hideComponent(NEXT_BUTTON);
			}
			if (start) {
				showComponent(START_BUTTON);
			}
			else {
				hideComponent(START_BUTTON);
			}
		}
		
		public function get horseSelectPage():HorseRacingHorseSelectPage {
			return HorseRacingHorseSelectPage(getComponent(HORSE_SELECT_PAGE));
		}
		
		public function get leagueSelectPage():HorseRacingLeagueSelectPage {
			return HorseRacingLeagueSelectPage(getComponent(LEAGUE_SELECT_PAGE));
		}
		
		public function get paddockPage():HorseRacingPaddockPage {
			return HorseRacingPaddockPage(getComponent(PADDOCK_PAGE));
		}
	}
}