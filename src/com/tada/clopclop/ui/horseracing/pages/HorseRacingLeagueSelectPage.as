package com.tada.clopclop.ui.horseracing.pages {
	
	import com.tada.clopclop.ui.components.FrameComponent;
	import com.tada.clopclop.ui.components.ItemSelectionComponent;
	import com.tada.clopclop.ui.horseracing.miscellaneous.LeagueItem;
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public class HorseRacingLeagueSelectPage extends FrameComponent {
		private const STEPUP_SELECTION:String = "stepupSelection";
		private const SPECIAL_SELECTION:String = "specialSelection";
		private var _itemArray:Array = [];
		private var _selectedItem:LeagueItem;
		
		public function HorseRacingLeagueSelectPage() {
			initObjects();
			populateStepupSelection();
			populateSpecialSelection();
		}
		
		private function initObjects():void {
			var stepupTitle:DisplayObject = new LabelStepUpLeague;
			var specialTitle:DisplayObject = new LabelSpecialLeague;
			addChild(stepupTitle);
			addComponent(STEPUP_SELECTION, new ItemSelectionComponent(new BtnLeftBig, null, BtnLeague, onItemClick, 5), 0, stepupTitle.y + stepupTitle.height + 10);
			stepupTitle.x = (getComponent(STEPUP_SELECTION).displayObject.width / 2) - (stepupTitle.width / 2);
			addChild(specialTitle);
			specialTitle.x = stepupTitle.x + (stepupTitle.width / 2) - (specialTitle.width / 2);
			specialTitle.y = getComponent(STEPUP_SELECTION).displayObject.y + getComponent(STEPUP_SELECTION).displayObject.height + 50;
			addComponent(SPECIAL_SELECTION, new ItemSelectionComponent(new BtnLeftBig, null, BtnLeague, onItemClick, 5), 0, specialTitle.y + specialTitle.height + 10);
		}
		
		private function onItemClick(item:LeagueItem):void {
			stepupSelection.deactivateButtons();
			specialSelection.deactivateButtons();
			
			_selectedItem = item;
			
			for (var a:int = 0; a < _itemArray.length; a++) {
				if (_itemArray[a] == _selectedItem) {
					_itemArray[a].setToActive();
					Logger.print(this, _itemArray[a].name + " has been selected!");
				}
				else if (_itemArray[a].active == true) {
					_itemArray[a].setToInactive();
				}
			}
		}
		
		public function get stepupSelection():ItemSelectionComponent {
			return ItemSelectionComponent(getComponent(STEPUP_SELECTION));
		}
		
		public function get specialSelection():ItemSelectionComponent {
			return ItemSelectionComponent(getComponent(SPECIAL_SELECTION));
		}
		
		public function get selectedItem():LeagueItem {
			return _selectedItem;
		}
		
		private function populateStepupSelection():void {
			for (var a:int = 0; a < 18; a++) {
				var loader:Loader = new Loader();
				loader.load(new URLRequest("assets/leagueSelectItems/league_0" + ((a % 3) + 1) + ".png"), new LoaderContext);
				var item:LeagueItem = new LeagueItem("Stepup League " + a, loader, true);
				var rand:int = 1 + Math.floor(Math.random() * 3);
				if (rand == 1) {
					item.setToDisabled();
				}
				_itemArray.push(item);
				stepupSelection.addItem(item);
			}
			stepupSelection.displayItemsToButtons();
		}
		
		private function populateSpecialSelection():void {
			for (var a:int = 0; a < 4; a++) {
				var loader:Loader = new Loader();
				loader.load(new URLRequest("assets/leagueSelectItems/league_0" + ((a % 3) + 1) + ".png"), new LoaderContext);
				var item:LeagueItem = new LeagueItem("Special League " + a, loader, true);
				var rand:int = 1 + Math.floor(Math.random() * 3);
				if (rand == 1) {
					item.setToDisabled();
				}
				_itemArray.push(item);
				specialSelection.addItem(item);
			}
			specialSelection.displayItemsToButtons();
		}
	}
}