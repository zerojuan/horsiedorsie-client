package com.tada.clopclop.ui {
	import com.greensock.TweenMax;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.tada.clopclop.Constants;
	import com.tada.clopclop.ui.events.HorseManagementEvent;
	import com.tada.clopclop.ui.miscellaneous.BarInfo;
	import com.tada.clopclop.ui.miscellaneous.SelectionInfo;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	public class HorseManagementControls extends EventDispatcher {
		TweenPlugin.activate([GlowFilterPlugin]);
		
		private var _horseMgmtUI:HorseManagementUI;
		private var _activeButton:MovieClip;
		private var _activeType:String;
		private var _statBars:Array;
		private var _levelBar:BarInfo;
		private var _selectionItems:Array;
		private var _currentSelectionIndex:int;
		
		private const LVL_JOCKEY_Y_POS:Object = {rank:3, lvl1:6, lvl2:6, bar:28};
		private const LVL_HORSE_Y_POS:Object = {rank:13, lvl1:16, lvl2:16, bar:38};
		
		public static const FEEDING_VIEW:String = "feeding";
		public static const SHOWER_VIEW:String = "shower";
		public static const TRAINING_VIEW:String = "training";
		
		public static const RANK_SS:int = 1;
		public static const RANK_S:int = 2;
		public static const RANK_A:int = 3;
		public static const RANK_B:int = 4;
		public static const RANK_C:int = 5;
		public static const RANK_D:int = 6;
		
		public function HorseManagementControls() {
			_horseMgmtUI = new HorseManagementUI();
			initializeObjects();
		}
		
		public function showHorseManagement(parent:DisplayObjectContainer, X:int = 0, Y:int = 0, type:String = null):void {
			parent.addChild(_horseMgmtUI);
			_horseMgmtUI.x = X;
			_horseMgmtUI.y = Y;
			switchViewType(type);
			addListeners();
		}
		
		public function hideHorseManagement():void {
			if (_horseMgmtUI.parent) {
				_horseMgmtUI.parent.removeChild(_horseMgmtUI);
			}
			removeListeners();
		}
		
		private function switchViewType(type:String):void {
			stopAllButtons();
			clearSelectionWindows();
			initSelectionItems(type);
			correctLevelPosition(type);
			_activeType = type;
			var frame:int = 2;
			var text:int = 1;
			switch (type) {
				case FEEDING_VIEW:
					frame = 2;
					text = 1;
					_activeButton = _horseMgmtUI.feeding;
					break;
				case SHOWER_VIEW:
					frame = 2;
					text = 2;
					_activeButton = _horseMgmtUI.shower;
					break;
				case TRAINING_VIEW:
					frame = 1;
					text = 3;
					_activeButton = _horseMgmtUI.training;
					break;
			}
			if (_horseMgmtUI.backgroundMode.currentFrame != frame) {
				_horseMgmtUI.backgroundMode.gotoAndStop(frame);
				switch (frame) {
					case 1:
						initStatInfo();
						setStatInfo(); //test
						break;
					case 2:
						initParameterInfo();
						setParameterInfo(); //test
						break;
				}
			}else{
				_horseMgmtUI.backgroundMode.stop();
			}
			_activeButton.gotoAndPlay(2);
			_horseMgmtUI.modeTxt.gotoAndStop(text);
		}
		
		private function stopAllButtons():void {
			_horseMgmtUI.feeding.gotoAndStop(1);
			_horseMgmtUI.shower.gotoAndStop(1);
			_horseMgmtUI.training.gotoAndStop(1);
		}
		
		private function initializeObjects():void {
			_horseMgmtUI.feeding.buttonMode = true;
			_horseMgmtUI.feeding.mouseChildren = false;
			_horseMgmtUI.shower.buttonMode = true;
			_horseMgmtUI.shower.mouseChildren = false;
			_horseMgmtUI.training.buttonMode = true;
			_horseMgmtUI.training.mouseChildren = false;
			_horseMgmtUI.information.buttonMode = true;
			_horseMgmtUI.information.mouseChildren = false;
			_horseMgmtUI.racing.buttonMode = true;
			_horseMgmtUI.racing.mouseChildren = false;
			_horseMgmtUI.rank.gotoAndStop(1);
			_horseMgmtUI.level1stDigit.gotoAndStop(1);
			_horseMgmtUI.level2ndDigit.gotoAndStop(1);
			_levelBar = new BarInfo(_horseMgmtUI.horseLevelBar, BarInfo.LEVEL);
			setLevelInfo(1 + Math.floor(Math.random() * 6), Math.floor(Math.random() * 100), Math.floor(Math.random() * 100)); //test 
		}
		
		private function initSelectionItems(type:String):void {
			_currentSelectionIndex = 0;
			_selectionItems = [];
			switch (type) {
				case FEEDING_VIEW:
					_selectionItems.push(new SelectionInfo(new Feedin01Carrot, "carrot", Constants.CASH, 100));
					_selectionItems.push(new SelectionInfo(new Feeding02Hay, "hay", Constants.COIN, 1000));
					_selectionItems.push(new SelectionInfo(new Feeding03Apple, "apple", Constants.COIN, 60));
					_selectionItems.push(new SelectionInfo(new Shower01Rubberbrush, "rubber brush", Constants.COIN, 800));
					_selectionItems.push(new SelectionInfo(new Shower02Cleansingset, "cleansing set", Constants.CASH, 5000));
					_selectionItems.push(new SelectionInfo(new Shower03Showermachine, "shower machine", Constants.CASH, 50));
					_selectionItems.push(new SelectionInfo(new Training01Aidexercise, "aid exercise", Constants.ENERGY, 35));
					_selectionItems.push(new SelectionInfo(new Training02Flatwalk, "flat walk", Constants.ENERGY, 50));
					_selectionItems.push(new SelectionInfo(new Training03Cavalletti, "cavalletti", Constants.ENERGY, 85));
					_selectionItems.push(new SelectionInfo(new Training04Heavyhorsepull, "heavy horse pull", Constants.ENERGY, 120));
					break;
				case SHOWER_VIEW:
					_selectionItems.push(new SelectionInfo(new Shower01Rubberbrush, "rubber brush", Constants.COIN, 800));
					_selectionItems.push(new SelectionInfo(new Shower02Cleansingset, "cleansing set", Constants.CASH, 5000));
					_selectionItems.push(new SelectionInfo(new Shower03Showermachine, "shower machine", Constants.CASH, 50));
					break;
				case TRAINING_VIEW:
					_selectionItems.push(new SelectionInfo(new Training01Aidexercise, "aid exercise", Constants.ENERGY, 35));
					_selectionItems.push(new SelectionInfo(new Training02Flatwalk, "flat walk", Constants.ENERGY, 50));
					_selectionItems.push(new SelectionInfo(new Training03Cavalletti, "cavalletti", Constants.ENERGY, 85));
					_selectionItems.push(new SelectionInfo(new Training04Heavyhorsepull, "heavy horse pull", Constants.ENERGY, 120));
					break;
			}
			displaySelectionItems();
		}
		
		private function displaySelectionItems():void {
			var windowNum:int = 1;
			for (var a:int = _currentSelectionIndex; a < _selectionItems.length && a < (_currentSelectionIndex + 4); a++) {
				_selectionItems[a].addSelectionToButton(_horseMgmtUI["window" + windowNum]);
				windowNum++;
			} 
		}
		
		private function clearSelectionWindows():void {
			if (_selectionItems) {
				for (var a:int = 0; a < _selectionItems.length; a++) {
					_selectionItems[a].removeSelection(); 
				}
			}
		}
		
		private function initStatInfo():void {
			_statBars = [];
			_statBars[BarInfo.BALANCE] = new BarInfo(_horseMgmtUI.backgroundMode.balanceBar, BarInfo.BALANCE, _horseMgmtUI.backgroundMode.balanceIndicatorIcon);
			_statBars[BarInfo.LUCK] = new BarInfo(_horseMgmtUI.backgroundMode.luckBar, BarInfo.LUCK, _horseMgmtUI.backgroundMode.luckIndicatorIcon);
			_statBars[BarInfo.STRENGTH] = new BarInfo(_horseMgmtUI.backgroundMode.strengthBar, BarInfo.STRENGTH, _horseMgmtUI.backgroundMode.strengthIndicatorIcon);
			_statBars[BarInfo.STAMINA] = new BarInfo(_horseMgmtUI.backgroundMode.staminaBar, BarInfo.STAMINA, _horseMgmtUI.backgroundMode.staminaIndicatorIcon);
			_statBars[BarInfo.SPEED] = new BarInfo(_horseMgmtUI.backgroundMode.speedBar, BarInfo.SPEED, _horseMgmtUI.backgroundMode.speedIndicatorIcon);
			_statBars[BarInfo.ENERGY] = new BarInfo(_horseMgmtUI.backgroundMode.energyBar, BarInfo.ENERGY);
			_statBars[BarInfo.PARTNERSHIP] = new BarInfo(_horseMgmtUI.backgroundMode.partnershipBar2, BarInfo.PARTNERSHIP);
		}
		
		private function initParameterInfo():void {
			_statBars = [];
			_statBars[BarInfo.SHOWER] = new BarInfo(_horseMgmtUI.backgroundMode.showerBar, BarInfo.SHOWER);
			_statBars[BarInfo.FEEDING] = new BarInfo(_horseMgmtUI.backgroundMode.feedingBar, BarInfo.FEEDING);
			_statBars[BarInfo.ENERGY] = new BarInfo(_horseMgmtUI.backgroundMode.energyBar, BarInfo.ENERGY);
			_statBars[BarInfo.PARTNERSHIP] = new BarInfo(_horseMgmtUI.backgroundMode.partnershipbar, BarInfo.PARTNERSHIP);
		}
		
		public function setLevelInfo(rank:int, level:int, exp:int):void {
			_horseMgmtUI.rank.gotoAndStop(rank);
			var num1:int = (level - (level % 10)) / 10;
			var num2:int = level % 10;
			_horseMgmtUI.level1stDigit.gotoAndStop(num1 + 1);
			_horseMgmtUI.level2ndDigit.gotoAndStop(num2 + 1);
			_levelBar.setBar(exp);
		}
		
		public function setParameterInfo(energy:int = 0, shower:int = 0, partnership:int = 0, feeding:int = 0):void {
			updateInfoBar(BarInfo.ENERGY, 1 + Math.floor(Math.random() * 100));
			updateInfoBar(BarInfo.SHOWER, 1 + Math.floor(Math.random() * 100));
			updateInfoBar(BarInfo.PARTNERSHIP, 1 + Math.floor(Math.random() * 100));
			updateInfoBar(BarInfo.FEEDING, 1 + Math.floor(Math.random() * 100));
		}
		
		public function setStatInfo(balance:int = 0, luck:int = 0, strength:int = 0, stamina:int = 0, speed:int = 0, energy:int = 0, partnership:int = 0):void {
			updateInfoBar(BarInfo.BALANCE, 100) //1 + Math.floor(Math.random() * 100));
			updateInfoBar(BarInfo.LUCK, 1 + Math.floor(Math.random() * 100));
			updateInfoBar(BarInfo.STRENGTH, 1 + Math.floor(Math.random() * 100));
			updateInfoBar(BarInfo.STAMINA, 1 + Math.floor(Math.random() * 100));
			updateInfoBar(BarInfo.SPEED, 1 + Math.floor(Math.random() * 100));
			updateInfoBar(BarInfo.ENERGY, 1 + Math.floor(Math.random() * 100));
			updateInfoBar(BarInfo.PARTNERSHIP, 1 + Math.floor(Math.random() * 100));
		}
		
		public function updateInfoBar(type:String, value:int):void {
			_statBars[type].setBar(value);
		}
		
		public function showStatLock(type:String):void {
			_statBars[type].indicator.visible = true;
		}
		
		private function correctLevelPosition(type:String):void {
			var params:Object;
			switch (type) {
				case FEEDING_VIEW:
				case SHOWER_VIEW:
					params = LVL_HORSE_Y_POS;
					break;
				case TRAINING_VIEW:
					params = LVL_JOCKEY_Y_POS;
					break;
			}
			_horseMgmtUI.rank.y = params.rank;
			_horseMgmtUI.level1stDigit.y = params.lvl1;
			_horseMgmtUI.level2ndDigit.y = params.lvl2;
			_horseMgmtUI.horseLevelBar.y = params.bar;
			_horseMgmtUI.baseLevelBarMask.y = params.bar;
		}
		
		private function addListeners():void {
			_horseMgmtUI.feeding.addEventListener(MouseEvent.CLICK, onFeedingClick);
			_horseMgmtUI.shower.addEventListener(MouseEvent.CLICK, onShowerClick);
			_horseMgmtUI.training.addEventListener(MouseEvent.CLICK, onTrainingClick);
			_horseMgmtUI.information.addEventListener(MouseEvent.CLICK, onInfoClick);
			_horseMgmtUI.racing.addEventListener(MouseEvent.CLICK, onRacingClick);
			_horseMgmtUI.left.addEventListener(MouseEvent.CLICK, onLeftClick);
			_horseMgmtUI.right.addEventListener(MouseEvent.CLICK, onRightClick);
			_horseMgmtUI.done.addEventListener(MouseEvent.CLICK, onDoneClick);
			
			_horseMgmtUI.window1.addEventListener(MouseEvent.CLICK, onWindowClick);
			_horseMgmtUI.window2.addEventListener(MouseEvent.CLICK, onWindowClick);
			_horseMgmtUI.window3.addEventListener(MouseEvent.CLICK, onWindowClick);
			_horseMgmtUI.window4.addEventListener(MouseEvent.CLICK, onWindowClick);
			
			_horseMgmtUI.feeding.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_horseMgmtUI.shower.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_horseMgmtUI.training.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_horseMgmtUI.information.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_horseMgmtUI.racing.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		}
		
		private function removeListeners():void {
			_horseMgmtUI.feeding.removeEventListener(MouseEvent.CLICK, onFeedingClick);
			_horseMgmtUI.shower.removeEventListener(MouseEvent.CLICK, onShowerClick);
			_horseMgmtUI.training.removeEventListener(MouseEvent.CLICK, onTrainingClick);
			_horseMgmtUI.information.removeEventListener(MouseEvent.CLICK, onInfoClick);
			_horseMgmtUI.racing.removeEventListener(MouseEvent.CLICK, onRacingClick);
			_horseMgmtUI.left.removeEventListener(MouseEvent.CLICK, onLeftClick);
			_horseMgmtUI.right.removeEventListener(MouseEvent.CLICK, onRightClick);
			_horseMgmtUI.done.removeEventListener(MouseEvent.CLICK, onDoneClick);
			
			_horseMgmtUI.window1.removeEventListener(MouseEvent.CLICK, onWindowClick);
			_horseMgmtUI.window2.removeEventListener(MouseEvent.CLICK, onWindowClick);
			_horseMgmtUI.window3.removeEventListener(MouseEvent.CLICK, onWindowClick);
			_horseMgmtUI.window4.removeEventListener(MouseEvent.CLICK, onWindowClick);
			
			_horseMgmtUI.feeding.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_horseMgmtUI.shower.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_horseMgmtUI.training.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_horseMgmtUI.information.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_horseMgmtUI.racing.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		}
		
		private function onWindowClick(e:MouseEvent):void {
			for each (var selection:SelectionInfo in _selectionItems) {
				if (selection.buttonReference == e.target) {
					var params:Object = new Object;
					params.name = selection.name;
					params.currencyType = selection.currencyType;
					params.amount = selection.amount;					
					dispatchEvent(new HorseManagementEvent(_activeType, params));
					break;
				}
			}
		}
		
		private function onDoneClick(e:MouseEvent):void {
			dispatchEvent(new HorseManagementEvent(HorseManagementEvent.CLOSE));
			hideHorseManagement();
		}
		
		private function onFeedingClick(e:MouseEvent):void {
			if (e.target != _activeButton) {
				switchViewType(FEEDING_VIEW);
				onMouseOut(e);
			}
		}
		
		private function onShowerClick(e:MouseEvent):void {
			if (e.target != _activeButton) {
				switchViewType(SHOWER_VIEW);
				onMouseOut(e);
			}
		}
		
		private function onTrainingClick(e:MouseEvent):void {
			if (e.target != _activeButton) {
				switchViewType(TRAINING_VIEW);
				onMouseOut(e);
			}
		}
		
		private function onInfoClick(e:MouseEvent):void {
			dispatchEvent(new HorseManagementEvent(HorseManagementEvent.INFO));
		}
		
		private function onRacingClick(e:MouseEvent):void {
			dispatchEvent(new HorseManagementEvent(HorseManagementEvent.RACING));
		}
		
		private function onLeftClick(e:MouseEvent):void {
			_currentSelectionIndex-= 4;
			if (_currentSelectionIndex < 0) {
				_currentSelectionIndex = 0;
			}
			clearSelectionWindows();
			displaySelectionItems();
		}
		
		private function onRightClick(e:MouseEvent):void {
			_currentSelectionIndex+= 4;
			if (_currentSelectionIndex > (_selectionItems.length - 4)) {
				_currentSelectionIndex = _selectionItems.length - 4;
			}
			if (_currentSelectionIndex < 0) {
				_currentSelectionIndex = 0;
			}
			clearSelectionWindows();
			displaySelectionItems();
		}
		
		private function onMouseOver(e:MouseEvent):void {
			var object:DisplayObject = e.target as DisplayObject;
			if (object != _activeButton) {
				object.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				TweenMax.to(object, .5, {
					glowFilter:{color:0xFFFFFF, alpha:1, blurX:5, blurY:5, strength: 10}
				});
			}
		}
		
		private function onMouseOut(e:MouseEvent):void {
			var object:DisplayObject = e.target as DisplayObject;
			object.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			var time:Number;
			if (object == _activeButton) {
				time = 0;
			}
			else {
				time = 2;
			}
			TweenMax.to(object, time, {
				glowFilter:{alpha:0, blurX:0, blurY:0, remove:true}
			});
		}
	}
}