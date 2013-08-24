package com.tada.clopclop.pane {
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.tada.utils.ChartUtil;
	import com.tada.clopclop.ui.miscellaneous.BarInfo;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class HorseInformationPane {
		private var _horseInfo:HorseInfoUI;
		private var _activeTab:MovieClip;
		private var _statBars:Array;
		private var _parameterBars:Array;
		private var _levelBar:BarInfo;
		private var _chart:ChartUtil;
		
		public static const RACE_RECORD:int = 1;
		public static const EVENT_RECORD:int = 2;
		public static const STATUS:int = 3;
		public static const ABILITY:int = 4;
		
		public function HorseInformationPane() {
			_horseInfo = new HorseInfoUI();
			initializeObjects();
		}
		
		public function showHorseInfoPane(parent:DisplayObjectContainer, X:int = 0, Y:int = 0):void {
			parent.addChild(_horseInfo);
			_horseInfo.x = X - 100;
			_horseInfo.y = Y;
			_horseInfo.alpha = 0;
			TweenLite.to(_horseInfo, .5, {
				x: X,
				alpha: 1,
				ease: Back.easeOut
			});
			switchPage(1);
			addListeners();
		}
		
		public function hideHorseInfoPane():void {
			if (_horseInfo.parent) {
				TweenLite.to(_horseInfo, .5, {
					x: _horseInfo.x + 100,
					alpha: 0,
					ease: Back.easeIn,
					onComplete: function():void {
						_horseInfo.parent.removeChild(_horseInfo);
					}
				});
			}
			removeListeners();
		}
		
		//public function setHorseInfo(level:int, exp:int, 
		
		private function initializeObjects():void {
			initParameterInfo();
			setParameterInfo(); //test
			_horseInfo.horseLvlSecondDigit.gotoAndStop(1);
			_horseInfo.horseLvlFirstDigit.gotoAndStop(1);
			_levelBar = new BarInfo(_horseInfo.horseLevelBar, BarInfo.LEVEL);
			_chart = new ChartUtil([BarInfo.SPEED,BarInfo.STRENGTH,BarInfo.LUCK,BarInfo.BALANCE,BarInfo.STAMINA], 60);
			setLevelInfo(Math.floor(Math.random() * 100), Math.floor(Math.random() * 100)); //test
		}
		
		private function switchPage(type:int):void {
			resetAllTabs();
			_horseInfo.depth1TabSelection.gotoAndStop(type);
			if (_chart.parent) {
				_chart.parent.removeChild(_chart);
			}
			switch (type) {
				case RACE_RECORD:
					_activeTab = _horseInfo.depth1TabSelection.raceRecordsTab;
					break;
				case EVENT_RECORD:
					_activeTab = _horseInfo.depth1TabSelection.eventRaceRecordsTab;
					break;
				case STATUS:
					_activeTab = _horseInfo.depth1TabSelection.statusTab;
					initStatInfo();
					setStatInfo(); //test
					break;
				case ABILITY:
					_activeTab = _horseInfo.depth1TabSelection.specialAbilityTab;
					break;
			}
			_activeTab.gotoAndStop(2);
		}
		
		private function initStatInfo():void {
			_statBars = [];
			_statBars[BarInfo.BALANCE] = new BarInfo(_horseInfo.depth1TabSelection.balanceBar, BarInfo.BALANCE, _horseInfo.depth1TabSelection.balanceIndicatorIcon);
			_statBars[BarInfo.LUCK] = new BarInfo(_horseInfo.depth1TabSelection.luckBar, BarInfo.LUCK, _horseInfo.depth1TabSelection.luckIndicatorIcon);
			_statBars[BarInfo.STRENGTH] = new BarInfo(_horseInfo.depth1TabSelection.strengthBar, BarInfo.STRENGTH, _horseInfo.depth1TabSelection.strengthIndicatorIcon);
			_statBars[BarInfo.STAMINA] = new BarInfo(_horseInfo.depth1TabSelection.staminaBar, BarInfo.STAMINA, _horseInfo.depth1TabSelection.staminaIndicatorIcon);
			_statBars[BarInfo.SPEED] = new BarInfo(_horseInfo.depth1TabSelection.speedBar, BarInfo.SPEED, _horseInfo.depth1TabSelection.speedIndicatorIcon);
			_horseInfo.depth1TabSelection.addChild(_chart);
			_chart.x = _horseInfo.depth1TabSelection.x + 194;
			_chart.y = _horseInfo.depth1TabSelection.y + 438;
		}
		
		private function initParameterInfo():void {
			_parameterBars = [];
			_parameterBars[BarInfo.SHOWER] = new BarInfo(_horseInfo.showerBar, BarInfo.SHOWER);
			_parameterBars[BarInfo.FEEDING] = new BarInfo(_horseInfo.feedingBar, BarInfo.FEEDING);
			_parameterBars[BarInfo.ENERGY] = new BarInfo(_horseInfo.energyBar, BarInfo.ENERGY);
			_parameterBars[BarInfo.PARTNERSHIP] = new BarInfo(_horseInfo.partnershipBar, BarInfo.PARTNERSHIP);
		}
		
		public function setParameterInfo(energy:int = 0, shower:int = 0, partnership:int = 0, feeding:int = 0):void {
			updateParameterBar(BarInfo.ENERGY, 1 + Math.floor(Math.random() * 100));
			updateParameterBar(BarInfo.SHOWER, 1 + Math.floor(Math.random() * 100));
			updateParameterBar(BarInfo.PARTNERSHIP, 1 + Math.floor(Math.random() * 100));
			updateParameterBar(BarInfo.FEEDING, 1 + Math.floor(Math.random() * 100));
		}
		
		public function updateParameterBar(type:String, value:int):void {
			_parameterBars[type].setBar(value);
		}
		
		public function setStatInfo(balance:int = 0, luck:int = 0, strength:int = 0, stamina:int = 0, speed:int = 0, energy:int = 0, partnership:int = 0):void {
			updateStatBar(BarInfo.BALANCE, 1 + Math.floor(Math.random() * 100));
			updateStatBar(BarInfo.LUCK, 1 + Math.floor(Math.random() * 100));
			updateStatBar(BarInfo.STRENGTH, 1 + Math.floor(Math.random() * 100));
			updateStatBar(BarInfo.STAMINA, 1 + Math.floor(Math.random() * 100));
			updateStatBar(BarInfo.SPEED, 1 + Math.floor(Math.random() * 100));
		}
		
		public function updateStatBar(type:String, value:int):void {
			_statBars[type].setBar(value);
			_chart.setStat(type, value);
		}
		
		public function showStatLock(type:String):void {
			_statBars[type].indicator.visible = true;
		}
		
		public function setLevelInfo(level:int, exp:int):void {
			var num1:int = (level - (level % 10)) / 10;
			var num2:int = level % 10;
			_horseInfo.horseLvlSecondDigit.gotoAndStop(num1 + 1);
			_horseInfo.horseLvlFirstDigit.gotoAndStop(num2 + 1);
			_levelBar.setBar(exp);
		}
		
		private function resetAllTabs():void {
			_horseInfo.depth1TabSelection.raceRecordsTab.gotoAndStop(1);
			_horseInfo.depth1TabSelection.eventRaceRecordsTab.gotoAndStop(1);
			_horseInfo.depth1TabSelection.statusTab.gotoAndStop(1);
			_horseInfo.depth1TabSelection.specialAbilityTab.gotoAndStop(1);
		}
		
		private function addListeners():void {
			_horseInfo.depth1TabSelection.raceRecordsTab.addEventListener(MouseEvent.CLICK, onRaceTabClick);
			_horseInfo.depth1TabSelection.eventRaceRecordsTab.addEventListener(MouseEvent.CLICK, onEventTabClick);
			_horseInfo.depth1TabSelection.statusTab.addEventListener(MouseEvent.CLICK, onStatusTabClick);
			_horseInfo.depth1TabSelection.specialAbilityTab.addEventListener(MouseEvent.CLICK, onAbilityTabClick);
		}
		
		private function removeListeners():void {
			_horseInfo.depth1TabSelection.raceRecordsTab.removeEventListener(MouseEvent.CLICK, onRaceTabClick);
			_horseInfo.depth1TabSelection.eventRaceRecordsTab.removeEventListener(MouseEvent.CLICK, onEventTabClick);
			_horseInfo.depth1TabSelection.statusTab.removeEventListener(MouseEvent.CLICK, onStatusTabClick);
			_horseInfo.depth1TabSelection.specialAbilityTab.removeEventListener(MouseEvent.CLICK, onAbilityTabClick);
		}
		
		private function onRaceTabClick(e:MouseEvent):void {
			if (e.currentTarget != _activeTab) {
				switchPage(RACE_RECORD);
			}
		}
		
		private function onEventTabClick(e:MouseEvent):void {
			if (e.currentTarget != _activeTab) {
				switchPage(EVENT_RECORD);
			}
		}
		
		private function onStatusTabClick(e:MouseEvent):void {
			if (e.currentTarget != _activeTab) {
				switchPage(STATUS);
			}
		}
		
		private function onAbilityTabClick(e:MouseEvent):void {
			if (e.currentTarget != _activeTab) {
				switchPage(ABILITY);
			}
		}
	}
}