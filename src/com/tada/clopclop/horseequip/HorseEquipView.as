	package com.tada.clopclop.horseequip
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.common.EquipItemBoxModel;
	import com.tada.clopclop.toolsets.character.horse.HorseGR;
	
	import fl.controls.ScrollBar;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import com.tada.clopclop.horseequip.tool.EquipHorse;
	
	public class HorseEquipView extends Sprite
	{
		private var _comboBox:HorseComboBoxCustom;
		private var _comboArray:Array = new Array();
		private var _comboButtons:horseComboBoxButtons;
		private var _comboHorse:Number = 10;
		private var _horseRank:Number;
		private var _horseLevel:Number;
		private var _horseName:String;
		private var _maxScroll:Number;
		private var _minScroll:Number;
		private var comboBoxElements:MovieClip;
		private var _scrollBar:MovieClip;
		private var _scrollBarStart:Number;
		private var _scrollBarEnd:Number;
		private var _scrollDistance:Number;
		private var _scrollY:Number;
		private var _mouseDown:Boolean = false;
		private var _scrollBarBounds:Number;
		private var _scrollArray:Number;
		private var _maxDistance:Number;
		private var _equipItemBox:EquipItemBoxModel
		private var _equipItemBoxPointer:Object
		
		private var _horseEquipUI:HorseEquipmentUI;
		private var currentItem:String;
		private var showNew:Boolean = true;
		
		private var _speedCounter:Number = 0;
		private var _staminaCounter:Number = 0;
		private var _strengthCounter:Number = 0;
		private var _balanceCounter:Number = 0;
		private var _luckCounter:Number = 0;
		
		private var statHolder:Number=0;
		private var complete:Number = 0;
		
		private var _speedStat:Number = 80;
		private var _staminaStat:Number = 50;
		private var _strengthStat:Number = 80;
		private var _balanceStat:Number = 25;
		private var _luckStat:Number = 60;
		
		private var _speedCurrent:Number;
		private var _staminaCurrent:Number;
		private var _strengthCurrent:Number;
		private var _balanceCurrent:Number;
		private var _luckCurrent:Number;
		
		private var _speedStatBonus:Number = 10;
		private var _staminaStatBonus:Number = 20;
		private var _strengthStatBonus:Number = 20;
		private var _balanceStatBonus:Number = 20;
		private var _luckStatBonus:Number = 10;
		
		private var _speedCurrentBonus:Number=0;
		private var _staminaCurrentBonus:Number=0;
		private var _strengthCurrentBonus:Number=0;
		private var _balancCurrentBonus:Number=0;
		private var _luckCurrentBonus:Number=0;
		
		private var statUInt:uint
		private var currentMouseY:Number
		
		private var _EquipHorse:EquipHorse;	
		private var view:View3D;
		
		
		
		private var animateButtonArray: Array = [
			"newi",
			"body",
			"equipment",
			"shop",
			"mystorage"
			
		];
		private var bodyButtonArray:Array = [
			"mane",
			"eyes",
			"mouth",
			"pattern",
			"skin"
		]
			
		private var equipmentButtonArray:Array = [
			"head",
			"saddle",
			"bridle",
			"wings",
			"accessory",
		]
		
		public function HorseEquipView(_view3D:View3D)
		{			
			view = _view3D;
		}
		
		public function initHorseEquipView():void
		{
			inheritHorseEquipmentUI();
			
			initializePosition(0,0);	
			
			initializeComboBox();
			
			visibility(false);
			
			initializeObjects();
			
			initializeComboArray(_comboHorse);
			
			activateSubZero("shop");
			
			activateSubOne("newi");
			
			deActivate("mystorage_sub_0");
			
			deActivate("body_sub_1");
			
			deActivate("equipment_sub_1");
			
			initializeSprite();
			
			initializeEquipItemBox("horse");			
			
			addListeners();
			
		}
		
		private function initializeSprite():void{			
			_EquipHorse = new EquipHorse(view);
		}
		
		private function initializeEquipItemBox(type:String):void
		{
			_equipItemBox = new EquipItemBoxModel(type,_horseEquipUI.horseEquipmentMotion,_EquipHorse);
			_equipItemBox.name = "_equipItemBox"
			_horseEquipUI.horseEquipmentMotion.itemEquipmentHolder.addChild(_equipItemBox)
			_equipItemBoxPointer = _equipItemBox
			_equipItemBox.initEquipItemBoxModel();	
		}
		
		private function animate():void
		{
			setInterval(animateSpeedValue,1,_speedCounter,_speedStat,"speed");
			
			setInterval(animateStaminaValue,1,_staminaCounter,_staminaStat,"stamina");
			
			setInterval(animateStrengthValue,1,_strengthCounter,_strengthStat,"strength");
			
			setInterval(animateBalanceValue,1,_balanceCounter,_balanceStat,"balance");
			
			setInterval(animateLuckValue,1,_luckCounter,_luckStat,"luck");
			
			_speedCurrent = _speedStat;
			_staminaCurrent = _staminaStat;
			_strengthCurrent = _strengthStat;
			_balanceCurrent = _balanceStat;
			_luckCurrent = _luckStat;
		}
		private function nextHorse():void
		{
			_speedStat = Math.round(Math.random()*100);
			_staminaStat = Math.round(Math.random()*100);
			_strengthStat = Math.round(Math.random()*100);
			_balanceStat = Math.round(Math.random()*100);
			_luckStat = Math.round(Math.random()*100);
			_speedStatBonus = Math.round(Math.random()*20);
			_staminaStatBonus = Math.round(Math.random()*20);
			_strengthStatBonus = Math.round(Math.random()*20);
			_balanceStatBonus = Math.round(Math.random()*20);
			_luckStatBonus = Math.round(Math.random()*20);
			animate();
		}
		private function inheritHorseEquipmentUI():void
		{
			_horseEquipUI = new HorseEquipmentUI;
			_horseEquipUI.name = "_horseEquipUI";
			addChild(_horseEquipUI);
		}
		private function initializeObjects():void 
		{
			resetBodyButtons(false);
			resetEquipmentButtons(false);
			
		}
		private function initializeComboBox():void
		{
			_comboBox = new HorseComboBoxCustom;
			_comboBox.name = "_comboBox";
			_horseEquipUI.horseEquipmentMotion.addChild(_comboBox);
			_comboBox.x = 59.15;
			_comboBox.y = 259.15;
		}
		private function initializeComboArray(n:Number):void
		{
			_comboButtons = new horseComboBoxButtons()
			for (var i:Number = 0;i<n;i++){
				
				_comboArray[i] = new horseComboBoxButtons()
				comboBoxElements = _comboArray[i]
				comboBoxElements.currentHighlight.visible = false;
				comboBoxElements.mouseChildren = false;
				//comboBoxElements.currentSelection.nameHighlight = false;
				_horseName = String("horse "+i);
				_horseLevel = Math.floor(Math.random()*30+1);
				_horseRank = Math.floor(Math.random()*6+1)
				comboBoxElements.horseName.text = _horseName;
				comboBoxElements.level.text = _horseLevel;
				comboBoxElements.rank.gotoAndStop(_horseRank);
				comboBoxElements.addEventListener(MouseEvent.MOUSE_OVER,selectButton);
				comboBoxElements.addEventListener(MouseEvent.MOUSE_OUT,unSelectButton);
				comboBoxElements.addEventListener(MouseEvent.CLICK ,selectedButton);
				_comboBox.arrayButtonsHolder.addChild(comboBoxElements);
				
				comboBoxElements.x = 0
				comboBoxElements.y = 23.05*i
				
			}
			_maxDistance = -23.05*(n-5);
			_scrollBar = _comboBox.scrollBarWheel.scrollBarWheel;
			_scrollBarStart = 5+ (_scrollBar.height/2)*-1;
			_scrollBarBounds = 64.3 + (_scrollBar.height)*-1;
			_scrollDistance = (60-(_scrollBar.height/2))/(n-4);
			_scrollBar.y = _scrollBarStart;
			
		}
		private function animateSpeedValue(start:Number,end:Number,name:String):void 
		{
			
			if(_speedCounter < _speedCurrent) {
				_speedCounter+= 1
			}
			else if(_speedCounter > _speedCurrent) {
				_speedCounter-= 1
			}
			changeObjectValue(name,_speedCounter,_speedStatBonus);
			changeTextValue(name,_speedCounter,_speedStatBonus);
			
		}
		private function animateStaminaValue(start:Number,end:Number,name:String):void 
		{
			if(_staminaCounter < _staminaCurrent) {
				_staminaCounter+= 1
			}
			else if(_staminaCounter > _staminaCurrent) {
				_staminaCounter-= 1
			}
			changeObjectValue(name,_staminaCounter,_staminaStatBonus)
			changeTextValue(name,_staminaCounter,_staminaStatBonus);		
		}
		private function animateStrengthValue(start:Number,end:Number,name:String):void 
		{
			if(_strengthCounter < _strengthCurrent) {
				_strengthCounter+= 1
			}
			else if(_strengthCounter >_strengthCurrent) {
				_strengthCounter-= 1
			}
			changeObjectValue(name,_strengthCounter,_strengthStatBonus)
			changeTextValue(name,_strengthCounter,_strengthStatBonus);		
		}
		private function animateBalanceValue(start:Number,end:Number,name:String):void 
		{
			if(_balanceCounter < _balanceCurrent) {
				_balanceCounter+=1
			}
			else if(_balanceCounter > _balanceCurrent) {
				_balanceCounter-= 1
			}
			changeObjectValue(name,_balanceCounter,_balanceStatBonus)
			changeTextValue(name,_balanceCounter,_balanceStatBonus);		
		}
		private function animateLuckValue(start:Number,end:Number,name:String):void 
		{
			if(_luckCounter < _luckCurrent) {
				_luckCounter+= 1
			}
			else if(_luckCounter > _luckCurrent) {
				_luckCounter-= 1
			}
			if(_luckCurrentBonus < _luckStatBonus) {
				_luckCurrentBonus+= 1
			}
			else if(_luckCurrentBonus > _luckStatBonus) {
				_luckCurrentBonus-= 1
			}
			changeObjectValue(name,_luckCounter,_luckCurrentBonus)
			changeTextValue(name,_luckCounter,_luckCurrentBonus);		
		}
		
		private function changeObjectValue(get_obj:String,value:Number,bonus:Number):void 
		{
			//statSpeedYellow
			var objToChange:Object = _horseEquipUI.horseEquipmentMotion.getChildByName("stat_"+get_obj)
			var bonusObj:Object = _horseEquipUI.horseEquipmentMotion.getChildByName("stat_"+get_obj+"_bonus")
			objToChange.gotoAndStop(value)
			bonusObj.gotoAndStop(value+bonus);			
		}
		private function changeTextValue(get_obj:String,value:Number,bonus:Number):void 
		{
			//statSpeedYellow
			var textToChange:Object = _horseEquipUI.horseEquipmentMotion.getChildByName(get_obj)
			var textHolder:Object = _horseEquipUI.horseEquipmentMotion.getChildByName(get_obj);
			textHolder.statusText.stats.text = String(""+value+"+"+bonus);	
			textToChange.gotoAndStop(value)
			
		}
		
		//*********************************RESET functions*******************************************
		
		private function resetBodyButtons(value:Boolean):void
		{
			for (var i:Number=0; i<bodyButtonArray.length; i++) 
			{
				var getAnimateButton:Object = _horseEquipUI.horseEquipmentMotion.getChildByName(bodyButtonArray[i]+"_sub_2_button")
				getAnimateButton.visible = value
			}
		}
		private function resetEquipmentButtons(value:Boolean):void
		{
			for (var i:Number=0; i<equipmentButtonArray.length; i++) 
			{
				var getAnimateButton:Object = _horseEquipUI.horseEquipmentMotion.getChildByName(equipmentButtonArray[i]+"_sub_2_button")
				getAnimateButton.visible = value
			}
		}
		
		
		public function visibility(value:Boolean):void 
		{
			visible = value
			if (visible){
				animate();
				rollDown(true);
			}
		}
		public function rollDown(value:Boolean):void
		{
			
			_comboBox.rollDown.visible = value;
			if (value == false){
				_comboBox.play();
			}else
				_comboBox.gotoAndStop(0);
		}
		//********************************DE-ACTIVATE/ACTIVATE FUNCTIONS********************************* 
		private function activateSubZero(selected:String):void
		{
			
			var selected_animate:Object = _horseEquipUI.horseEquipmentMotion.getChildByName(selected+"_sub_0_animate");
			var selected_button:Object = _horseEquipUI.horseEquipmentMotion.getChildByName(selected+"_sub_0_button");
			
			selected_button.visible = false;
			selected_animate.visible = true;
			
		}
		private function activateSubOne(selected:String):void
		{
			
			var selected_animate:Object = _horseEquipUI.horseEquipmentMotion.getChildByName(selected+"_sub_1_animate");
			var selected_button:Object = _horseEquipUI.horseEquipmentMotion.getChildByName(selected+"_sub_1_button");
			selected_animate.visible = true;
			selected_button.visible = false;
			
		}
		private function deActivate(unselected:String):void
		{
			var unselected_animate:Object = _horseEquipUI.horseEquipmentMotion.getChildByName(unselected+"_animate");
			var unselected_button:Object = _horseEquipUI.horseEquipmentMotion.getChildByName(unselected+"_button");
			
			unselected_animate.visible = false;
			unselected_button.visible = true;
		}
		private function hideObj(hide:String):void
		{
			var hide_animate:Object = _horseEquipUI.horseEquipmentMotion.getChildByName(hide+"_sub_1_animate");
			var hide_button:Object = _horseEquipUI.horseEquipmentMotion.getChildByName(hide+"_sub_1_button");
			
			hide_animate.visible = false;
			hide_button.visible = false;
		}
		//************************************LISTENERS and OnCLick Functions******************************
		private function addListeners():void 
		{
			//click listeners
			_horseEquipUI.horseEquipmentMotion.done.addEventListener(MouseEvent.CLICK,clickDoneButton)
			_horseEquipUI.horseEquipmentMotion.closeDown.addEventListener(MouseEvent.CLICK,clickCloseButton)
			_horseEquipUI.horseEquipmentMotion.newi_sub_1_button.addEventListener(MouseEvent.CLICK,clickNewButton)
			_horseEquipUI.horseEquipmentMotion.body_sub_1_button.addEventListener(MouseEvent.CLICK,clickBodyButton)
			_horseEquipUI.horseEquipmentMotion.equipment_sub_1_button.addEventListener(MouseEvent.CLICK,clickEquipmentButton)
			_horseEquipUI.horseEquipmentMotion.shop_sub_0_button.addEventListener(MouseEvent.CLICK,clickShopButton)
			_horseEquipUI.horseEquipmentMotion.mystorage_sub_0_button.addEventListener(MouseEvent.CLICK,clickMyStorageButton)
			//**********************ComboBox ********************
			_comboBox.rollDown.addEventListener(MouseEvent.CLICK,clickComboBox)
			_comboBox.scrollBarDown.addEventListener(MouseEvent.CLICK,clickScrollBarDown)
			_comboBox.scrollBarUp.addEventListener(MouseEvent.CLICK,clickScrollBarUp);
			_scrollBar.addEventListener(MouseEvent.MOUSE_DOWN,clickScrollWheel);
			//**********************Body*************************
			//_horseEquipUI.horseEquipmentMotion.D3Eyes.addEventListener(MouseEvent.CLICK,clickEyesButton)
			//_horseEquipUI.horseEquipmentMotion.D3Mane.addEventListener(MouseEvent.CLICK,clickManeButton)
			//_horseEquipUI.horseEquipmentMotion.D3Mouth.addEventListener(MouseEvent.CLICK,clickMouthButton)
			//_horseEquipUI.horseEquipmentMotion.D3Pattern.addEventListener(MouseEvent.CLICK,clickPatternButton)
			//**********************Equipments***********************
			//_horseEquipUI.horseEquipmentMotion.D3Saddle.addEventListener(MouseEvent.CLICK,clickSaddleButton)
			//_horseEquipUI.horseEquipmentMotion.D3Wings.addEventListener(MouseEvent.CLICK,clickWingsButton)
			//_horseEquipUI.horseEquipmentMotion.D3Accessory.addEventListener(MouseEvent.CLICK,clickAccessoryButton)
			//_horseEquipUI.horseEquipmentMotion.D3Bridle.addEventListener(MouseEvent.CLICK,clickBridleButton)
			//_horseEquipUI.horseEquipmentMotion.D3Head.addEventListener(MouseEvent.CLICK,clickHeadButton)
		}
		private function clickDoneButton(me:MouseEvent):void 
		{
			//save changes
			var _clopClopMainController:Object = parent.getChildByName("_clopclopMainController");
			_clopClopMainController.visibilityUI("_horseEquipController",false)
			_clopClopMainController.visibilityUI("_socialController",true)
			
			
		}
		private function clickCloseButton(me:MouseEvent):void 
		{
			var _clopClopMainController:Object = parent.getChildByName("_clopclopMainController");
			_clopClopMainController.visibilityUI("_horseEquipController",false)
			_clopClopMainController.visibilityUI("_socialController",true)
			
			
		}
		private function clickComboBox(me:MouseEvent):void
		{
			rollDown(false);
			
		}
		//===========================SCROLLBAR FUNCTIONS======================================
		private function clickScrollBarDown(me:MouseEvent):void
		{
			_comboBox.arrayButtonsHolder.y -=23.05;
			_scrollBar.y += _scrollDistance;
			if (_scrollBar.y >_scrollBarBounds)
			{
				_scrollBar.y = _scrollBarBounds;
				_comboBox.arrayButtonsHolder.y=_maxDistance
			}
		}
		private function clickScrollBarUp(me:MouseEvent):void
		{
			_comboBox.arrayButtonsHolder.y +=23.05;
			_scrollBar.y -= _scrollDistance;
			
			if (_scrollBar.y < _scrollBarStart){
				_scrollBar.y = _scrollBarStart;
				_comboBox.arrayButtonsHolder.y=34.575;
			}
			
		}
		private function clickScrollWheel(me:MouseEvent):void
		{
			_scrollBar.addEventListener(MouseEvent.MOUSE_MOVE,dragScrollWheel);
			_scrollBar.addEventListener(MouseEvent.MOUSE_UP,upScrollWheel);
			
		}
		private function upScrollWheel(me:MouseEvent):void
		{
			_scrollBar.removeEventListener(MouseEvent.MOUSE_MOVE,dragScrollWheel);	
			_scrollBar.removeEventListener(MouseEvent.MOUSE_UP,clickScrollWheel);	
		}
		private function disArm():void
		{
			_scrollBar.removeEventListener(MouseEvent.MOUSE_MOVE,dragScrollWheel);	
			_scrollBar.removeEventListener(MouseEvent.MOUSE_UP,clickScrollWheel);	
		}
		private function dragScrollWheel(me:MouseEvent):void
		{
			var cursor:Point = new Point(mouseX,mouseY);
			var endPoint:Number = _comboBox.scrollBarDown.y;
			var currentPos:Number = _scrollBar.y;
			var holder:Number = 0;
			
			if (_scrollBar.y <= _scrollBarBounds &&(_scrollBar.y >= _scrollBarStart))
			{
				_scrollBar.y = mouseY-(_scrollBar.height/1.5)-331;
				if (holder == 0){
					holder = currentPos - _scrollBar.y;
				}
				arrayIndexScroll(holder);
			}
			else if (_scrollBar.y < _scrollBarStart){
				_scrollBar.y = _scrollBarStart;
				_comboBox.arrayButtonsHolder.y=34.575;
				disArm();
			}
			else if (_scrollBar.y >_scrollBarBounds)
			{
				_scrollBar.y = _scrollBarBounds;
				_comboBox.arrayButtonsHolder.y=_maxDistance
				disArm();
			}
			_scrollBar.addEventListener(MouseEvent.MOUSE_OUT,upScrollWheel);
			
		}
		private function arrayIndexScroll(n:Number):void
		{
			_comboBox.arrayButtonsHolder.y+=(23.05/(_comboHorse-4))*n;
		}
		private function selectButton(me:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(me.target);
			mc.currentHighlight.visible = true;
		}
		private function unSelectButton(me:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(me.target);
			mc.currentHighlight.visible = false;
		}
		private function selectedButton(me:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(me.target);
			_comboBox.currentSelection.horseName.text = String(mc.horseName.text);
			_comboBox.currentSelection.level.text = String(mc.level.text);
			_comboBox.currentSelection.rank.gotoAndStop(mc.rank.currentFrame);
			_horseEquipUI.horseEquipmentMotion.levelBarControl.levelText.text = String(mc.level.text);
			nextHorse();
			rollDown(true);
			
		}
		
		private function clickShopButton(me:MouseEvent): void
		{
			showNew=true;
			activateSubZero("shop");
			activateSubOne("newi");
			deActivate("mystorage_sub_0");
			deActivate("body_sub_1");
			deActivate("equipment_sub_1");
			resetBodyButtons(false);
			resetEquipmentButtons(false);
			rollDown(true);
			_equipItemBoxPointer.d1Listeners(me)
			
		}
		private function clickMyStorageButton(me:MouseEvent): void
		{
			showNew=false;
			activateSubZero("mystorage");
			activateSubOne("body");			
			deActivate("shop_sub_0");
			deActivate("equipment_sub_1");
			hideObj("newi");
			resetBodyButtons(true);
			resetEquipmentButtons(false);
			rollDown(true);
			_equipItemBoxPointer.d1Listeners(me)
		}
		private function clickNewButton(me:MouseEvent): void
		{
			activateSubOne("newi");
			deActivate("body_sub_1");
			deActivate("equipment_sub_1");
			resetEquipmentButtons(false);
			resetBodyButtons(false);
			rollDown(true);
			_equipItemBoxPointer.d2Listeners(me)
		}
		private function clickBodyButton(me:MouseEvent): void
		{
			activateSubOne("body");
			deActivate("equipment_sub_1");
			if (showNew == true){
				deActivate("newi_sub_1");
			}
			resetEquipmentButtons(false);
			resetBodyButtons(true);
			rollDown(true);
			_equipItemBoxPointer.d2Listeners(me)
		}
		private function clickEquipmentButton(me:MouseEvent): void
		{
			activateSubOne("equipment");
			deActivate("body_sub_1");
			if (showNew == true){
				deActivate("newi_sub_1");
			}
			resetEquipmentButtons(true);
			resetBodyButtons(false);
			rollDown(true);
			_equipItemBoxPointer.d2Listeners(me)
		}
		
		private function initializePosition(pos_x:Number,pos_y:Number):void 
		{
			x = pos_x;
			y = pos_y;
		}
	}
}